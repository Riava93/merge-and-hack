CardGrouping = require './CardGrouping'
corporations = require './cards/corporations'

class Board
	constructor: ->
		@players = [
			new corporations.SparkFresh
			new corporations.SomethingCorp
			new corporations.OtherCorp
		]
		@productCards = new CardGrouping
		@securityCards = new CardGrouping
		@espionageCards = new CardGrouping



module.exports = Board
