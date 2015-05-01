cardGroupings = require './cardGroupings'
corporations = require './cards/corporations'

class GameState
	states: [
		'GAME_START' # introduction screen
		'GAME_INFO' # more explanation, help screen before game start, possibly
		'TURN_START' # beginning of a turn, player picks a card
		'TURN_DECIDING_MERGE_OR_HACK' # player decides whether to acquire a sub with money or attempt to hack for one
		'TURN_MERGING' # drawing from the innovation pool
		'TURN_HACKING' # attempting to hack for a subsidiary
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

	endTurn: ->
		# TODO: tick all corporations
		for corp in @players
			corp.tick @
		@nextTurn()

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
		@state.current = @state.TURN_HACKING
		#TODO: stuff with conflict resolution between 2 players
		#TODO: possibly have to select a corp here, or maybe attack both???

	confirmHack: (playerIndex) ->
		#TODO: perform hacquisition and report results
		@endTurn()


module.exports = Board
