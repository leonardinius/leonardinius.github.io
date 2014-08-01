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
 - [The Evaluation](#the-evaluation)
 - [The Choice](#the-choice)
 - [Things I wish I knew before start](#things-i-wish-i-knew-before-start)
 - [Lessons learned](#lessons-learned)

## The Struggle ##

I don't fanatically believe that system administrators are extinct creatures
from Age of Reptiles. I also don't think that in-team operations experience is
a MUST. In my humble opinion in some cases it makes more sense to outsource
application maintenance or use PAAS. It depends on scope, budget, difficulty,
level of expertise required, average Joe on the team, ... To sum up, in some
cases it's up to external stuff you can't control (budget, client wishes..) and
in some cases it's team internal decision.

> Are operations part of your Core Competences?
> You don't want to outsource that.

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
mystic _Golden Hammer_ (we also might call it _Holy Grail_), some particular
practice or set of tools, which would do all the hard work instead of us and
would make all hard problems to vanish away.

[DevOps] [define:devops] is such new sexy buzzword methodology glossing all
around on top of _i-cloudy i-thingy_ and claims to address exactly that.

__tl; dr;__
In business there is no place for separate development and operations teams
working independently in isolated environments. There is ONLY ONE PRODUCT TEAM.
Period. Product team is solely and completely responsible for Product, there is
no other group to blame for mis-deployment or misconfiguration. Everybody needs
to communicate, cooperate and work together.

I don't completely buy into _DevOps universal swiss knife idea_. It's clear
that sane amounts of cooperation and communication are only welcome addition
and natural fit into bigger product evolution picture, nothing new here. Also,
one of DevOps interpretation is what development team empowered by set of tools
and practices would prepare OR/AND perform most of operations tasks in
automated, repeatable and testable manner. It does not necessary mean
developers perform the operations themselves.  There is still a place for
operation guys if it needs to be there: e.g. monitoring, topology setup,
hardware router configuration, Linux kernel parameter tuning et cetera, et
cetera. The DevOps scope is really about defining the framework for automation,
testing and team internal communication.  The goal is to judiciously automate
business enablers, reduce change delivery turnout time and minimize
_1-sysadmin-know-how_ and human error factors.

**Example procedure for Feature A turnout**

 - The feature has been implemented in [feature branch] [define:f-branch] OR
   [feature toggle] [define:f-toggle] has been created.
 - The provisioning (automated deployment and configuration) scripts have been
   committed into [VCS] [define:vcs].
 - The [Continuous Integration][define:ci] (CI) server deployed and enabled
   feature using [provisioning scripts][define:provisioning]
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

I won't try to beat Google Search and repeat multiple various posts trying to
do apples-to-oranges OR apples-to-apples comparisons. However, I'm wiling to
share my subjective evaluation results and explain why I've chosen tool A over
B in my particular use case.

## The Evaluation

The whole process was highly subjective - no measurable criteria, no Cartesian
square comparisons etc... However, those are some of criteria I was paying
attention to:

 - Find Homepage, source code, documentation URLs. Assess availability and
   readability.
 - Estimate size of community and assess the level of support it provides.
 - Asses how quickly and easy is to start doing something useful.
 - Find ready to use templates, solutions OR solution repositories.
 - Locate Best Practices OR similar tutorials and their readability.
 - Assess infrastructure around the solution and community.

Please note I was limited in time to assess tools. Therefore the results most
likely are misdirected or single sided in one way or another. If you reader
find my notes misleading, wrong or incomplete - please comment here. I would
like indeed have free of charge peer review and another look into this.

### Chef

**+ I liked**

I think most programmers find imperative states are easy to reason about since
it's something that they are used to do on daily basis - reading imperative
code. Chef has one of the richest ecosystem, lots of available modules and
templates, AWS OpsWorks. Chef also enables both _master - slave_ and _knife
bootstrap_ modes.

**- I didn't like**

I know I've said earlier I find imperative code more natural choice for
programmers, still I prefer declarative [idempotent] [define:idempotence]
states over [imperative code] [define:imperative] any day. In my opinion
idempotence hardly could be overrated. Also, in my experience declarative
states are usually more concise and easier to communicate to non programmers
(e.g. to consult with SysOps).  Another obstacle is Ruby DSL - no one in our
team is neither familiar enough with the language, nor likes it. The language
itself is the least of concerns.  Our team has small experience maintaining RoR
applications (Redmine mostly) and I have to say the way Ruby ecosystem behaves
is out of my comfort zone and expertise. Chef also has one of thickest
indirection layers expressing target provisioning states, e.g. up to five
folders with multiple files in each describing some particular piece of state.
I'm not saying it's definitely the bad thing, it most likely is used to enforce
certain structure, enables _convention over configuration_ and provides
ultimate modularity and extensibility ;) However it's something I would like to
avoid. My preference is to have as flat structure as possible, with least files
possible while maintaining certain style and conceptual integrity. Having said
that I find Chef to be excellent project, just maybe not the best fit for our
team.

### Puppet

**+ I liked**

In general I find
[DSL](http://docs.puppetlabs.com/puppet/latest/reference/lang_summary.html)
more readable and concise than code. I also consider state idempotence nice
feature. The project seems to have one of the biggest communities, especially
in non-developers camps. By all means it is mature solution.

**- I didn't like**

It seems the project aggressively tries to monetize on "Enterprise" additions
and services. Also, in the process I had a look in what I consider to be a
[simple case](https://github.com/aestasit/talks2013-javaday-groovy-devops-setup/blob/a3259feebddf66dbce336447babdae5343b71e3e/manifests/init.pp)
and I couldn't say I liked that. I like DSL and I liked _hello world_ level
examples. That being said I don't want to reinvent the wheel and learn another
complex still useless XSLT/XML programming language.

### Ansible

**+ I liked**

Lightweight. Almost no extra dependencies on target nodes. Remote provisioning
over SSH. Ansible is able to provision IaS through API (e.g. AWS, Digital Ocean
et cetera).

**- I didn't like**

Didn't find any kind of public playbook repository. Also I found documentation
too brief and compact. I lacked details, complex examples and best practices
documentation.

_Discovered later_ [Ansible Galaxy](https://galaxy.ansible.com/) is publicly
available playbook repository. I must say I most likely misjudged Ansible and
this tool is definitely in _will try on next small project_ category.

### Salt

**+ I liked**

It's execution model (modules) are imperative and it's states are imperative
and idempotent. Basically they are just YML files/data describing the end state
of things. Some complex dynamic things could be expressed in state templates
via Jinja markup. To sum up, Salt provides some multi paradigm mix of things and
it's your choice how to glue things. On top of it - Salt explicitly documents
[best practices and recommendations](http://docs.saltstack.com/en/latest/topics/best_practices.html).
Salt also has support of _master - slaves_, _standalone masterless_, _salt over
ssh_, _master of master of slaves_ modes. Again, you have a choice. Salt also
claims to support IaS provisioning through API (e.g. AWS, ...). I also was
intrigued by fact Salt was one the most active OSS projects on Github last
year, to test it I've registered several documentation clarification and
improvement issues and have visited IIRC one several occasions. I have to admit
I was astonished by level of support I received. If anyone from Salt community
is reading this, kudos to you guys!

**- I didn't like**

Salt introduces a lot of it's own terminology. The amount of supported use
cases is quite big, there is quite a lot documentation out there. No all of it
is newcomer friendly.

## The Choice ##



## Things I wish I knew before start ##

## Lessons learned ##


----

<!-- Link definition -->

[galeo]: https://twitter.com/galeoconsulting "Galeo twitter"
[define:devops]: http://en.wikipedia.org/wiki/DevOps "DevOps"
[define:vcs]: http://en.wikipedia.org/wiki/Revision_control "Version Control System"
[define:f-branch]: http://martinfowler.com/bliki/FeatureBranch.html "Feature Branch"
[define:f-toggle]: http://martinfowler.com/bliki/FeatureToggle.html "Feature Toggle"
[define:ci]: http://martinfowler.com/articles/continuousIntegration.html "Continious Integration"
[define:provisioning]: http://en.wikipedia.org/wiki/Provisioning "Provisioning"
[define:idempotence]: http://en.wikipedia.org/wiki/Idempotence "Idempotence"
[define:imperative]: http://en.wikipedia.org/wiki/Imperative_programming "Imperative"
[1]: http://puppetlabs.com/ "Puppet"
[2]: https://github.com/puppetlabs/puppet "Puppet at Github"
[3]: http://www.getchef.com/ "Chef"
[4]: https://github.com/opscode/chef "Chef at Github"
[5]: http://www.saltstack.com/ "Salt"
[6]: https://github.com/saltstack/salt "Salt at Github"
[7]: http://www.ansible.com/ "Ansible"
[8]: https://github.com/ansible/ansible "Ansible at Github"

