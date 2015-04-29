# HTML5 Game Jam Template!

A basic template for HTML5 Games that can run without browser dependency using node.js

## Getting Started

1. `$ npm install`
2. `$ grunt`

The browser should automatically launch when everything is built and monitor your changes with livereload

### Preprocessors used
- Coffeescript
	Because subclassing is hella handy for game development and semicolons are just in your way
- SASS
	Because curly braces and semicolons are just in your way


##### See the example output in your browser console
```
  // from app.js
  var game = new Game();
  game.start();
```

##### Or to run the game from your command line
```
  $ npm start
  // This will run the simulator.coffee file in the root of the project
```

##### Both should yield the same output and allow you to work with your game logic with or without a browser which maybe be easier for running fast simulations

## Put your browser depedent logic in `app/`
## Put your game specific logic in `game/`
