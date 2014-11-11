set -e
elm --make --bundle-runtime --only-js Froggy/Main.elm
cp -r site/* build