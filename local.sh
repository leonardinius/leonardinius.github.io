#!/bin/bash

sudo hostname leonardinius.galeoconsulting.com

cd /vagrant \
  && sudo jekyll serve \
   --port 80 \
   --lsi \ 
   --watch \
   --force_polling \
   --drafts \
   --config _config-dev.yml
