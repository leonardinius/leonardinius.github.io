---
title: "play-draft-title"
layout: post
---

[Play Framework](http://www.playframework.com/) is getting a lot of attention lately. I won't speculate on the reasons
 why this is so. However since I had lately a first hand experience developing small app using the Play framework for
 java developers I thought I might come clean about the process, share my findings, thoughts & concerns here.

 Let me preface this in that I really don't consider myself to be any kind of Web-development, JVM-platform or any
 other platform or stack guru. I don't intend to criticise or misjudge any stack, platform team or developer
 deliberately. The opinions expressed here are mine and mine only. More than that, because of my brief acquaintance
 with the subject and not very prolonged overall experience with top-edge high-load real-time buzz-this buzzword-that
 system development and operation - my opinions and conclusions are expected to be one-sided, shallow, incomplete and to
 certain degree incompetent.

 Originally this post was supposed to be 1-2 paragraphs large, with scope to mention pain points and findings. Despite
 it turned out to be more 'get familiar with Play framework and my thoughts about it' entry.

Brief acquaintance with Play Framework
---------------------------------------

[Play Framework](http://www.playframework.com/) team describes the framework as
> The High Velocity Web Framework For Java and Scala

Plus, as you might have noticed in case you actually opened the link - it proudly shows of
[Reactive Manifesto](http://www.reactivemanifesto.org/) ribbon on every page (at least at the moment of writing).

Play is acknowledged to be full-stack family framework, which means it comes with (at least) following layers:

* **Development, deployment and operation tooling**

  Similar to Ruby on Rails, Django or your favorite flavor of similar kind of full-stack development frameworks, Play
  comes with it's own version of tooling set.

  With a little help of `play new app-name`, `play debug run` and `play dist` commands
  (see [Play Console documentation](http://www.playframework.com/documentation/2.0.2/PlayConsole)) you are able to
  create new project skeleton, run application in debug mode or prepare standalone deployment artifact.
* **Server, Network, and Hosting Environment**

  Play dismiss JEE servlet model in favor of NIO-charged [Netty](http://netty.io/) network stack. As a result, Play
  features _Stateless Web Tier_, _Non-blocking I/O_, _Real-time communication support_ (Web-sockets, Comet, EventSource)
  and more...

  As a result of such bold move - Play applications are bad fit for deployment on top of classical JEE Application
  containers (which as I understand is still possible, just highly not recommended). It's not something very uncommon
  lately: certain niche application frameworks abandon classical well-established enterprise deployment strategies and
  provide their own alternative to develop and deploy applications into production. Just to name a few:
  [Vert.x](http://vertx.io/), [Dropwizard](http://dropwizard.codahale.com/)...

  In my humble opinion the main reasons to
  do so is the possibility to optimize hard for particular niche/use-case. Plus, let's not forget that modern web,
  people and application developer requirements are a decade ahead of enterprise. The enterprise/JEE world tries to
  solve yesterdays problems on enterprise scale of business and processes; the rest of the world tries to address
  tomorrow's issues and challenges, empowering users to make them come a reality today.

  I'm in the process of finalizing the delivery and "throwing it over the fence" ;) into production, so I don't have
  any _REAL_ experience with Play application in operation. I'm planning to leverage most of it to
  [play2-native-packager-plugin](https://github.com/kryptt/play2-native-packager-plugin) sbt-plugin
  (assembles debian package) and built-in [Play evolutions](http://www.playframework.com/documentation/2.2.x/Evolutions)
  (manages database schema migrations). Only the time will show how it goes.

* **Data Modeling**

  Play Framework comes in two flavors: `Play for Scala developers` and `Play for Java developers`. The former one by
  default integrates with lightweight functional-like [Anorm](http://www.playframework.com/documentation/2.0/ScalaAnorm)
  toolkit. It's definitely not your grandfather ORM, however according to examples and documentation it should be more
  than enough ang quite powerful beast in skillful hands. Play for Java developers by default integrates with
  [Ebean](http://www.playframework.com/documentation/2.2.x/JavaEbean) ORM.

  Ebean ORM is the option I got familiar with during my experience with Play Framework for java. I'm more than satisfied
  with Ebean ORM capabilities, I even like it more than hibernate/JPA now. It was a good fit for my simple limited use
  cases, with small learning curve and almost no annoyances. The only thing I dislike so far is the lack of
  opportunities to specify `NULLS FIRST` or `NULLS LAST` in order expressions (the workaround is available - to use
  [RawSql](http://www.avaje.org/ebean/introquery_rawsql.html) and manual column mapping, however it defeats ORM concept
  for such simple use case). By no means I allege Ebean is more feature-rich, faster, cleaner or simpler to use in multi
  module SME or JEE application, but it was good enough for my use case and didn't step on toes during development.

  As mentioned above, Play comes with built-in [evolutions](http://www.playframework.com/documentation/2.2.x/Evolutions)
  database schema migration tool, which in turned out to be very handy in practice. The way it works in local
  development environment is - it tracks special directory for sql scripts and when sql scripts changes are detected it
  offers to changes on local development database. As it often is the case using agile methodologies - the specification
 (read database schema) was not engraved in stone during application development. So I had developed another small Play
  application to process business-analyst crafted Excel with database meta-model (sheets are database tables, certain
  way marked columns are Foreign Keys etc..) and generate database DDL and data, application model beans, DAOs and admin
  CRUD interface. That way all I had to do was to upload new version of Excel into my utility
  application, refresh my main application page in browser, wait a little, press button to agree to update database
  schema and vuala, I'm ready to go. Kinda cool I think ;)

* **API layer / Action Layer / MVC**

 ```
  controller
  json, xml?
  rest

  RESTful by default
  Asset Compiler for CoffeeScript, LESS, etc
  JSON is a first class citizen
  Websockets, Comet, EventSource
  Extensive NoSQL & Big Data Support
 ```


What is playframework
Reactive manifesto
History
Play1 vs play2
* scala bid
* springsource ex-ceo bid
Niche
Future

How does play! compare to framework x
=====================================

Alternatives
* Spring
* Grails
* Wicket
* Vert.x
* Dropwizard
* Ninja Web Framework


+ Main goal is to replace, not to accompanion

Ecosystem
========

List
* libs
* IDEs
* last not least - community

* play compatability
* compilation time
* scala and sbt-weirdness
* cool stuff - routes nad jsroutes
* matureness (i-net bank)
* not so cools stuff - java compatability is weird; modules are not very mature;fight multi-headed dragons (api, binary compatability, sbt ...)
* nio kinda cool, java shop web-app vs json media-type WS/RPC service
* windows is second class citizen
* community is not so bad, however the backward compatability approach etc .. rifing the other horse (not java shop way)


While writing this article - came across http://lucumr.pocoo.org/2013/12/9/stop-being-clever/
share the idea and concerns

scala sucks

> Let me preface this in that I really don't want to criticise anyone's individual code here.
> More than that, if someone would look at my own JavaScript code it would not be any better.
> If anything it's worse, because I did not spend much time on it and I'm not very experienced with JavaScript.

