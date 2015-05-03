Card = require '../Card'

class Subsidiary extends Card
	constructor: (id, institution) ->
		super id, institution
		@value = 10
		@trustLevel = 20  # Default starting trust level
		@stats.security = 1
		@stats.product = 1
		@stats.espionage = 1

	tick: (board, corp) ->
		super()
		corp.cash += Math.ceil(@stats.product / 10)
		@bonusTick()  # Not really implemented

###
# Product companies
###

class Sidekick extends Subsidiary
	constructor: ->
		super 'sidekick', 'smile-o'
		@description = 'Gee Will-a-kers, Batman!'
		@stats.security = 30
		@stats.product = 40
		@stats.value = 80

class Froogle extends Subsidiary
	constructor: ->
		super @constructor.name, 'shopping-cart'
		@description = 'Tell them at the counter what you want and if you\'re feeling lucky they might give you a discount on whatever they find first.'
		@stats.product = 30
		@value = 65

class Guygantic extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'They really know how to make an impressive slideshow.'
		@stats.product = 20
		@value = 40

class WhitemanOil extends Subsidiary
	constructor: ->
		super @constructor.name, 'tint'
		@description = 'The profit margin\'s are phenomenal but owning them might hurt our image'
		@stats.product = 40
		@value = 50

class MaximumViableProduct extends Subsidiary
	constructor: ->
		super @constructor.name, 'institution'
		@description = 'These guys go big or go home'
		@stats.product = 50
		@value = 70

class Oligoplimart extends Subsidiary
	constructor: ->
		super @constructor.name, 'sitemap'
		@description = 'A chain of supermarkets by different names that collectively fix prices'
		@stats.product = 50
		@value = 90

class CalvinBall extends Subsidiary
	constructor: ->
		super @constructor.name, 'soccer-ball-o'
		@description = 'Their product line changes every day, but I\'ll be damned if they don\'t get things done'
		@stats.product = 30
		@value = 30

class Banana extends Subsidiary
	constructor: ->
		super @constructor.name, 'phone'
		@description = 'It\'s just a banana company. There\'s nothing special here. Why do people line up for these?'
		@stats.product = 35
		@value = 48

class BarkshoreHashere extends Subsidiary
	constructor: ->
		super @constructor.name, 'bitcoin'
		@description = 'A holding company might be a good place to improve our porfolio'
		@stats.product = 30
		@value = 55

class Quadcomm extends Subsidiary
	constructor: ->
		super @constructor.name, 'volume-up'
		@description = 'The future of communications - Near Field Telepathy. Feels kind of tingley.'
		@stats.product = 40
		@value = 80

class UnitedProductService extends Subsidiary
	constructor: ->
		super @constructor.name, 'cube'
		@description = 'They make great products, but we should use someone else to deliver them.'
		@stats.product = 35
		@value = 50

class FinePrintCo extends Subsidiary
	constructor: ->
		super @constructor.name, 'file-word-o'
		@description = 'The kings of legalese. They use an 8px font on their website.'
		@stats.product = 20
		@value = 30

###
# Security companies
###

class NationalBusinessMachines extends Subsidiary
	constructor: ->
		super @constructor.name, 'database'
		@description = 'A premier enterprise business solutions company.'
		@value = 130
		@stats.security = 60

class DukesSecurity extends Subsidiary
	constructor: ->
		super @constructor.name, 'life-ring'
		@description = 'An average security company that stays in business mostly by bandwagoning on Dukes of Hazzard nostalgia in its commercials.'
		@value = 30
		@stats.security = 20

class CashCompanion extends Subsidiary
	constructor: ->
		super @constructor.name, 'eur'
		@description = 'They are really good with not losing money'
		@value = 60
		@stats.security = 20

class EdgeSecurity extends Subsidiary
	constructor: ->
		super @constructor.name, 'exclamation-triangle'
		@description = 'A company pushing the limits on web security and extreme sports.'
		@value = 80
		@stats.security = 30

class IntelliSolutions extends Subsidiary
	constructor: ->
		super @constructor.name, 'group'
		@description = 'A strong research team, but their engineers are really socially akward.'
		@value = 40
		@stats.security = 20

class Macrosoft extends Subsidiary
	constructor: ->
		super @constructor.name, 'star-o'
		@description = 'Security, security, security, security.'
		@value = 150
		@stats.security = 50

class JonesControlSystems extends Subsidiary
	constructor: ->
		super @constructor.name, 'lock'
		@description = 'Their master control room does not disappoint. Lifestyles of the secure and discrete.'
		@value = 20
		@stats.security = 10

class GenSecSecurities extends Subsidiary
	constructor: ->
		super @constructor.name, 'filter'
		@description = 'A new age security company led by an ex black hat hacker.'
		@value = 60
		@stats.security = 30

class TheSecurityCompany extends Subsidiary
	constructor: ->
		super @constructor.name, 'shield'
		@description = 'You don\'t need a witty business name to prevent hacktastrophes'
		@value = 95
		@stats.security = 40

class ChariotSecurity extends Subsidiary
	constructor: ->
		super @constructor.name, 'space-shuttle'
		@description = 'The premier security provider. You know you are overpaying, but it will be great for your image.'
		@value = 70
		@stats.security = 40

###
# Espionage
###

class SpyTechCo extends Subsidiary
	constructor: ->
		super @constructor.name, 'eye'
		@description = 'Distributors of novelty and amateur spy technology. Their regulars are a bit creepy.'
		@stats.espionage = 10
		@value = 20

class UniversalElectric extends Subsidiary
	constructor: ->
		super @constructor.name, 'bolt'
		@description = 'This company does all things electrical. They can hack anything from your toaster to an enterprise.'
		@stats.espionage = 10
		@value = 35

class BullseyeSystems extends Subsidiary
	constructor: ->
		super @constructor.name, 'bullseye'
		@description = 'A vulnerbilities exploitation company. Show them a weak spot and they will mess it up.'
		@stats.espionage = 10
		@value = 30

class DoctorAndGamble extends Subsidiary
	constructor: ->
		super @constructor.name, 'plus-square'
		@description = 'A company of researchers, risktakers and exploiters. They also hacked the potato chip.'
		@stats.espionage = 10
		@value = 25

class SystoSystems extends Subsidiary
	constructor: ->
		super @constructor.name, 'align-justify'
		@description = 'The company is best known for making Systception. A system within a system within a system within a container.'
		@stats.espionage = 40
		@value = 80

class PipMorris extends Subsidiary
	constructor: ->
		super @constructor.name, 'eyedropper'
		@description = 'This company offers systems for directly wiring your brain into a computer. Its good for productivity and feels amazing.'
		@stats.espionage = 40
		@value = 80

class SpamazonWebServices extends Subsidiary
	constructor: ->
		super @constructor.name, 'cogs'
		@description = 'The premier DDOS systems provider. They guarantee 99.9% downtime for your target.'
		@stats.espionage = 50
		@value = 128

class Falliburton extends Subsidiary
	constructor: ->
		super @constructor.name, 'meh-o'
		@description = 'A company focussed in vulnerability identification. They slogan is \'Be Evil\', so at least they are forward.'
		@stats.espionage = 20
		@value = 44

class Gonesanto extends Subsidiary
	constructor: ->
		super @constructor.name, 'legal'
		@description = 'They claim they can make any problem go away.'
		@stats.espionage = 80
		@value = 190

class WeeverIndustries extends Subsidiary
	constructor: ->
		super @constructor.name, 'magic'
		@description = 'They are famous for finding and exposing vulnerabilities in companies.'
		@stats.espionage = 80
		@value = 140

module.exports =
	# Prod
	Sidekick: Sidekick
	Froogle: Froogle
	Guygantic: Guygantic
	WhitemanOil: WhitemanOil
	MaximumViableProduct: MaximumViableProduct
	Oligoplimart: Oligoplimart
	CalvinBall: CalvinBall
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
