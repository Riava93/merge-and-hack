class AI
	constructor: (@me) ->

	think: (@board) ->
		# pick an event card
		@findOwnWeakness()
		@chooseCard()
		@chooseAction()

	findOwnWeakness: ->
		lowestNum = -1
		for key, value of @me.stats
			if value < lowestNum or lowestNum is -1
				lowestNum = value
				lowestStat = key
				#console.log "The current lowest stat is #{key}"
		@weakestStat = lowestStat


	chooseCard: (weakestStat) ->
		if weakestStat is 'product'
			@board.selectCard 0
		else if weakestStat is 'security'
			@board.selectCard 1
		else
			@board.selectCard 2

	chooseAction: ->
		randInt = Math.random()
		if randInt > 0.5
			@board.selectMerge()
			@board.confirmMerger yes
		else
			@board.selectHack()
			@solveHackPuzzle(@selectTarget())

	selectTarget: ->
		targets = []
		debugger
		for player in @board.players
			if player isnt @me
				targets.push player

		randInt = Math.random()
		if randInt > 0.5
			return target = targets[0]
		else
			return target = targets[1]

	solveHackPuzzle: (target) ->
			@board.confirmHack target
			@board.hackPuzzleCellClick 0, 0
			@board.hackPuzzleCellClick 1, 0
			@board.hackPuzzleCellClick 2, 0


module.exports = AI
