MegaCorporation = require './Corporation'
subsidiaries = require '../cards/subsidiaries'

class SparkFresh extends MegaCorporation
	constructor: ->
		super 'SparkFresh Inc.', 'bolt'
		@stats.product = 5
		@stats.security = 3
		@stats.espionage = 3
		@cash = 100
		@description = 'A product focused company that grew to prominence with affiliate marketing. No one likes to talk about those days.'

class BubbleHearth extends MegaCorporation
	constructor: ->
		super 'Bubble Hearth Industries', 'sun-o'
		@stats.product = 3
		@stats.security = 5
		@stats.espionage = 3
		@cash = 50
		@description = 'A security focused company that made it\'s fortune from providing insurance on virtual game items'

class Tinjeki extends MegaCorporation
	constructor: ->
		super 'Tinjeki Corporation', 'database'
		@stats.product = 3
		@stats.security = 3
		@stats.espionage = 5
		@cash = 10
		@description = 'A suspicious company with year on year growth but no clear business model. They seem to have some effective techniques.'

module.exports =
	SparkFresh: SparkFresh,
	BubbleHearth: BubbleHearth
	Tinjeki: Tinjeki
