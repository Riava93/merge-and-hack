MegaCorporation = require './Corporation'
subsidiaries = require '../cards/subsidiaries'

class Sparkfresh extends MegaCorporation
	constructor: ->
		super 'SparkFresh Inc.', 'bolt'
		@affinity = 'product'
		@color = 'green'

	initialize: ->
		@stats.product = 50
		@stats.security = 3
		@stats.espionage = 3
		@cash = 50
		@description = 'A product focused company that grew to prominence with affiliate marketing. No one likes to talk about those days.'
		super()

class BubbleHearth extends MegaCorporation
	constructor: ->
		super 'Bubble Hearth Industries', 'sun-o'
		@affinity = 'security'
		@color = 'medium-blue'

	initialize: ->
		@stats.product = 3
		@stats.security = 50
		@stats.espionage = 3
		@cash = 50
		@description = 'A security focused company that made it\'s fortune from providing insurance on virtual game items'
		super()

class Tinjeki extends MegaCorporation
	constructor: ->
		super 'Tinjeki Corporation', 'database'
		@affinity = 'espionage'
		@color = 'orange'

	initialize: ->
		@stats.product = 3
		@stats.security = 3
		@stats.espionage = 50
		@cash = 10
		@description = 'A suspicious company with year on year growth but no clear business model. They seem to have some effective techniques.'
		super()

module.exports =
	Sparkfresh: Sparkfresh,
	BubbleHearth: BubbleHearth
	Tinjeki: Tinjeki
