---
layout: post
title: Atlassian Plugin SDK / maven proxy issues
date: 2010-11-10
comments: false
page: 2010/11/atlassian-plugin-sdk-maven-proxy-issues.html

---

Recent problem: maven repositories on https behind proxy.<br /><pre><code class="xml"><br />&lt;?xml version=&quot;1.0&quot;?&gt;<br />&lt;proxy&gt;<br />    &lt;id&gt;http.XXX.global&lt;/id&gt;<br />    &lt;active&gt;true&lt;/active&gt;<br />    &lt;protocol&gt;http&lt;/protocol&gt;<br />    &lt;host&gt;XXXt&lt;/host&gt;<br />    &lt;port&gt;8080&lt;/port&gt;<br />    &lt;nonproxyhosts&gt;localhost|127.0.*.*|191.168.*.*&lt;/nonproxyhosts&gt;<br />&lt;/proxy&gt;   <br /> &lt;proxy&gt;<br />&lt;id&gt;https.XXX.global&lt;/id&gt;<br />&lt;active&gt;true&lt;/active&gt;<br />&lt;protocol&gt;https&lt;/protocol&gt;<br />&lt;host&gt;XXXt&lt;/host&gt;<br />&lt;port&gt;8080&lt;/port&gt;<br />&lt;nonproxyhosts&gt;localhost|127.0.*.*|191.168.*.*&lt;/nonproxyhosts&gt;<br />&lt;/proxy&gt;<br /></code></pre><br />and it failed until I switched http proxy of (set active to false)
