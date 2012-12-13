# Radish

## About

Radish is a skeleton for browser games. It contains code and tools that help you
get started quickly with your new game.

In that sense it's kind of like a framework, except that it's not. A framework
is someone else's code that you use from the outside. The Radish code lives in
your own repository, right next to your game's code. You wish that one feature
worked slightly different? Change it! Something's getting in your way? Throw it
out!

Radish uses HTML5 technology (specifically canvas) with
[CoffeeScript](http://coffeescript.org) for the programming language. It's ready
right now, if you need it, but be careful: Radish is still pretty young and not
everything you would expect might be there yet.


## Get started

To create a game, just clone this repository and start filling in the blanks. If
any of the base code is not to your liking, feel free to modify or just outright
replace it.

Prepare the repository:

* git clone https://github.com/hannobraun/browser-game-skeleton.git your-game
* cd your-game
* git submodule update --init

Install CoffeeScript: http://coffeescript.org


## Develop

Start continuous compilation on the command-line:<br />
./scripts/compile

Run tests in the browser:<br />
http://path/to/your-game/tests

Run the game in the browser:<br />
http://path/to/your-game/public


## Deploy

There's a script that deploys your game to any Git repository of your choosing.
This is especially useful if said repository is hosted on GitHub, since you can
host your game on [GitHub Pages](http://pages.github.com) then.

Usage:

1. Edit the configuration section in scripts/deploy to fit your needs.
1. Run the script from the base directory of your repository: ./scripts/deploy

*Attention*: Don't run the deploy script from the scripts directory (or any
other directory but the base directory of your repository). The script infers
the game's name from the directory it's run from, so if you, for example, run
from scripts, the game will be deployed to a directory called "scripts".


## Contribute

The contents of this repository are available under the permissive ISC license.
See the LICENSE file for details.

Feel free to contribute any improvements you make to the base code back to this
project. Just fork the repository on GitHub, port your changes and start a pull
request.
