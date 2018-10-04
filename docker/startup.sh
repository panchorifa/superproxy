#! /bin/sh

./docker/wait-for-services.sh
./docker/prepare-db.sh
cd api && yarn start &
cd sentinel && yarn start &
npm rebuild node-sass
yarn add -D jit-grunt
grunt dev-webapp
