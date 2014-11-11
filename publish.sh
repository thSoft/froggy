git stash
git checkout gh-pages
cp build/* .
git commit -am "publish"
git push origin gh-pages
git checkout master
git stash pop