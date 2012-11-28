# Browser Game Skeleton

## About

This is a skeleton project that helps me to get started quickly with new
browser game projects. It uses HTML5 technology (specifically canvas) with
[CoffeeScript](http://coffeescript.org) for the programming language. The
repository provides some base code (you could call it a framework), as well as
infrastructure for developing and deploying your game.

Feel free to use this, if you feel that it helps you with your game, although
all of this might still be a bit too rough for public consumption.


## Get started

To create a game, just clone the repository and start filling in the blanks. If
any of the base code is not to your liking, feel free to modify or just outright
replace it.

Prepare the repository:

- git clone https://github.com/hannobraun/browser-game-skeleton.git your-game<br />
- cd your-game<br />
- git submodule update --init

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
This is especially useful if said repository is hosted on GitHub, since you host
your game on [GitHub Pages](http://pages.github.com) then.

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
