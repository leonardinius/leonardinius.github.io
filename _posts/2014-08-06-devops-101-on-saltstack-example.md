---
title: "DevOps101 with SaltStack: Because salt goes EVERYWHERE"
layout: post
---

I by all means am not a system administrator or SCM guy or DBA guy or whatever.
I call myself _Developer vulgaris_. Still, I'm used to find myself in position
I have locally working solution and little or no clue how the heck to get it
out in window.  Should I just throw it to support guys and let let them handle
that?
![Throwing code at admins](/img/posts/devops101_over_the_fence.jpg)
Image source
@[mptron.com](http://mptron.com/news/javagame/sisgame/3919-volk-yaycelov-nu-pogodi.html)

It works perfectly well. Until... until you become small consultant venture
with 3-5 team members and no additional separate support team to poke issues
to.

## Contents ##

**Update** The post topic and layout grew out of my control and present more or
less chaotic nature of my thought flow. I've tried to concentrate the post
around the following topics: the problem in hand, my take on it, strategy,
goals and how to address them efficiently, evaluation and findings down the road...
Hopefully you can make sense out of it.

Given the length, here's a helpful table of contents.

 - [The Problem](#the-problem)
 - [The Golden Hammer](#the-golden-hammer)
 - [The Goals](#the-goals)
 - [The Evaluation](#the-evaluation) ([Chef](#chef), [Puppet](#puppet),
   [Ansible](#ansible), [Salt](#salt))
 - [The Final Choice](#the-final-choice)
 - [Things I wish I'd known before I start](#things-i-wish-i'd-known-before-i-start)
 - [What worked well](#what-worked-well)
 - [Personal takeout](#personal-takeout)

## The Problem ##

I don't fanatically believe that system administrators are extinct creatures
from Age of Reptiles. I also don't think that in-team operations experience is
a MUST. In my humble opinion in some cases it makes more sense to outsource
application maintenance or use PaaS. It depends on scope, budget, difficulty,
level of expertise required, average Joe on the team, ... To sum up, in some
cases it's up to external stuff you can't control (budget, client wishes..) and
in some cases it's team internal decision.

> Are operations part of your Core Competences?
> You don't want to outsource that.

In my latest project our team have found ourselves in need of system
administration and maintenance. Project deliveries (amongst others) are legacy
system migration to Amazon Web Services, support and operations takeover. As
usual things become more and more difficult when you dig in deep enough. Even
simple cases (and I consider that particular project small enough to give it
`M` size complexity T-shirt) become nontrivial:

 - Mapping all different kinds of topology to constraints of new platform
 - Ensuring non-functional requirements still stand true
 - We want to take small confident steps and polish later. Thus we are
   unwilling to throw away all existing infrastructure, security configuration,
   instance intercommunication schemes, et cetera. We do it as we need to (or
   are forced to by two previous bullet points).

Recently I came across [@pukhalski's] [9] [tweet] [10]

> Architecture is constraint-based design.
> Art is design without constraints.

And I could not agree more. Sometimes we have to limit our creative side and do
what we need to do in most safe/efficient way plausible given the constraints.

## The Golden Hammer

The struggle for resolution in my practice quite often begins with search for
mystic _Golden Hammer_ - some particular practice, tool or set of tools which
would do all the hard work instead of us and would make all hard problems to
vanish away.

[DevOps] [define:devops] is such new sexy buzzword methodology glossing all
around on top of _i-cloudy i-thingy_ and claims to address exactly that.

__tl; dr;__
In business there is no place for separate development and operations teams
working independently in isolated environments. There is ONLY ONE PRODUCT TEAM.
Period. Product team is solely and completely responsible for Product, there is
no other group to blame for misdeployment or misconfiguration. Everybody needs
to communicate, cooperate and work together.

I don't completely buy into _DevOps universal swiss knife idea_. It's clear
that sane amounts of cooperation and communication are only welcome addition
and natural fit into bigger product evolution picture, nothing new here. Also,
one of DevOps interpretation is what development team empowered by set of tools
and practices would prepare OR/AND perform most of operations tasks in
automated, repeatable and testable manner. It does not necessary mean
developers perform the operations themselves.  There is still a place for
operation guys if it needs to be there: e.g. monitoring, topology setup,
hardware router configuration, Linux kernel parameter tuning, et cetera, et
cetera. The DevOps scope is really about defining the framework for automation,
testing and team internal communication.  The goal is to **judiciously**
automate business enablers, reduce change delivery turnout time and minimize
_one-sysadmin-know-how_ and human error factors.

## The Goals ##

In our case our goals were more migration process related:

 - **Minimize _try-fail-repeat_ cycle turnout time** <br/>
   Our initial assumption was we won't get into PROD-ready state right away. In
   the process we definitely would like to experiment with certain components
   AND/OR approaches more than few times. Think about multi node environment
   [provisioning] [define:provisioning] from scratch, DB backup restores, file
   system backup restores, etc... It's likely to take a while. EVERY. SINGLE.
   TIME. I wanted to automate as much as possible to reduce human error risks
   and speedup the whole procedure.

 - **Enable local development** <br/>
   Our goal was to enable every team member to contribute in right away from
   migration project start. The plan was to setup local [Vagrant] [11]
   virtual environment similar to current stage. That would allow us to
   remove dependency on AWS in local development environment, reduce initial
   ramp up to new team members, would make it easier to reproduce
   problems and provide fixes. And once again, experiments become more easily
   to setup and manage.

 - **Document things** <br/>
   One of the problems in early estimation was getting grasp of existing
   environment, topology and all inter-connections and inter-dependencies.
   Having our infrastructure in even semi automated way would be a big step
   forward in terms of platform internals documentation. Every developer would
   be able to sift through [Code Versioning System] [define:vcs] history and be
   able to make informed guesses about _who_, _when_, _how_ and _why_
   introduced certain change, adjusted particular parameter or opened some
   port.

 - **Single point of truth** <br />
   With infrastructure as data/code we would be able to answer that the state
   _should be_ in every moment of time. Where should not be questions of
   whether John followed the Wiki instructions OR some ticket comment OR
   whatever else. There might be issues in implementation OR our assumptions
   about the platform universe might be wrong (e.g. what state revision was
   used to provision service A). However now there is only one place the
   state _should_ come from - from Code Versioning System.

## The Evaluation

I did my best in research what the tools available on the market are, that the
trends are and what potential benefits I might get. In the matter of literally
30 minutes I have come up with the following list:

 1. [PuppetLabs Puppet] [1], [puppetlabs/puppet] [2]
 2. [OpsCode Chef] [3], [opscode/chef] [4]
 3. [Ansible] [7], [ansible/ansible] [8]
 4. [SaltStack Salt] [5], [saltstack/salt] [6]

I won't try to beat Google Search and repeat multiple various posts trying to
do apples-to-oranges OR apples-to-apples comparisons. However, I'm wiling to
share my subjective evaluation results and explain why I've chosen tool A over
B in my particular use case.

The whole process was highly subjective - no measurable criteria, no Cartesian
square comparisons etc... However, those are some of criteria I was paying
attention to:

 - Access to and readability of source code and documentation.
 - Size of community and level of support it provides.
 - How quickly and easy it is to start doing something useful.
 - Ready to use templates, solutions OR solution repositories.
 - Best Practices OR similar tutorial documents availability.
 - Infrastructure around the community.

Please note I was limited in time to assess tools. Therefore the results most
likely are misdirected or single sided in one way or another. If you, dear
reader, find my notes misleading, wrong or incomplete - please comment here.
I would like indeed have another look on this.

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
(e.g. to consult with SysOps).

Another obstacle is Ruby DSL - no one in our team is neither familiar enough
with the language, nor likes it. The language itself is the least of concerns.
Our team has small experience maintaining RoR applications (Redmine mostly) and
I have to say the way Ruby ecosystem behaves is out of my comfort zone and
expertise.

Chef also has one of thickest indirection layers expressing target provisioning
states, e.g. up to five folders with multiple files in each describing some
particular piece of state.  I'm not saying it's definitely the bad thing, it
most likely is used to enforce certain structure, enables _convention over
configuration_ and provides ultimate modularity and extensibility ;) However
it's something I would like to avoid. My preference is to have as flat
structure as possible, with least files possible while maintaining certain
style and conceptual integrity.

Having said that I find Chef to be excellent project, just maybe not the best
fit for our team.

### Puppet

**+ I liked**

In general I find [DSL] [12] more readable and concise than code. I also
consider state idempotence nice feature. The project seems to have one of the
biggest communities, especially in non-developers camps. By all means it is
mature solution.

**- I didn't like**

It seems the project aggressively tries to monetize on "Enterprise" additions
and services.

Also, in the process I had a look in what I consider to be a [simple case] [13]
and I couldn't say I liked that. I like DSL and I liked _hello world_ level
examples. That being said I don't want to reinvent the wheel and learn another
complex still useless XSLT/XML programming language.

### Ansible

**+ I liked**

Lightweight. Almost no extra dependencies on target nodes. Remote provisioning
over SSH.  Ansible claims to be able to provision Cloud Computing resources
(e.g.  AWS, Digital Ocean etc..).

**- I didn't like**

Didn't find any kind of public playbook repository. Also I found documentation
too brief. I lacked details, complex examples and best practices
documentation.

**Discovered later** [Ansible Galaxy] [14] is publicly available playbook
repository.  I must say I most likely misjudged Ansible and this tool is
definitely in _will try on next small project_ category.

### Salt

**+ I liked**

It's execution model is imperative but it's states are declarative and
idempotent. Basically they are just [YAML] [define:yaml] files/data describing
the end state of things. Some complex dynamic things could be expressed in
state templates via [Jinja] [15] markup OR implemented as [Salt modules] [16]
in Python programming language. To sum up, Salt provides some multi paradigm
mix of things and it's your choice how to glue pieces together.

I particularly liked that Salt offered [best practices and recommendations][17]
document.

Salt also has supports _master - slaves_, _standalone masterless_, _salt over
ssh_, _master of master of slaves_ modes. Again, you have a choice.

Salt also has some sort Cloud Computing resource provisioning support.

I was intrigued by fact Salt was one the most active OSS projects on Github
last year. I've registered several documentation clarification and improvement
issues to test it, occasionally visited IIRC and a little chat there. I have to
admit I was astonished by level of support I received. If anyone from Salt
community is reading this, kudos to you guys!

**- I didn't like**

Salt introduces a lot of it's own terminology. Not all of it is newcomer
friendly.

## The Final Choice ##

In the end I choose SaltStack Salt over other solutions. The list of reasons in
order of importance:

 - I've found it easier to begin with. Most likely it has something with
   _Getting Started_ tutorials and quality of documentation in general.
 - The astonishing community.
 - Idempotent declarative states.
 - Multi paradigm approach gave a feeling I could make it work one way or another.
 - Cloud Computing provisioning support

## Things I wish I'd known before I start ##

In the process I have re-evaluated some of the evaluation results and findings.

Things I have discovered during implementation phase (mostly the hard way).

### I. Community and enormous velocity has it's quirks ###

Salt community is huge and vibrant. At the moment of writing [saltstack] [6]
has 320 watchers and 3,787 stars. **And 1,462 open issues.** No doubt, being an
open souce gardener [is no an easy walk] [18]. The community contribution are
easy and kindly accepted, no strict procedures, no CLA agreements and long
formal reviews. As a result some of functionality or documentation is
incomplete or inconsistent.

I wouldn't say it's all bad OR black and white, I believe Salt has managed to
be in compromise sweet spot - getting maximum from community, free of charge,
while still be useful and mostly reliable.

### II. Screw you GitFS, I'm going home ###

My initial plan was to leverage [GitFS] [19] to deliver environment
configuration to Salt master and slave nodes (minions).  Salt recommends to
split states and sensitive data in separate things, e.g. [Salt states] [20] and
[Salt pillar] [21].

Former one could be split in environments (each Git branch is a separate
environment name) and multiple Git repositories with different branch names
could be collected under one single environment (e.g. you own states under PROD
branch, some Github repo with Apache provisioning formula under MASTER
branch).

Pillar data however has drawback [#11575] [22] of not being able to redefine
`base` environment data.

That, lack of transparency, no means to ensure pillar GitFS data and multiple
state GitFS repositories are correctly inter-synchronized (each of GitFS
repositories is potential point of failure, while most of data might be pulled
correctly, however some other git repo might fail due to network connectivity
and still refer to previous outdated version), etc. - effectively kill the
idea, at least for use in production. A local copy of data on production
instances in AWS seems much more better idea. Continuous Integration server
with rsync to AWS master seems to provide more much more transparent and
controlled setup. Those are two qualities I seek for in production setups.

### III. Salt multi environment setup has no answer ###

[Environments] [23] seems to  work best in _master of masters of minions_
(aka [syndic] [24] mode. In such case it's convenient to control multiple
environments from one super master.

However, in our case I would like to treat each particular environment as
sandbox, each of being `base` or baseline in itself. E.g. I view STAGE
environment as a separate sandbox version of PROD environment. They might not
share the same topology, however all the roles/components are present in one
way or another (e.g. we use RDS in AWS and PostgreSQL in local development
environment). As it turns out, Salt does not have an answer on how to layout
things in multi environment configuration. I have tried asking on user mailing
lists and IIRC. People do things the way it works best for them, however there
is not such thing as _Recommended layouts for different types of environments_
document out there. There are certain means how to cover your needs one way or
another (it's the place where Salt's enormous flexibility kicks in), still it
feels as reinventing square wheel over and over, again and again.

### IV. Salt orchestration is not worth it ###

Salt has certain means to define order and interdependencies between nodes. In
Salt terminology it's called _orchestration_. The recommended way nowadays
seems to be Salt's [orchestrate runner] [25].

I've spent fair amount of time trying to automate our environment initial roll
out using that tool. However I've found it inadequately lacking for our needs.
The nature of our project enforced multi-node deployment, multi-step restore
from backups et cetera. That kind of logic, especially different kind of
retry-wait-retry procedures, is difficult if even possible to express using
that tool. I'm not saying that could not be done in safe reliable way. But, my
outtake was it's quite time consuming to implement it and I would rather spend
that time moving project further rather than staying still and doing time
sinking exercises. I've decided to leave it as manual step-by-step procedure
put in Wiki. It serves our needs, is much more reliable and doesn't bother us
much.

### V. Salt Cloud provisioning is insufficient ###

[Salt Cloud] [26] is Salt's way of how to describe and launch nodes (minions)
on different target Cloud Computing providers. The list of supported providers
covers most of mainstream cargo providers out there.

Initially I've tried to leverage node configuration to Salt Cloud, to keep
things in one uniformed way. However I soon had a lot of questions with no
answer: how to describe [VPC] [27], how to define security groups et cetera, et
cetera.

I have found Salt Cloud inadequately lacking for my needs and not documented
well enough (e.g. I've discovered some pieces of functionality from issue
tracker, not from official documentation). Salt Cloud might be a handy tool for
different use cases, e.g. to launch several nodes outside of VPC, no Elastic
Load Balancer and no AutoScale groups, however we decided we will use different
solutions more suited for our needs.

## What worked well ##

### I. AWS CloudFormation ###

> [AWS CloudFormation][28] gives developers and systems administrators an easy
> way to create and manage a collection of related AWS resources, provisioning
> and updating them in an orderly and predictable fashion.

Technically speaking it's [JSON] [define:json] formatted AWS Cloud Computing
resources template. See AWS CloudFormation [Template Reference] [31] for more
information of what's possible to define using this solution.

What in particular I like about AWS CloudFormation:

 - [Version Control System] [define:vcs] friendly <br/>
   JSON files are perfect fit to be stored and versioned in VCS system. We
   still are able to dig into history, read comments and reason about changes,
   are able to rollback to previous versions or even bisect problems if we need
   to.

 - The [range] [32] of supported AWS resources <br/>
   AWS CloudFormation allowed us to define every bit of AWS infrastructure we
   were up to: Elastic Load Balancer, Instances, RDS, Security Groups, EBS
   volumes, ... To many to list. We didn't feel we are somehow limited in any
   sense by this solution.

 - The support of stack [updates] [33] <br/>
   You modify AWS CloudFormation JSON template file and in most cases AWS is
   able to use it as new state to stack into (you still need to read each
   particular resource documentation to see whether the resource supports the
   update operation and what does it mean in each particular case).

 - Last, but not least - Atomicity of operations and treating stack as whole<br/>
   It either updates fully, or not. It isn't stuck in the middle (at least it
   shouldn't). And if something went wrong, the whole update could be
   cancelled. I also found _wholism_ quite useful during early prototype phase.
   I would create POC environment, play with it for a while and then drop it
   completely with all associated resources. Very handy.

At the moment of writing we use hand-crafted AWS CloudFormation templates,
mostly from the control point of view. We wanted to keep it as simple and plain
as possible, with as little intermediate transformation, magic or whatever else
involved in the middle.

Having said that, we are keeping eyes on alternative approaches, such as:

 - Use [Troposphere] [30] OR similar solutions to generate CloudFormation
   templates from meta-model. This hopefully will allow us to reduce
   boilerplate code and make our stack meta-model more concise, readable and
   documented (CloudFormation templates don't allow to have comments).
 - Use of [boto] [34] library to automate certain things, e.g. certain amount
   of orchestration AND production environment freeze (e.g. create AMI images
   from some instances and use them later on as Amazon Auto Scaling launch
   configuration image, ...).

### II. Roles based configuration ###

We were highly influenced by [Roles based configuration] [29], the concept we
overtook in our SaltStack based configuration as well.

In our case we have different STAGE and PROD topology configurations (different
count of instances, no RDS in STAGE, etc..), mostly due to practical expense
reasons.

In our case we use roles as means of specify resource location and as service
discovery starting point.

We assign roles to instances via EC2 [UserData] [35] (in CloudFormation
templates). We don't auto generate top files, instead we define that each
particular role means in THIS particular environment (single node LDAP in STAGE
might become Active-Active LDAP SyncReplica in PROD), e.g.

```yaml
...
  'roles:www-frontend':
    - match: grain
    - fileserver.client-gfs
    - www.site1
    - www.site2
...
```

This approach allowed us to concentrate on functionality and common
denominators, with differences kept in role definitions in top files.

### III. Service discovery ###

See previous point. We use `(role, AWS region/Zone)` tuple as service discovery
ID.

It enables us to decouple components from physical topology removes need to
hardcode things like DSN names, IP addresses etc..

At the moment we leverage self-made solution on top of [Salt Mine] [36], which
seemed the quickest to setup at the time. However it's our feeling it adds
quite a lot of [accidental complexity] [37] to the cake, which we don't like.
We are keeping our eyes on [Consul] [38] or some clever [dnsmasq] [39]
schemas.

### IV. Plain layout ###

In general we like to keep things as simple as possible. We understand it as
following:

 - Keep levels of indirection to meaningful minimum
 - Keep things plain
 - Prefer composition OR copy of things to any clever smart-ass
   inheritance / override schemas.

Plus, we had experienced certain annoyances, bugs and glitches with SalStack
GitFS implementation. Having said that we have come to the following general
approach how to layout things in our SaltStack based configuration.

```text
/srv/salt
├── base
│   ├── sanity.sls             # shared
│   ├── security-updates.sls   # shared
│   ├── ...
├── ldap
│   ├── server-ha.sls          # PROD uses it to define it's ldap-server role
│   └── server.sls             # DEV uses it to define it's ldap-server role
├── reverse-proxy
│   ├── httpd
│   │   ├── config
│   │   │   ├── www-zyx
│   │   │   │   ├── default
│   │   │   │   ├── httpd.args.jinja         # same role definition
│   │   │   │   ├── httpd.conf.jinja         # uses file.managed with multiple sources e.g.
│   │   │   │   ├── prod-httpd.args.jinja    # xyz:
│   │   │   │   ├── prod-httpd.conf.jinja    #   file.managed:
│   │   │   │   ├── prod-httpd.env.jinja     #     source:
│   │   │   └── init.d.jinja                 #       - salt://{ { grains['environment'] } }-xyz
│   │   └── init.sls                         #       - salt://xyz
│   └── init.sls
├── stage-top.sls              # STAGE top file
└── prod-top.sls               # PROD top file
```

I'm not sure it's the best layout out there, but it works for us. Bear in mind
that our salt universe might be considered small and simple enough. We
definitely don't have hundreds of minions and thousands of services to
provision, just a handful ten or so. So, I suspect we would come to different
conclusion with different scale level.

## Personal takeout ##

**Update** I've made a decision to time limit myself on this post and it's
scope. So, instead of expanding on this I will limit myself to simple plain
bullet points with no explanations whatsoever.

 - **Automation saves huge amount of time**

 - **Don't buy into feature lists**

 - **Decouple first**

 - **Time limit proof of concept attempts**

 - **Make first, polish later**

----

<!-- Link definition -->

[galeo]: https://twitter.com/galeoconsulting "Galeo twitter"
[define:devops]: http://en.wikipedia.org/wiki/DevOps "DevOps"
[define:vcs]: http://en.wikipedia.org/wiki/Revision_control "Version Control System"
[define:provisioning]: http://en.wikipedia.org/wiki/Provisioning "Provisioning"
[define:idempotence]: http://en.wikipedia.org/wiki/Idempotence "Idempotence"
[define:imperative]: http://en.wikipedia.org/wiki/Imperative_programming "Imperative"
[define:yaml]: http://en.wikipedia.org/wiki/YAML "YAML"
[define:json]: http://en.wikipedia.org/wiki/JSON "JSON"
[1]: http://puppetlabs.com/ "Puppet"
[2]: https://github.com/puppetlabs/puppet "Puppet at Github"
[3]: http://www.getchef.com/ "Chef"
[4]: https://github.com/opscode/chef "Chef at Github"
[5]: http://www.saltstack.com/ "Salt"
[6]: https://github.com/saltstack/salt "Salt at Github"
[7]: http://www.ansible.com/ "Ansible"
[8]: https://github.com/ansible/ansible "Ansible at Github"
[9]: https://twitter.com/pukhalski "@pukhalski"
[10]: https://twitter.com/pukhalski/status/492235123597639680
[11]: http://www.vagrantup.com/ "Vagrant"
[12]: http://docs.puppetlabs.com/puppet/latest/reference/lang_summary.html "Puppet DSL"
[13]: https://github.com/aestasit/talks2013-javaday-groovy-devops-setup/blob/a3259feebddf66dbce336447babdae5343b71e3e/manifests/init.pp "Simple Puppet Case"
[14]: https://galaxy.ansible.com/ "Ansible Galaxy"
[15]: http://jinja.pocoo.org/ "Jinja Templates"
[16]: http://docs.saltstack.com/en/latest/ref/modules/ "Salt Modules"
[17]: http://docs.saltstack.com/en/latest/topics/best_practices.html "Salt Best Practices"
[18]: http://words.steveklabnik.com/how-to-be-an-open-source-gardener "How to be an open source gardener"
[19]: http://docs.saltstack.com/en/latest/topics/tutorials/gitfs.html "GitFS"
[20]: http://docs.saltstack.com/en/latest/topics/tutorials/starting_states.html "Salt States"
[21]: http://docs.saltstack.com/en/latest/topics/pillar/index.html "Salt Pillar"
[22]: https://github.com/saltstack/salt/issues/11575 "#11575"
[23]: http://docs.saltstack.com/en/latest/ref/states/top.html#environments "Salt Environments"
[24]: http://docs.saltstack.com/en/latest/topics/topology/syndic.html "Salt Syndic"
[25]: http://salt.readthedocs.org/en/latest/topics/tutorials/states_pt5.html#the-orchestrate-runner "Orchestrate runner"
[26]: http://docs.saltstack.com/en/latest/topics/cloud/ "Salt Cloud"
[27]: http://aws.amazon.com/vpc/ "Amazon VPC"
[28]: http://aws.amazon.com/cloudformation/ "Amazon CloudFormation"
[29]: http://www.saltstat.es/posts/role-infrastructure.html "Role based infrastructure"
[30]: https://github.com/cloudtools/troposphere "Troposphere"
[31]: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html "AWS CloudFormation Template reference"
[32]: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html "AWS CloudFormation Resource Types"
[33]: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks.html "AWS CloudFormation Stack Updates"
[34]: https://github.com/boto/boto "Boto"
[35]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AESDG-chapter-instancedata.html "UserData"
[36]: http://docs.saltstack.com/en/latest/topics/mine/#mine-functions "Salt Mine"
[37]: http://en.wikipedia.org/wiki/No_Silver_Bullet "accidental complexity"
[38]: http://www.consul.io/ "consul.io"
[39]: http://www.thekelleys.org.uk/dnsmasq/doc.html "dnsmasq"
