---
layout: post
title: atlas-cli IntelliJ support
date: 2010-12-13
comments: false
permalink: 2010/12/atlas-cli-with-intellij-support.html
tags: [atlassian]
---

I assume most of you, Atlassian Plugin SDK consumers are well familiar with <a href="http://confluence.atlassian.com/display/DEVNET/atlas-cli">atlas-cli</a> command.

After reading Down's Browns great article titled <a href="http://www.jroller.com/mrdon/entry/maven_without_all_the_slowness">Maven without all the slowness - now with IDEA support</a> decided to give it a try. I wish it would be so straightforward :) See the <a href="https://github.com/mrdon/maven-cli-plugin/issues/#issue/13">bugreport</a>. It seems the <i>cli:idea</i> artifact is broken.

So, of course, you could get the <a href="https://github.com/mrdon/maven-cli-plugin/tree/master/idea">sources</a> and compile it by your own. However I have found what JBoss repository have compiled Intellij Artifact itself, get it <a href="https://repository.jboss.org/nexus/index.html#nexus-search;gav~org.twdata.maven~maven-cli-idea-plugin~~~~kw,versionexpand">here</a>. Copy the jar file in the plugin directory (in my case it's <span class="Apple-style-span" style="font-family: helvetica, arial, freesans, clean, sans-serif; font-size: 13px; line-height: 20px;">/Users/leonidmaslov/Library/Application Support/IntelliJIdea10CE/</span>) and viola, you are done.

Let'see it in action, configuration first:

<div class="separator" style="clear: both; text-align: center;"><a href="http://3.bp.blogspot.com/_Y9XTlNGJRTQ/TQVbM5NBgiI/AAAAAAAAEGM/oVngN5u7Uug/s1600/2010-12-13_0030.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="265" src="http://3.bp.blogspot.com/_Y9XTlNGJRTQ/TQVbM5NBgiI/AAAAAAAAEGM/oVngN5u7Uug/s400/2010-12-13_0030.png" width="400" /></a></div><div class="separator" style="clear: both; text-align: left;">
</div><div class="separator" style="clear: both; text-align: left;">And now 3 more build commands/shortcuts are available </div><div class="separator" style="clear: both; text-align: left;">
</div><div class="separator" style="clear: both; text-align: center;"><a href="http://1.bp.blogspot.com/_Y9XTlNGJRTQ/TQVbbTjEd7I/AAAAAAAAEGQ/hWmRMO7XDHM/s1600/2010-12-13_0028.png" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" height="201" src="http://1.bp.blogspot.com/_Y9XTlNGJRTQ/TQVbbTjEd7I/AAAAAAAAEGQ/hWmRMO7XDHM/s320/2010-12-13_0028.png" width="320" /></a></div><div class="separator" style="clear: both; text-align: left;">
</div><div class="separator" style="clear: both; text-align: left;">Enjoy :)</div><div class="separator" style="clear: both; text-align: left;">
</div><div class="separator" style="clear: both; text-align: left;">
</div>
