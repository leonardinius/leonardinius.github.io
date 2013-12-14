---
title: "play-draft-title"
layout: post
---

[Play Framework] [1] is getting a lot of attention lately. Since I had recent first hand experience using Play
framework for java developers to develop small web application, I decided to summarize my thoughts and concerns in
the form of blog entry.

For the disclosure, the application I developed with Play Framework consists from around 142 Java files (647 Kb),
106 Scala.Html templates (416 Kb), 3 Scala files (28 Kb), 14 SQL files (478 Kb), css, js, etc...

Let me preface this in that I really don't consider myself to be any kind of Web-development,
platform or stack guru. The opinions expressed here are mine and mine only. More than that,
because of my brief  acquaintance with the subject and not very prolonged overall experience with top-edge high-load
real-time buzz-this buzzword-that system development and operations - my opinions and conclusions are expected to be
one-sided, shallow, incomplete and to certain degree incompetent.

The main goal of this post is to mentally iterate through my Play experience, summarize all of things I have in my
head, get it down in the written form and share it with my colleagues at
[@galeoconsulting] [galeo]. Plus, I find it useful to sometimes re-iterate through previous experiences and
re-evaluate past assumptions and reconsider conclusions.

In my first draft of this article it was 1-2 paragraphs large, just few pain points and thoughts.  After a while,
however, it became less and less concentrated, the whole thing became confusing. At one point I stopped worrying
about overall structure and decided to simply go with the natural flow of my thoughts.

## Brief acquaintance with Play Framework ##

[Play Framework] [1] team describes the framework as
> The High Velocity Web Framework For Java and Scala

Play is acknowledged to be full-stack family framework, which means it comes with (at least) following layers:

### Development, deployment and operation tooling ###

  Similar to Ruby on Rails, Django or your favorite flavor of similar kind of full-stack development frameworks, Play
  comes with it's own version of tooling set.

  With a little help of `play new app-name`, `play debug run` and `play dist` commands
  (see [Play Console documentation] [2] for more) you are able to create new project skeleton,
  run application in debug mode or prepare standalone deployment artifacts...

  For those of you who actually like their IDEs to do most of their job, there are good news for you - Play comes
  with decent modern [IDE support] [11]. I would not vouch for all the IDEs listed there (Eclipse, IntelliJ Idea,
  Netbeans) since I haven't tried them all with Play Framework. Still, I found IntelliJ Idea integration with Play
  Framework quite feature complete, snappy and mostly bug-free.

### Server, Network, and Hosting Environment ###

  Play dismisses JEE servlet model in favor of NIO-charged [Netty] [3] network stack. As a result,
  Play features _Stateless Web Tier_, _Non-blocking I/O_, _Real-time communication support_ (Web-sockets, Comet,
  EventSource) and more...

  As a result of such bold move - Play applications are bad fitted for deployment on top of classical JEE Application
  containers (which as I understand is still [possible] [12], just highly not recommended). It's not something very
  uncommon lately: certain niche application frameworks abandon classical well-established enterprise deployment
  strategies and provide their own alternatives to develop and deploy applications into production. Just to name a
  few: [Vert.x] [4], [Dropwizard] [5]...

  In my personal opinion it's mostly a good thing, it provides Play Framework core developers possibility to optimize
  hard for particular niche. In this case Play concentrates on high-load, high-throughput and low-latency web services.

  Another take on this is to consider that modern web application requirements are a decade ahead of enterprise. The
  enterprise/JEE world tries to solve yesterdays problems on enterprise scale of business and processes; the rest of
  the world tries to address tomorrow's issues and challenges, empowering users to make them come a reality today.

  I myself am in the process of finalizing my application delivery and "throwing it over the fence" into
  production, so I don't have any _REAL_ experience with Play application in operation. I'm planning to leverage most
  of it to [play2-native-packager-plugin] [6] sbt-plugin (assembles debian package) and built-in [Play evolutions] [7]
  (manages database schema migrations). Only the time will show how it goes.

### Data Modeling ###

  Play for Java developers by default integrates with [Ebean ORM] [9].

  During the development process I grew more and more satisfied with Ebean capabilities,
  I even like it more than hibernate/JPA now. It was good fit for my needs, with small learning curve and almost no
  annoyances. The only thing I dislike so far is the lack of opportunities to specify `NULLS FIRST` or `NULLS LAST`
  in `ORDER BY` statements (the workaround is to use [RawSql] [10] and manual column mapping,
  but it defeats the whole ORM purpose). By no means I allege Ebean is more feature-rich, faster,
  cleaner or simpler to use in multi-layered OSGi application, but it was good enough for my use case and didn't step
   on my toes too much during development.

  As mentioned above, Play comes with built-in [evolutions] [7] database schema migration tool,
  which turned out to be very handy in practice. In development environment it watches
  `conf/evolutions/<<ebean.server.instance>>` directory for SQL script changes and allows developer either to apply
  those or dismiss.

  As it's often the case using agile methodologies I had to frequently adjust database schema during application
  development. So I had developed another small utility application to process business-analyst crafted Excel with
  database meta-model (sheets are database tables, columns are columns, certain meta-data gives Foreign Keys etc..)
  and generate database DDL and data (in Play evolutions format), application model beans,
  DAOs and admin CRUD interface. That way all I had to do was to provide new version of Excel into my utility
  application, refresh my main application page in browser, wait a few seconds, press button to agree with database
  schema update and vuala, I'm ready to go.

  And the best part of it - it's something integrated with the platform itself,
  is part of natural and default workflow. Any other developers running application on their own local development
  environments will get latest database version without any hassle, procedures or 'read in wiki and proceed with step
  by step instructions'. All they have to do - to continue run application the same way they always do and then
  `git pull` will fetch new updates - framework will conveniently notify them and allow to apply latest changes.

### API layer / Action Layer ###

  Play Framework for java developers defaults to statically scoped class functions (see [JavaActions] [13] for
  idiomatic Java examples).

  The most of us, the _JVM programmer-vulgaris_ kind come from C/C++, OOP, Spring world with JEE system legacy behind
  backs. First we are taught to learn structures, then algorithms, then OOP and abstractions,
  then someone comes in and makes all of us look as fools, because _patterns are the king_. Then, few years after
  another newcomer makes all of look as fools again - _we should use Scala / Haskell / XYZ_ and write our code
  monads / burritoto style ;) The same thing applies to application layers as well.

  So, my first _wtf_ reaction is mostly because of what influence Spring, Guice and similar programming models has had
  on me. I'm used to layer applications certain way now. And it was challenging to me rethink this approach with Play
  Framework stack. Initially it was something unpleasant/mentally challenging at least,
  however as time moved on I got more and more used to program things that way and now I'm mentally ok now with this
  model.

  Play Framework 2.x series core is written in Scala programming language (which itself is another buzz-generating
  topic out there, especially if you follow Twitter and LinkedIn engineering blog posts). The Play core is built
  around [Akka actors] [16] and [Netty network stack] [3], both promote functional programming style,
  state immutability, event-loops, message passing etc.., which idiomatically maps to first class functions or
  function objects (I understand I'm functional paradigm n00b and might have mis-used terminology). I personally hope
  that Java8 and [Project Lambda] [17] will provide lots of better alternatives of expressing this kind of stuff with
  Java language itself. Still, at the moment of writing, Java7 is the current bleeding technology; thus static
  functions are the most cleanest and easiest way to express _just code, no shared state other than method arguments
  and framework-methods to access current execution scope_ programming model. The whole API and stack design screams
  out of it, the whole stack points you mentally in _process event_, _share nothing_,
  _cache aggressively_ thinking model.

  I still don't believe Play for Java approach is _the only right_ design approach. Plus,
  I have to mention here what Play provides means to integrate with Spring or Guice IoC containers (e.g. see
  [Play Java Spring template] [14] and [Play Guice template] [15]). In my particular case I decided to go without any
  additional fancy toolkits or IoC, both as experiment and simplification instrument. My application was small enough,
  with most of the boilerplate code and coupling auto-generated by my other utility application; the rest of
  business logic was arranged in specific controller classes and in shared Domain Knowledge utility services. At the
  moment I'm pretty ok with the application layout and layers: I don't find it too difficult or too spaghetti. Of
  course, the real implications of design decisions made and their consequences I will see only in system operations
  and support.

### V for Vendetta or Scala Templates for Views ###

  [Play Framework Templates] [18] is the feature I personally found the as one of the most controversial Play
  Framework features.

  From day zero I hated that it forces me to learn new template programming language (basically Scala subset). Plus,
  initially I disliked the fact that Play Framework Scala templates are generally much more imperative,
  than declarative. It reminded me old good PHP scripts with business process logic literally littered around and mixed
  with visualization.

  I still believe declarative approach should be used as much as possible for application views (encourages
  business process and logic decoupling from the actual view). However I also Sound scala template reusable blocks,
  implicit form field decoration (I was able to modify default field html layout with my twitter bootstrap based
  field layout) and view composition extremely powerful and flexible.

  At the end of the day I came to conclusion I love Scala Templates engine. Of course it's easy to misuse them the
  same way as PHP does. Openly speaking I myself performed quite a lot model lookups ( -> SQL queries) from
  auto-generated template views, it was just so simple and easy solution to render dropdown fields. Though,
  is used properly with certain layering constraints - Scala Templates are extremely convenient and powerful.

### Media type support ###

  Play Framework provides built-in [Json request support] [19] and [Xml content support] [20].

  Saying that I must admit that I find Play Framework Json support quite decent (Play Json support is backed by
  popular [Jackson] [21] toolkit). However Xml support ir disappointingly limited comparing to Spring MVC (basically
  Play just exposes request body as `org.w3c.dom.Document` and you are free to use SAX parser to process it).

  During my particular application development I switched to [FasterXML/jackson-dataformat-xml] [22] library,
  for simple, light-weight and more feature-rich XML support. Basically I was able to continue use my Json beans and
  serialize/deserialize them either as Json or as Xml depending on context.

  I came to conclusion that Xml is treated as second class citizen in the framework, all the love,
  care and polishing comes to Json. Xml is that poor neighbour which with envy watches Json riding his Bentley in
  front of his doors ;) To some extent it makes certain sense.

  It seems that Play is more interested in modern Web technologies, light-weight micro-services etc... The Xml is
  undoubtedly dying beast in these areas, it's mostly enterprise legacy. With all new specs addressing json document
  constraints, schemas and data validation rules - it's not too long until Json replaces Xml completely.

## The things I liked about Play Framework ##

## The things I dislike about Play Framework ##

## Would I choose Play for my next project ##

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

<!-- Link definition -->
[galeo]: https://twitter.com/galeoconsulting "Galeo twitter"
[1]:  http://www.playframework.com/ "Play Framework site"
[2]:  http://www.playframework.com/documentation/2.1.5/PlayConsole "Play Console documentation"
[3]:  http://netty.io/ "Netty home page"
[4]:  http://vertx.io/ "Vert.x home page"
[5]:  http://dropwizard.codahale.com/ "Dropwizard site"
[6]:  https://github.com/kryptt/play2-native-packager-plugin "sbt play2-native-packager github home"
[7]:  http://www.playframework.com/documentation/2.1.5/Evolutions "Play evolutions documentation"
[8]:  http://www.playframework.com/documentation/2.1.5/ScalaAnorm "Scala Anorm and Play integration documentation"
[9]:  http://www.playframework.com/documentation/2.1.5/JavaEbean "EBean and Play for java developers documentation"
[10]: http://www.avaje.org/ebean/introquery_rawsql.html "EBean RawSql example"
[11]: http://www.playframework.com/documentation/2.1.5/IDE "Play documentation on Setting up your preferred IDE"
[12]: https://github.com/dlecan/play2-war-plugin "Play2 War Plugin Github page"
[13]: http://www.playframework.com/documentation/2.1.5/IDE "Play Java Actions"
[14]: http://typesafe.com/activator/template/play-java-spring "Play Java Spring template"
[15]: http://typesafe.com/activator/template/play-guice "Play Guice template"
[16]: http://akka.io/ "Akka home page"
[17]: http://openjdk.java.net/projects/lambda/ "Project Lambda home page"
[18]: http://www.playframework.com/documentation/2.1.5/ScalaTemplates "Scala Templates"
[19]: http://www.playframework.com/documentation/2.1.5/JavaJsonRequests "Java Json Content handling"
[20]: http://www.playframework.com/documentation/2.1.5/JavaXmlRequests "Java Xml Content handling"
[21]: http://jackson.codehaus.org/ "Jackson toolkit home page"
[22]: https://github.com/FasterXML/jackson-dataformat-xml "Jackson JSON support for de-/serializing POJOs as XML"
