Card = require '../Card'

subsidiaries = require '../subsidiaries'

class MegaCorporation extends Card
	constructor: (id, icon) ->
		super id, icon
		@cash = 0
		@subsidiaries = [
			new subsidiaries.Sidekick
		] # subsidiary company cards
		@events = [] # event cards
		@totalTrust = 0

	tick: (board, wasHacked) ->
		console.log '-----------'
		console.log @name, 'tick'
		console.log '-----------'
		@getInvestorTrust()
		for subsidiary in @subsidiaries
			subsidiary.tick()
		for event, i in @events
			event.merge @ if event.hasMerged isnt true
			if wasHacked
				console.log "tick event: A hack has been done"
				@stats.security -= event.currentBonus if event.bonusType is 'security'
				@stats.espionage -= event.currentBonus if event.bonusType is 'espionage'
				@stats.product -= event.currentBonus if event.bonusType is 'product'
				event.resetBonus()
			else if event.currentBonus > 0
				console.log "currentBonus is growing"
				console.log "Current Security is #{@stats.security}"
				@stats.security += event.currentBonus if event.bonusType is 'security'
				@stats.espionage += event.currentBonus if event.bonusType is 'espionage'
				@stats.product += event.currentBonus if event.bonusType is 'product'

			event.tick()
			if event.shouldExpire()
				event.ownerGrouping.discard event
				@events.splice i, 1

	getInvestorTrust: ->
		for subsidiary in @subsidiaries
			@totalTrust += subsidiary.trustLevel

class SparkFresh extends MegaCorporation
	constructor: ->
		super 'SparkFresh Inc.', 'bomb'
		@stats.product = 5
		@stats.security = 3
		@stats.espionage = 3

class SomethingCorp extends MegaCorporation
	constructor: ->
		super 'Something Inc.', 'bomb'
		@stats.product = 3
		@stats.security = 3
		@stats.espionage = 5

class OtherCorp extends MegaCorporation
	constructor: ->
		super 'Other Stuff Inc.', 'bomb'
		@stats.product = 3
		@stats.security = 5
		@stats.espionage = 3

module.exports =
	SparkFresh: SparkFresh,
	SomethingCorp: SomethingCorp,
	OtherCorp: OtherCorp
