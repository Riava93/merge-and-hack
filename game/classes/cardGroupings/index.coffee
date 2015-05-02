cards = require '../cards'

class CardGrouping
	constructor: (@icon) ->
		@name = @constructor.name
		@allCards = [] # a reference holder to all cards in this grouping, regardles of their state
		@newStack = [] # the face down stack of cards
		@inPlayStack = [] # cards facing up, currently in play
		@discardStack = [] # used cards, discarded and ready to be shuffled

	add: (card) -> # put a card in the pile set grouping as the owner
		card.ownerGrouping = @
		@allCards.push card
		@newStack.push card

	draw: ->
		card = @newStack.shift() # remove the top card and put it in play
		card.isFlipped = yes
		@inPlayStack.push card

	clear: ->
		for discardable in @inPlayStack # put the remaining cards in the discard pile
			@discard @inPlayStack.shift()

	discard: (card) -> #card was in use and is now being put back into the discardPile
		card.isVisible = no
		card.isRetained = no
		@discardStack.push card

	select: (index) ->
		card = @inPlayStack.splice(index, 1)[0] # retain the desired card
		card.isRetained = yes
		@clear()
		return card # return the card, expecting it to be moved to another CardGrouping

	replenishStack: ->
		for discarded in @discardStack
			@newStack.push @discardStack.shift()
		for inPlay in @inPlayStack
			@newStack.push @inPlayStack.shift()

	shuffle: ->
		@replenishStack()
		array = @newStack
		counter = array.length
		#While there are elements in the array
		while counter > 0
			#Pick a random index
			index = Math.floor(Math.random() * counter)
			#Decrease counter by 1
			counter--
			#And swap the last element with it
			temp = array[counter]
			array[counter] = array[index]
			array[index] = temp
		# lastly reset the cards
		for card in array
			card.isVisible = yes
			card.isFlipped = no
			card.isRetained = no

class ProductCardGrouping extends CardGrouping
	constructor: ->
		super 'bar-chart'
		@name = 'Product'
		@add new cards.events.product.SuccessfulSprint
		@add new cards.events.product.MarketingPlan
		@add new cards.events.product.KeynoteSpeech
		@add new cards.events.product.AdCampaign
		@add new cards.events.product.ViralCampaign
		@add new cards.events.product.ISOCompliance
		@add new cards.events.product.BrandRedesign
		@add new cards.events.product.SalesEvent
		@add new cards.events.product.NewProductLine
		@add new cards.events.product.ImprovedCustomerService
		@add new cards.events.product.Spokesperson

class SecurityCardGrouping extends CardGrouping
	constructor: ->
		super 'shield'
		@name = 'Security'
		@add new cards.events.security.HashedPasswords
		@add new cards.events.security.InjectionPrevention
		@add new cards.events.security.CrossOriginPolicy
		@add new cards.events.security.AccessControl
		@add new cards.events.security.HTTPS
		@add new cards.events.security.CSRFTokens
		@add new cards.events.security.ReduceVulnerabilities
		@add new cards.events.security.SecureSessions
		@add new cards.events.security.OAuthAccess
		@add new cards.events.security.ConsistentSecurity
		@add new cards.events.security.ReduceExposure
		@add new cards.events.security.GetOffOfWordPress
		@add new cards.events.security.Insurance

class EspionageCardGrouping extends CardGrouping
	constructor: ->
		super 'user-secret'
		@name = 'Espionage'
		@add new cards.events.espionage.UnhashedPasswordFile
		@add new cards.events.espionage.CrawlerBots
		@add new cards.events.espionage.CompromisedComputers
		@add new cards.events.espionage.CustomVirus
		@add new cards.events.espionage.NewHardware
		@add new cards.events.espionage.ManInTheMiddle
		@add new cards.events.espionage.HitTheBank
		@add new cards.events.espionage.PhishingTechniques
		@add new cards.events.espionage.InfectPublicRouters
		@add new cards.events.espionage.SSLExploit
		@add new cards.events.espionage.InjectionTechniques
		@add new cards.events.espionage.SocialEngineering

class InnovationPoolCardGrouping extends CardGrouping
	constructor: ->
		super()
		@newStack.push new cards.subsidiaries.Sidekick
		@newStack.push new cards.subsidiaries.Froogle
		@newStack.push new cards.subsidiaries.Guygantic
		@newStack.push new cards.subsidiaries.WhitemanOil
		@newStack.push new cards.subsidiaries.MaximumViableProduct
		@newStack.push new cards.subsidiaries.Oligoplimart
		@newStack.push new cards.subsidiaries.Calvinball
		@newStack.push new cards.subsidiaries.Banana
		@newStack.push new cards.subsidiaries.BarkshoreHashere
		@newStack.push new cards.subsidiaries.SpamazonWebServices
		@newStack.push new cards.subsidiaries.UnitedProductService
		@newStack.push new cards.subsidiaries.Security
		@newStack.push new cards.subsidiaries.NationalBusinessMachines
		@newStack.push new cards.subsidiaries.CashCompanion

module.exports =
	ProductCardGrouping: ProductCardGrouping
	SecurityCardGrouping: SecurityCardGrouping
	EspionageCardGrouping: EspionageCardGrouping
	InnovationPoolCardGrouping: InnovationPoolCardGrouping
