---
title: "play-draft-title"
layout: post
---

[Play Framework] [1] is getting a lot of attention lately. I won't speculate on the reasons  why this is so. However
since I had lately a first hand experience developing small application using the Play framework for java developers,
I decided to share my thoughts and concerns here.

Let me preface this in that I really don't consider myself to be any kind of Web-development,
platform or stack guru. The opinions expressed here are mine and mine only. More than that,
because of my brief  acquaintance with the subject and not very prolonged overall experience with top-edge high-load
real-time buzz-this buzzword-that system development  and operations - my opinions and conclusions are expected to be
one-sided, shallow, incomplete and to certain degree incompetent.

In my first draft of this article it was 1-2 paragraphs large, just few pain points and thoughts.  After a while,
however, it became less and less concentrated, the whole thing became confusing. So I’ve decided to simply go with
the natural flow of thoughts, listing main concepts of the Play Framework along with my comments,
sharing my experience and then (potentially) write a series of follow up posts with more details on particular
matters.

## Brief acquaintance with Play Framework ##

[Play Framework] [1] team describes the framework as
> The High Velocity Web Framework For Java and Scala

Play is acknowledged to be full-stack family framework, which means it comes with (at least) following layers:

### Development, deployment and operation tooling ###

  Similar to Ruby on Rails, Django or your favorite flavor of similar kind of full-stack development frameworks, Play
  comes with it's own version of tooling set.

  With a little help of `play new app-name`, `play debug run` and `play dist` commands
  (see [Play Console documentation] [2] for more) you are able to create new project skeleton,
  run application in debug mode or prepare standalone deployment artifact ...

  For those of you who actually like their IDEs to do most of their job, there are good news for you - Play comes
  with decent modern [IDE support] [11]. I would not vouch for all the IDEs listed there (Eclipse, IntelliJ Idea,
  Netbeans) since I haven't tried them all with Play Framework. Still, I found IntelliJ Idea and Play Framework
  integration quite feature complete, snappy and mostly bug-free.

### Server, Network, and Hosting Environment ###

   Play dismisses JEE servlet model in favor of NIO-charged [Netty] [3] network stack. As a result,
   Play features _Stateless Web Tier_, _Non-blocking I/O_, _Real-time communication support_ (Web-sockets, Comet,
   EventSource)  and more...

   As a result of such bold move - Play applications are bad fitted for deployment on top of classical JEE Application
   containers (which as I understand is still [possible] [12], just highly not recommended). It's not something very
   uncommon lately: certain niche application frameworks abandon classical well-established enterprise deployment
   strategies and provide their own alternatives to develop and deploy applications into production. Just to name a
   few: [Vert.x] [4], [Dropwizard] [5]...

  In my personal opinion it's mostly good thing, it provides Play Framework core developers possibility to optimize
  hard for particular niche. In this case Play concentrates on high-load, high-throughput and low-latency web services.

  Another take on this is to consider that modern web application developer requirements are a decade ahead of
  enterprise. The enterprise/JEE world tries to solve yesterdays problems on enterprise scale of business and
  processes; the rest of the world tries to address tomorrow's issues and challenges,
  empowering users to make them come a reality today.

  I myself am in the process of finalizing my application delivery and "throwing it over the fence" into
  production, so I don't have any _REAL_ experience with Play application in operation. I'm planning to leverage most
   of it to [play2-native-packager-plugin] [6] sbt-plugin (assembles debian package) and built-in [Play evolutions] [7]
  (manages database schema migrations). Only the time will show how it goes.

### Data Modeling ###

  Play for Java developers by default integrates with [Ebean ORM] [9].

  During the development process I grew more and more satisfied with Ebean capabilities,
  I even like it more than hibernate/JPA now. It was a good fit for my needs,
  with small learning curve and almost no annoyances. The only thing I dislike so far is the lack of opportunities to
   specify `NULLS FIRST` or `NULLS LAST` in order expressions (the workaround is to use [RawSql] [10] and manual
   column mapping, but it defeats the whole ORM concept). By no means I allege Ebean is more feature-rich, faster,
   cleaner or simpler to use in multi module SME or JEE application, but it was good enough for my use case and
   didn't step on my toes during development.

  As mentioned above, Play comes with built-in [evolutions] [7] database schema migration tool,
  which turned out to be very handy in practice. The way it works in local development environment is - it tracks
  special directory for sql scripts and when sql scripts changes are detected it offers to changes on local
  development database.

  As it often is the case using agile methodologies I had to constantly update database schema during application
  development. So I had developed another small Play application to process business-analyst crafted Excel with
  database meta-model (sheets are database tables, columns are columns, certain meta-data gives Foreign Keys etc..)
  and generate database DDL and data, application model beans, DAOs and admin CRUD interface. That way all I had to
  do was to upload new version of Excel into my utility application, refresh my main application page in browser,
  wait a few seconds, press button to agree with database schema update and vuala,
  I'm ready to go.

  And the best part of it - it's something integrated with the platform itself,
  is part of natural and default workflow. Any other developers running application on their own local development
  environments will get latest database version without any hassle, procedures or 'read in wiki and proceed with step
  by step instructions'. All they have to do - to continue run application the same way they always do and then
  `git pull` will fetch new updates - framework will conveniently notify them and allow to apply latest changes.

### API layer / Action Layer / MVC ###

  ss
  sd

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

<!-- Link definition -->
[1]: http://www.playframework.com/ "Play Framework site"
[2]: http://www.playframework.com/documentation/2.0.2/PlayConsole "Play Console documentation"
[3]: http://netty.io/ "Netty home page"
[4]: http://vertx.io/ "Vert.x home page"
[5]: http://dropwizard.codahale.com/ "Dropwizard site"
[6]: https://github.com/kryptt/play2-native-packager-plugin "sbt play2-native-packager github home"
[7]: http://www.playframework.com/documentation/2.2.x/Evolutions "Play evolutions documentation"
[8]: http://www.playframework.com/documentation/2.0/ScalaAnorm "Scala Anorm and Play integration documentation"
[9]: http://www.playframework.com/documentation/2.2.x/JavaEbean "EBean and Play for java developers documentation"
[10]: http://www.avaje.org/ebean/introquery_rawsql.html "EBean RawSql example"
[11]: http://www.playframework.com/documentation/2.0.1/IDE "Play documentation on Setting up your preferred IDE"
[12]: https://github.com/dlecan/play2-war-plugin "Play2 War Plugin Github page"