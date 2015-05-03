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

	tick: (board, wasHackAttempted) ->
		console.log '-----------'
		console.log @name, 'tick'
		console.log '-----------'
		@getInvestorTrust()
		for subsidiary in @subsidiaries
			subsidiary.tick()
		for event, i in @events
			event.merge @ if event.hasMerged isnt true
			if wasHackAttempted and board.getCurrentPlayer() is @
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

			event.tick board, @
			if event.shouldExpire()
				event.ownerGrouping.discard event
				@events.splice i, 1

	getInvestorTrust: ->
		for subsidiary in @subsidiaries
			@totalTrust += subsidiary.trustLevel

class SparkFresh extends MegaCorporation
	constructor: ->
		super 'SparkFresh Inc.', 'bolt'
		@stats.product = 5
		@stats.security = 3
		@stats.espionage = 3
		@cash = 100
		@description = 'A product focused company that grew to prominence with affiliate marketing. No one likes to talk about those days.'

class BubbleHearth extends MegaCorporation
	constructor: ->
		super 'Bubble Hearth Industries', 'sun-o'
		@stats.product = 3
		@stats.security = 5
		@stats.espionage = 3
		@cash = 50
		@description = 'A security focused company that made it\'s fortune from providing insurance on virtual game items'

class Tinjeki extends MegaCorporation
	constructor: ->
		super 'Tinjeki Corporation', 'database'
		@stats.product = 3
		@stats.security = 3
		@stats.espionage = 5
		@cash = 10
		@description = 'A suspicious company with year on year growth but no clear business model. They seem to have some effective techniques.'

module.exports =
	SparkFresh: SparkFresh,
	BubbleHearth: BubbleHearth
	Tinjeki: Tinjeki
