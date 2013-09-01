---
layout: post
title: com4j and many many threads
date: 2007-04-15
comments: false
permalink: 2007/04/com4j-and-many-many-threads.html

---

The usage of com4j in apps with sosme additional threads happens to be problematistic.<br />It actually registers somewhere threads which originally were used to create/initiate some com objects and fails if code from another thread is trying to invoke some methods on those com objects.<br />//<br />4 me it was not a suprise, but it's probem. I use com4j for accessing MS WORD objects and to load them into memory. So, i actually tried to use new SwingWorker architecture to to it in the background, and it actually worked (1 time) and all the actions were performed slightly and smoothly... but!!!!<br />It worked only once, then i tried to perfom the same action again, the SwingWorker acquired new Therad from the pool an the com4j code actually failed ...<br />//<br />So, i use EWTEventDispatchThread at the moment, which is weird and incorrect approach, but it works...<br />//<br />TODO: If some free time suddenly occurs - to think out better solution
