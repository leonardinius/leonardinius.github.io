---
title: "DevOps101 with SaltStack: Because salt goes EVERYWHERE"
layout: post
---

I by all means am not a system administrator or SCM guy or DBA guy or whatever.
I call myself _Developer vulgaris_. Still, I'm used to find myself in position
I have working (locally) solution and little or no clue how the heck to get it
out in window.  Should I just throw it to support and let let them handle that?
![Throwing code at admins](/img/posts/devops101_over_the_fence.jpg)
Image source
@[mptron.com](http://mptron.com/news/javagame/sisgame/3919-volk-yaycelov-nu-pogodi.html)

It works perfectly well. Until... until you become small consultant venture
with 3-5 team members and no additional separate support team to poke issues
to.

## Contents

Given the length, here’s a helpful table of contents.

 - [The Struggle](#the-struggle)
 - [The Golden Hammer](#the-golden-hammer)
 - [Evaluation notes](#evaluation-notes)

## The Struggle ##

I don't fanatically believe that system administrators are extinct creatures
from Age of Reptiles. I also don't think that in-team operations experience is
a MUST. In my humble opinion in some cases it makes more sense to outsource
application maintenance or use PAAS. It depends on scope, budget, difficulty,
level of expertise required, average Joe on the team, ... To sum up, in some
cases it's up to external stuff you can't control (budget, client wishes..) and
in some cases it's team internal decision.

> _Are operations part of your Core Competences?_
> _You don't want to outsource that_.

In my latest project our team have found ourselves in need of system
administration and maintenance. Project deliveries (amongst others) are legacy
system migration to Amazon Web Services and support/operations takeover. As
usual things become more and more difficult when you dig in deep enough. Even
simple cases (and I consider that particular project small enough to give it
`M` size complexity T-shirt) become nontrivial:

 - Mapping all different kinds of topology to constraints of new platform
 - Ensuring non-functional requirements still stand true We want to make small
 - confident steps and polish later. Therefore we are unwilling to throw away
 - all existing infrastructure, security configuration, instance inter
 - communication schemes et cetera. We do it as we need to (or are forced to by
 - two previous bullet points).

As [@pukhalski](https://twitter.com/pukhalski) has [pointed out](https://twitter.com/pukhalski/status/492235123597639680)

> Architecture is constraint-based design.
> Art is design without constraints.

And I could not agree more. Sometimes we have to limit our creative side and do
what we need to do in most safe/efficient way plausible.

## The Golden Hammer

The struggle for resolution in my practice quite often begins with search for
mystic 'Golden Hammer', some particular practice or set of tools, which would
do all the hard work instead of as and would make all hard problems to vanish
away.

[DevOps] [devops] is such new promising sexy buzzword glossing all around on
top of _i-cloudy i-thingy_ and claims to address exactly that.

__tl; dr;__ In business there is no place for separate development and
operations teams working independently in isolated environments. There is ONLY
ONE PRODUCT TEAM.  Period. Product team is solely and completely responsible
for Product, there is no other group to blame for mis-deployment or
misconfiguration. Everybody needs to communicate, cooperate and work together.

I don't completely buy into _DevOps as Golden Hammer universal tool idea_. It's
clear that sane amounts of cooperation and communication are only welcome
addition and natural fit into bigger product evolution picture, nothing new
here. Also, one of DevOps interpretation is what development team empowered by
set of tools and practices would prepare OR/AND perform most of operations
tasks in automated, repeatable and testable manner. It does not necessary mean
developers perform the operations themselves.  There is still a place for
operation guys if it needs to be there: e.g. monitoring, topology setup,
hardware router configuration, Linux kernel parameter tuning et cetera, et
cetera. The DevOps scope is really about defining the framework for automation,
testing and team internal communication.  The goal is to judiciously automate
business enablers, reduce change delivery turnout time and minimize
_1-sysadmin-know-how_ and human error factors.

**Example procedure for Feature A turnout**

 - The feature has been implemented in [feature branch] [f-branch] OR [feature
   toggle] [f-toggle] has been created.
 - The provisioning (automated deployment and configuration) scripts have been
   committed into [VCS] [vcs].
 - The [Continuous Integration][ci] (CI) server deployed and enabled feature
   using [provisioning scripts][provisioning]
 - CI unit tests and feature acceptance tests have been successfully passed
 - Feature was automatically merged into master
 - ...TBD

The procedure may vary depending on product needs and team preferences.

Having said that, I did my best in research what the tools available on the
market are, that the trends are and what potential benefits I might get. In the
matter of literally 10 minutes I have come up with the following list:

 1. [PuppetLabs Puppet] [1], [puppetlabs/puppet] [2]
 2. [OpsCode Chef] [3], [opscode/chef] [4]
 3. [Ansible] [7], [ansible/ansible] [8]
 4. [SaltStack Salt] [5], [saltstack/salt] [6]

I won't try to beat Google Search and repeat multiple various sites comparing
tools and do apples-to-oranges OR trying to switch into apples-to-apples zones.
However, I'm wiling to share my subjective evaluation results and explain why
I've chosen tool A over B in my particular use case.

## Evaluation notes

TODO

### Puppet

[Puppet] [1]

### Chef

[OpsCode Chef] [3]

### Ansible

[Ansible] [7]

### Salt

[Salt] [5]

----

<!-- Link definition -->

[galeo]: https://twitter.com/galeoconsulting "Galeo twitter"
[devops]: http://en.wikipedia.org/wiki/DevOps "DevOps"
[vcs]: http://en.wikipedia.org/wiki/Revision_control "Version Control System"
[f-branch]: http://martinfowler.com/bliki/FeatureBranch.html "Feature Branch"
[f-toggle]: http://martinfowler.com/bliki/FeatureToggle.html "Feature Toggle"
[ci]: http://martinfowler.com/articles/continuousIntegration.html "Continious Integration"
[provisioning]: http://en.wikipedia.org/wiki/Provisioning "Provisioning"
[1]: http://puppetlabs.com/ "Puppet"
[2]: https://github.com/puppetlabs/puppet "Puppet at Github"
[3]: http://www.getchef.com/ "Chef"
[4]: https://github.com/opscode/chef "Chef at Github"
[5]: http://www.saltstack.com/ "Salt"
[6]: https://github.com/saltstack/salt "Salt at Github"
[7]: http://www.ansible.com/ "Ansible"
[8]: https://github.com/ansible/ansible "Ansible at Github"

