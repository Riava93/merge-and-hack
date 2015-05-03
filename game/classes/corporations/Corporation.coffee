GameStats = require '../GameStats'

class MegaCorporation
	constructor: (@id, @icon) ->
		@name = @constructor.name
		@stats = new GameStats
		@description = ''
		@cash = 0
		@subsidiaries = [] # subsidiary company cards
		@events = [] # event cards

	tick: (board, wasHackAttempted) ->
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

module.exports = MegaCorporation
