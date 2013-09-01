---
title: C#/.Net project analysis showcase in 30 minutes (featuring Sonar)
date: 2012-07-02
permalink: 2012/07/c-net-code-quality-analysis-showcase-in-30-minutes-featuring-sonar.html

---

# Table of contents
- [Introducing Sonar](#introducing-sonar)
- [Why sonar indeed?](#why-sonar-indeed)
- [30 min showcase sprint](#30-min-showcase-sprint)
- [Congrats](#congrats)

# Introducing Sonar

> [Sonar](http://www.sonarsource.org/) is an open platform to manage code quality. As such, it covers the 7 axes of
> code quality
![Sonar 7 axes](http://www.sonarsource.org/wp-content/themes/sonar/images/7axes.png)

Sonar itself is implemented in Java (ough, sweet-sweet [Java beans](http://www.youtube.com/watch?v=TAX0gJt-aZg)). Here
the are some of the supported languages and platforms (on the moment of writing) and the list goes on:
C-Sharp Ecosystem, CXX (C++ languages), Delphi, Flex, Groovy, JavaScript, PHP, Python, Web (JSP, JSF), XML.

# Why Sonar indeed?

_Reason I - community, maturity, acceptance_

It's quite difficult to answer it in two words. Sonar is platform, rather than tool and I am quite confident it already
does everything you need. And if it doesn't - you easily could code it yourself in a couple of days/weeks
(rule of thumb - if it something the Sonar community needs as well, it's very likely
[@sonarsource](https://twitter.com/sonarsource) will include it in upcoming release).
As the whole Sonar team is very agile (frequent releases) and very friendly. It's not
surprise why it's becoming de-facto standard (e.g. [mentioned in Thoughworks Technology Radar](http://www.sonarsource.org/sonar-in-thoughtworks-technology-radar/)

_Reason II - previous experience_

I've already used Sonar on several Java projects and liked it very much. I liked it so much you could say I was
overexcited. So, objective judgement may not be so objective after all. My previous experience have taught me what I
could ask almost every question about project codebase and Sonar, my reliable servant, will give me correct answer back.
We used it to track project technical debt, code metrics, issues per component/subsystem, comment ratio etc..
Within Sonar it was quite easy for us to setup Sprint/Release quality improvement goal and keep it on track during our
daily code commits.

# 30 min showcase sprint

During 30min showcase:
- Sonar downloaded and installed
- C# ecosystem support added
- Test project is getting analyzed

Why 30 minutes? It's simple:
- in general case it's hard to persuade upper management to give your more time to such experiments (not my case though)
- it's better to time-box such exercise (thus you don't waste your time on anything else unrelated and you keep focused
on getting bare minimum done and fine-working)
- you better oversee benefit/investment ratio
- it's just amazingly shocking how fast you get difficult things up and running nowadays (kudos @sonarsource team)

Ok, enough cheap talk, let's start rolling.

## Sonar installation

Visit [http://www.sonarsource.org/downloads/](http://www.sonarsource.org/downloads/) downloads page and grab latest
version available there (it's 3.1.1 on the moment of writing).

- Check Sonar [prerequisites](http://docs.codehaus.org/display/SONAR/Requirements)

> The only prerequisite to run Sonar is to have Java (Oracle JDK 1.5 onwards) installed on your machine.

- Download ant unzip it to `C:\sonar-3.1.1`
- Execute `c:\sonar-3.1.1\bin\windows-x86-32\StartSonar.bat`
  The expected output should look like

```console
$ C:\sonar-3.1.1\bin\windows-x86-32\StartSonar.bat
wrapper  | --> Wrapper Started as Console
wrapper  | Launching a JVM...
jvm 1    | Wrapper (Version 3.2.3) http://wrapper.tanukisoftware.org
jvm 1    |   Copyright 1999-2006 Tanuki Software, Inc.  All Rights Reserved.
jvm 1    |
jvm 1    | 2012-07-03 01:21:24.305:INFO::Logging to STDERR via org.mortbay.log.StdErrLog
jvm 1    | 2012-07-03 01:21:24.408:INFO::jetty-6.1.25
jvm 1    | 2012-07-03 01:21:24.725:INFO::NO JSP Support for /, did not find org.apache.jasper.servlet.JspServlet
jvm 1    | JRuby limited openssl loaded. http://jruby.org/openssl
jvm 1    | gem install jruby-openssl for full support.
jvm 1    | 2012-07-03 01:21:54.571:INFO::Started SelectChannelConnector@0.0.0.0:9000
```
  NB - in my case it's Win7, 32. Please see sibling folders for other options, such as Win 64x. The bin folder contains
  much more useful scripts, such as `InstallNTService.bat` etc.. Please see Sonar documentation for more info.

Vuala, you are all set. You have minimal working instance under your belt. Of course, it's not production ready
(default configs are for sissies). In real world you **MUST** [configure Sonar instance database](http://docs.codehaus.org/display/SONAR/Installing+Sonar#InstallingSonar-ConfiguringDatabase) at least.

## Installing C#/.Net ecosystem

- Visit [http://docs.codehaus.org/display/SONAR/C-Sharp+Plugins+Ecosystem](http://docs.codehaus.org/display/SONAR/C-Sharp+Plugins+Ecosystem)
and download latest (1.3 at the moment of writing) CSharpPluginsEcosystem plugin zip.
- Unzip CSharpPluginsEcosystem-1.3.zip and copy the following jars to `/extensions/plugins` folder of Sonar

```
sonar-csharp-core-plugin-1.3.jar
sonar-csharp-ndeps-plugin-1.3.jar
sonar-csharp-squid-plugin-1.1.1.jar
sonar-csharp-gendarme-plugin-1.3.jar
sonar-csharp-stylecop-plugin-1.3.jar
```

You might want to copy all the jars, however some of the plugins require additionals tools to be installed, which
definitely won't fit in our 30 min time-box (See [install page](http://docs.codehaus.org/display/SONAR/1.+Install) for
more info).

- Relaunch `c:\sonar-3.1.1\bin\windows-x86-32\StartSonar.bat` to ensure everything starts as before.

## Analyze test project

- Visit and download latest [Simple Java Runner](http://docs.codehaus.org/display/SONAR/Installing+and+Configuring+Sonar+Runner#InstallingandConfiguringSonarRunner-Download)
(1.3 at the moment of writing)
- Create file `sonar-project.properties` with the following content:

```properties
# Project identification
sonar.projectKey=com.mycompany:myApp
sonar.projectVersion=1.0-SNAPSHOT
sonar.projectName=My C# Application
# Info required for Sonar
sources=<<Your source folder>>
sonar.language=cs
```
- Place `sonar-project.properties` to you project/solution root folder
- Change you working directory  to you project/solution root folder and execute `sonar-runner.bat`

```
$ Your_project_root>c:\sonar-runner-1.3\bin\sonar-runner.bat
c:\sonar-runner-1.3\bin\..
Runner configuration file: c:\sonar-runner-1.3\bin\..\conf\sonar-runner.properties
Project configuration file: Your_project_root\sonar-project.properties
Runner version: 1.3
Java version: 1.7.0_05, vendor: Oracle Corporation
OS name: "Windows 7", version: "6.1", arch: "x86"
Server: http://localhost:9000
Work directory: Your_project_root\.sonar
01:48:52.885 WARN  .c.p.DefaultDatabase - Derby database should be used for evaluation purpose only
01:48:52.888 INFO      o.s.c.p.Database - Create JDBC datasource
01:48:53.964 INFO  actDatabaseConnector - Initializing Hibernate
01:48:56.236 INFO  StudioProjectBuilder - No '.sln' file found or specified: trying to find one...
01:48:56.244 INFO  StudioProjectBuilder - The following 'sln' file has been found and will be used: Your_project_root\YourSolution.sln
01:48:57.926 INFO  .s.b.b.ProjectModule - -------------  Analyzing YourProject
01:48:58.821 INFO  .s.b.ProfileProvider - Selected quality profile : [name=Sonar C# Way,language=cs]
01:48:58.840 INFO  nPluginsConfigurator - Configure maven plugins...
01:48:59.085 INFO        org.sonar.INFO - Compare to previous analysis (2012-07-02)
01:48:59.168 INFO        org.sonar.INFO - Compare over 5 days (2012-06-28, analysis of 2012-07-02 14:58:48.105)
01:48:59.189 INFO        org.sonar.INFO - Compare over 30 days (2012-06-03, analysis of 2012-07-02 14:58:48.105)
01:48:59.325 INFO  .b.p.SensorsExecutor - Initializer ProjectFileSystemLogger...
01:48:59.332 INFO  jectFileSystemLogger - Source directories:
01:48:59.332 INFO  jectFileSystemLogger -   Your_project_root\YourProject
01:48:59.335 INFO  .b.p.SensorsExecutor - Initializer ProjectFileSystemLogger done: 10 ms
01:48:59.335 INFO  .b.p.SensorsExecutor - Initializer CSharpProjectInitializer...
01:48:59.345 INFO  .b.p.SensorsExecutor - Initializer CSharpProjectInitializer done: 10 ms
01:48:59.548 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.core.CSharpSourceImporter@13107af...
01:49:03.709 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.core.CSharpSourceImporter@13107af done: 4161 ms
01:49:03.710 INFO  p.PhasesTimeProfiler - Sensor com.sonar.plugins.csharp.squid.C@1376a02...
01:49:12.853 INFO  p.PhasesTimeProfiler - Sensor com.sonar.plugins.csharp.squid.C@1376a02 done: 9143 ms
01:49:12.854 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.gendarme.GendarmeSensor@da7188...
01:49:12.859 INFO  d.t.g.GendarmeRunner - Gendarme executable not found: 'C:\Program Files\gendarme-2.10-bin\gendarme.exe'. The embedded version (2.10) will be used instead.
01:49:12.865 INFO  .u.c.CommandExecutor - Executing command: Your_project_root\.sonar\gendarme-2.10-bin\gendarme.exe --config Your_project_root\YourProject\.sonar\sonar.Gendarme --xml Your_project_root\YourProject\.sonar\gendarme-report.xml --quiet --confidence normal+ --severity all Your_project_root\YourProject\bin\Debug\YourProject.exe
01:49:16.391 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.gendarme.GendarmeSensor@da7188 done: 3537 ms
01:49:16.392 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.ndeps.NDepsSensor@153afc0...
01:49:16.393 INFO  .s.d.t.n.NDepsRunner - NDeps executable not found: 'C:\DependencyParser.exe'. The embedded version (1.1) will be used instead.
01:49:16.396 INFO  .u.c.CommandExecutor - Executing command: Your_project_root\.sonar\NDeps-1.1\DependencyParser.exe -a Your_project_root\YourProject\bin\Debug\YourProject.exe -o Your_project_root\YourProject\.sonar\ndeps-report.xml
01:49:16.669 INFO  .u.c.CommandExecutor - Parsing YourProject.exe
01:49:16.827 INFO  .u.c.CommandExecutor - Skip mscorlib... maybe in the GAC?
01:49:16.847 INFO  .u.c.CommandExecutor - The existing file WebDriver doesn't match the fullName WebDriver, skip it
01:49:16.848 INFO  .u.c.CommandExecutor - Skip Microsoft.VisualStudio.QualityTools.UnitTestFramework... maybe in the GAC?
..
01:49:17.999 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.ndeps.NDepsSensor@153afc0 done: 1607 ms
01:49:17.999 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.stylecop.StyleCopSensor@110ad01...
01:49:18.038 INFO  d.t.s.StyleCopRunner - StyleCop install folder not found: 'C:\Program Files\Microsoft StyleCop 4.4.0.14'. The embedded version (4.4.0.14) will be used instead.
01:49:18.044 INFO  .u.c.CommandExecutor - Executing command: C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe /p:AppRoot=Your_project_root /target:StyleCopLaunch /noconsolelogger Your_project_root\YourProject\.sonar\stylecop-msbuild.xml
01:49:18.372 INFO  .u.c.CommandExecutor - Microsoft (R) Build Engine Version 4.0.30319.1
01:49:18.372 INFO  .u.c.CommandExecutor - [Microsoft .NET Framework, Version 4.0.30319.269]
01:49:18.373 INFO  .u.c.CommandExecutor - Copyright (C) Microsoft Corporation 2007. All rights reserved.
01:49:18.374 INFO  .u.c.CommandExecutor -
01:49:21.528 INFO  p.PhasesTimeProfiler - Sensor org.sonar.plugins.csharp.stylecop.StyleCopSensor@110ad01 done: 3529 ms
01:49:21.528 INFO  p.PhasesTimeProfiler - Sensor CpdSensor...
01:49:21.529 INFO   o.s.p.cpd.CpdSensor - SonarBridgeEngine is used
01:49:21.573 INFO  s.p.c.i.IndexFactory - Cross-project analysis disabled
01:49:23.738 INFO  p.PhasesTimeProfiler - Sensor CpdSensor done: 2210 ms
01:49:23.739 INFO  p.PhasesTimeProfiler - Sensor ProfileSensor...
01:49:24.234 INFO  p.PhasesTimeProfiler - Sensor ProfileSensor done: 495 ms
01:49:24.235 INFO  p.PhasesTimeProfiler - Sensor ProfileEventsSensor...
01:49:24.287 INFO  p.PhasesTimeProfiler - Sensor ProfileEventsSensor done: 52 ms
01:49:24.288 INFO  p.PhasesTimeProfiler - Sensor VersionEventsSensor...
01:49:24.334 INFO  p.PhasesTimeProfiler - Sensor VersionEventsSensor done: 46 ms
01:49:24.547 INFO  p.PhasesTimeProfiler - Execute decorators...
01:49:33.397 INFO  .s.b.b.ProjectModule - -------------  Analyzing My C# Application
01:49:33.777 INFO  .s.b.ProfileProvider - Selected quality profile : [name=Sonar C# Way,language=cs]
01:49:33.786 INFO  nPluginsConfigurator - Configure maven plugins...
01:49:33.802 INFO        org.sonar.INFO - Compare to previous analysis (2012-07-02)
01:49:33.817 INFO        org.sonar.INFO - Compare over 5 days (2012-06-28, analysis of 2012-07-02 14:58:47.901)
01:49:33.824 INFO        org.sonar.INFO - Compare over 30 days (2012-06-03, analysis of 2012-07-02 14:58:47.901)
01:49:33.836 INFO  .b.p.SensorsExecutor - Initializer ProjectFileSystemLogger...
01:49:33.837 INFO  .b.p.SensorsExecutor - Initializer ProjectFileSystemLogger done: 1 ms
01:49:33.838 INFO  .b.p.SensorsExecutor - Initializer CSharpProjectInitializer...
01:49:33.839 INFO  .b.p.SensorsExecutor - Initializer CSharpProjectInitializer done: 1 ms
01:49:33.841 INFO  p.PhasesTimeProfiler - Sensor CpdSensor...
01:49:33.843 INFO   o.s.p.cpd.CpdSensor - SonarBridgeEngine is used
01:49:33.850 INFO  p.PhasesTimeProfiler - Sensor CpdSensor done: 9 ms
01:49:33.851 INFO  p.PhasesTimeProfiler - Sensor ProfileSensor...
01:49:34.250 INFO  p.PhasesTimeProfiler - Sensor ProfileSensor done: 399 ms
01:49:34.251 INFO  p.PhasesTimeProfiler - Sensor ProfileEventsSensor...
01:49:34.256 INFO  p.PhasesTimeProfiler - Sensor ProfileEventsSensor done: 5 ms
01:49:34.256 INFO  p.PhasesTimeProfiler - Sensor VersionEventsSensor...
01:49:34.262 INFO  p.PhasesTimeProfiler - Sensor VersionEventsSensor done: 6 ms
01:49:34.391 INFO  p.PhasesTimeProfiler - Execute decorators...
01:49:34.758 INFO  .b.p.UpdateStatusJob - ANALYSIS SUCCESSFUL, you can browse http://localhost:9000
01:49:34.759 INFO  b.p.PostJobsExecutor - Executing post-job class org.sonar.plugins.core.batch.IndexProjectPostJob
01:49:34.861 INFO  b.p.PostJobsExecutor - Executing post-job class org.sonar.plugins.dbcleaner.ProjectPurgePostJob
01:49:34.886 INFO  .p.d.p.KeepOneFilter - -> Keep one snapshot per day between 2012-06-05 and 2012-07-02
01:49:34.888 INFO  .p.d.p.KeepOneFilter - -> Keep one snapshot per week between 2011-07-05 and 2012-06-05
01:49:34.888 INFO  .p.d.p.KeepOneFilter - -> Keep one snapshot per month between 2007-07-10 and 2011-07-05
01:49:34.889 INFO  .d.p.DeleteAllFilter - -> Delete data prior to: 2007-07-10
01:49:34.903 INFO  o.s.c.purge.PurgeDao - -> Clean My C# Application [id=1]
01:49:34.924 INFO  o.s.c.purge.PurgeDao - <- Clean snapshot 1
01:49:35.961 INFO  o.s.c.purge.PurgeDao - -> Clean YourProject [id=2]
Total time: 46.733s
Final Memory: 6M/44M
Your_project_root>
```

NB: It warns us about built-in database usage again. It's something should re-configured indeed in production use.

> 01:48:52.885 WARN  .c.p.DefaultDatabase - Derby database should be used for evaluation purpose only

- Check Sonar web-interface [http://localhost:9000/](http://localhost:9000/)

![Sonar web-interface](/resources/images/Sonar-30-min-showcase-capture.png)

# Congrats

Congratulations, you have lived through our 30 min sprint and should already have TestProject analysed.

Any comments and feedback is highly appreciated as always.

