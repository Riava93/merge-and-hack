angular.module 'mergeAndHack', ['ngAnimate']

	.controller 'GameController', ($scope, $window) ->
		_theGame = new $window.Game
		$scope.game = _theGame
		$scope.game.start()

		$scope.setPlayer = (corporation) ->
			_theGame.board.chooseCorporation(corporation)
			_theGame.board.setAI()
			_theGame.board.nextTurn()

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
