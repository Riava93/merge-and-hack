Card = require '../Card'

class Event extends Card
	constructor: (id, icon) ->
		super id, icon
		@value = 0
		@expiry = -1
		@hasMerged = false
		@currentBonus = 0

	tick: ->
		super()
		if @expiry isnt -1
			@expiry--

	merge: (currentPlayer) ->
		currentPlayer?.stats.espionage += @stats.espionage if @stats.espionage?
		currentPlayer?.stats.security += @stats.security if @stats.security?
		currentPlayer?.stats.product += @stats.product if @stats.product?
		@hasMerged = true

	resetBonus: ->


	shouldExpire: ->
		return @expiry is 0

module.exports = Event
