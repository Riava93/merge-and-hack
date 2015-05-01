GameStats = require '../Card'

class MegaCorporation
	constructor: (@name) ->
		@stats = new GameStats
		@subsidiaries = []

class SparkFresh extends MegaCorporation
	constructor: ->
		super 'SparkFresh Inc.'

class SomethingCorp extends MegaCorporation
	constructor: ->
		super 'Something Inc.'

class OtherCorp extends MegaCorporation
	constructor: ->
		super 'Other Stuff Inc.'

module.exports =
	SparkFresh: SparkFresh,
	SomethingCorp: SomethingCorp,
	OtherCorp: OtherCorp
