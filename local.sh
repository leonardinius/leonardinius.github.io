#!/bin/bash

sudo hostname leonardinius.galeoconsulting.com

cd /vagrant \
  && dos2unix -q _drafts/* _posts/* _layout/* \
  && rm -rf ./_site \
  && sudo jekyll serve \
   --watch \
   --port 80 \
   --force_polling \
   --drafts  \
   --config _config-dev.yml
