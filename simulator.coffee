Game = require './game/game'

game = new Game()
game.start()

# first player selects espionage event and a merger
firstCard = game.board.selectCard 2, 0
game.board.selectMerge()
game.board.confirmMerger yes
