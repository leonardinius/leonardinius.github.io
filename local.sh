#!/bin/bash

sudo hostname leonardinius.galeoconsulting.com

cd /vagrant && sudo jekyll serve -twP 80 --config _config-dev.yml
