Board = require './classes/Board'

class Game
	start: ->
		console.log 'Game start'
		board = new Board
		console.log JSON.stringify(board, undefined, 2)

module.exports = Game
