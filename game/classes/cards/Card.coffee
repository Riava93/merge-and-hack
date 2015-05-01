# All cards in the game will have game stats
class GameStats
	constructor: ->
		@product = 0
		@security = 0
		@espionage = 0

#Everything will be a card
class Card
	constructor: (@id) ->
		@name = @constructor.name
		@stats = new GameStats
		@ownerGrouping = null #a reference to the grouping that owns this card

	tick: (board) ->
		console.log @name, 'tick'

module.exports = Card
