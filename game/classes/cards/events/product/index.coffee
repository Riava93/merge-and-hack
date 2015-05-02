Event = require '../Event'

class ProductEvent extends Event
	constructor: (id) ->
		super id
		@expiry = 1

class SuccessfulSprint extends ProductEvent
	constructor: ->
		super()
		@description = 'Deliver new product features from a successful sprint'

class MarketingPlan extends ProductEvent
	constructor: ->
		super()
		@description = ''

class KeynoteSpeech extends ProductEvent
	constructor: ->
		super()
		@description = ''

class AdCampaign extends ProductEvent
	constructor: ->
		super()
		@description = ''

class ViralCampaign extends ProductEvent
	constructor: ->
		super()
		@description = ''

class ISOCompliance extends ProductEvent
	constructor: ->
		super()
		@description = 'It\'s time to start shipping less defective products'

class BrandRedesign extends ProductEvent
	constructor: ->
		super()
		@description = ''

class SalesEvent extends ProductEvent
	constructor: ->
		super()
		@description = 'Discounts on many of your product lines'

class NewProductLine extends ProductEvent
	constructor: ->
		super()
		@description = ''

class ImprovedCustomerService extends ProductEvent
	constructor: ->
		super()
		@description = 'Require sensitivity training for all our sales reps'

class Spokesperson extends ProductEvent
	constructor: ->
		super()
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
