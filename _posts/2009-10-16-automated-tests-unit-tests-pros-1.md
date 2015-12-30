---
layout: post
title: Automated Tests, Unit tests, Pros (1)
date: 2009-10-16
comments: false
permalink: 2009/10/automated-tests-xunit-pros-1.html
tags: [tdd]
---

<div><b>My humble opinion only</b></div><ul><li><u><i>Improves design.</i></u></li></ul><i><span class="Apple-style-span" style="font-style: normal; "> At least +1 client, decoupling from the Application.main([]) method.</span></i><br /><ul><li><u><i>Regression tests, cost of running them VS cost of manual retesting.</i></u></li><li><u><i>Difficult to test by mortal hand areas</i></u> </li></ul>(multi-threading issues, timing, DB connectivity loses). As extra point, the cost of such hand-made tests are extremely high and won't disappear on 2nd/3rd/... run. <i>_Not my opinion, but I share this point of view_</i><br /><ul><li><u><i>Easier to explore internal (unclear from user point's of view) Grey Areas or Unpredictability Corners (more commonly known as old plain Boundary Values).</i></u> </li></ul>It's not always clear from User Story or User Interface that the boundary values would be, or other subsystem boundary values influence on this particular component. Or the boundary value application will eventually hit is very-hard to prepare by mortal hand. For example  tester should repeat Long.MAX_VALUE operations to hit this one.
