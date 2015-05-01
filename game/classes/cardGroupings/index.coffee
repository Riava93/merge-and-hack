cards = require '../cards'

class CardGrouping
	constructor: ->
		@name = @constructor.name
		@newStack = [] # the face down stack of cards
		@inPlayStack = [] # cards facing up, currently in play
		@discardStack = [] # used cards, discarded and ready to be shuffled

	add: (card) -> # put a card in the pile set grouping as the owner
		card.ownerGrouping = @
		@newStack.push card

	draw: ->
		@inPlayStack.push @newStack.shift() # remove the top card and put it in play

	clear: ->
		for discardable in @inPlayStack # put the remaining cards in the discard pile
			@discardStack.push @inPlayStack.shift()

	discard: (card) -> #card was in use and is now being put back into the discardPile
		@discardStack.push card

	select: (index) ->
		card = @inPlayStack.splice(index, 1)[0] # retain the desired card
		@clear()
		return card # return the card, expecting it to be moved to another CardGrouping

	shuffle: ->
		array = @newStack
		counter = array.length
		#While there are elements in the array
		while counter > 0
			#Pick a random index
			index = Math.floor(Math.random() * counter)
			#Decrease counter by 1
			counter--
			#And swap the last element with it
			temp = array[counter]
			array[counter] = array[index]
			array[index] = temp

class ProductCardGrouping extends CardGrouping
	constructor: ->
		super()
		@add new cards.events.ProductEvent 'a-product-event'

class SecurityCardGrouping extends CardGrouping
	constructor: ->
		super()
		@add new cards.events.SecurityEvent 'a-security-event'

class EspionageCardGrouping extends CardGrouping
	constructor: ->
		super()
		@add new cards.events.EspionageEvent 'a-espionage-event'

class InnovationPoolCardGrouping extends CardGrouping
	constructor: ->
		super()
		@newStack.push new cards.subsidiaries.SidekickSubsidiary

module.exports =
	ProductCardGrouping: ProductCardGrouping
	SecurityCardGrouping: SecurityCardGrouping
	EspionageCardGrouping: EspionageCardGrouping
	InnovationPoolCardGrouping: InnovationPoolCardGrouping
