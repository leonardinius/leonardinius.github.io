---
layout: post
title: JIRA workflows -Postfunction exceptions, database commits and Pretty workflow exception
date: 2010-12-25
comments: false
permalink: 2010/12/jira-workflows-postfunction-exceptions.html
tags: [atlassian, jira]
---

<a href="http://images.zaazu.com/img/Hohoho--merry-christmas-xmas-christmas-smiley-emoticon-000364-large.gif" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" src="http://images.zaazu.com/img/Hohoho--merry-christmas-xmas-christmas-smiley-emoticon-000364-large.gif" /></a>
Hi again,
For all of you who happens to be catholic - Happy Xmas
<a href="http://en.wikipedia.org/wiki/Xmas_Story">futurama style</a>.

So, back to coding again.







I assume most of you are familiar with JIRA <a href="http://confluence.atlassian.com/display/JIRA/Workflow+Plugin+Modules">post functions</a>. So, would like to share my 0.02$ on the subject though. Boring stuff.
<div class="separator" style="clear: both; text-align: center;"><span class="Apple-style-span" style="font-size: x-large;">OS Workflow</span><a href="http://today.java.net/images/tiles/111-oswflow.gif" imageanchor="1" style="margin-left: 1em; margin-right: 1em;"><img border="0" src="http://today.java.net/images/tiles/111-oswflow.gif" /></a></div>
The less known things about post functions are:

<ul><li>Workflow, steps and history are stored in different database tables than issue data. So Jira uses database commits to enforce data consistency.</li><li>Post functions might throw <span class="Apple-style-span" style="font-family: monospace; white-space: pre;">WorkflowException </span>exception and workflow manager will rollback transaction in this case. Actually if the other exception will be thrown the transaction won't be commit (see Ofbiz Workflow et cetera), but imo it's implementation specific nuances and I wouldn't recommend that</li><li>In case you use MySQl - please ensure you have configured it properly - to use <a href="http://confluence.atlassian.com/display/JIRA/Connecting+JIRA+to+MySQL#ConnectingJIRAtoMySQL-2.ConfigureMySQL">transactional database engine</a>. If you haven't - let's say you do <i>Resolve</i> transition from status <u><i>Opened</i></u> -> to <i style="text-decoration: underline;">Closed</i> and exception occurs.  The workflow engine will think (no transaction rollback) the issue is closed, while the rest of the JIRA (issue view etc, issue.getStatus()) will think the issue is still <u><i>Opened</i></u>. Happened with me :). </li></ul><div><b><span class="Apple-style-span" style="font-size: large;">The pain</span></b></div>I've found myself to put some conditioning into my custom wf functions, like if smth has ben selected in the transition screen view - the function should fail. The same could be achieved my using wf validators and  <b>for sure!</b> would be more correct solution - it's the type of component that should do the validation thing. However - think about it - I have 1 thing to do during transition - it's one post function. And I have 3-8 validations for it, like is it configured properly, are all fields entered from the UI etc. It would be more flexible to do it using wf postfunction and  3-5 validations, but it's so much more work (at least configuration and maintenance). So I decided to stick with 1 postfunction approach.
<div>
</div><div>The way to implement this would be to throw exceptionn during the wf transition. In the regular case I would throw smth like IllegalArgumentException, but for reasons mentioned earlier I decided to convert it to general WorkflowException. The thing with it is - in case it does contain exception cause (and I like to preserve stacktrace as long I can) - it messes the exception getMessage() result and user on-screen output is smth like <i><b>"rootCause: Please specify ..."</b></i>, which is ... wrong. </div><div>
</div><div>So, the approach i decided to go with is:
<pre><code class="java">

//... postfunction class declaration
{

public void execute(java.util.Map transientVars, java.util.Map args, com.opensymphony.module.propertyset.PropertySet ps) throws com.opensymphony.workflow.WorkflowException {
try
{
 //..
 doStuff();
}
catch(XYZIssueException e){ throw new WorkflowException(e); }
//...
catch(IllegalArgumentException e) { throw new PrettyMessageWorkflowException(e); }
}

// ... rest the postfunction
}

// And the pretty lady herself
class PrettyMessageWorkflowException extends WorkflowException
{
// ------------------------------ FIELDS ------------------------------

 private final String prettyMessage;

// --------------------------- CONSTRUCTORS ---------------------------

 public PrettyMessageWorkflowException()
 {
     super();
     this.prettyMessage = null;
 }

 public PrettyMessageWorkflowException(String message)
 {
     super(message);
     this.prettyMessage = message;
 }

 public PrettyMessageWorkflowException(Throwable rootCause)
 {
     super(rootCause);
     this.prettyMessage = null;
 }

 public PrettyMessageWorkflowException(String message, Throwable rootCause)
 {
     super(message, rootCause);
     this.prettyMessage = message;
 }

// -------------------------- OTHER METHODS --------------------------

 @Override
 public String getMessage()
 {
     if (this.prettyMessage == null || this.prettyMessage.isEmpty())
     {
         return super.getMessage();
     }

     return this.prettyMessage;
 }
}
</code></pre>

It saves a day as usually :) </div><div><code class="html"><span class="Apple-style-span" style="color: #222222; font-family: Arial, Tahoma, Helvetica, FreeSans, sans-serif; font-size: x-small;"><span class="Apple-style-span" style="line-height: 18px;"> </span></span></code></div>
