Event = require '../Event'

class SecurityEvent extends Event
	constructor: (id, icon) ->
		super id, icon
		@type = 'security'
		@bonusType = 'security'
		@color = 'medium-blue'

class HashedPasswords extends SecurityEvent
	constructor: ->
		super @constructor.name, 'ellipsis-v'
		@stats.security = 3
		@baseExpiry = 1
		@description = 'It\'s time to stop being so irresponsible'

class InjectionPrevention extends SecurityEvent
	constructor: ->
		super @constructor.name, 'unlink'
		@stats.security = 2
		@baseExpiry = 1
		@description = 'Whoever keeps dropping our \'Users\' table need to stop'

class CrossOriginPolicy extends SecurityEvent
	constructor: ->
		super @constructor.name, 'file-code-o'
		@stats.security = 3
		@baseExpiry = 1
		@description = 'Our users are getting scammed from phishing sites'

class AccessControl extends SecurityEvent
	constructor: ->
		super @constructor.name, 'group'
		@stats.security = 4
		@baseExpiry = 1
		@description = 'It occured to management that User #1 shouldn\'t be able to edit User #2'

class HTTPS extends SecurityEvent
	constructor: ->
		super @constructor.name, 'lock'
		@stats.security = 5
		@baseExpiry = 1
		@description = 'Maybe we shouldn\'t be accepting credit cards over unencrypted lines...'

class CSRFTokens extends SecurityEvent
	constructor: ->
		super @constructor.name, 'circle-o-notch'
		@stats.security = 3
		@baseExpiry = 1
		@description = 'We should probably prevent our input forms from being abused'

class ReduceVulnerabilities extends SecurityEvent
	constructor: ->
		super @constructor.name, 'bug'
		@stats.security = 3
		@baseExpiry = 1
		@description = 'We need to root out vulnerable 3rd party code'

class SecureSessions extends SecurityEvent
	constructor: ->
		super @constructor.name, 'lock'
		@stats.security = 2
		@baseExpiry = 1
		@description = 'We need more secure session that can\'t be comprimised'

class OauthAccess extends SecurityEvent
	constructor: ->
		super @constructor.name, 'circle-o-notch'
		@stats.security = 4
		@baseExpiry = 1
		@description = 'Giving users revokable passwordless access would be a good idea'

class ConsistentSecurity extends SecurityEvent
	constructor: ->
		super @constructor.name, 'ban'
		@stats.security = 5
		@baseExpiry = 1
		@description = 'Our security configurations are a mess; let\'s fix them'

class ReduceExposure extends SecurityEvent
	constructor: ->
		super @constructor.name, 'eye-slash'
		@stats.security = 4
		@baseExpiry = 1
		@description = 'There is opportunity to expose less potentially critical data from servers'

class GetOffOfWordpress extends SecurityEvent
	constructor: ->
		super @constructor.name, 'wordpress'
		@stats.security = 7
		@baseExpiry = 1
		@description = 'This has been asking for a security breach since the day we launched'

class Insurance extends SecurityEvent
	constructor: ->
		super @constructor.name, 'diamond'
		@stats.security = 4
		@baseExpiry = 15
		@description = 'Management had this idea of making backups of our stuff. I think it could work.'

module.exports =
	HashedPasswords: HashedPasswords
	InjectionPrevention: InjectionPrevention
	CrossOriginPolicy: CrossOriginPolicy
	AccessControl: AccessControl
	HTTPS: HTTPS
	CSRFTokens: CSRFTokens
	ReduceVulnerabilities: ReduceVulnerabilities
	SecureSessions: SecureSessions
	OauthAccess: OauthAccess
	ConsistentSecurity: ConsistentSecurity
	ReduceExposure: ReduceExposure
	GetOffOfWordpress: GetOffOfWordpress
	Insurance: Insurance
