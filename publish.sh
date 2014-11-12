set -e
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$BRANCH" != "master" ]; then
  echo "Current branch has to be master!"
  exit 1
fi
if [ -n "$(git status --porcelain)" ]; then 
  echo "Working directory must be clean!"
  exit 1
fi
git checkout gh-pages
cp -r build/* .
git add -A
git commit -am "publish"
git push origin gh-pages
git checkout master