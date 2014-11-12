set -e
rm -rf build
elm --make --bundle-runtime --only-js Froggy/Main.elm
cp -r site/* build