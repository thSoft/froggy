git stash
git checkout gh-pages
cp build/Froggy/Main.html index.html
git commit -am "publish"
git push origin gh-pages
git checkout master
git stash pop