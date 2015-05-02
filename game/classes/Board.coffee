cardGroupings = require './cardGroupings'
corporations = require './cards/corporations'
HackPuzzle = require './HackPuzzle'

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

	triggerTick: ->
		console.log "TRIGGER TICK CURRENT STATE: #{@state.current}"
		for corp in @players
			if @onHack()
				corp.tick @, true
			else
				corp.tick @, false

	onHack: ->
		@state.current is @state.TURN_RESULT

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
		@triggerTick()

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
				@outcome = new Results 'hacquisition', @hackPuzzle.hackSuccessful, 'You\'ve successfully hacked your target', @hackPuzzle.attacker, @hackPuzzle.defender
			else
				@state.current = @state.TURN_RESULT
				@triggerTick()
				@outcome = new Results 'hacquisition', @hackPuzzle.hackSuccessful, 'You\'ve failed to successfully hack your target', @hackPuzzle.attacker, @hackPuzzle.defender
		else
			console.log 'continuing the hack'

	hackPuzzleBail: ->
		result = @hackPuzzle.bailOut()
		if result
			@state.current = @state.TURN_RESULT
			@triggerTick()
			@outcome = new Results 'hacquisition', !result, 'You bailed out of the hacquisition!'

class Results

	constructor: (@type, @result, @details, @attacker, @defender) ->
		if @result
			@stealSubsidiary()
		else
			@failConsequence()

	stealSubsidiary: ->
		if @defender.subsidiaries.length > 0
			reward = @defender.subsidiaries.shift()
			@attacker.subsidiaries.push reward
			console.log "Awared subsidiary: #{reward.name} => #{@attacker.name}"
		else if @defender.cash > 0
			@attacker.cash += 150
			@defender.cash -= 150
			console.log "#{@attacker.name} stole $150.00 from #{@defender.name}"
		else
			console.log "#{@defender.name} has absolutely nothing to take! Quit picking on them!"


	failConsequence: ->
		if @attacker.cash > 0
			@attacker.cash -= 100
		else
			console.log "#{@attacker.name} has no funds to lose!"


module.exports = Board
