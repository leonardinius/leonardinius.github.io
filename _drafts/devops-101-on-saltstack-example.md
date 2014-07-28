---
title: "Devops101 with SaltStack: Because salt goes EVERYWHERE"
layout: post
---

I by no means am no system administrator or SCM guy or DBA guy or whatever. My
job duties consist mostly from analysis, system design and delivery, little
piece of architecture now and then. I proudly call myself _Developer vulgaris_.

Still, I used to find myself in position I have working (locally) solution and
little or no clue how the heck to get it out in window. Should I just throw it
to admins, let them handle that and hope it won't break? 

![Throwing code at admins](/img/posts/devops101_over_the_fence.jpg) 
Image source @[mptron.com](http://mptron.com/news/javagame/sisgame/3919-volk-yaycelov-nu-pogodi.html)

It worked perfectly well. Until... until you are small consultant venture with
3-5 team members and no additional separate support/admin team to poke issues
to.

I myself don't religiously believe system administrators are extinct creatures
from Age of Reptiles. I also don't think that in-team operations experience is
a MUST. In my humble opinion in some cases it makes more sense to outsource
application maintenance or use PAAS. It depends on scope, budget, difficulty,
level of expertise required, average Joe on the team et cetera.

To sum up, in some cases it's up to external stuff you can't control (budget,
client wishes..) and in some cases it's team internal decision. In later case
the real question is - _Are operations part of your Core Competences?  You
don't want to outsource that_.

In my latest project our team have found ourselves in need of system
administration and maintenance. One of the project delivery if legacy system
migration to Amazon Web Services (namely ec2, s3 et cetera).

And here it begins, The Struggle

## Operations struggle

The struggle for resolution in my practice quite often begins with search for
mystic 'Golden Hammer', some particular tool or set of tools, which would make
all the hard work and defeat all problems.

[Devops][devops] is new promising sexy buzzword glossing all around on top of
_i-cloudy i-thingy_. One of assumed promises is what development team empowered
by set of tools and practices would perform most of operations needs and will
increase operations turnout and indirectly ROI (return of investment) on people
and infrastructure automation.

In real life it more or less means that in business there is no place for
separate development and operations teams working independently in isolated
environments. There is ONLY ONE PRODUCT TEAM. Period. Product team is solely
and completely responsible for Product, there is no other group to blame for
mis-deployment or misconfiguration. Everybody needs to communicate and
cooperate and work together.

Having said that, I did my best in research what are the latest tools available
on the market, that the trends are. In the matter of literally 10 minutes I
have come up with the following list:

1. [PuppetLabs Puppet][1], [puppetlabs/puppet][2]
2. [OpsCode Chef][3], [opscode/chef][4]
3. [SaltStack Salt][5], [saltstack/salt][6]
4. [Ansible][7], [ansible/ansible][8]

I won't try to beat Google Search and repeat multiple various sites comparing
tools and do apples-to-oranges OR trying to switch into apples-to-apples zones.
However, I'm wiling to share my subjective evaluation results and explain why
I've chosen tool A over B in my particular use case.

### Puppet

Puppet

### Chef

Chef

### Salt

Salt

### Ansible

Ansible


----

<!-- Link definition --> 

[galeo]: https://twitter.com/galeoconsulting "Galeo twitter"
[devops]: http://en.wikipedia.org/wiki/DevOps "DevOps"
[1]: http://puppetlabs.com/ "Puppet"
[2]: https://github.com/puppetlabs/puppet "Puppet at Github"
[3]: http://www.getchef.com/ "Chef"
[4]: https://github.com/opscode/chef "Chef at Github"
[5]: http://www.saltstack.com/ "Salt"
[6]: https://github.com/saltstack/salt "Salt at Github"
[7]: http://www.ansible.com/ "Ansible"
[8]: https://github.com/ansible/ansible "Ansible at Github"

