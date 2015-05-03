class AI
	constructor: (@me) ->

	think: (board) ->
		# pick an event card
		board.selectCard 0, 0
		randNum = Math.random()
		if randNum > 0.5
			board.selectMerge()
			board.confirmMerger yes
		else
			board.selectHack()
			board.confirmHack board.players[0]
			board.hackPuzzleCellClick 0, 0
			board.hackPuzzleCellClick 1, 0
			board.hackPuzzleCellClick 2, 0

module.exports = AI
