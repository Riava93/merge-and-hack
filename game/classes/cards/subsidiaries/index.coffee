Card = require '../Card'

class Subsidiary extends Card
	constructor: (id, institution) ->
		super id, institution
		@value = 10
		@trustLevel = 20  # Default starting trust level
		@stats.security = 1
		@stats.product = 1
		@stats.espionage = 1

	tick: ->
		super()
		@bonusTick()

###
# Product companies
###

class Sidekick extends Subsidiary
	constructor: ->
		super 'sidekick', 'institution'
		@stats.security = 30
		@stats.product = 40
		@stats.espionage = 30

	bonusTick: ->
		console.log 'Sidekick Ticked!'

class Froogle extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'Tell them at the counter what you want and if you\'re feeling lucky they might give you a discount on whatever they find first.'
		@stats.product = 10
		@value = 10

class Guygantic extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'They really know how to make an impressive slideshow.'
		@stats.product = 10
		@value = 10

class WhitemanOil extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'The profit margin\'s are phenomenal but owning them might hurt our image'
		@stats.product = 10
		@value = 10

class MaximumViableProduct extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'These guys go big or go home'
		@stats.product = 10
		@value = 10

class Oligoplimart extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'A chain of supermarkets by different names that collectively fix prices'
		@stats.product = 10
		@value = 10

class Calvinball extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'Their product line changes every day, but I\'ll be damned if they don\'t get things done'
		@stats.product = 10
		@value = 10

class Banana extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'It\'s just a banana company. There\'s nothing special here. Why do people line up for these?'
		@stats.product = 10
		@value = 10

class BarkshoreHashere extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'A holding company might be a good place to improve our porfolio'
		@stats.product = 10
		@value = 10

class Quadcomm extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'The future of communications - Near Field Telepathy. Feels kind of tingley.'
		@stats.product = 10
		@value = 10

class UnitedProductService extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'They make great products, but we should use someone else to deliver them.'
		@stats.product = 10
		@value = 10

class FinePrintCo extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'The kings of legalese. They use an 8px font on their website.'
		@stats.product = 10
		@value = 10

###
# Security companies
###

class NationalBusinessMachines extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'A premier enterprise business solutions company.'
		@value = 10
		@stats.security = 10

class DukesSecurity extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'An average security company that stays in business mostly by bandwagoning on Dukes of Hazzard nostalgia in its commercials.'
		@value = 10
		@stats.security = 10

class CashCompanion extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'They are really good with not losing money'
		@value = 10
		@stats.security = 10

class EdgeSecurity extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'A company pushing the limits on web security and extreme sports.'
		@value = 10
		@stats.security = 10

class IntelliSolutions extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'A strong research team, but their engineers are really socially akward.'
		@value = 10
		@stats.security = 10

class Macrosoft extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'Security, security, security, security.'
		@value = 10
		@stats.security = 10

class JonesControlSystems extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'Their master control room does not disappoint. Lifestyles of the secure and discrete.'
		@value = 10
		@stats.security = 10

class GenSecSecurities extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'A new age security company led by an ex black hat hacker.'
		@value = 10
		@stats.security = 10

class TheSecurityCompany extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'You don\'t need a witty business name to prevent hacktastrophes'
		@value = 10
		@stats.security = 10

class ChariotSecurity extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'The premier security provider. You know you are overpaying, but it will be great for your image.'
		@value = 10
		@stats.security = 10

###
# Espionage
###

class SpyTechCo extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'Distributors of novelty and amateur spy technology. Their regulars are a bit creepy.'
		@stats.espionage = 10
		@value = 10

class UniversalElectric extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'This company does all things electrical. They can hack anything from your toaster to an enterprise.'
		@stats.espionage = 10
		@value = 10

class BullseyeSystems extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'A vulnerbilities exploitation company. Show them a weak spot and they will mess it up.'
		@stats.espionage = 10
		@value = 10

class DoctorAndGamble extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'A company of researchers, risktakers and exploiters. They also hacked the potato chip.'
		@stats.espionage = 10
		@value = 15

class SystoSystems extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'The company is best known for making Systception. A system within a system within a system within a container.'
		@stats.espionage = 40
		@value = 20

class PipMorris extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'This company offers systems for directly wiring your brain into a computer. Its good for productivity and feels amazing.'
		@stats.espionage = 40
		@value = 20

class SpamazonWebServices extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'The premier DDOS systems provider. They guarantee 99.9% downtime for your target.'
		@stats.espionage = 50
		@value = 28

class Falliburton extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'A company focussed in vulnerability identification. They slogan is \'Be Evil\', so at least they are forward.'
		@stats.espionage = 20
		@value = 50

class Gonesanto extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'They claim they can make any problem go away.'
		@stats.espionage = 80
		@value = 50

class WeeverIndustries extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'They are famous for finding and exposing vulnerabilities in companies.'
		@stats.espionage = 80
		@value = 50

module.exports =
	# Prod
	Sidekick: Sidekick
	Froogle: Froogle
	Guygantic: Guygantic
	WhitemanOil: WhitemanOil
	MaximumViableProduct: MaximumViableProduct
	Oligoplimart: Oligoplimart
	Calvinball: Calvinball
	Banana: Banana
	BarkshoreHashere: BarkshoreHashere
	Quadcomm: Quadcomm
	UnitedProductService: UnitedProductService
	FinePrintCo: FinePrintCo

	# Sec
	NationalBusinessMachines: NationalBusinessMachines
	DukesSecurity: DukesSecurity
	CashCompanion: CashCompanion
	EdgeSecurity: EdgeSecurity
	IntelliSolutions: IntelliSolutions
	Macrosoft: Macrosoft
	JonesControlSystems: JonesControlSystems
	GenSecSecurities: GenSecSecurities
	TheSecurityCompany: TheSecurityCompany
	ChariotSecurity: ChariotSecurity

	# Esp
	SpyTechCo: SpyTechCo
	UniversalElectric: UniversalElectric
	BullseyeSystems: BullseyeSystems
	DoctorAndGamble: DoctorAndGamble
	SystoSystems: SystoSystems
	PipMorris: PipMorris
	SpamazonWebServices: SpamazonWebServices
	Falliburton: Falliburton
	Gonesanto: Gonesanto
	WeeverIndustries: WeeverIndustries
