#!/bin/bash
if [ "${TRAVIS_PULL_REQUEST}" = "true" ]; then
	cross-env NODE_ENV=test ./node_modules/.bin/mocha --ui bdd --reporter spec --colors --compilers js:babel-core/register server/tests --recursive 
  	npm run build 
	git add dist/
	git checkout -b release
	git commit -m "Dist"
	git push heroku release:master
fi
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
	cross-env NODE_ENV=test ./node_modules/.bin/mocha --ui bdd --reporter spec --colors --compilers js:babel-core/register server/tests --recursive
	npm run build
fi
