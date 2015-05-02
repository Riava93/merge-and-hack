cardGroupings = require './cardGroupings'
corporations = require './cards/corporations'

class GameState
	states: [
		'GAME_START' # introduction screen
		'GAME_INFO' # more explanation, help screen before game start, possibly
		'TURN_START' # beginning of a turn, player picks a event card
		'TURN_DECIDING_MERGE_OR_HACK' # player decides whether to acquire a sub with money or attempt to hack for one
		'TURN_MERGING' # drawing from the innovation pool
		'TURN_HACKING_SELECT' # Select a player to hack
		'TURN_HACKING' # attempting to hack for a subsidiary
		'TURN_RESULT'  # See Results of the hack
		'GAME_OVER' # the very end of the game
	]
	constructor: ->
		@current = 0
		# enumerate the game states at start time
		for state, i in @states
			@[state] = i

	toString: ->
		@states[@current]

class Board
	constructor: ->
		@state = new GameState

	setUp: ->
		@state.current = @state.GAME_INFO
		@turn = -1 # No turn yet, first call to nextTurn() will let player 1 go first
		@players = [
			new corporations.SparkFresh
			new corporations.SomethingCorp
			new corporations.OtherCorp
		]
		@cardGroups = [
			new cardGroupings.ProductCardGrouping
			new cardGroupings.SecurityCardGrouping
			new cardGroupings.EspionageCardGrouping
		]

		@innovationPool = new cardGroupings.InnovationPoolCardGrouping

		for group in @cardGroups
			group.shuffle()

	nextTurn: ->
		@state.current = @state.TURN_START
		@turn++
		if @turn >= @players.length
			@turn = 0

		for group in @cardGroups
			group.draw()

		console.log 'next turn for player', @players[@turn]

	triggerTick: (@event, @grouping) ->
		# check if player has subsidiaries
		if @players[@turn].subsidiaries.length > 0
			# Tick all cards based on event
			@players[@turn].tick @
		else
			console.log 'Player has no subsidiaries yet, nothing to tick'

	endTurn: ->
		# TODO: tick all corporations
		for corp in @players
			corp.tick @
		@nextTurn()

	getCurrentPlayer: ->
		@players[@turn]

	selectCard: (groupIndex, index) ->
		currentCorp = @players[@turn]
		for group, i in @cardGroups
			if i is groupIndex
				eventCard = @cardGroups[groupIndex].select index
			else
				@cardGroups[i].clear()
		currentCorp.events.push eventCard
		@state.current = @state.TURN_DECIDING_MERGE_OR_HACK

	selectMerge: ->
		@state.current = @state.TURN_MERGING
		@innovationPool.draw()

	confirmMerger: (shouldMerge) ->
		if shouldMerge
			subsidiary = @innovationPool.select 0
			currentCorp = @players[@turn]
			currentCorp.subsidiaries.push subsidiary
		else
			@innovationPool.clear()
		@endTurn()

	selectHack: ->
		@state.current = @state.TURN_HACKING_SELECT
		#TODO: stuff with conflict resolution between 2 players
		#TODO: possibly have to select a corp here, or maybe attack both???

	confirmHack: (target) ->
		# Give selection for players
		# Return selected player as target
		attackingPlayer = @getCurrentPlayer()
		@state.current = @state.TURN_HACKING unless target is attackingPlayer
		@hackPuzzle = new HackPuzzle attackingPlayer, target

		#@endTurn()

	hackPuzzleCellClick: (x, y) ->
		isHackOver = @hackPuzzle.activateCell(x, y)
		if isHackOver
			console.log 'the hack is over'
			if @hackPuzzle.hackSuccessful
				@state.current = @state.TURN_RESULT
				@triggerTick()
				@outcome = new Results 'hacquisition', @hackPuzzle.hackSuccessful, 'You\'ve successfully hacked your target', { subsidiaries: 'Gained 1 Security Subsidiary' }
			else
				@state.current = @state.TURN_RESULT
				@triggerTick()
				@outcome = new Results 'hacquisition', @hackPuzzle.hackSuccessful, 'You\'ve failed to successfully hack your target', { funds: 'You\'ve lost 1 bagillion dollars' }
		else
			console.log 'continuing the hack'

	hackPuzzleBail: ->
		result = @hackPuzzle.bailOut()
		if result
			@state.current = @state.TURN_RESULT
			@triggerTick()
			@outcome = new Results 'hacquisition', !result, 'You bailed out of the hacquisition!'

class HackPuzzle

	constructor: (attacker, defender, @totalTurns = 3) ->
		@playerEspionage = attacker.stats.espionage
		@targetsSecurity = defender.stats.security
		@cells_grid = [[], [], []]
		@buildGrid()
		@calculateProbability()
		@populateIceNodes()

	calculateProbability: ->
		# (1 - (attackEsp / defendSec)) * 6 [randomly choose Math.ceil, or Math.floor]
		@probability = ((1 - @playerEspionage / @targetsSecurity) * 6 || 1)
		rand_num = Math.random()

		if rand_num > 0.5
			@probability = Math.ceil(@probability)
		else
			@probability = Math.floor(@probability)

		console.log 'probability', @probability

	buildGrid: ->
		#  Instantiate a new cell in the grid
		for y in [0...3]
			for x in [0...3]
				@cells_grid[x][y] = new Cell x, y

	populateIceNodes: ->
		count = 0
		while count isnt @probability
			xCell = Math.floor(Math.random() * 3)  # Choose random x coordinate
			yCell = Math.floor(Math.random() * 3)  # Choose random y coordinate
			cell = @cells_grid[xCell][yCell]
			cell.setCellSafety(false)  # Create an ice node
			console.log(xCell, yCell, cell)
			count++

	checkForWin: ->
		@hackSuccessful = false

		# Check all rows...
		@hackSuccessful = true if (@cells_grid[0][0].cellValue + @cells_grid[1][0].cellValue + @cells_grid[2][0].cellValue) is 3
		@hackSuccessful = true if (@cells_grid[0][1].cellValue + @cells_grid[1][1].cellValue + @cells_grid[2][1].cellValue) is 3
		@hackSuccessful = true if (@cells_grid[0][2].cellValue + @cells_grid[1][2].cellValue + @cells_grid[2][2].cellValue) is 3

		# Check all columns...
		@hackSuccessful = true if (@cells_grid[0][0].cellValue + @cells_grid[0][1].cellValue + @cells_grid[0][2].cellValue) is 3
		@hackSuccessful = true if (@cells_grid[1][0].cellValue + @cells_grid[1][1].cellValue + @cells_grid[1][2].cellValue) is 3
		@hackSuccessful = true if (@cells_grid[2][0].cellValue + @cells_grid[2][1].cellValue + @cells_grid[2][2].cellValue) is 3

		# Check L2R Diagonal for win
		@hackSuccessful = true if (@cells_grid[0][2].cellValue + @cells_grid[1][1].cellValue + @cells_grid[2][0].cellValue) is 3
		# Check R2L Diagonal for win
		@hackSuccessful = true if (@cells_grid[2][2].cellValue + @cells_grid[1][1].cellValue + @cells_grid[0][0].cellValue) is 3

	activateCell: (xCell, yCell) ->
		@cells_grid[xCell][yCell].activate()
		@checkForWin()
		@totalTurns--
		console.log 'turns remaining', @totalTurns
		console.log 'successful?', @hackSuccessful
		console.log 'over?', @hackSuccessful isnt true and @outOfTurns()

		if @hackSuccessful is true
			return yes
		else if @hackSuccessful isnt true and @outOfTurns()
			return yes

		return no

	# check if out of turns
	outOfTurns: ->
		@totalTurns is 0

	bailOut: ->
		yes

class Cell

	constructor: (x, y, safe = true) ->
		@isSafe = true  # This may be irrelevant
		@isRevealed = false
		@value = 0
		@x = x
		@y = y

	isCellSafe: ->
		@isSafe

	setCellSafety: (safeBool) ->
		@isSafe = safeBool

	activate: ->
		@isRevealed = yes
		if @isSafe
			@value = 1
		else
			@value = 0


class Results

	constructor: (@type, @result, @details) ->
		if @result
			@rewards @details
		else
			@consequences @details

	rewards: (@rewards...) ->

	consequences: (@conseq...) ->

module.exports = Board
