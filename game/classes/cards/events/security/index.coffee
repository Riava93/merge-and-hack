Event = require '../Event'

class SecurityEvent extends Event
	constructor: (id, icon) ->
		super id, icon
		@bonusType = 'security'

class HashedPasswords extends SecurityEvent
	constructor: () ->
		super 'Hashed Passwords', 'icon'
		@description = 'It\'s time to stop being so irresponsible'
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
		@description = 'Whoever keeps dropping our `Users` table needs to stop'
		@stats.security = 3

class CrossOriginPolicy extends SecurityEvent
	constructor: ->
		super()
		@description = 'Our users are getting scammed from phishing sites'
		@stats.security = 2

class AccessControl extends SecurityEvent
	constructor: ->
		super()
		@description = 'It occured to management that User #1 shouldn\'t be able to edit User #2'

class HTTPS extends SecurityEvent
	constructor: ->
		super()
		@description = 'Maybe we shouldn\'t be accepting credit cards over unencrypted lines...'

class CSRFTokens extends SecurityEvent
	constructor: ->
		super()
		@description = 'We should probably prevent our input forms from being abused'

class ReduceVulnerabilities extends SecurityEvent
	constructor: ->
		super()
		@description = 'We need to root out vulnerable 3rd party code'

class SecureSessions extends SecurityEvent
	constructor: ->
		super()
		@description = 'We need more secure session that can\'t be comprimised'

class OAuthAccess extends SecurityEvent
	constructor: ->
		super()
		@description = 'Giving users revokable passwordless access would be a good idea'

class ConsistentSecurity extends SecurityEvent
	constructor: ->
		super()
		@description = 'Our security configurations are a mess; let\'s fix them'

class ReduceExposure extends SecurityEvent
	constructor: ->
		super()
		@description = 'There is opportunity to expose less potentially critical data from servers'

class GetOffOfWordPress extends SecurityEvent
	constructor: ->
		super()
		@description = 'This has just be asking for trouble since we launched.'

class Insurance extends SecurityEvent
	constructor: ->
		super()
		@description = 'In the event of a hack, recieve a cash payout from your insurance provider'

module.exports =
	HashedPasswords: HashedPasswords
	InjectionPrevention: InjectionPrevention
	CrossOriginPolicy: CrossOriginPolicy
	AccessControl: AccessControl
	HTTPS: HTTPS
	CSRFTokens: CSRFTokens
	ReduceVulnerabilities: ReduceVulnerabilities
	SecureSessions: SecureSessions
	OAuthAccess: OAuthAccess
	ConsistentSecurity: ConsistentSecurity
	ReduceExposure: ReduceExposure
	GetOffOfWordPress: GetOffOfWordPress
	Insurance: Insurance

