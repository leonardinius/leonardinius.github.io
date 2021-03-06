---
layout: post
title: Clamour and stir around Servlet 3.0 Draft
date: 2008-05-03
comments: false
permalink: 2008/05/clamour-and-stir-around-servlet-30.html
tags: [jsp, "servlet-3.0", java]
---

So, Servlet 3.0 Specification ([JSR-315](http://jcp.org/en/jsr/detail?id=315)) is now being in discussion topic.
It appears different people feel different about the spec proposal, but the majority of them agree in one point - 3.0 spec should be more strong-type centric and much more annotation agnostic/less centric.

What brought me in this discussion and based on that I am making assumptions about people attitude? Great [article about spec draft version](http://java.dzone.com/articles/reviewing-early-draft-servlet-) appeared on my RSS feed and a lot of people took a word in discussion and different points of view appeared on the horizon.

What's in the end? What the conclusion to make? The silent thoughts in my heads:

* JSR has become more public stuff than ever. People are wrapping their heads around the proposals and try to give fair run/evaluation of it.
* In spite of the growing <span style="font-style: italic;">Dynamic Language community</span> - it crowd :) doesn't like the idea of loosing strong typing benefits and refactoring possibilities.
* No one likes the idea of looking in two places (web.xml and POJOS) instead of just one.

    > Imagine the situation Your application is built on top of the N jars. Each of them could contain annotations like that @Servlet etc. And some of them might be stacks You are highly dependent off - like Axis or smth. What It would be like. I suppose - It would be not as easy to switch @Servlet annotation auto discovery for *pattern1*.jar libraries and to switch it on for the another *pattern2*.jar.

    > Another question - would it resolve all the annotation in all the libraries I will deploy in WEB-INF/lib? If so - I do know exactly how they imagine that. Personally I don't know all the internals of all the ten/tons of the libraries I add to the classpath or are added through framework I use (for example Seam/Wicket..) - So, how would I control any memory/security flaws if any?

*   People try to use it. It's wonderful. Because inconsistencies are found and they could be worked through if community will insist on it. (See [article](http://java.dzone.com/articles/reviewing-early-draft-servlet-) - @Servlet and @Filter inconsistence sample)

My personal opinion on JSR:

* [Cometd](http://cometd.com/) support is <span style="font-weight: bold;">MUST HAVE</span>. Yes, Jetty and friends have built-in support, but all we java developers like standardized way to do things (things must be done <span style="font-style: italic;">right</span> in order not to rewrite the entire solution from time to time - just to deploy on another AS/hosting service. So, it's GREAT things like this are coming into Servlets API, allowing to get benefits and efficiency of the WEB2.0 in the <span style="font-style: italic;">"standard"</span> way.
* Registering servlets via annotations not with verbose XML - could be nice feature for testing purposes. Personally I don't like the idea of maintaining one more web.xml or smth just for running my unit-test-cycle. At the same time - it could be enchantment to make some embedded lightweight clean solution to serve some javadoc or smth with 2/3 java classes and without any web.xml required. But - it isn't EE anyway.
* Servlet/Filter mappings etc voa annotations - is a feature nice to have without any extra complaining (if mapping parameters could be mapped in the verbose xml file)
* Lack of Strong typing or forcing it - is <span style="font-weight: bold;">BAD BAD BAD.</span> Nothing will be automatically checked in compile/development time (intellectual IDEs aren't the solution, they are work around. And.. No all the developers have them as well on all the target/host/dev environment). I believe - things like @Get should be removed from draft (or explicitly explained - why so and and why this way. Possible answer could be - to make integration with <span style="font-style: italic;">Dynamical Language stack</span> a little bit easier. But - it's not worth to make life for the ordinary JEE much more harder).
