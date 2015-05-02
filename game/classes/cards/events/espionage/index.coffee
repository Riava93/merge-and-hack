Event = require '../Event'

class EspionageEvent extends Event
	constructor: (id, icon) ->
		super id, icon

class UnhashedPasswordFile extends EspionageEvent
	constructor: ->
		super()
		@description = 'You found a list of passwords, unencrypted, in a document labelled "passwords".'

class CrawlerBots extends EspionageEvent
	constructor: ->
		super()
		@description = 'Crawl the web with bots and look for vulnerabilities'

class CompromisedComputers extends EspionageEvent
	constructor: ->
		super()
		@description = 'We have a database of infected computers that can be used in a DDOS attack'

class CustomVirus extends EspionageEvent
	constructor: ->
		super()
		@description = 'Start work on a specialized virus to infect the next opponent we hack'

class NewHardware extends EspionageEvent
	constructor: ->
		super()
		@description = 'If we invest in better hardware we can attempt hacking puzzles with greater success.'

class ManInTheMiddle extends EspionageEvent
	constructor: ->
		super()
		@description = 'We\'ve identified an opportunity to listen in on competitors'

class HitTheBank extends EspionageEvent
	constructor: ->
		super()
		@description = 'Steal corporate cash the next time you sucessfully hack'

class PhishingTechniques extends EspionageEvent
	constructor: ->
		super()
		@description = 'Send out a mail campaign posing as your competitors and attempt to glean information'

class InfectPublicRouters extends EspionageEvent
	constructor: ->
		super()
		@description = 'Have a hacker exploit as much public wifi as possible and scan for sensitive data'

class SSLExploit extends EspionageEvent
	constructor: ->
		super()
		@description = 'Use a new hacking technique to exploit secure connections'

class InjectionTechniques extends EspionageEvent
	constructor: ->
		super()
		@description = 'Attempt to destroy important data tables from services through injection'

class SocialEngineering extends EspionageEvent
	constructor: ->
		super()
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
