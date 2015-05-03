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
		@affinity = null # does the mega corp lean to one direction when AI is deciding?
		@initialize()

	initialize: ->
		@calculateTotalStats()

	calculateTotalStats: ->
		@totalStats = clone @stats
		for subsidiary in @subsidiaries
			@totalStats.product += subsidiary.stats.product
			@totalStats.security += subsidiary.stats.security
			@totalStats.espionage += subsidiary.stats.espionage

	tick: (board, wasHackAttempted) ->
		for subsidiary in @subsidiaries
			subsidiary.tick()
		for i in [(@events.length - 1)..0] by -1 #@events
			event = @events[i]
			event.merge @
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
