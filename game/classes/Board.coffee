cardGroupings = require './cardGroupings'
corporations = require './cards/corporations'
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


	chooseCorporation: (corp) ->
		corp.isHuman = yes

	setAI: ->
		aiId = 0
		for corp in @players
			unless corp.isHuman
				aiId++
				if aiId is 1
					firstAI = new AI corp
				else if aiId is 2
					secondAI = new AI corp


	nextTurn: ->
		@state.current = @state.TURN_START
		if @turn is -1
			for corp, index in @players
				if corp.isHuman
					@turn = index
		else
			@turn++
		if @turn >= @players.length
			@turn = 0

		for group in @cardGroups
			group.draw()

		console.log 'next turn for player', @players[@turn]

	turnRecap: []

	resetTurnRecap: ->
		@turnRecap.length = 0

	addToTurnRecap: (message) ->
		@turnRecap.push message


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
		@resetTurnRecap()
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
		@addToTurnRecap "#{currentCorp.name} selected the #{eventCard.name} event card"
		@triggerTick()

	selectMerge: ->
		@state.current = @state.TURN_MERGING
		@innovationPool.draw()
		@addToTurnRecap "#{@players[@turn].name} has chosen to try a merger"

	confirmMerger: (shouldMerge) ->
		if shouldMerge
			subsidiary = @innovationPool.select 0
			currentCorp = @players[@turn]
			currentCorp.subsidiaries.push subsidiary
			@addToTurnRecap "#{currentCorp} chose to merge with #{subsidiary.name}"
		else
			@innovationPool.clear()
			@addToTurnRecap "#{@players[@turn].name} chose not to merge."
		@endTurn()

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
			if @hackPuzzle.hackSuccessful
				@state.current = @state.TURN_RESULT
				@triggerTick()
				@outcome = new Results 'hacquisition', @hackPuzzle.hackSuccessful, 'You\'ve successfully hacked your target', @hackPuzzle.attacker, @hackPuzzle.defender
				@addToTurnRecap "#{@hackPuzzle.attacker.name} successfully hacked #{@hackPuzzle.defender.name}"
			else
				@state.current = @state.TURN_RESULT
				@triggerTick()
				@outcome = new Results 'hacquisition', @hackPuzzle.hackSuccessful, 'You\'ve failed to successfully hack your target', @hackPuzzle.attacker, @hackPuzzle.defender
				@addToTurnRecap "#{@hackPuzzle.attacker.name} failed to hack #{@hackPuzzle.defender.name}"
		else
			console.log 'continuing the hack'

	hackPuzzleBail: ->
		result = @hackPuzzle.bailOut()
		if result
			@state.current = @state.TURN_RESULT
			@triggerTick()
			@outcome = new Results 'hacquisition', !result, 'You bailed out of the hacquisition!'
			@addToTurnRecap "#{@players[@turn].name} bailed out of the hack!"

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
