---
title: Python playground: Minimum Viable Product experience
date: 2012-09-11
permalink: 2012/09/python-playground-part-1-noimageyet-com-placeholder-image-service-experience.html

---

> Disclaimer: This is one of the 'My adventures in Python world' stories. This post is first one in NoImageYet.com MVP experience series. 

> **Update:** 
>  You also might be interested in [Part 2: Deploying Flask app on Ubuntu (nginx, uwsgi, supervisor, git)](/2012/09/python-playground-part-2-deploying-flask-app-on-ubuntu-nginx-uwsgi-supervisor-git/ "Part 2: Deploying Flask app on Ubuntu (nginx, uwsgi, supervisor, git)")

**Paragraphs**

{{toc}}

## The biggest problem of all: to find  one 
During my spare time experiments I eventually desided to train my python muscles on some simple, yet real world problem / service. I tried to choose as simple problem as possible, still not too simple. 
My requirements were:

- small, simple, 1 file solution preferred
- web-service, flask preferred
- approximate 16h (newbie time): ~3-4 evenings or 1 weekend
- I should be able to launch publicly on one of the many PaaS out there
- play with UI things, such as [Twitter Bootstrap](http://twitter.github.com/bootstrap/ "Twitter Bootstrap") et cetera 

I was thinking very hard several days before I was able to pick. Some imagined problems seemed too big, to difficult, others too small and trivial. After all I decided to copycast [DummyImage.com](http://dummyimage.com "DummyImage.com") placeholder image service. It is:

- small and simple
- does one thing
- is web-site + web-service
- I felt I could squeeze in 1 weekend estimate

## How did it turned out in practice?

Quick answer is - rather good than bad. The service itself took ~3-4 evenings (as expected), however PaaS deployment, configuration and SSL things took another day or so. So, the original estimate got extended to ~1/3, which is around industry average for project estimates.

## Lessons learned

- I tried to take this spare time playground thing as small project so a little/no planning was involved. As a result multiple actions were not thought through and action items such as "deploy to [X] PaaS out there" turned out to be "investigate options", "evaluate pricing", "Ough, I actually need DNS, don't I?" etc ... As a result timeline shifted.
- I tried to take this project as small funny thing, nothing personal, no feelings attached. Just another small, "MINIMAL" service. However, in the retrospective, I was bad in this, always tried another one "better" thing, again and again tried to improve and enchance this little thing, trying to feed "inner perfectionist" aka "inner artist".

## Service Demo aka Show Me The Code

- [Source code on Github](https://github.com/leonardinius/noimage-py "Source code on Github")
- [https://noimageyet.com/](https://noimageyet.com/ "https://noimageyet.com/") service itself

<a href="https://noimageyet.com/"><img src="/resources/images/2012-09-11_2358_noimageyet_screenshot.png" title="NoImageYet service screenshot" /></a>

## What's next? 

In the next articles I will describe my adventures chosing PaaS, installing stack (Ubuntu, Nginx, Uwsgi etc...) and will provide step-by-step instructions and/or installation scripts. Stay tuned ;) 

_**Update:** Here it is - [Part 2: Deploying Flask app on Ubuntu (nginx, uwsgi, supervisor, git)](/2012/09/python-playground-part-2-deploying-flask-app-on-ubuntu-nginx-uwsgi-supervisor-git/ "Part 2: Deploying Flask app on Ubuntu (nginx, uwsgi, supervisor, git)")_