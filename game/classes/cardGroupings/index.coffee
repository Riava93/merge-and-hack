cards = require '../cards'

class CardGrouping
	constructor: (@icon) ->
		@name = @constructor.name
		@allCards = [] # a reference holder to all cards in this grouping, regardles of their state
		@newStack = [] # the face down stack of cards
		@inPlayStack = [] # cards facing up, currently in play
		@discardStack = [] # used cards, discarded and ready to be shuffled

	add: (card) -> # put a card in the pile set grouping as the owner
		card.ownerGrouping = @
		@allCards.push card
		@newStack.push card

	draw: ->
		card = @newStack.shift() # remove the top card and put it in play
		card.isFlipped = yes
		@inPlayStack.push card

	clear: ->
		for discardable in @inPlayStack # put the remaining cards in the discard pile
			@discard @inPlayStack.shift()

	discard: (card) -> #card was in use and is now being put back into the discardPile
		card.isVisible = no
		card.isRetained = no
		@discardStack.push card

	select: (index) ->
		card = @inPlayStack.splice(index, 1)[0] # retain the desired card
		card.isRetained = yes
		@clear()
		return card # return the card, expecting it to be moved to another CardGrouping

	replenishStack: ->
		for discarded in @discardStack
			@newStack.push @discardStack.shift()
		for inPlay in @inPlayStack
			@newStack.push @inPlayStack.shift()
		for card in @newStack
			card.reset()

	shuffle: ->
		@replenishStack()
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
		# lastly reset the cards
		for card in array
			card.isVisible = yes
			card.isFlipped = no
			card.isRetained = no

class ProductCardGrouping extends CardGrouping
	constructor: ->
		super 'bar-chart'
		@name = 'Product'
		for k, v of cards.events.product
			@add new v

class SecurityCardGrouping extends CardGrouping
	constructor: ->
		super 'shield'
		@name = 'Security'
		for k, v of cards.events.security
			@add new v

class EspionageCardGrouping extends CardGrouping
	constructor: ->
		super 'user-secret'
		@name = 'Espionage'
		for k, v of cards.events.espionage
			@add new v

class InnovationPoolCardGrouping extends CardGrouping
	constructor: ->
		super()
		for k, v of cards.subsidiaries
			@add new v

module.exports =
	ProductCardGrouping: ProductCardGrouping
	SecurityCardGrouping: SecurityCardGrouping
	EspionageCardGrouping: EspionageCardGrouping
	InnovationPoolCardGrouping: InnovationPoolCardGrouping
