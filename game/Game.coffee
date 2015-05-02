Board = require './classes/Board'

class Game
	constructor: ->
		@board = new Board
		@board.setUp()

	start: ->
		console.log 'Game start'
		#@board.nextTurn()


module.exports = Game
