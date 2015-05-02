Card = require '../Card'

class Event extends Card
	constructor: (id, icon) ->
		super id, icon
		@value = 0
		@expiry = -1

	tick: (@event) ->
		super()
		if @expiry isnt -1
			@expiry--

	shouldExpire: ->
		return @expiry is 0

module.exports = Event
