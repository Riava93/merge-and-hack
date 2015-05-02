TestGame = require './game/Game'
Event = require './game/classes/cards/events/security/index'

test = new TestGame
test.start()
currentPlayer = test.board.getCurrentPlayer()

console.log currentPlayer.stats

hashedPasswords = new Event.HashedPasswords
currentPlayer.events.push hashedPasswords
test.board.triggerTick()

console.log currentPlayer.stats


console.log "Hashed Passwords Event Security #{currentPlayer.stats.security}"

test.board.triggerTick()

console.log "Hashed Passwords Event Security #{currentPlayer.stats.security}"

test.board.triggerTick()
test.board.triggerTick()
test.board.triggerTick()

console.log "Hashed Passwords Event Security #{currentPlayer.stats.security}"
