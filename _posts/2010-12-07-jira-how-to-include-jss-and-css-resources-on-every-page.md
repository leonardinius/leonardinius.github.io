---
layout: post
title: Jira - How to Include JSS and CSS resources on every page
date: 2010-12-07
comments: false
permalink: 2010/12/jira-how-to-include-jss-and-css.html
tags: [atlassian, jira, pdk]
---

Hi all,

<blockquote>Disclaimer 1: The post and approach is 99% based on <a href="https://studio.plugins.atlassian.com/wiki/display/JBHV/JIRA+Behaviours+Plugin">Jira&nbsp;Behaviors&nbsp;Plugin</a>&nbsp;source code.</blockquote><blockquote>Disclaimer 2: The approach described here should be considered a hack/workaround and does not inline with Atlassian Jira Plugin structture and maintainability.&nbsp;</blockquote><blockquote><b>Update: </b>See the comments section. I would recommend better approach using Servlet Filter.&nbsp;</blockquote>You may find yourself requiring to either show/hide some part of Jira UI elements, or extend JIRA built-in edit/search capabilities. If it's custom field we are talking about - you might consider to implement Jira Custom Field (See <a href="http://confluence.atlassian.com/display/JIRA/How+to+create+a+new+Custom+Field+Type#HowtocreateanewCustomFieldType-AQuickCustomFieldTypesPrimer">Quick Custom Field Types Primer</a>&nbsp;on render options and capabilities).

For some other cases - like <a href="http://blogs.onresolve.com/?author=3">Jamie Eclin</a>&nbsp;awesome Behaviors Plugin, or like in my example - hiding some always visible JIRA UI built-in &nbsp;elements - you might consider different approach to implement. Your options basically are:

<ol><li>Hack and modify velocity/JSP file whatever does render the element in context. It even might be system level plugin - like system Issue operations. In some cases it might require JIRA instance restart and even re-compilation&nbsp;and re-deployment. And thus we will increase&nbsp;maintainability&nbsp;technical debt a lot.</li><li>We could manually configure&nbsp;<a href="http://confluence.atlassian.com/display/JIRA/Configuring+an+Announcement+Banner">Jira Announcement Banner</a>&nbsp;to include required resources on every page. Thus it will be one-time configuration option and it will be our responsibility to do so and maintain that piece of JSS/CSS snippet. In case our product consists of several plugins - we will endup with long list of configuration items + 1 more unrelated item - which is kind of implementation details only item. So, not so good afterwards (good enough for internal stuff, not so good for giving away).</li></ol><div>So, after reconsidering those options - I've chosen the second one + basically the Jamie Eclin approach on Behaviors Plugin. The main reasons to do so were:</div><div><ol><li>Not really a complete hack - could be implemented as valid Atlassian Plugin v2 plugin</li><li>Could be automated - no additional configuration needed</li><li>Source code for Behaviors Plugin is provided :)</li><li>See pt 3.</li></ol><div>
<span class="Apple-style-span" style="font-size: large;">Implementation</span>
<span class="Apple-style-span" style="font-size: large;">
</span>
<b>1. Component</b>
Simple interface with the only method - void setup(); Serves only as an entry point for resource injection during Jira startup procedure.

<b>2. ComponentImpl</b>
The actual component implementation. The purpose is to check whether Jira announcement banner already contains required JSS/CSS and it doesn't the inject them to the banner contents.
<pre><code class="java">
public class ComponentImpl implements Component, Startable {
    private static final String HIDE_CREATE_ISSUE_MARKER = "XYZ Plugin Marker - Do not modify!";
    private static final String CREATE_ISSUE_MARKER_START = "&lt;!-- --Start--[" + HIDE_CREATE_ISSUE_MARKER + "]--Start--";
    private static final String CREATE_ISSUE_MARKER_END = "&lt;!-- --End--[" + HIDE_CREATE_ISSUE_MARKER + "]--End-- --&gt;";

    private final ApplicationProperties applicationProperties;

    public ComponentImpl(ApplicationProperties applicationProperties) {
        this.applicationProperties = applicationProperties;
    }

    @Override
    public void setup() throws RuntimeException {
        String alertHeader = applicationProperties.getDefaultBackedText(APKeys.JIRA_ALERT_HEADER);
        String injectedAlertHeader = installHideCreateIssue(alertHeader);
        if (!StringUtils.equals(alertHeader, injectedAlertHeader)) {
            applicationProperties.setText(APKeys.JIRA_ALERT_HEADER, injectedAlertHeader);
            //applicationProperties.setString(APKeys.JIRA_ALERT_HEADER_VISIBILITY, EditAnnouncementBanner.PUBLIC_BANNER);
        }
    }

    @Override
    public void start() throws Exception {
        setup();
    }

    
    private boolean isIncludesCreateIssueMarker(String input) {
        return StringUtils.contains(input, CREATE_ISSUE_MARKER_START)
                &amp;&amp; StringUtils.contains(input, CREATE_ISSUE_MARKER_END);
    }

    String getInjection(String comment, String cssDefinitions, String javascript) {
        StringBuilder injection = new StringBuilder(CREATE_ISSUE_MARKER_START).append(comment).append(" --&gt;");

        if (StringUtils.isNotBlank(cssDefinitions)) {
            injection = injection.append("\n&lt;style type=\"text/css\"&gt;\n")
                    .append(prepareCleanInject(cssDefinitions))
                    .append("\n&lt;/style&gt;");
        }

        if (StringUtils.isNotBlank(javascript)) {
            injection = injection.append("\n&lt;script type=\"text/javascript\"&gt;\n")
                    .append(prepareCleanInject(javascript))
                    .append("\n&lt;/script&gt;");
        }

        injection = injection.append(CREATE_ISSUE_MARKER_END);

        return injection.toString();
    }

    public String installHideCreateIssue(String alertHeader) throws RuntimeException {
        if (!isIncludesCreateIssueMarker(alertHeader)) {
            alertHeader = new StringBuilder()
                    // PROOF OF concept Items - it really should be done with Permission Schemes, not this hacky way
                    .append(getInjection("", "div#create-issue, div#createItem, ul#opsbar-edit li a#editIssue { display : none; }", ""))

                    .append("\n")
                    .append(StringUtils.defaultString(alertHeader)).toString();
        }

        return alertHeader;
    }
}
</code></pre>
<b>3. atlassian-plugin.xml snippet</b>
<b>Component and ComponentImpl registration snippet</b>
<pre><code class="xml">
&lt;component key="myJSSCSSInjectionSnippet" name="My CSS/JSS injection snippet"
    class="com.xyz.ComponentImpl"&gt;
    &lt;interface&gt;com.xyz.Component&lt;/interface&gt;
&lt;/component&gt;
</code></pre>
and Voile, we are done :)</div></div>
