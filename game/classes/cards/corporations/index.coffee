Card = require '../Card'

subsidiaries = require '../subsidiaries'

class MegaCorporation extends Card
	constructor: (id, icon) ->
		super id, icon
		@cash = 0
		@subsidiaries = [
			new subsidiaries.SidekickSubsidiary
		] # subsidiary company cards
		@events = [] # event cards

	tick: (board) ->
		console.log '-----------'
		console.log @name, 'tick'
		console.log '-----------'
		for subsidiary in @subsidiaries
			subsidiary.tick()
		for event, i in @events
			event.tick()
			if event.shouldExpire()
				event.ownerGrouping.discard event
				@events.splice i, 1

class SparkFresh extends MegaCorporation
	constructor: ->
		super 'SparkFresh Inc.', 'bomb'

class SomethingCorp extends MegaCorporation
	constructor: ->
		super 'Something Inc.', 'bomb'

class OtherCorp extends MegaCorporation
	constructor: ->
		super 'Other Stuff Inc.', 'bomb'

module.exports =
	SparkFresh: SparkFresh,
	SomethingCorp: SomethingCorp,
	OtherCorp: OtherCorp
