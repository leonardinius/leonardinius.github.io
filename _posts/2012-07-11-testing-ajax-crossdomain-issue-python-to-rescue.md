---
title: Browser Ajax crossdomain issue - Python twisted reverse proxy to rescue.
date: 2012-07-11
permalink: 2012/07/testing-ajax-crossdomain-issue-python-to-rescue

---

Struggle
---
It is big day today. It's first time python came in handy in my day-to-day job ;) Ok, ok, there might have been 5ek other ways to nail that, but it felt so good then need for 'learn-some-stuff-in-your-spare-time' emerged. 

Brief intro
---
The colleague of mine is developing html5-mobile application. He wanted to test/troubleshoot it on his Mac while developing (w/o need to perform the whole `build->package->deploy to mobile/emulator` cycle). So, he started with some simple html page and certain amount of jQuery ajax. The problem occurred immediately: Ajax crossdomain issue.
His setup:

- browser: Safari
- html url: `file://path_to_file.html`
- service url: `http://test.company.com/service1/v1/JsonService`

It is impossible to understand why, but for some reason I'm considered to be all-knowing-ajax-javascript guy in the company :D (According to Dmitry Baranovskiy [I suck](http://www.webdirections.org/resources/javascript-enter-the-dragon-dmitry-baranovskiy/). Nevertheless colleague asked for help.

As always, google + stackoverflow pointed out the simplest solution.

Solution
---
As we all (or some) know, Mac already comes with python and ruby. So, I decided the simplest way to go would be some sort of python or ruby reverse-proxy script (other straightforward solution would be apache + mod_proxy).

Stackoverflow pointed me out [twisted](http://twistedmatrix.com/trac/) toolkit. Few minutes spent with [twisted-web sample](http://twistedmatrix.com/documents/current/web/examples/) page and the following script has born (PS> as it turned out - Mac already comes with twisted toolkit shipped).

```python
from twisted.internet import reactor
from twisted.web import static, proxy, server

path = "/Users/xxx/yyy/www"  # path to static resources (html, js etc..)
root = static.File(path)     # will be served under '/'

# reverse proxy, served under '/svc'
# http://test.company.com/service1/v1/JsonService -> becomes http://localhost/svc/service1/v1/JsonService
root.putChild('svc', proxy.ReverseProxyResource('test.company.com', 80, ''))

# the magic
site = server.Site(root)
reactor.listenTCP(8080, site)
reactor.run()
```

Vuala part
---
Vuala, problem solved. Python you rock!
