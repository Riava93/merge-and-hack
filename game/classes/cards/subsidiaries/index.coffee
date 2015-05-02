Card = require '../Card'

class Subsidiary extends Card
	constructor: (id, icon) ->
		super id, icon
		@value = 0
		@trustLevel = 20  # Default starting trust level

	tick: ->
		super()
		@bonusTick()


class SidekickSubsidiary extends Subsidiary
	constructor: ->
		super 'sidekick', 'male'
		@value = 10000000
		@stats.security = 3
		@stats.product = 4
		@stats.espionage = 3

	bonusTick: ->
		console.log 'Sidekick Ticked!'


module.exports =
	SidekickSubsidiary: SidekickSubsidiary
