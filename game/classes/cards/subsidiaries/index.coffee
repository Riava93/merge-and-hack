Card = require '../Card'

class Subsidiary extends Card
	constructor: (id, icon) ->
		super id, icon
		@value = 10
		@trustLevel = 20  # Default starting trust level

	tick: ->
		super()
		@bonusTick()

class Sidekick extends Subsidiary
	constructor: ->
		super 'sidekick', 'male'
		@stats.security = 3
		@stats.product = 4
		@stats.espionage = 3

	bonusTick: ->
		console.log 'Sidekick Ticked!'

class Froogle extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'A discount super store chain'

class Guygantic extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'They really know how to make an impressive slideshow.'

class WhitemanOil extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'The profit margin\'s are phenomenal but owning them might hurt our image'

class MaximumViableProduct extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'These guys go big or go home'

class Oligoplimart extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'A chain of supermarkets by different names that collectively fix prices'

class Calvinball extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'Their product line changes every day, but I\'ll be damned if they don\'t get things done'

class Banana extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'It\'s just a banana company. There\'s nothing special here. Why do people line up for these?'

class BarkshoreHashere extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'A holding company might be a good place to improve our porfolio'

class SpamazonWebServices extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = ''

class UnitedProductService extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'They make great products, but we should use someone else to deliver them.'

class Security extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = ''

class NationalBusinessMachines extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = ''

class CashCompanion extends Subsidiary
	constructor: ->
		super @constructor.name, 'icon'
		@description = 'They are really good with not losing money'

module.exports =
	Sidekick: Sidekick
	Froogle: Froogle
	Guygantic: Guygantic
	WhitemanOil: WhitemanOil
	MaximumViableProduct: MaximumViableProduct
	Oligoplimart: Oligoplimart
	Calvinball: Calvinball
	Banana: Banana
	BarkshoreHashere: BarkshoreHashere
	SpamazonWebServices: SpamazonWebServices
	UnitedProductService: UnitedProductService
	Security: Security
	NationalBusinessMachines: NationalBusinessMachines
	CashCompanion: CashCompanion
