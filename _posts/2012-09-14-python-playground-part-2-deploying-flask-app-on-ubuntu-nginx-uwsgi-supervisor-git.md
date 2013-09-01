---
title: Python Playground Part 2: Deploying Flask app on Ubuntu (nginx, uwsgi, supervisor, git)
date: 2012-09-14
permalink: 2012/09/python-playground-part-2-deploying-flask-app-on-ubuntu-nginx-uwsgi-supervisor-git

---

> This is a followup on my [previous post](/2012/09/python-playground-part-1-noimageyet-com-placeholder-image-service-experience/ "previous post") on building and getting up and running small online image placeholder generator service - [https://noimageyet.com](https://noimageyet.com "https://noimageyet.com").

This post will list steps to set up a Flask app in Ubuntu Linux server 12.04 using [nginx](http://nginx.com/), [uWSGI](http://projects.unbit.it/uwsgi/) and [supervisord](http://supervisord.org/). On top of that I will provide installation scripts and deployment scheme using Git SCM.

**Table of contents**
{{toc}}

## Credits First ##

This post (and service deployement in live) would not be possible without these awesome resources:

\[1\] [Conrad Kramer's "Getting a Flask website up and running in Ubuntu"][1]

\[2\] [Conrad Kramer's "Deploy a website using git in Ubuntu"][2] 

\[3\] [Linode StackScript: shazow's stack (nginx+uwsgi+postgresql+more)][3]

----------

## Installing Python stack ##

```console
$ sudo apt-get install -y python-software-properties python-dev python-pip
$ sudo pip install virtualenv
```

NoImageYet also requires [Python Imaging Library](http://www.pythonware.com/library/pil/handbook/index.htm "Python Imaging Library"), which depends on certain native libs. Here it goes:

```console 
$ sudo apt-get install -y libfreetype6-dev libjpeg62-dev libpng12-dev

 # PIL PIP package fails to install, since it expects libs located in /usr/lib/
 # So, will reset /usr/lib/ *.so references
$ sudo rm -rf /usr/lib/{libfreetype.so,libz.so,libjpeg.so}
$ sudo ln -s /usr/lib/*-linux-gnu/{libfreetype.so,libz.so,libjpeg.so} /usr/lib/
```

## Installing NGINX ##

```console
$ sudo apt-get install -y nginx
 # Nginx-related: Move the default nginx config name so that it doesn't take
 # priority over our other configurations.
$ sudo mv /etc/nginx/sites-enabled/{default,99_default}
```

## Installing Git, Supervisord and uWSGI ##

```console
$ sudo apt-get install -y build-essential git-core

$ sudo apt-get install -y supervisor
$ sudo apt-get install -y uwsgi uwsgi-plugin-python python-uwsgidecorators
```

## Creating Deploy / App user ##

You might want to change password from `password` to something more applicable ;)

```console
$ sudo adduser --disabled-password --gecos "" deploy

$ sudo passwd deploy <<EOF
password
password
EOF

echo "Adding deploy user to sudoers"
sudo tee -a /etc/sudoers <<EOF
deploy  ALL=(ALL) NOPASSWD:ALL
EOF
```

## Auto-magic deploy script ##

The script below is derived from [\[3\]][3].

Script summary: scipt creates folder layout, configures NGINX site, updates supervisod config and setups Git repository with post-receive hook to perform re-deploy on push magic.

**Script**
<script src="https://gist.github.com/3667663.js?file=create_project.sh"></script>

## Script usage / Deploying ##

* Get the script.

```console
$ cd /home/deploy
$ sudo -u deploy wget "https://raw.github.com/gist/3667663/create_project.sh"
$ sudo -u deploy chmod +x create_project.sh
```

* Login as deploy user, e.g. `su - deploy`
* Executing the script.
Parameters: app name (`theservice`) and service domain name (`yourdomain.com`)

```console
$ ./create_project.sh theservice yourdomain.com
 This script is intended to be run on a remote server, not on a local development environment. It will create a bunch of directories and change a bunch of configurations.
 Are you sure you want to continue? [y/N] y
 ...
  Setup your development clone as follows:
 
     git branch live
     git remote add -t live live ssh://deploy@192.168.1.103/home/deploy/repo/theservice
 
 Now you can deploy:
 
     git checkout live
     git merge master
     git checkout master
     git push live
 
 Or use this handy 'deploy' alias in your ~/.gitconfig file:
 
     deploy = "!merge(){ git checkout $2 && git merge $1 && git push $2 && git checkout ${1#refs/heads/}; }; merge $(git symbolic-ref HEAD) $1"
 
 So you can do (from 'master'):
 
     git deploy live
 
 Happy pushing!
```
Please follow the script instructions. When pushing please note: the script assumes folder layout is `theservice/theservice.py` and `theservice.py` exports Flask application as `app`. E.g.

```python
# theservice.py file 
#...
app = flask.Flask(__name__)
#...
```

* When application code has been pushed to server (following script recomendations) you should resolce app's dependecies and do proper app's configuration (db connections, etc ..)

```console
 # this will install app dependencies
$ source ~/env/noimageyet/local/bin/activate
 # usual way to provide/install dependencies
$ pip install -r deploy/theservice/requirements.txt

 ## restart services
$ sudo service nginx restart
 # supervisor sometimes fails to reload via restart 
$ sudo service supervisor stop
$ sleep 3
$ sudo service supervisor start
``` 

## Vuala part ##

We are done. Your service should be available at [http://youdomain.com](http://youdomain.com) and [http://www.youdomain.com](http://www.youdomain.com).

Deploy part should be as easy as sample below

```console
$ git add noimageyet.py && git commit -m 'the change'
 [master df78831] the change
  1 file changed, 1 insertion(+)
$ git deploy live
 Switched to branch 'live'
 Auto-merging noimageyet.py
 Merge made by the 'recursive' strategy.
  noimageyet.py |    1 +
  1 file changed, 1 insertion(+)
 deploy@noimageyet.com's password:
 Counting objects: 10, done.
 Delta compression using up to 4 threads.
 Compressing objects: 100% (6/6), done.
 Writing objects: 100% (6/6), 625 bytes, done.
 Total 6 (delta 4), reused 0 (delta 0)
 remote: From /home/deploy/repo/noimageyet
 remote:  * branch            live       -> FETCH_HEAD
 remote: Restarting uwsgi.
 To ssh://deploy@noimageyet.com/home/deploy/repo/noimageyet
    c76aa28..cd59843  live -> live
 Switched to branch 'master'
 Your branch is ahead of 'origin/master' by 1 commit.
```

## Profit ##

[http://knowyourmeme.com/memes/profit](http://knowyourmeme.com/memes/profit)

<!-- Link definition -->

[1]: <http://blog.kramerapps.com/post/22551999777/flask-uwsgi-nginx-ubuntu> "Getting a Flask website up and running in Ubuntu"
[2]: <http://blog.kramerapps.com/post/24447423014/deploy-website-git-ubuntu> "Deploy a website using git in Ubuntu" 
[3]: <http://www.linode.com/stackscripts/view/?StackScriptID=3249> "Linode StackScript: shazow's stack (nginx+uwsgi+postgresql+more)"

