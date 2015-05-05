GameStats = require '../GameStats'
#Everything will be a card
class Card
	constructor: (@id, @icon = 'none') ->
		@name = @constructor.name
		@stats = new GameStats
		@ownerGrouping = null # a reference to the grouping that owns this card
		@description = ''

		###
		# Related to visual representation
		###
		@isFlipped = no # is face up?
		@isVisible = yes # is showing in the view?
		@isRetained = no # is contained in a corporation?

	reset: -> # if you need to reset any changing stats on the card..

	tick: (board) ->
		console.log @name, 'tick'

	onHack: ->

	bonusTick: ->  # For subsidiary bonus perks on tick


module.exports = Card
