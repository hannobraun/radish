# Radish

## About

Radish is an atypical framework for browser games. Contrary to most other
frameworks, Radish isn't someone elses code that you just use from the outside.
Radish's code lives in your game's repository, right next to your own code. You
wish that one of Radish's features worked slightly different? Change it!
Something's getting in your way? Throw it out!

Radish uses HTML5 technology (specifically canvas) with
[CoffeeScript](http://coffeescript.org) for the programming language. It's ready
right now, if you need it. But be careful: It's still very rough around the
edges. Some parts are implemented in ways that are less than optimal and not all
the features you might expect from a framework are there yet.


## Get started

To create a game, just clone this repository and start filling in the blanks. If
any of the base code is not to your liking, feel free to modify or just outright
replace it.

Prepare the repository:

* git clone https://github.com/hannobraun/radish.git your-game
* cd your-game
* git submodule update --init

Install CoffeeScript: http://coffeescript.org


## Develop

Start continuous compilation on the command-line:  
./bin/compile

Generate some code, that helps you with development (this is required from time
to time):  
./bin/generate-modules

Run tests in the browser:  
http://path/to/your-game/tests

Run the game in the browser:  
http://path/to/your-game/public


## Deploy

There's a script that deploys your game to any Git repository of your choosing.
This is especially useful if said repository is hosted on GitHub, since you can
host your game on [GitHub Pages](http://pages.github.com) then.

Usage:

1. Edit the project configuration in "config" to fit your needs.
1. Run the deploy script from the base directory of your repository: ./bin/deploy

*Attention*: Don't run the deploy script from the bin directory (or any
other directory but the base directory of your repository). The script infers
the game's name from the directory it's run from, so if you, for example, run
from bin, the game will be deployed to a directory called "bin".


## Contribute

The contents of this repository are available under the permissive ISC license.
See the LICENSE file for details.

Feel free to contribute any improvements you make to the base code back to this
project. Just fork the repository on GitHub, port your changes and start a pull
request.
