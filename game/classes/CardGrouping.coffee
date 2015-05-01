cards = require './cards'

class CardGrouping
	constructor: ->
		@newStack = [
			new cards.Subsidiary
		] # the face down stack of cards
		@inPlayStack = [] # cards facing up, currently in play
		@discardStack = [] # used cards, discarded and ready to be shuffled

	draw: ->
		@inPlayStack.push @newStack.unshift() # remove the top card and put it in play

	select: (index) ->
		card = @inPlayStack.splice index, 1 # retain the desired card
		for discardable in @inPlayStack # put the remaining cards in the discard pile
			@discardStack.push @inPlayStack.unshift()
		return card # return the card, expecting it to be moved to another CardGrouping

	shuffle: ->
		console.log 'TODO: Shuffle cards'


module.exports = CardGrouping
