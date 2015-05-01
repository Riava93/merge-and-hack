Card = require '../Card'

class Subsidiary extends Card
	constructor: (@id) ->
		super @id
		@value = 0

	tick: ->
		super()

module.exports = Subsidiary
