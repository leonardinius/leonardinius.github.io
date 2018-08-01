---
title: "TIL notes or Stuff I Learned Most Recently"
layout: post
tags: [til, python, pex, performance, perftests, gatling, faketdd, websockets, nginx, geoip, docker, bi, redash, postgresql,  macosx]
permalink: 2018/03/aggregate-recent-tils
---

Once again I have started to write down TIL (`T`oday `I` `L`earned) notes in my notebook & push some of that here, both as a way to share useful things and a reminder to myself.
![TIL sysyphus process](/img/posts/2018-03-01-sysyphus.jpg)
<span style="color:gray; font-size: smaller;">[Copyright 2011-2015 industrial-evolution](http://industrial-evolution.deviantart.com/) from [DeviantArt](http://industrial-evolution.deviantart.com/art/Sisyphus-198120115)</span> <br />
Humble request - if you have discovered the page via google & found it useful - please leave a comment. That's it.

## TILs 

In random appearance order

## Websockets

* Chrome built-in WS (Web socket) traffic monitoring.
  
  I have most recently used Firefox as my main browser & development environment.
  Turns out - most recent Firefox has broken (e.g. Firefox is in transition to new engine parts phase) web socket traffic monitoring and respective plugin support. 
  Not the case with Chrome.
  ![chrome ws example](/img/posts/2018-03-01-chrome-ws.png)

## Performance Tests

* [Gatling](http://gatling.io/)

  For most of my professional career, I have mostly used tools like Apache AB and Jmeter in generic performance testing.
  This time I needed WS (WebsScket) support and it made a compelling case to try something new.

  Pros:
  * DSL scriptable == flexible
  * Simulation setup is done in [virtual user terms](https://gatling.io/docs/2.3/general/simulation_setup/), not in traditional RPS (request per second) terms, which gives more high level and IMO more useful perspective.

  Cons:
  * DSL, in this case, is Scala
  * Mediocre documentation. Still could find everything that needed, but with extra effort.
* [flood.io](http://flood.io/) superb performance test execution service.

  BTW featured in [ThoughtWorks 2018 Technology Radar](https://www.thoughtworks.com/radar/platforms/flood-io). Basically, you just upload your performance test scripts, select how many nodes you want to execute them, get aggregated execution report with no hassle.

  Not affiliated in any sense, happy customer, highly recommend. 

### TDD

After attending [DevTernity 2017: Ian Cooper - TDD, Where Did It All Go Wrong](https://www.youtube.com/watch?v=EZ05e7EMOLM) session - we had a small epiphany to redesign most of our tests from Mockito mocks to `FakeRepository`.

Now the test maintenance process is fewer tears and more joy. Retrospectively, most of the tests were easier to adjust to using `FakeRepository` than "fix" them.

### HTTP Middleware

* ALB header rewrite is confusing. 

  We were forced to use `Forwarded` header to make WebSockets work with Spring (Java) implementations.

* Nginx GeoIP module.

  Initially, I developed GeoIP detection on top of [http://freegeoip.net/](http://freegeoip.net/) service. 
  
  Later on, we started to use CloudFlare with CF built in GeoIP data. So, we had an option to remove hundreds of code lines, simplify and reduce latencies significantly.
  
  Then I have discovered [Nginx GeoIP](http://nginx.org/en/docs/http/ngx_http_geoip_module.html) module as an exit strategy in places we do not plan to use CloudFlare. 
  
  Things could not be better. 

### Business Intelligence & PostgreSQL

* [Redash](https://redash.io/)

  ![Redash in action](/img/posts/2018-03-01-redash_screenshot_vis-slide-2.png)

  I have discovered Redash service and I love it. E.g. simple way to combine Database and Google Analytics data in a single business report. Awesome. 

* [PostgreSQL conditional Aggregated queries](https://www.postgresql.org/docs/9.4/static/sql-expressions.html)

  See example below:

  ```
  SELECT
        count(*) AS unfiltered,
        count(*) FILTER (WHERE i < 5) AS filtered
    FROM generate_series(1,10) AS s(i);
    unfiltered | filtered
    ------------+----------
            10 |        4
    (1 row)
  ```

### Random (MacOS X, docker,..)

* Docker on Mac, performance degradation. 

  Fix - add localhost to /etc/hosts. Refer to [https://github.com/docker/compose/issues/3419](https://github.com/docker/compose/issues/3419) for more details.

* MacOS X - autohide menu  (status bar) + dock == eternal && fast fullscreen
  ** `General`- `Automatically hide and show menu bar`
  ** `Dock` - `Automatically hide and show the Dock`

## Python

* Use `decode("utf-8")` to achieve camel case with Russian `str`.
  
  ```python
  RE_PUNCTUATION = re.compile(r'[\s{}]+'.format(re.escape(string.punctuation)))

  def namify(name):
    if isinstance(name, str):
        cap = string.capwords(name.decode('utf-8'))
    else:
        cap = string.capwords(name)
    return ''.join(RE_PUNCTUATION.split(cap))
  ```

* [PEX](https://github.com/pantsbuild/pex) - "cross-platform-binary" format.

  We use PEX (`P`ython `EX`ecutable) as a way to bundle devops python scripts into one single `.pex` file.

  So most of the operations are as simple as `scp deploy.pex .. && deploy.pex --arg1 --arg2`, 

**Voilà**

More to come.
