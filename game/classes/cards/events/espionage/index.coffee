Event = require '../Event'

class EspionageEvent extends Event
	constructor: (id, icon) ->
		super id, icon
		@type = 'espionage'

class UnhashedPasswordFile extends EspionageEvent
	constructor: ->
		super @constructor.name, 'file-powerpoint-o'
		@stats.espionage = 3
		@expiry = 3
		@description = 'You found a list of passwords, unencrypted, in a document labelled "passwords".'

class CrawlerBots extends EspionageEvent
	constructor: ->
		super @constructor.name, 'eye'
		@stats.espionage = 5
		@expiry = 6
		@description = 'Crawl the web with bots and look for vulnerabilities'

class CompromisedComputers extends EspionageEvent
	constructor: ->
		super @constructor.name, 'group'
		@stats.espionage = 1
		@expiry = 1
		@description = 'We have a database of infected computers that can be used in a DDOS attack'

class CustomVirus extends EspionageEvent
	constructor: ->
		super @constructor.name, 'bug'
		@stats.espionage = 3
		@expiry = 15
		@description = 'Start work on a specialized virus to infect the next opponent we hack'

class NewHardware extends EspionageEvent
	constructor: ->
		super @constructor.name, 'server'
		@stats.espionage = 3
		@expiry = -1
		@description = 'If we invest in better hardware we can attempt hacking puzzles with greater success.'

class ManInTheMiddle extends EspionageEvent
	constructor: ->
		super @constructor.name, 'child'
		@stats.espionage = 5
		@expiry = 3
		@description = 'We\'ve identified an opportunity to listen in on competitors'

class HitTheBank extends EspionageEvent
	constructor: ->
		super @constructor.name, 'dollar'
		@stats.espionage = 6
		@expiry = 15
		@description = 'Steal corporate cash the next time you sucessfully hack'

class PhishingTechniques extends EspionageEvent
	constructor: ->
		super @constructor.name, 'dot-circle-o'
		@stats.espionage = 5
		@expiry = 3
		@description = 'Send out a mail campaign posing as your competitors and attempt to glean information'

class InfectPublicRouters extends EspionageEvent
	constructor: ->
		super @constructor.name, 'download'
		@stats.espionage = 3
		@expiry = 3
		@description = 'Have a hacker exploit as much public wifi as possible and scan for sensitive data'

class SSLExploit extends EspionageEvent
	constructor: ->
		super @constructor.name, 'minus'
		@stats.espionage = 7
		@expiry = 3
		@description = 'Use a new hacking technique to exploit secure connections'

class InjectionTechniques extends EspionageEvent
	constructor: ->
		super @constructor.name, 'neuter'
		@stats.espionage = 3
		@expiry = 3
		@description = 'Attempt to destroy important data tables from services through injection'

class SocialEngineering extends EspionageEvent
	constructor: ->
		super @constructor.name, 'glass'
		@stats.espionage = 5
		@expiry = 3
		@description = 'Sometimes there\'s no replacement for just pretending to be someone else on the phone'

module.exports =
	UnhashedPasswordFile: UnhashedPasswordFile
	CrawlerBots: CrawlerBots
	CompromisedComputers: CompromisedComputers
	CustomVirus: CustomVirus
	NewHardware: NewHardware
	ManInTheMiddle: ManInTheMiddle
	HitTheBank: HitTheBank
	PhishingTechniques: PhishingTechniques
	InfectPublicRouters: InfectPublicRouters
	SSLExploit: SSLExploit
	InjectionTechniques: InjectionTechniques
	SocialEngineering: SocialEngineering
