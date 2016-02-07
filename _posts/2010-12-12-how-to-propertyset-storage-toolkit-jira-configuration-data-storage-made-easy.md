---
layout: post
title: "HOW-TO: propertyset-storage-toolkit - Jira configuration data storage made easy"
date: 2010-12-12
comments: false
permalink: 2010/12/how-to-propertyset-storage-toolkit-jira.html
tags: [atlassian, jira, pdk]
---

<b>Q:</b> What is your favorite type of job? Atlassian Plugin SDK? <b>A:</b> Sure!
<b>Q:</b> How exactly you like to code? <b>A:</b> As little as possibe!

Here it comes -&nbsp;<a href="https://github.com/leonardinius/propertyset-storage-toolkit">propertyset-storage-toolkit</a>&nbsp;with as bare minimal API set as it could be.

Let's see what the standard project for me as Jira plugin developer is? The answer probably would be - to make this thing A, that thing B and yeah, almost forgot - to make this configurable, there definitely should be a switch et cetera and this should be administration UI dialog.

And yeah, there are a lots of data persistence options available, but they all too complic-API-cated. So after&nbsp;scratching&nbsp;my head several times I remembered one piece of code I've written before while being employed &nbsp; by some company and decided to re-implement the idea from the scratch on my own and to use in my current project&nbsp;assignment.

So, to illustrate how EASY is to do plugin configuration from now on, see the code snippet below
<pre><code class="java">
private final StorageService storageService; // IoC by framework via Constructor Dependency Injection
 ...

 // data fields
 private boolean adminOnly;
 private String helloText;
 private String welcomeText;

 private StorageFacade getStorage()
 {
     return storageService.actionStorage(this);
 }


 private void loadConfig(StorageFacade storage)
 {
     setAdminOnly(storage.getBoolean(ADMIN_ONLY));
     setHelloText(StringUtils.defaultString(storage.getString(HELLO_TEXT), 
         "Hello, "));
     setWelcomeText(StringUtils
         .defaultString(storage.getString(WELCOME_TEXT), "World"));
 }

 private void saveConfig(StorageFacade storage)
 {
     storage.setBoolean(ADMIN_ONLY, isAdminOnly());
     storage.setString(HELLO_TEXT, getHelloText());
     storage.setString(WELCOME_TEXT, getWelcomeText());
 }
</code></pre>
And voila, it's as easy as this, no strings attached. 

Please take a look into&nbsp;<a href="https://github.com/leonardinius/propertyset-storage-toolkit/blob/master/README.md">README</a> file for more details.

And, please, do not shy to contact me in case of any problems, issues, thoughts or comments. Your feedback is always appreciated. 

See ya ;)
