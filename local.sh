#!/bin/bash

cp -r /secret/nginx /etc/nginx
sudo service nginx restart

cd /vagrant && sudo jekyll serve -twP 80
