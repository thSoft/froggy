#!/usr/bin/env node

require('shelljs/global');
var common = require('./common.js');
var path = require('path');

rm('-Rf', common.buildDirectory);
cp('-R', common.siteDirectory, common.buildDirectory);
exec('elm --make --bundle-runtime --only-js Froggy/Main.elm');

var allPaths = ls('-R', common.siteDirectory);
var imagePaths = allPaths.filter(function(filePath) {
  var extension = path.extname(filePath);
  return extension == '.png' || extension == '.jpg';
});
var script = 'var images = ' + JSON.stringify(imagePaths) + ';';
script.to(path.join(common.buildDirectory, 'images.js'));