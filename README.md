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

There are is a deploy script that deploys your game to the gh-pages branch of
your repository. This is useful if your repository is hosted on
[GitHub](http://github.com), since it will deploy your game to
[GitHub Pages](http://pages.github.com).

### Setup

git remote set-url origin your-repository-url<br />
git push -u origin master<br />

Additional setup steps are necessary but not documented yet.


### Deploying a new version

./scripts/deploy<br />
git push<br />
