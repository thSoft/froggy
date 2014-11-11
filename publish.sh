set -e
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ $BRANCH -ne "master" ]] ; then
    exit 1
fi
git stash
git checkout gh-pages
cp -r build/* .
git add -A
git commit -am "publish"
git push origin gh-pages
git checkout master
git stash pop