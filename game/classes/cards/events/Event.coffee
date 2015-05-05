Card = require '../Card'

class Event extends Card
	constructor: (id, icon) ->
		super id, icon
		@type = null
		@value = 0
		@expiry = -1 # what ticks down and resets
		@baseExpiry = -1 # the static setting for the card
		@hasMerged = false
		@currentBonus = 0

	tick: (board, corp) ->
		super board
		console.log 'corp cash', corp.cash, 'adding product value', @stats.product
		if @expiry isnt -1
			@expiry--

	reset: ->
		super()
		@expiry = @baseExpiry

	merge: (currentPlayer) ->
		currentPlayer?.stats.espionage += @stats.espionage if @stats.espionage?
		currentPlayer?.stats.security += @stats.security if @stats.security?
		currentPlayer?.stats.product += @stats.product if @stats.product?
		@hasMerged = true

	resetBonus: ->

	shouldExpire: ->
		return @expiry is 0

module.exports = Event
