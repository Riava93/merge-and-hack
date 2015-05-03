Event = require '../Event'

class ProductEvent extends Event
	constructor: (id, icon) ->
		super id, icon
		@type = 'product'
		@expiry = 1
		@color = 'green'

class SuccessfulSprint extends ProductEvent
	constructor: ->
		super @constructor.name, 'simplybuilt'
		@stats.product = 6
		@expiry = 1
		@description = 'Deliver new product features from a successful sprint'

class MarketingPlan extends ProductEvent
	constructor: ->
		super @constructor.name, 'file-powerpoint-o'
		@stats.product = 6
		@expiry = 1
		@description = 'The last time we did marketing there was no plan. Let\'s try a plan this time and it might go better.'

class KeynoteSpeech extends ProductEvent
	constructor: ->
		super @constructor.name, 'bullhorn'
		@stats.product = 6
		@expiry = 1
		@description = 'Rent out the nearest opera house and hire the orchestra. This slideshow needs to look epic.'

class AdCampaign extends ProductEvent
	constructor: ->
		super @constructor.name, 'newspaper-o'
		@stats.product = 6
		@expiry = 1
		@description = 'We need to remind everyone that everything is totally fine.'

class ViralCampaign extends ProductEvent
	constructor: ->
		super @constructor.name, 'line-chart'
		@stats.product = 3
		@expiry = 3
		@description = 'There\'s no viral video quite like a paid-to-be viral video'

class ISOCompliance extends ProductEvent
	constructor: ->
		super @constructor.name, 'thumbs-up'
		@stats.product = 3
		@expiry = 3
		@description = 'It\'s time to start shipping less defective products'

class BrandRedesign extends ProductEvent
	constructor: ->
		super @constructor.name, 'rocket'
		@stats.product = 3
		@expiry = 3
		@description = 'The logo is sooo last Tuesday '

class SalesEvent extends ProductEvent
	constructor: ->
		super @constructor.name, 'dollar'
		@stats.product = 1
		@expiry = 15
		@description = 'Discounts on many of your product lines'

class NewProductLine extends ProductEvent
	constructor: ->
		super @constructor.name, 'laptop'
		@stats.product = 1
		@expiry = 15
		@description = 'Let\'s make something new and tell people they need it'

class ImprovedCustomerService extends ProductEvent
	constructor: ->
		super @constructor.name, 'hand-o-up'
		@stats.product = 1
		@expiry = 15
		@description = 'Require sensitivity training for all the sales reps'

class Spokesperson extends ProductEvent
	constructor: ->
		super @constructor.name, 'male'
		@stats.product = 1
		@expiry = 15
		@description = 'Ease your investors\' concerns the next time you take bad publicity for hacking'

module.exports =
	SuccessfulSprint: SuccessfulSprint
	MarketingPlan: MarketingPlan
	KeynoteSpeech: KeynoteSpeech
	AdCampaign: AdCampaign
	ViralCampaign: ViralCampaign
	ISOCompliance: ISOCompliance
	BrandRedesign: BrandRedesign
	SalesEvent: SalesEvent
	NewProductLine: NewProductLine
	ImprovedCustomerService: ImprovedCustomerService
	Spokesperson: Spokesperson
