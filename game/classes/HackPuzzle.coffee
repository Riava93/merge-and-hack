class HackPuzzle

	constructor: (@attacker, @defender, @totalTurns = 3) ->
		@playerEspionage = @attacker.stats.espionage
		@targetsSecurity = @defender.stats.security
		@cells_grid = [[], [], []]
		@buildGrid()
		@calculateProbability()
		@populateIceNodes()

	calculateProbability: ->
		# (1 - (attackEsp / defendSec)) * 6 [randomly choose Math.ceil, or Math.floor]
		@probability = ((1 - @playerEspionage / @targetsSecurity) * 6 || 1)
		if @probability < 0
			return @probability = 0

		rand_num = Math.random()

		if rand_num > 0.5
			@probability = Math.ceil(@probability)
		else
			@probability = Math.floor(@probability)

		console.log 'probability', @probability

	buildGrid: ->
		#  Instantiate a new cell in the grid
		for y in [0...3]
			for x in [0...3]
				@cells_grid[x][y] = new Cell x, y

	populateIceNodes: ->
		count = 0
		while count isnt @probability
			xCell = Math.floor(Math.random() * 3)  # Choose random x coordinate
			yCell = Math.floor(Math.random() * 3)  # Choose random y coordinate
			cell = @cells_grid[xCell][yCell]
			cell.setCellSafety(false)  # Create an ice node
			console.log(xCell, yCell, cell)
			count++

	checkForWin: ->
		@hackSuccessful = false

		# Check all rows...
		@hackSuccessful = true if (@cells_grid[0][0].value + @cells_grid[1][0].value + @cells_grid[2][0].value) is 3
		@hackSuccessful = true if (@cells_grid[0][1].value + @cells_grid[1][1].value + @cells_grid[2][1].value) is 3
		@hackSuccessful = true if (@cells_grid[0][2].value + @cells_grid[1][2].value + @cells_grid[2][2].value) is 3

		# Check all columns...
		@hackSuccessful = true if (@cells_grid[0][0].value + @cells_grid[0][1].value + @cells_grid[0][2].value) is 3
		@hackSuccessful = true if (@cells_grid[1][0].value + @cells_grid[1][1].value + @cells_grid[1][2].value) is 3
		@hackSuccessful = true if (@cells_grid[2][0].value + @cells_grid[2][1].value + @cells_grid[2][2].value) is 3

		# Check L2R Diagonal for win
		@hackSuccessful = true if (@cells_grid[0][2].value + @cells_grid[1][1].value + @cells_grid[2][0].value) is 3
		# Check R2L Diagonal for win
		@hackSuccessful = true if (@cells_grid[2][2].value + @cells_grid[1][1].value + @cells_grid[0][0].value) is 3

	activateCell: (xCell, yCell) ->
		@cells_grid[xCell][yCell].activate()
		@checkForWin()
		@totalTurns--
#		console.log 'turns remaining', @totalTurns
#		console.log 'successful?', @hackSuccessful
#		console.log 'over?', @hackSuccessful isnt true and @outOfTurns()

		if @hackSuccessful is true
			return yes
		else if @hackSuccessful isnt true and @outOfTurns()
			return yes

		return no

	# check if out of turns
	outOfTurns: ->
		@totalTurns is 0

	bailOut: ->
		yes


class Cell

	constructor: (x, y, safe = true) ->
		@isSafe = true  # This may be irrelevant
		@isRevealed = false
		@value = 0
		@x = x
		@y = y

	isCellSafe: ->
		@isSafe

	setCellSafety: (safeBool) ->
		@isSafe = safeBool

	activate: ->
		@isRevealed = yes
		if @isSafe
			@value = 1
		else
			@value = 0

module.exports = HackPuzzle
