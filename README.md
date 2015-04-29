# HTML5 Game Jam Template!
This is intended for games that can run without a server side but leverages node.js to help you run faster game simulations
than you would probably get by trying to do everything in the browser with user interactions

**NOTE**: This template uses Coffeescript and SASS preprocessors

## Getting Started

1. You should have the popular node.js tools `npm, bower and grunt` installed
2. `$ npm install`
3. `$ grunt`

The browser should automatically launch when everything is built and monitor your changes with livereload

## Developing your game

#### Put your browser dependent logic in `app/`
#### Put your game specific logic in `game/`

## In the browser

`Game` has been exposed as a global variable in the browser
 See the example output in your browser console after building by opening `out/index.html`

This template is also `bower.json` ready and has included the utility library `lodash` as a generic example of how you can add 3rd party libraries for your browser code

## In the command line
```
  $ npm start // This will run the simulator.coffee file in the root of the project
```

## Deploying

You can run `grunt deploy` to send your `out` folder directly to Amazon S3 for an instant hosting solution
However, you will need to make a copy of `config.sample.json` to `config.json` and fill out your personal credentials

## Other info
### Preprocessors used
- **Coffeescript** - Because subclassing is hella handy for game development and semicolons are just in your way
- **SASS** - Because curly braces and semicolons are just in your way

