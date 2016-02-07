---
layout: post
title: Unit tests, What they should be like? (2)
date: 2009-10-16
comments: false
permalink: 2009/10/xunit-tests-what-they-should-be-like-2.html
tags: [tdd]
---

**My humble opinion only**

*   Every test should be story (scenario) test.

It could either be User story (user logins in, does A, soes B), Engineering story (the application developer will create component A, pass in reference for component B, will invoke #xxx(), #yyy() in turn and will await for something). It doesn't mean, it couldn't test just like one function, ore just one invocation. It's about check separation to different coherent scenarios.

*   Tests should not calculate.

Test logics is logics too. It easily becomes clumsy, buggy and all the stuff like that. It should be supported too. a) If one (wrong!) application logics value equals to some other (wrong too!) value it doesn't mean the test is true (false positive) .
b) the efforts to support tests should be minimized
c) tests should be readable. assertEquals("concrete-value", calculate()) is the way more readable than `assertEquals(calculateA(calculateB()), calculateC(calculateD()))`

*   Tests should be as readable as they could be.

In my opinion automated tests could be considered as separate maintenance project. Test code is not throwaway code, otherwise it could be 1 time successfully executed and safely removed.

Test code is the most fragile part of the application, but it needs hands-on all the time. The developers tend to write unreadable test code and when, obviously, don't want to spend lot's of time maintaining it. As a result, tests stories degrade over the time and become useless at some point (no one knows for sure that the hell does this story test check...). So, the more readable the test would be, the more time it would take to degrade to such as state


*   Monogamy

Testcase, test story (continue this sequence on your own) should stick to one particular component, one particular User/Usage Use Case (UUC) and should not influence or gets influnced by any other subsystems, logics, components, whatever. The test should create Well Known, Hardcode, As Small as Possible sexy **Universe** and marry and have children with her.a) Well-known (see Don't calculate; Readable)b) Hardcode (see Don't calculate; Readable)c) Universe (all the space, objects as needed). As the result, no affairs are allowed. If TestA testCase fails, only A should be blamed. No chances of getting children with B should be allowed. If test scenario (story) testScenarioA fails, there shouldn't be option for testScenarionB to be blamed. Doing so, we will easily find the root cause and understand the possible impact on both the application and business behind it.

*   Tests should fail

See Readable. If the test will not ever fail, that is the reason for keeping it? It will never fail anyway (run once and purge from your eyes away). The test should testa) will probably fail someday (or we do change this component a lot and rely on it tightly)b) something having high value (business probably) we want to have a eye on it. No one likes receiving urgent emails, night calls or working Sundays' eves.

*   Test "stories" should be as minimal as possible, without any any additional assumptions (temporally true).

a) The smaller the "story" (the code) is the less maintenance effort will be required.
b) Test developer should not add any non-business/non specified assumptions into unit tests. Consider this, POJOA contains #toString() method delegating to Object#toString(). The test developer might considering to add additional assumption that #toString () would return a string with '@' character. Since this is not a requirement at all, at some point we might considering to provide some meaningful (business point of view) implementation. Thus we will not only to write new xUnit tests, but will also spend some effort due to previous assumptions maintenance (those in this particular cases could be omitted).If for some reason the test story / test setup is unreasonable big (put your threshold here) you might consider refactoring, or starting from some point - complete rewrite of this particular application logics/or test part. It's like a doorbell, jing, the application code will rot soon.Will reread this twice and continue the listing.. Someday :)