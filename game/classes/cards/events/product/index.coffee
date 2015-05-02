Event = require '../Event'

class ProductEvent extends Event
	constructor: (@id) ->
		super @id
		@expiry = 1

class CoolProduct extends ProductEvent
	constructor: ->
		@expiry = 3
	tick: (corporation) ->
		corporation.stats.product += 1

module.exports =
	ProductEvent: ProductEvent
	CoolProduct: CoolProduct
