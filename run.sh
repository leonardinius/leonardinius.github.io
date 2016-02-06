#!/bin/bash

#$FORCE_APK_INSTALL - Force install .apk 100% of the time.
#$BUNDLE_CACHE - Cache and install to the vendor/bundle folder.
#$POLLING - Force polling with --force_polling.
#$VERBOSE -  Enable jekyll --verbose.

docker run --rm \
  --label=jekyll \
  --volume=$(pwd):/srv/jekyll \
  -it \
  \
  --env BUNDLE_CACHE=1 \
  --env POLLING=1 \
  --env VERBOSE=1 \
  \
  -p 127.0.0.1:4000:4000 \
  \
  jekyll/jekyll:pages
