cardGroupings = require './cardGroupings'
corporations = require './corporations'
AI = require './AI'
HackPuzzle = require './HackPuzzle'

class GameState
	states: [
		'GAME_START' # introduction screen
		'GAME_INFO' # more explanation, help screen before game start, possibly
		'CHOOSE_CORP' # Choose which corporation to play as
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
		@monthsPassed = 0
		@state.current = @state.GAME_INFO
		@turn = -1 # No turn yet, first call to nextTurn() will let player 1 go first
		@players = [
			new corporations.SparkFresh
			new corporations.BubbleHearth
			new corporations.Tinjeki
		]
		@cardGroups = [
			new cardGroupings.ProductCardGrouping
			new cardGroupings.SecurityCardGrouping
			new cardGroupings.EspionageCardGrouping
		]
		@computerAIPlayers = []

		@innovationPool = new cardGroupings.InnovationPoolCardGrouping

		# shuffle all the card groups
		for group in @cardGroups
			group.shuffle()
		@innovationPool.shuffle()

	isCorporationBankrupt: ->
		for player in @players
			if player.cash < 0
				bankruptPlayer = player
		if bankruptPlayer?
			@state.current = @state.GAME_OVER
			winner = @getPlayerWithHighestValue()
			@endGameResult = new GameResult 'bankrupt', winner, { details: bankruptPlayer.name }

	shouldGameEnd: (checkBankrupt, checkTime) ->
		@isCorporationBankrupt() if checkBankrupt
		@hasTwoYearsPassed() if checkTime

	#  Check if it has been two years
	hasTwoYearsPassed: ->
		if @monthsPassed >= 24
			@state.current = @state.GAME_OVER
			winner = @getPlayerWithHighestValue()
			@endGameResult = new GameResult 'two_year', winner, { details: 'They had the highest wealth of all players' }
			console.log "%c End game result details %o", 'background: #008aff; color: white', @endGameResult
			#console.log '%c THE GAME IS OVER ', 'background: red; color: white'

	getPlayerWithHighestValue: ->
		highestValue = -1
		for index, player of @players
			console.log
			value = @calculateSubsidiaryValues(player) + player.cash
			if highestValue < value
				highestValue = value
				currentWinningPlayer = player
		return currentWinningPlayer

	calculateSubsidiaryValues: (player) ->
		total = 0
		if player.subsidiaries.length is 0
			return total
		for sub in player.subsidiaries
			total += sub.value
		return total

	chooseCorporation: (corp) ->
		@players.splice @players.indexOf(corp), 1
		@players.unshift corp
		@computerAIPlayers.push new AI @players[1]
		@computerAIPlayers.push new AI @players[2]
		@nextTurn()

	reshuffleEmptyDecks: ->
		for group in @cardGroups
			if group.newStack.length is 1
				#console.log "%c Reshuffling #{group}", "background: #008aff; color: white;"
				group.shuffle()

	nextTurn: ->
		@shouldGameEnd true, false
		if @endGameResult? then return
		@state.current = @state.TURN_START
		@reshuffleEmptyDecks()
		@turn++
		if @turn >= @players.length
			@monthsPassed++
			@shouldGameEnd false, true
			#console.log "%c Months Passed #{@monthsPassed} ", 'background: #008aff; color: white'
			@turn = 0

		for group in @cardGroups
			group.draw()

		if @turn > 0 # this is an AI player
			@computerAIPlayers[@turn - 1].think @

	turnRecap: []

	resetTurnRecap: ->
		@turnRecap.length = 0

	addToTurnRecap: (message) ->
		@turnRecap.push message

	triggerTick: ->
		console.log "TRIGGER TICK CURRENT STATE: #{@state.current}"
		for corp in @players
			corp.tick @, @didHackThisTurn()

	didHackThisTurn: ->
		@state.current is @state.TURN_HACKING

	endTurn: ->
		@resetTurnRecap()
		@nextTurn()

	getCurrentPlayer: ->
		@players[@turn]

	selectCard: (groupIndex, index) ->
		currentCorp = @players[@turn]
		console.log 'corp', currentCorp, @players, @turn
		for group, i in @cardGroups
			if i is groupIndex
				eventCard = @cardGroups[groupIndex].select index
			else
				@cardGroups[i].clear()
		currentCorp.events.push eventCard
		@state.current = @state.TURN_DECIDING_MERGE_OR_HACK
		@addToTurnRecap "#{currentCorp.name} selected the #{eventCard.name} event card"
		@triggerTick()

	selectMerge: ->
		@state.current = @state.TURN_MERGING
		@innovationPool.draw()
		@addToTurnRecap "#{@players[@turn].name} has chosen to try a merger"

	confirmMerger: (shouldMerge) ->
		currentCorp = @players[@turn]
		if shouldMerge
			subsidiary = @innovationPool.select 0
			currentCorp.cash -= subsidiary.value
			currentCorp.subsidiaries.push subsidiary
			@addToTurnRecap "#{currentCorp.name} chose to merge with #{subsidiary.name}"
		else
			if currentCorp.cash >= @innovationPool.inPlayStack[0].value
				@addToTurnRecap "#{@players[@turn].name} chose not to merge."
			else
				@addToTurnRecap "#{@players[@turn].name} could not afford to merge."
			@innovationPool.clear()
		@state.current = @state.TURN_RESULT

	selectHack: ->
		@state.current = @state.TURN_HACKING_SELECT
		@addToTurnRecap "#{@players[@turn].name} chose to hack another corporation"
		#TODO: stuff with conflict resolution between 2 players
		#TODO: possibly have to select a corp here, or maybe attack both???

	confirmHack: (target) ->
		# Give selection for players
		# Return selected player as target
		attackingPlayer = @getCurrentPlayer()
		@state.current = @state.TURN_HACKING unless target is attackingPlayer
		@addToTurnRecap "#{attackingPlayer.name} attempts a hacquisiton on #{target.name}!"
		@hackPuzzle = new HackPuzzle attackingPlayer, target
		#@endTurn()

	hackPuzzleCellClick: (x, y) ->
		isHackOver = @hackPuzzle.activateCell(x, y)
		if isHackOver
			console.log 'the hack is over'
			@triggerTick()
			@state.current = @state.TURN_RESULT
			if @hackPuzzle.hackSuccessful
				@outcome = new HackResult @hackPuzzle.attacker, @hackPuzzle.defender, @hackPuzzle.hackSuccessful
				@outcome.type = 'Hacquisition'
				@outcome.details = "You've successfully hacked #{@hackPuzzle.defender}!"
				@addToTurnRecap "#{@hackPuzzle.attacker.name} successfully hacked #{@hackPuzzle.defender.name}"
			else
				@outcome = new HackResult @hackPuzzle.attacker, @hackPuzzle.defender, @hackPuzzle.hackSuccessful
				@outcome.type = 'Hacquisition'
				@outcome.details = "You've failed to hack #{@hackPuzzle.defender}!"
				@addToTurnRecap "#{@hackPuzzle.attacker.name} failed to hack #{@hackPuzzle.defender.name}"
		else
			console.log 'continuing the hack'

	hackPuzzleBail: ->
		result = @hackPuzzle.bailOut()
		if result
			@state.current = @state.TURN_RESULT
			@triggerTick()
			@outcome = new HackResult @hackPuzzle.attacker, @hackPuzzle.defender, @hackPuzzle.hackSuccessful
			@outcome.type = 'Hacquisition'
			@outcome.details = "You've bailed out of your hack on #{@hackPuzzle.defender}!"
			@addToTurnRecap "#{@players[@turn].name} bailed out of the hack!"

class Results

	constructor: (@type, @details, @options...) ->



class GameResult extends Results

	constructor: (@outcome, @winner, @options...) ->
		@determineHowWinHappened()

	determineHowWinHappened: ->  # I am The best at naming methods.
		if @outcome is 'two_year'
			return @winCondition = 'Two Years have passed, and it\'s all come to this...'
		else if @outcome is 'bankrupt'
			return @winCondition = "#{@options[0].details} has gone bank rupt and #{@winner.name} owns the most wealth!"



class HackResult extends Results

	constructor: (@attacker, @defender, @outcome) ->
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
			@attacker.cash += 2
			@defender.cash -= 2
			console.log "#{@attacker.name} stole $1M from #{@defender.name}"
		else
			console.log "#{@defender.name} has absolutely nothing to take! Quit picking on them!"

	failConsequence: ->
		if @attacker.cash > 0
			@attacker.cash -= 1
		else
			console.log "#{@attacker.name} has no funds to lose!"

module.exports = Board
