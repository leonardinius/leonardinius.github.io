---
title: "Summarizing My Play Framework experience"
layout: post
---

[Play Framework 2x] [1] is getting a lot of attention lately. Since I had recent first hand experience using Play
framework for java developers to develop small web application, I decided to summarize my thoughts and concerns in
the form of blog entry.

For the disclosure, the application I developed with Play Framework consists from around 142 Java files (647 Kb),
106 Scala Html templates (416 Kb), 3 Scala files (28 Kb), 14 SQL files (478 Kb), css, js, etc...

Let me preface this in that I really don't consider myself to be any kind of Web-development,
platform or stack guru. The opinions expressed here are mine and mine only. More than that,
because of my brief acquaintance with the subject - my opinions and conclusions are expected to be one-sided,
shallow, incomplete and to certain degree incompetent.

The main goal of this post is to mentally iterate through my Play experience, summarize all of things I have in my
head, get it down in the written form and share it with my colleagues at
[@galeoconsulting] [galeo]. Plus, I find it useful sometimes to go through previous experiences and re-evaluate past
assumptions and reconsider conclusions.

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

With a little help of `play new app-name`, `play debug run` and `play dist` commands (see
[Play Console documentation] [2] for more) you are able to create new project skeleton,
run application in debug mode or prepare standalone deployment artifacts...

For those of you who actually like their IDEs to do most of their job, there are good news for you - Play comes with
decent modern [IDE support] [11]. I would not vouch for all the IDEs listed there (Eclipse, IntelliJ Idea,
Netbeans) since I haven't tried them all with Play Framework. Still, I found IntelliJ Idea integration with Play
Framework quite feature complete, snappy and mostly bug-free.

### Server, Network, and Hosting Environment ###

Play dismisses JEE servlet model in favor of NIO-charged [Netty] [3] network stack. As a result,
Play features _Stateless Web Tier_, _Non-blocking I/O_, _Real-time communication support_ (Web-sockets, Comet,
EventSource) and more...

As a result of such bold move - Play applications are bad fitted for deployment on top of classical JEE Application
containers (which as I understand is still [possible] [12], just highly not recommended). It's not something very
uncommon lately: certain niche application frameworks abandon classical well-established enterprise deployment
strategies and provide their own alternatives to develop and deploy applications into production. Just to name a few:
 [Vert.x] [4], [Dropwizard] [5]...

In my opinion it's mostly a good thing, it provides Play core developers possibility to optimize hard for particular
niche. In this case Play concentrates on high-load, high-throughput and low-latency web services.

Another take on this is to consider that modern web application requirements are a decade ahead of enterprise. The
enterprise / JEE world tries to solve yesterdays problems on enterprise scale of business and processes; the rest of
the world tries to address tomorrow's issues and challenges, empowering users to make them come a reality today.

I myself am in the process of finalizing my application delivery and "throwing it over the fence" into production,
so I don't have any _REAL_ experience with Play application in operation. I'm planning to leverage most of it to
[play2-native-packager-plugin] [6] sbt-plugin (assembles debian package) and built-in [Play evolutions] [7] (manages
database schema migrations). Only the time will show how it goes.

### Data Modeling ###

Play for Java developers by default integrates with [Ebean ORM] [9].

During the development process I grew more and more satisfied with Ebean capabilities,
I even like it more than hibernate / JPA now. It was good fit for my needs, with small learning curve and almost no
annoyances. The only thing I dislike so far is the lack of opportunities to specify `NULLS FIRST` or `NULLS LAST` in
`ORDER BY` statements (the workaround is to use [RawSql] [10] and manual column mapping,
but it defeats the whole ORM purpose). By no means I allege Ebean is more feature-rich, faster,
cleaner or simpler to use in multi-layered OSGi application, but it was good enough for my use case and didn't step
on my toes too much during development.

As mentioned above, Play comes with built-in [evolutions] [7] database schema migration tool,
which turned out to be very handy in practice. In development environment it watches
`conf/evolutions/<<ebean.server.instance>>` directory for SQL script changes and allows developer either to apply
those or dismiss.

As it's often the case using agile methodologies I had to frequently adjust database schema during application
development. So I had developed another small utility application to process business-analyst crafted Excel with
database meta-model (sheets are database tables, columns are columns, certain meta-data gives Foreign Keys etc..) and
generate database DDL and data (in Play evolutions format), application models, DAOs and admin CRUD interface. That
way all I had to do was to provide new version of Excel into my utility application,
refresh my main application page in browser, wait a few seconds, press button to agree with database schema update
and vuala, I'm ready to go.

And the best part of it - it's something integrated with the platform itself, is part of natural and default workflow.
Any other developers running application on their own local development environments will get latest database version
without any hassle, procedures or _read in wiki and proceed with step by step instructions_. All they have to do - to
continue run application the same way they always do and then `git pull` will fetch new updates - framework will
conveniently notify them and allow to apply latest changes.

### API layer / Action Layer ###

Play Framework for java developers defaults to static function usage (see [JavaActions] [13] for idiomatic Java
examples).

The most of us, _JVM programmer-vulgaris_ kind, come from C/C++, OOP, Spring world with JEE system legacy behind
our backs. First we were taught to learn structures, then algorithms, then OOP and abstractions,
then someone comes in and makes all of us look as fools, because _patterns are the king_. Then,
few years after another newcomer makes all of look as fools again - _we should use Scala / Haskell / XYZ_ and write
our code monads / burritoto style ;) The same thing applies to application layers as well.

So, my first _wtf_ reaction is mostly because of what influence Spring, Guice and similar programming models has had
on me. I'm used to layer applications certain way now. And it was mentally challenging to me rethink this approach
with Play stack. Initially it was something unpleasant / mentally challenging at least,
however as time moved on I got more and more used to program things that way and now I'm mentally ok now with this
model.

Play 2.x series core is written in Scala programming language (which itself is another buzz-generating topic out
there, especially if you follow Twitter and LinkedIn engineering blog posts). The Play core is built around
[Akka actors] [16] and [Netty network stack] [3], both promote functional programming style, state immutability,
event-loops, message passing etc.., which idiomatically maps to first class functions or function objects (I
know I'm functional paradigm n00b and might have mis-used terminology). I personally hope that Java8 and [Project
Lambda] [17] will provide lots of better alternatives of expressing this kind of stuff with Java language itself.
Still, at the moment of writing, Java7 is the current bleeding technology; thus static functions are the most
cleanest and easiest way to express _just code, no shared state other than method arguments and framework-methods to
access current execution scope_ programming model. The whole API and stack design screams out of it,
the whole stack points you mentally in _process event_, _share nothing_, _cache aggressively_ thinking model.

I still don't believe Play for Java approach is _the only right_ design approach. Plus,
I have to mention here what Play provides means to integrate with Spring or Guice IoC containers (e.g. see
[Play Java Spring template] [14] and [Play Guice template] [15]). In my particular case I decided to go without any
additional fancy toolkits or IoC, both as experiment and simplification instrument. My application was small enough,
with most of the boilerplate code and coupling auto-generated by my other utility application; the rest of business
logic was arranged in specific controller classes and in shared Domain Knowledge utility services. At the moment I'm
pretty ok with the application layout and layers: I don't find it too difficult or too spaghetti. Of course,
the real implications of design decisions made and their consequences I will see only in system operations and support.

### V for Vendetta or Scala Templates for Views ###

Play [Scala Templates] [18] is the feature I initially considered one of the most controversial Play features.

From day zero I hated that it forces me to learn new template programming language (basically Scala subset). Plus,
initially I disliked the fact that Scala templates are generally much more imperative,
than declarative. It reminded me old good PHP scripts with business process logic literally littered around and mixed
with visualization.

I still believe declarative approach should be used as much as possible for application views (encourages business
process and logic decoupling from the actual view). However I also find Scala Template reusable blocks,
implicit form field decoration and view compositions very powerful and flexible.

At the end of the day I came to conclusion I love Scala Templates engine. Of course it's easy to misuse them the same
way as most PHP code does. Openly speaking, I myself performed quite a lot model lookups (-> SQL queries) from auto
generated template views, it was just so dead simple and easy to render dropdown fields in Admin Crud interface this
way. Still, if used properly with certain cross-layer constraints - Scala Templates are extremely convenient and
useful.

### Media type support ###

Play Framework provides built-in [Json content support] [19] and [XML content support] [20].

Saying that I must admit that I find Json support quite decent (Play Json support is backed by popular [Jackson] [21]
toolkit). However XML support ir disappointingly limited comparing to Spring MVC (basically Play just exposes request
body as `org.w3c.dom.Document` and you are free to use SAX parser or whatever else to process it).

During my particular application development I switched to [FasterXML/jackson-dataformat-xml] [22] library for
simple, light-weight and more feature-rich XML support. Basically I was able to continue use my Json beans and
serialize / deserialize them either as Json or as XML depending on context.

I came to conclusion that XML is treated as second class citizen in the framework, all the love,
care and polishing comes to Json. XML is that poor neighbour which with envy watches Json riding his Bentley in front
of his doors ;)

## The things I liked most about Play Framework ##

* Low entry level

  I believe Play Framework has almost the lowest entry level to Java full-stack web framework I have seen so far. For
  starters it comes with it's [Typesafe Activator] [24] and multiple [starter templates] [25].

  I do honestly believe you don't have to know a lot / recognize a lot of concepts to start developing Play
  application. Play's helloworld is really no more different that Java `static void main(String[]args)`. And you
  don't need to know anything how to bundle things, how to deploy them, WARs or JARs - what's that?

  Saying that I have to note that when you overcome helloworld application level and want to move forward,
  you might start to struggle first, since there are no really tons of qualitative documentation available. You
  should either have good basic understanding of how things works or where and how to look for solution / help
  to stay productive.

  So, I think entry level is extremely low, however getting to experienced plateau might be a challenge.
* Static typing (templates, routes)

  Almost everything (except i18N messages most noticeably) is statically typed and checked during compilation. All
  the web application routes to controller methods, all the view templates are compiled and checked before going out
  into production. It's freakingly awesome, I don't have to worry about mistyping url, miscasting request parameter
  or accidental change introduced during refactoring. And I don't need to rely on integration / Selenium tests to
  catch this type of errors, I get this kind of feedback almost instantly on save / refresh.

  Now I have single point of truth for url definitions, `conf/routes` file. There is no other place to look into. In
  my views and my controller code I just reference compile-time generated binding, if something is mis-configured or
  mis-used - compile time error will be displayed.

  I had quite positive experience with IntelliJ Idea IDE using and navigating Play routes during application
  development. So, it's not something inconvenient (I didn't have to launch anything,
  wait for something or perform any other kind of manual configuration magic; it just worked).

* JsRoutes

  The same thing as routes above, but to [invoke controllers action from client-side Javascript] [30]. It makes just
  so strangely easy and convenient to call server-side action from the browser, and still I don't need to worry about
  using right URL or using right HTTP method etc ... I even still reference it using statically typed and
  compile-time checked helper methods. What can I say? Convenient.

## The things I dislike about Play Framework ##

The list in the order of dislike:

* Scala vs Java battle

  Typesafe (the company behind Scala and Play Framework) poses Scala as general programming language which is
  evolutionary improvement over current programming languages and paradigms. The ultimate goal in my understanding is
  not to accomplish _JVM developer vulgaris_, but eventually to replace the Java language or become the serious
  alternative.

  The Play2 core is written in Scala and Typesafe provide separate version of Play modules for developers who still
  wants to use Java for their daily job (silly me).

  The problems appear when you want to for example - dynamically update certain parts of configurations during
  application startup, or you notice that form field validation actually behaves differently in Scala and Java
  versions (different error messages and Java version does not provides all the validations Scala version does) etc...
  Mostly those are small things, however it's still something I had to struggle with or inspect and compare Scala and
  Java version internals.
* Compatibility

  Play is famously known for rewriting Play1 core from Java -> Scala, replacing view system etc... So,
  historical record is pretty bad. I can't not to be afraid the next major version release won't introduce,
  for example, Clojure based stack if it will become good-selling trend).

  Other side of the problem is Scala itself. As I understand it - Scala might (and often is) binary incompatible
  between version updates (even minor ones). As an end result - if Play core team decides to change it's compiler
  version to benefit from new Scala features or bug fixes - it potentially will introduce dependency hell for end
  developers to upgrade (dependencies might either be binary incompatible or their new updated recompiled version
  might be missing).
* Compilation time

  Even with my small application, SSD disk and 8Gb Ram - compilation took up to 30 secs or in some cases up to 1-2
  min. It places it nearby GWT, which is sad for both of those frameworks.

* Sbt

  It's the system I just don't get. So far I've some sort of experience with Ant, Maven, Gradle, even Leiningen,
  Rake and Buildr. But I don't get sbt, just don't. And actually I don't want and couldn't care less (maybe it's the
  problem).

* Module maturity

  I'm used to Spring Security authentication and authorization programming model and maturity. I was unpleasantly
  suprised with the state of things with Play modules. Some of them seem mature,
  but require quite a lot of boilerplate code to start with. Other just break binary compatibility too often (it
  happens when the only version to depend to in public repository is SNAPSHOT one).

  I wish auth modules would the only example to point to, however I had similar experience with different modules. I
  get it, it happens. The shitty thing is when you don't have a lot of alternatives to choose from. Something breaks
  and you are forced into options: either to rollback to snapshot, maintain module or fix the module dependency. It's
  not something you could always afford to spend your time on, especially on tight calendar schedule.

* Developer platform support (e.g. Windows)

  Basically the reason I ended up using version `2.1.5` at the moment - is shitty Windows platform support on `2.2x`
  branches on their initial releases. As I understood from GitHub issue comments and Google Group mailing lists - the
  core team doesn't have testing on Windows integrated into their develop pipelines (since their use Mac OS X and
  Linux mostly).

  I would expect something like this from beta or release candidate, however it was strange to see it in release
  version. But! I might misunderstood Play version and release concept, maybe it's something expected to happen until
  some certain version is marked as production ready.

## Would I choose Play for my next project ##

The short answer is classical _it depends_ ;) In case my next project is Json services oriented or requires client rich
interaction, or could be fitted in small web-application or micro-service categories - most definitely yes. There are
even crazy enough people to [develop advanced online bank system using Play1 Framework] [23].

I am concerned about Play compatibility, poor documentation and lack of developer resources. If we are talking about
Online Bank system - Play Framework would not be either my first choice, nor second one. But I am Ok to recommend Play
to develop small replace-able business non-critical application, or micro-service, or set of Akka actors or whatever
popular now, small, simple and requires high-throughput and low-latency.

## Other frameworks in my consideration list

Here is the list of frameworks I might consider to develop my next small experimental project (the list is in the
order of appeal):

* [Vert.x] [4]
* [Dropwizard] [5]
* [Ninja Web Framework] [26]
* [Grails] [27]
* [Apache Wicket] [28]

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
[20]: http://www.playframework.com/documentation/2.1.5/JavaXmlRequests "Java XML Content handling"
[21]: http://jackson.codehaus.org/ "Jackson toolkit home page"
[22]: https://github.com/FasterXML/jackson-dataformat-xml "Jackson JSON support for de-/serializing POJOs as XML"
[23]: http://blog.codeborne.com/2013/03/online-bank-from-scratch-in-five-months.html "Codeborne: Online Bank in five months"
[24]: http://typesafe.com/activator "Typesafe Activator"
[25]: http://typesafe.com/activator/templates "Typesafe Activator Templates"
[26]: http://www.ninjaframework.org/ "Ninja Web Framework home page"
[27]: http://grails.org/ "Grails Home Page"
[28]: https://wicket.apache.org/ "Apache Wicket Home page"
[29]: http://www.playframework.com/documentation/2.1.5/JavaRouting "Play Framework Routing"
[30]: http://www.playframework.com/documentation/2.1.5/JavaGuide6 "Invoking actions from Javascript"
