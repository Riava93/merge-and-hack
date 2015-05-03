GameStats = require '../GameStats'

clone = (obj) ->
	return obj  if obj is null or typeof (obj) isnt "object"
	temp = new obj.constructor()
	for key of obj
		temp[key] = clone(obj[key])
	temp

class MegaCorporation
	constructor: (@id, @icon) ->
		@name = @constructor.name
		@stats = new GameStats
		@description = ''
		@cash = 0
		@subsidiaries = [] # subsidiary company cards
		@events = [] # event cards
		@initialize()

	initialize: ->
		@calculateTotalStats()

	calculateTotalStats: ->
		@totalStats = clone @stats
		for subsidiary in @subsidiaries
			@totalStats.product += subsidiary.product
			@totalStats.security += subsidiary.security
			@totalStats.espionage += subsidiary.espionage
		console.log 'total stats', @totalStats

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
		@calculateTotalStats()

module.exports = MegaCorporation
