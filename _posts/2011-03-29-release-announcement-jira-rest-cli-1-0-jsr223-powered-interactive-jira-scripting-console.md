---
layout: post
title: "Release announcement: jira-rest-cli-1.0 (jsr223 powered interactive jira scripting console)"
date: 2011-03-29
comments: false
permalink: 2011/03/release-announcement-jira-rest-cli-05.html
tags: [atlassian, rest-cli, pdk, java]
---

**Check it out**

<table cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-mkFMoGxOFi8/TZTCeGgyWyI/AAAAAAAAELU/8cnUY43s_TI/s1600/1_2011-03-31_1946.png" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" src="http://3.bp.blogspot.com/-mkFMoGxOFi8/TZTCeGgyWyI/AAAAAAAAELU/8cnUY43s_TI/s1600/1_2011-03-31_1946.png" /></a>  </td></tr><tr><td class="tr-caption" style="text-align: center;">logo</td></tr></tbody></table>

<a href="https://github.com/leonardinius/jira-rest-cli">jira-rest-cli</a> is JIRA plugin which provides a possibility to use your favorite programming language to script and interact with JIRA server realtime. The plugin provide following working modes:

<ul><li>JIRA web-executor interface - allows to execute script input from Jira admin interface, no continuos working session support and no working context preservation between invocations.</li><li>JIRA web-cli interface - allows to create and manage working scripting sessions from Jira admin interface, connect to them and execute script code in the scripting session context - state is preserved between invocations. </li><li>The are sample console clients available (Ruby, Groovy) which works similar to interactive language shells (irb, groovysh).</li></ul>

At the moment following programming languages are supported:

* JavaScript (Rhino) shipped with Oracle JDK - <span class="Apple-style-span" style="color: #274e13;">default</span>
* Groovy 1.7.9 - <span class="Apple-style-span" style="color: #bf9000;">separate</span>
* JRuby 1.5.6 - <span class="Apple-style-span" style="color: #bf9000;">separate</span>.

Languages are implemented as standalone plug-able components, installed separately, except for Rhino available by default.

The target is to come as close to Firebug / IRB / Groovysh as possible :)

- Project page: [https://github.com/leonardinius/jira-rest-cli](https://github.com/leonardinius/jira-rest-cli)
- README: [README.md](https://github.com/leonardinius/jira-rest-cli/blob/master/README.md)
- Plugin exchange <span class="Apple-style-span" style="background-color: yellow;">at the moment not mature enough. Needs more documentation, specification and testing...</span>[Link to plugin exchange](https://github.com/leonardinius/jira-rest-cli)

**Screenshots**

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-bottom: 0.5em; margin-left: auto; margin-right: auto; padding-bottom: 6px; padding-left: 6px; padding-right: 6px; padding-top: 6px; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-pXkS3i1_km0/TZECWFTFBSI/AAAAAAAAELQ/fM3T-kyrIVc/s1600/non+cli.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="232" src="http://1.bp.blogspot.com/-pXkS3i1_km0/TZECWFTFBSI/AAAAAAAAELQ/fM3T-kyrIVc/s640/non+cli.png" width="640" /></a></td></tr><tr><td class="tr-caption" style="padding-top: 4px; text-align: center;">Web-executor mode (non-interactive)</td></tr></tbody></table>

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-hS6PnineDH4/TZECSGv-rEI/AAAAAAAAELE/3fQXcd8Brlc/s1600/2011-03-28_2344.png" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://1.bp.blogspot.com/-hS6PnineDH4/TZECSGv-rEI/AAAAAAAAELE/3fQXcd8Brlc/s640/2011-03-28_2344.png" /></a></td></tr><tr><td class="tr-caption" style="text-align: center;">Web-cli mode, session management</td></tr></tbody></table>

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-bottom: 0.5em; margin-left: auto; margin-right: auto; padding-bottom: 6px; padding-left: 6px; padding-right: 6px; padding-top: 6px; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://1.bp.blogspot.com/-cPW_TitsUx4/TZECS2LQOeI/AAAAAAAAELI/pPJr5WiVUuo/s1600/2011-03-28_2346.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="379" src="http://1.bp.blogspot.com/-cPW_TitsUx4/TZECS2LQOeI/AAAAAAAAELI/pPJr5WiVUuo/s640/2011-03-28_2346.png" width="640" /></a></td></tr><tr><td class="tr-caption" style="padding-top: 4px; text-align: center;">Web-cli mode, script execution (jRuby)</td></tr></tbody></table>

<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="font-size: medium; margin-bottom: 0.5em; margin-left: auto; margin-right: auto; padding-bottom: 6px; padding-left: 6px; padding-right: 6px; padding-top: 6px; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://3.bp.blogspot.com/-62GtLpXPg6s/TZECVaXpdZI/AAAAAAAAELM/qigOfVpp_zQ/s1600/jruby.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="427" src="http://3.bp.blogspot.com/-62GtLpXPg6s/TZECVaXpdZI/AAAAAAAAELM/qigOfVpp_zQ/s640/jruby.png" width="640" /></a></td></tr><tr><td class="tr-caption" style="font-size: 13px; padding-top: 4px; text-align: center;">Remote console-cli mode, script execution (jRuby)</td></tr></tbody></table><span class="Apple-style-span" style="font-size: large;"><span class="Apple-style-span" style="background-color: yellow; font-size: small;"></span></span><br /><span class="Apple-style-span" style="font-size: x-large;"><b>Project goal / scratch the itch</b></span><br />The problem I periodically get with the JIRA is the necessity of creating and configuring multiple different JIRA instance. In some cases this is pilot version, prototype extension or some stage/perf tests related configuration. Let's say it as it is - it's extremely difficult to setup thing in JIRA from scratch: projects, issue types, fields and all the schemas; there are just so mane of them out there.<br /><br />So, I tried to automate certain things, at least at the local development environment. And I've found it extremely difficult to do so. So, I had this crazy idea - why couldn't I have some kind of JIRA API Firebug? Some environment I could actually script my environmental changes, experiment with the stuff and optionally save/reuse scripts later on. And yes: it would be cool if I would be able to use familiar to me ruby and maybe try out some different languages.<br /><br />Basically it's the core idea behind my pet <a href="https://github.com/leonardinius/jira-rest-cli">jira-rest-cli</a> project.<br /><b><span class="Apple-style-span" style="font-size: x-large;">Isn't something already available out there?</span></b><br />Before doing something I did my homework and looked for other available options:

<ul><li><span class="Apple-style-span" style="font-family: Times, 'Times New Roman', serif;"><a href="https://plugins.atlassian.com/plugin/details/16346">Python CLI for JIRA</a> - basically cli interface to JIRA SOAP interface;</span></li><li><span class="Apple-style-span" style="font-family: Times, 'Times New Roman', serif;"><a href="https://plugins.atlassian.com/plugin/details/16346">Jira Scripting Suite</a> - p<span class="Apple-style-span" style="color: #333333; line-height: 16px;">rovides a convenient way to put custom conditions, validators and post-functions into workflow in a form of Jython scripts..</span></span></li><li><span class="Apple-style-span" style="font-family: Times, 'Times New Roman', serif;"><a href="https://plugins.atlassian.com/plugin/details/6820">Script Runner</a> - provide ability to script (<span class="Apple-style-span" style="color: #333333; line-height: 16px;">JSR-223 capable) workflow validators, conditions, etc..</span></span></li></ul><div><span class="Apple-style-span" style="color: #333333; font-family: Times, 'Times New Roman', serif;"><span class="Apple-style-span" style="line-height: 16px;">What's wrong with? Actually - nothing. The</span></span><span class="Apple-style-span" style="color: #333333; font-family: Times, 'Times New Roman', serif; line-height: 16px;">y are great pieces of software and they excellently do they should do - extend JIRA functionality and provide possibility to easily extend workflows (Jira Scripting Suite, Script Runner) w/o need to restart Jira server, or provide access to built-in remote access (Python CLI for JIRA).</span></div><div><span class="Apple-style-span" style="color: #333333; font-family: Times, 'Times New Roman', serif; line-height: 16px;">The thing I've missed here - is to play with Jira API in the realtime, see what's inside of teddy bear looks </span>like (latvian: kas lācītim vēderā) and the ability to use the same approach to automate certain operations.</div><b><span class="Apple-style-span" style="font-size: x-large;">How could I use it?</span></b><br />When working with it I have several use-cases in mind:</div><div>

<ul><li>Use it as console-tool to script and automate certain configuration changes (local development; staging etc development rollout)</li><li>Use it as a tool to play with JIRA system API at realtime (local development needs)</li></ul><div>I would really appreciate if you will think out other use-cases and will report them back to me. So do it :) </div><span class="Apple-style-span" style="font-size: x-large;"><b>How to start?</b></span>

1. git clone git@github.com:leonardinius/jira-rest-cli.gitcd jira-rest-cli/git submodule initcd jira-rest-cli-parent/atlas-mvn clean install
2. To start play with the REST Cli - you need to install _jira-rest-cli-runner_ plugin, which is a main entry point and Rhino language provider.
3. If you want to try out JRuby or Groovy language support - then you should install _jira-rest-cli-jruby_ or _jira-rest-cli-groovy_ accordingly.

OR you could get all this artifacts here

* [jira-rest-cli-runner](http://dl.dropbox.com/u/379506/jira-rest-cli/jira-rest-cli-runner-1.0.jar) - Script runner, web-console, session mgmt admin interface, Rhino language support.
* [jira-rest-cli-jruby](http://dl.dropbox.com/u/379506/jira-rest-cli/jira-rest-cli-jruby-1.0.jar) - JRuby support
* [jira-rest-cli-groovy](http://dl.dropbox.com/u/379506/jira-rest-cli/jira-rest-cli-groovy-1.0.jar) - Groovy support
* cli-examples - browse on GitHub, fetch locally and play around yourselves :)


NB: on my local dev environment I install all the plugins using [atlas-cli](http://confluence.atlassian.com/display/DEVNET/atlas-cli) since I launch JIRA using [atlas-run](http://confluence.atlassian.com/display/DEVNET/atlas-run) / [atlas-debug](http://confluence.atlassian.com/display/DEVNET/atlas-debug) commands.

**Ok, it's useful. How could I help?**

Cool. First of all you are in the right place with the right attitude :)
The areas I'm struggling with on my personal Roadmap:

* High priority: Documentation - both creating one and understanding what actually is missing. Even GitHub issues for this are welcome.
* Medium priority: Upload plugin to [Atlassian Plugin Exchange](https://plugins.atlassian.com/)
* Medium priority: Improving console-cli modes sample applications (JRuby, Groovy) - cleaning up, since I'm not expert in those languages; adding command line options.
* Low priority: improving web-interface (more Ajax-like) etc...

PS: project is useful (at least for me) at the current stage and IMO documentation what is the only crucial piece missing.

Thin badge: <script src="http://www.ohloh.net/p/488909/widgets/project_thin_badge.js" type="text/javascript"></script>
