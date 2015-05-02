Event = require '../Event'

class SecurityEvent extends Event
	constructor: (@currentPlayer) ->
		super 'icon'
		@bonusType = 'security'

class HashedPasswords extends SecurityEvent
	constructor: (@currentPlayer) ->
		super()
		@stats.security = 3

	tick: ->
		@currentBonus = 0
		@currentBonus += 1 unless @currentBonus is 7
		console.log "Hashed Passwords has increased it's security stat to #{@stats.security}"

	resetBonus: ->
		console.log "Resetting Bonus"
		@currentBonus = 0

class InjectionPrevention extends SecurityEvent
	constructor: ->
		super()
		@stats.security = 3

class CrossOriginPolicy extends SecurityEvent
	constructor: ->
		super()
		@stats.security = 2

module.exports =
	HashedPasswords: HashedPasswords
	InjectionPrevention: InjectionPrevention
	CrossOriginPolicy: CrossOriginPolicy

