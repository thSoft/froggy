set -e
rm -rf build
cp -R site/ build
elm --make --bundle-runtime --only-js Froggy/Main.elm
node generateImageList.js