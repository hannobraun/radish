# Game Skeleton

## About

A skeleton project that helps me to get started quickly with new projects.

A bit too rough for public consumption but useful enough for me. Refinement and
documentation might happen or maybe not.


## Get started

Prepare the repository:

- git clone https://github.com/hannobraun/browser-game-skeleton.git your-game<br />
- cd your-game<br />
- git submodule update --init

Install coffeescript: http://coffeescript.org


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
your game using [GitHub Pages](http://pages.github.com) then.

Usage:

1. Edit the configuration in scripts/deploy to fit your needs.
1. Run the script from the base directory of your repository: ./scripts/deploy

*Attention*: Don't run the deploy script from the scripts directory (or any
other directory but the base directory of your repository). The script infers
the game's name from the directory it's run from, so if you run from scripts,
the game will be deployed to a directory called "scripts".
