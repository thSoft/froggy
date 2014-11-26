#!/usr/bin/env node

require('shelljs/global');

var currentBranch = exec('git rev-parse --abbrev-ref HEAD', { silent:true }).output;
var masterBranch = 'master';
if (currentBranch != (masterBranch + '\n')) {
  echo('Current branch has to be ' + masterBranch + '!');
  exit(1);
}
var status = exec('git status --porcelain', { silent:true }).output;
if (status != '') {
  echo('Working directory must be clean!');
  exit(1);
}
var pagesBranch = 'gh-pages';
exec('git checkout ' + pagesBranch);
cp('-Rf', 'build/', '.');
exec('git add -A');
exec('git commit -am "publish"');
exec('git push origin ' + pagesBranch);
exec('git checkout ' + masterBranch);