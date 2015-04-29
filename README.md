# HTML5 Game Jam Template!

A basic template for HTML5 Games that can run without browser dependency using node.js
This is intended for games that can run without a server side but leverages node to help you run faster game simulations
than you would probably get by trying to do everything in the browser with user interactions

## Getting Started

1. You should have the popular node.js tools `npm, bower and grunt` installed
2. `$ npm install`
3. `$ grunt`

The browser should automatically launch when everything is built and monitor your changes with livereload

This template is also `bower.json` ready and has included the utility library `lodash` as a generic example

## Deploying

You can run `grunt deploy` to send your `out` folder directly to Amazon S3 for an instant hosting solution
However, you will need to make a copy of `config.sample.json` to `config.json` and fill out your personal credentials

### Preprocessors used
- Coffeescript
	Because subclassing is hella handy for game development and semicolons are just in your way
- SASS
	Because curly braces and semicolons are just in your way

## More info

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
