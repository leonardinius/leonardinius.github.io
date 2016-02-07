---
layout: post
title: Maven2 project auto-release [@GitHub] example
date: 2011-02-25
comments: false
permalink: 2011/02/maven2-project-license-check-and-auto.html

---

What's about?
---
So, I finally got my head around&nbsp;<a href="http://maven.apache.org/plugins/maven-release-plugin/index.html">maven-release-plugin</a>&nbsp;maven plugin.&nbsp;And, yes, it's awesome.
I have not tried any kind of different/difficult scenarios yet, just plain basic ones.

So, what I wanted to achieve in the first place?
---
- G1 - maven artifact auto-versioning on build success
  
1.1-SNAPSHOT on master branch/TRUNK&nbsp;gets promoted to 1.1 maven release, at the same time master/TRUNK becomes 1.2-SNAPSHOT
- G2 - some kind of tagging/branching on build success
  
G1 support on CVS level via tags/branches
- G3 - maven artifact deployment (from CVS repository to maven repository)
- G4 - ability to launch it from CI tool

Visually that could be depicted in the following way:
<table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-fbfXjYrNXKI/TWbxumA8D-I/AAAAAAAAEJo/EIHRJxBmTPM/s1600/branching.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" src="http://4.bp.blogspot.com/-fbfXjYrNXKI/TWbxumA8D-I/AAAAAAAAEJo/EIHRJxBmTPM/s1600/branching.png" /></a></td></tr><tr><td class="tr-caption" style="text-align: center;">Branching [<a href="http://wiki.obiba.org/display/ONYX/Onyx+Branches,+Tags+and+Releases">source</a>]</td></tr></tbody></table>
All the goals accomplished. Yada-ya-da!

Ok, enough reading. Gimme the code
See&nbsp;<a href="https://github.com/leonardinius/test-maven-release">test-maven-release</a>&nbsp;Github project

How-to?
---
* <b>G1, G2</b> - are accomplished by <a href="http://maven.apache.org/plugins/maven-release-plugin/prepare-mojo.html">release:prepare</a>&nbsp;goal.
<b> Input needed:</b> scm info

<b>Input example:</b>
<pre><code class="xml">&lt;scm&gt;
  &lt;connection&gt;
     scm:git:git://github.com/leonardinius/test-maven-release.git
  &lt;/connection&gt;
  &lt;developerConnection&gt;
     scm:git:ssh://git@github.com/leonardinius/test-maven-release.git
  &lt;/developerConnection&gt;
  &lt;url&gt;
     https://github.com/leonardinius/test-maven-release
  &lt;/url&gt;
&lt;/scm&gt;
</code></pre>Execution sample:
<pre><code class="no-highlight">
prusax:test-maven-release leonidmaslov$ mvn release:clean release:prepare
[INFO] Scanning for projects...
[INFO] Searching repository for plugin with prefix: 'release'.
[INFO] ------------------------------------------------------------------------
[INFO] Building test-maven-release
[INFO]    task-segment: [release:clean, release:prepare] (aggregator-style)
[INFO] ------------------------------------------------------------------------
[INFO] [release:clean]
[INFO] Cleaning up after release...
[INFO] [release:prepare]
[INFO] Verifying that there are no local modifications...
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git status
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Checking dependencies and plugins for snapshots ...
What is the release version for "test-maven-release"? (leonardinius-test:test-maven-release) 1.0: : 
What is SCM release tag or label for "test-maven-release"? (leonardinius-test:test-maven-release) test-maven-release-1.0: : myTag
What is the new development version for "test-maven-release"? (leonardinius-test:test-maven-release) 1.1-SNAPSHOT: : 
[INFO] Transforming 'test-maven-release'...
[INFO] Not generating release POMs
[INFO] Executing goals 'clean verify'...
[WARNING] Maven will be executed in interactive mode, but no input stream has been configured for this MavenInvoker instance.
[INFO] [INFO] Scanning for projects...
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Building test-maven-release
[INFO] [INFO]    task-segment: [clean, verify]
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] [clean:clean]
[INFO] [INFO] [resources:resources]
[INFO] [WARNING] Using platform encoding (MacRoman actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] [INFO] skip non existing resourceDirectory /Users/leonidmaslov/Documents/workspace/test-maven-release/src/main/resources
[INFO] [INFO] [compiler:compile]
[INFO] [INFO] Compiling 1 source file to /Users/leonidmaslov/Documents/workspace/test-maven-release/target/classes
[INFO] [INFO] [resources:testResources]
[INFO] [WARNING] Using platform encoding (MacRoman actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] [INFO] Copying 1 resource
[INFO] [INFO] [compiler:testCompile]
[INFO] [INFO] Compiling 1 source file to /Users/leonidmaslov/Documents/workspace/test-maven-release/target/test-classes
[INFO] [INFO] [surefire:test]
[INFO] [INFO] Surefire report directory: /Users/leonidmaslov/Documents/workspace/test-maven-release/target/surefire-reports
[INFO] 
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running me.doautomate.ExampleServletTest
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.024 sec
[INFO] 
[INFO] Results :
[INFO] 
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] 
[INFO] [INFO] [jar:jar]
[INFO] [INFO] Building jar: /Users/leonidmaslov/Documents/workspace/test-maven-release/target/test-maven-release-1.0.jar
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] BUILD SUCCESSFUL
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] [INFO] Total time: 3 seconds
[INFO] [INFO] Finished at: Thu Feb 24 22:02:49 CET 2011
[INFO] [INFO] Final Memory: 22M/81M
[INFO] [INFO] ------------------------------------------------------------------------
[INFO] Checking in modified POMs...
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git add pom.xml
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git status
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git commit --verbose -F /var/folders/IA/IA2V6NfrE84m+Fcb-LJguU+++TI/-Tmp-/maven-scm-811668125.commit pom.xml
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git push
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Tagging release with the label myTag...
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git tag -F /var/folders/IA/IA2V6NfrE84m+Fcb-LJguU+++TI/-Tmp-/maven-scm-1676785108.commit myTag
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git push origin myTag
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git ls-files
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Transforming 'test-maven-release'...
[INFO] Not removing release POMs
[INFO] Checking in modified POMs...
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git add pom.xml
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git status
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git commit --verbose -F /var/folders/IA/IA2V6NfrE84m+Fcb-LJguU+++TI/-Tmp-/maven-scm-1157159798.commit pom.xml
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Executing: /bin/sh -c cd /Users/leonidmaslov/Documents/workspace/test-maven-release &amp;&amp; git push
[INFO] Working directory: /Users/leonidmaslov/Documents/workspace/test-maven-release
[INFO] Release preparation complete.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESSFUL
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1 minute 
[INFO] Finished at: Thu Feb 24 22:02:59 CET 2011
[INFO] Final Memory: 14M/81M
[INFO] ------------------------------------------------------------------------
prusax:test-maven-release leonidmaslov$ 
</code></pre>
</li><li><b>G3</b> - is accomplished by <a href="http://maven.apache.org/plugins/maven-release-plugin/perform-mojo.html">release:perform</a>&nbsp;plugin. The plugin checkouts the tag/branch from the CVS system, builds it and deploys to maven repository.
<b>NB: </b>relies on <i style="text-decoration: underline;">release:prepare</i>&nbsp;being called first (needs release.properties file).
<b> Input needed:</b> scm info, distribution management
<b>Input example:</b>
<pre><code class="xml">&lt;scm&gt;
    &lt;connection&gt;
      scm:git:git://github.com/leonardinius/test-maven-release.git
    &lt;/connection&gt;
    &lt;developerConnection&gt;
      scm:git:ssh://git@github.com/leonardinius/test-maven-release.git
    &lt;/developerConnection&gt;
    &lt;url&gt;https://github.com/leonardinius/test-maven-release&lt;/url&gt;
&lt;/scm&gt;

&lt;distributionManagement&gt;
    &lt;site&gt;
        &lt;id&gt;site-id&lt;/id&gt;
        &lt;name&gt;site-name&lt;/name&gt;
        &lt;url&gt;scp://host/path/to/repository/&lt;/url&gt;
    &lt;/site&gt;
    &lt;repository&gt;
        &lt;id&gt;repo-main&lt;/id&gt;
        &lt;name&gt;Repository Name&lt;/name&gt;
        &lt;url&gt;file://tmp/&lt;/url&gt;
    &lt;/repository&gt;
    &lt;!-- use the following if you ARE using a snapshot version. --&gt;
    &lt;snapshotRepository&gt;
        &lt;id&gt;repo-snapshot&lt;/id&gt;
        &lt;name&gt;Repository Name&lt;/name&gt;
        &lt;url&gt;file://tmp/&lt;/url&gt;
    &lt;/snapshotRepository&gt;
&lt;/distributionManagement&gt;
</code></pre>
</li><li><b>G4</b>&nbsp;is accomplished by launching maven in the batch mode.
<b>Example:</b>
<pre><code>mvn clean --batch-mode  release:prepare release:perform</code></pre>

Conclusion
---
Adding automated maven project versioning is not so hard and could be easily automated.
