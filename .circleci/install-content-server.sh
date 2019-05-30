#!/bin/bash -ex

DIR=$(dirname "$0")

if grep -e "fxa-content-server" -e 'all' $DIR/../packages/test.list; then
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-248.0.0-linux-x86_64.tar.gz
  tar zxvf google-cloud-sdk-248.0.0-linux-x86_64.tar.gz google-cloud-sdk
  ./google-cloud-sdk/install.sh
  sudo apt-get install -y graphicsmagick
  mkdir -p config
  cp ../version.json ./
  cp ../version.json config
  cd $DIR/..
  CIRCLECI=false npm install
  npx pm2 kill
else
  exit 0;
fi
