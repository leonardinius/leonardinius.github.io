#!/bin/bash

sudo hostname leonardinius.galeoconsulting.com

cd /vagrant \
  && rm -rf ./_site \
  && sudo jekyll serve \
   --watch \
   --force_polling \
   --port 80 \
   --drafts  \
   --config _config-dev.yml
