---
layout: post
title: jira-rest-cli-1.1-SNAPSHOT work in progress
date: 2011-04-12
comments: false
permalink: 2011/04/jira-erst-cli-11-snapshot-work-in.html
tags: [atlassian, rest-cli, pdk]
---

At the moment working on <a href="https://github.com/leonardinius/jira-rest-cli/tree/release/1.1">jira-rest-cli-1.1 release</a>.

Done already
---
<ul><li>console client improved (groovy): understands a whole set of command line options. See client help message below:

{% highlight console %}
$ rest-cli-groovy --help
usage: rest-cli-groovy -h <host> -u <user> -w <password> [options]
 -c,--context <context>               application context (e.g.: jira)
 -d,--drop-session <cli-session-id>   will terminate cli session
 -f,--file <file>                     will read file and evaluate its
                                      contents. use - for stdin
 -h,--host <host>                     server hostname
 -help                                prints this message
 -l,--list-sessions                   list cli session ids
 -n,--new-session                     will create new session and exit
                                      immediately
 -p,--port <port>                     server port. defaults to [80]
 -proto,--protocol <protocol>         http/https protocol; could be
                                      derived from port. defaults to
                                      [http]
 -s,--session <cli-session-id>        cli session id to connect to
 -u,--user <user>                     admin user name to connect with
 -w,--password <password>             password to authenticate with
{% endhighlight %}

</li>
<li>class loader problem fixed, now it's possible to use import and reference Jira classes from the scripts. See example below:

{% highlight groovy %}
import com.atlassian.jira.project.ProjectManager;
import com.atlassian.jira.ComponentManager;

ProjectManager manager = ComponentManager.getInstance().getProjectManager();
manager.projectObjects.collect { it.name }
{% endhighlight %}
</li>
<li>Work on automated configuration deployment (mini-framework started). If you are interested - please track&nbsp;<a href="https://github.com/leonardinius/jira-rest-cli/issues/1">https://github.com/leonardinius/jira-rest-cli/issues/1</a>&nbsp;and submit comments/u

Plans
---
<ul><li>Implement automated configuration deployment scripts, pre-alfa stage</li><li>Port (license, reasoning??) <a href="https://plugins.atlassian.com/plugin/details/6820">Script Runner</a>&nbsp;bundled scripts? Make them 
rest-callable.</li><li>Get JRuby client to the state of groovy client.</li><li>Documentation and tes
