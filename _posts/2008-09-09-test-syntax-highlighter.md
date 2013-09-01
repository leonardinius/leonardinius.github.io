---
layout: post
title: test syntax highlighter
date: 2008-09-09
comments: false
permalink: 2008/09/version-encoding-version-com.html

---

<pre name="code" class="xml">&lt;?xml version="1.0" encoding="ISO-8859-1" ?&gt;<br />&lt;web-app version="2.4"&gt;<br />   &lt;servlet&gt;<br />&lt;servlet-name&gt;shell&lt;/servlet-name&gt;<br />&lt;servlet-class&gt;<br />       com.google.gwt.dev.shell.GWTShellServlet<br />    &lt;/servlet-class&gt;<br /><br />   &lt;/servlet&gt;<br />   &lt;servlet-mapping&gt;<br />&lt;servlet-name&gt;shell&lt;/servlet-name&gt;<br />&lt;url-pattern&gt;/*&lt;/url-pattern&gt;<br />   &lt;/servlet-mapping&gt;<br />&lt;/web-app&gt;<br /></pre><br /><br /><pre name="code" class="java"><br /><br />@Servlet(urlMappings={"/foo", "/bar"})<br />public class SampleUsingAnnotationAttributes {<br />     @GET<br />     public void handleGet(HttpServletRequest req, HttpServletResponse res) {<br />          //Handle the GET<br />     }<br />}<br /><br /><br />private void addAliasesToStack(Token token) throws IOException {<br />   // comment <br />   String[] synonyms = engine.getSynonyms(token.termText());<br /><br />   if (synonyms == null) return;<br /><br />   for (int i = 0; i < synonyms.length; i++) {<br />     Token synToken = new Token(synonyms[i],<br />                                token.startOffset(),<br />                                token.endOffset(),<br />                                TOKEN_TYPE_SYNONYM);<br />     synToken.setPositionIncrement(0);<br /><br />     synonymStack.push(synToken);<br />   }<br /> }<br /></pre>
