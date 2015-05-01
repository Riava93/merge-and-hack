Card = require '../Card'

class Subsidiary extends Card
	constructor: (@id) ->
		super @id
		@value = 0

	tick: ->
		super()

class SidekickSubsidiary extends Subsidiary
	constructor: ->
		super 'sidekick'
		@value = 10000000

module.exports =
	SidekickSubsidiary: SidekickSubsidiary
