#!/usr/bin/env node

require('shelljs/global');
var path = require('path');

var buildDirectory = 'build/';
var siteDirectory = 'site/';
rm('-Rf', buildDirectory);
cp('-R', siteDirectory, buildDirectory);
exec('elm --make --bundle-runtime --only-js Froggy/Main.elm');

var allPaths = ls('-R', siteDirectory);
var imagePaths = allPaths.filter(function(filePath) {
  var extension = path.extname(filePath);
  return extension == '.png' || extension == '.jpg';
});
var script = 'var images = ' + JSON.stringify(imagePaths) + ';';
script.to(path.join(buildDirectory, 'images.js'));