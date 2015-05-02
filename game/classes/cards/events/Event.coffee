Card = require '../Card'

class Event extends Card
	constructor: (@id) ->
		super @id
		@value = 0
		@expiry = -1

	tick: ->
		super()
		if @expiry isnt -1
			@expiry--

	shouldExpire: ->
		return @expiry is 0

module.exports = Event
