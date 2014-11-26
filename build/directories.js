var path = require('path');

exports.build = path.dirname(process.argv[1]);

exports.cache = path.join(exports.build, 'cache');
exports.elmDependencies = path.join(exports.build, 'elm_dependencies');
exports.project = path.join(exports.build, '..');

exports.target = path.join(exports.project, 'target/');
var source = path.join(exports.project, 'src');

exports.site = path.join(source, 'site/');
exports.elm = path.join(source, 'elm/');