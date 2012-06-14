# Game Skeleton

## About

A skeleton project that helps me to get started quickly with new projects.

A bit too rough for public consumption but useful enough for me. Refinement and
documentation might happen or maybe not.


## Get started

git clone git://github.com/hbraun/game-skeleton.git your-game<br />
cd your-game<br />
git submodule update --init


## Development

Start compilation on the command-line:<br />
./scripts/develop

Run tests in the browser:<br />
http://path/to/your-game/test

Run the game in the browser:<br />
http://path/to/your-game/public


## Deployment

### Setup

git remote set-url origin your-repository-url<br />
git push -u origin master<br />

Additional setup steps are necessary but not documented yet.


### Deploying a new version

./scripts/deploy<br />
git push<br />
