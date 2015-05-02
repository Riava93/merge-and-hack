Event = require '../Event'

class SecurityEvent extends Event
	constructor: ->
		super 'icon'

class HashedPasswords extends SecurityEvent
	constructor: ->
		super()
		@stats.security = 3

	tick: ->
		console.log 'Hashed Passwords tick activated'

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

