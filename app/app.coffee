angular.module 'mergeAndHack', ['ngAnimate']

	.controller 'GameController', ($scope, $window) ->
		_theGame = new $window.Game
		$scope.game = _theGame
		$scope.game.start()

		$scope.setPlayer = (corporation) ->
			_theGame.board.chooseCorporation(corporation)

		$scope.chooseCorporation = ->
			_theGame.board.state.current = _theGame.board.state.CHOOSE_CORP

		$scope.startGame = ->
			_theGame.board.nextTurn()

		$scope.selectEventCard = (index) ->
			_theGame.board.selectCard index, 0

		$scope.chooseMerge = ->
			_theGame.board.selectMerge()

		$scope.confirmMerger = (shouldMerge) ->
			_theGame.board.confirmMerger shouldMerge

		$scope.chooseHack = ->
			_theGame.board.selectHack()

		$scope.confirmHack = (target) ->
			console.log 'confirming hack'
			_theGame.board.confirmHack target

		$scope.revealPuzzleCell = (x, y) ->
			_theGame.board.hackPuzzleCellClick x, y

		$scope.confirmResults = ->
			_theGame.board.endTurn()

		###
		# Prelim
		###
		$scope.chooseCorporation()
		$scope.setPlayer _theGame.board.players[0]

	.filter 'prettyPercent', ->
		return (double) ->
			return Math.ceil(double * 100) + '%'

	.filter 'prettyMoney', ->
		return (int) ->
			return "$#{int}B"

	.filter 'prettyName', ->
		return (name) ->
			theName = name.replace(/([a-z])([A-Z])/g, '$1 $2')
				.replace(/\b([A-Z]+)([A-Z])([a-z])/, '$1 $2$3')
				.replace(/^./, (str) -> return str.toUpperCase())
			return theName
