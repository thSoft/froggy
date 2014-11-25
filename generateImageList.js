var fs = require('fs');
var path = require('path');
var wrench = require('wrench');

var allPaths = wrench.readdirSyncRecursive('site');
var imagePaths = allPaths.filter(function (filePath) {
  var extension = path.extname(filePath);
  return extension == '.png' || extension == '.jpg';
});
var script = 'var images = ' + JSON.stringify(imagePaths) + ';';
fs.writeFileSync('build/images.js', script, 'utf8');