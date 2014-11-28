#!/usr/bin/env node

require('shelljs/global');
var directories = require('./directories.js');
var path = require('path');

rm('-Rf', directories.target);

cp('-R', directories.site, directories.target);

cd(directories.build);
exec('elm --make --bundle-runtime --only-js --build-dir=' + directories.target + ' --src-dir=' + directories.elm + ' Froggy/Main.elm');
// XXX workaround for https://github.com/elm-lang/elm-compiler/issues/618
var cacheFiles = find(directories.elm).filter(function(filePath) {
  var extension = path.extname(filePath);
  return extension == '.elmi' || extension == '.elmo';
});
rm(cacheFiles);

var imagePaths = ls('-R', directories.site).filter(function(filePath) {
  var extension = path.extname(filePath);
  return extension == '.svg' || extension == '.png' || extension == '.jpg';
});
var script = 'var images = ' + JSON.stringify(imagePaths) + ';';
script.to(path.join(directories.target, 'images.js'));