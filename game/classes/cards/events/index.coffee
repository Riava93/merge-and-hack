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

class ProductEvent extends Event
	constructor: (@id) ->
		super @id
		@expiry = 1

class SecurityEvent extends Event
class EspionageEvent extends Event

module.exports =
	ProductEvent: ProductEvent
	SecurityEvent: SecurityEvent
	EspionageEvent: EspionageEvent
