---
layout: post
title: EL hidden dangers
date: 2008-05-31
comments: false
permalink: 2008/05/el-hidden-dangers.html
tags: [jsp]
---

I was playing around with the expression language engine shipped as part of the Seam for some time. So: I created some utility component (let's call it <i>StringUtils(@Name="<span class="blsp-spelling-error" id="SPELLING_ERROR_0">stringUtils</span><wbr>")) </i>and <i>some </i><span class="blsp-spelling-error" id="SPELLING_ERROR_1">TestNg</span> unit tests for it (reusing <span class="blsp-spelling-corrected" id="SPELLING_ERROR_2">ComponentTest</span>#<span class="blsp-spelling-error" id="SPELLING_ERROR_3">testComponents</span>).

It was tricky to realize the way I misunderstood the EL behaviour. I thought (rarely thoughts come out from my head) that passing value from *.<span class="blsp-spelling-error" id="SPELLING_ERROR_4">jsf</span> view into El expression - will result <i><span class="blsp-spelling-error" id="SPELLING_ERROR_5"></span></i>in invocation with this value as parameter.

Aha, sure :) Sure not. It depends what the type of the parameter is and what's the value (thanks God, unit tests opened my eyes and <b>made</b> me to read through <a target="_blank" href="http://java.sun.com/developer/EJTechTips/2004/tt0126.html">SPECS</a>).

<blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> <b>Defining Default Values</b>
Like many scripting languages, EL is forgiving of null values. When it can, EL simply substitutes an empty string, or zero, for null. The problem with this behavior is that sometimes you want to have special behavior if the value is null.
</blockquote>

So. So, EL can do whatever it wants with Your parameters.

Let it show (from <i><span class="blsp-spelling-error" id="SPELLING_ERROR_7">stringUtils</span></i>):

<blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">     public String <span class="blsp-spelling-error" id="SPELLING_ERROR_8">capitalizeFirstCS</span>(<span class="blsp-spelling-error" id="SPELLING_ERROR_9">CharSequence</span> s) {<br />  if (s == null)<br />      return null;<br />  if (s.length() &amp;<span class="blsp-spelling-error" id="SPELLING_ERROR_10">lt</span>;= 1) {<br />      return s.toString().toUpperCase();<br />  }<br />  //<br />   return s.<span class="blsp-spelling-error" id="SPELLING_ERROR_11">subSequence</span>(0, 1).toString().toUpperCase()<wbr>.<span class="blsp-spelling-error" id="SPELLING_ERROR_12">concat</span>(<br />          s.<span class="blsp-spelling-error" id="SPELLING_ERROR_13">subSequence</span>(1, s.length()).toString());<br />}<br /></blockquote><br />And

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">     public String <span class="blsp-spelling-error" id="SPELLING_ERROR_14">capitalizeFirstStr</span>(String s) {<br /> <i>... basically the same code ..</i><br /></blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">}</blockquote><div>

<br />
And usage samples:

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">  <br /><i>#{<span class="blsp-spelling-error" id="SPELLING_ERROR_15">stringUtils</span>.<span class="blsp-spelling-error" id="SPELLING_ERROR_16">capitalizeFirstCS</span><wbr>(null)} </i><span style="font-style: italic;">passes </span><span style="font-weight: bold;">NULL</span><i><br />#{<span class="blsp-spelling-error" id="SPELLING_ERROR_17">stringUtils</span>.<span class="blsp-spelling-error" id="SPELLING_ERROR_18">capitalizeFirstCS</span><wbr>('')}, </i><span style="font-style: italic;">passes ""</span><span style="font-weight: bold;"></span><br /><i>#{<span class="blsp-spelling-error" id="SPELLING_ERROR_19">stringUtils</span>.<span class="blsp-spelling-error" id="SPELLING_ERROR_20">capitalizeFirstCS</span><wbr>('string')}</i> passes "string"<br /><i><br />#{<span class="blsp-spelling-error" id="SPELLING_ERROR_21">stringUtils</span>.<span class="blsp-spelling-error" id="SPELLING_ERROR_22">capitalizeFirstSt</span><wbr>r(null)} </i><span style="font-style: italic;">passes <span style="font-weight: bold;">""</span></span><span style="font-weight: bold;"></span><br /><i> #{<span class="blsp-spelling-error" id="SPELLING_ERROR_23">stringUtils</span>.<span class="blsp-spelling-error" id="SPELLING_ERROR_24">capitalizeFirstSt</span><wbr>r('')}, </i><span style="font-style: italic;">passes ""</span><span style="font-weight: bold;"></span><br /><i>#{<span class="blsp-spelling-error" id="SPELLING_ERROR_25">stringUtils</span>.<span class="blsp-spelling-error" id="SPELLING_ERROR_26">capitalizeFirstSt</span><wbr>r('string')}  </i><span style="font-style: italic;">passes "string"</span><span style="font-weight: bold;"></span></blockquote>See the difference.  As specs say - substitute "" for <span class="blsp-spelling-error" id="SPELLING_ERROR_27">NULLs</span> where possible. <span class="blsp-spelling-error" id="SPELLING_ERROR_28">Hmmm</span>. Char sequence couldn't be substituted? May be.. Or maybe it's just concrete implementation specifics (needs to be checked).<br /><br />Conclusion:<br />All I can tell -   writing the code supposed to be called from EL isn't as simple it may look like, You may become <span class="blsp-spelling-error" id="SPELLING_ERROR_29">foolished</span> by <span class="blsp-spelling-error" id="SPELLING_ERROR_30">sideEffects</span> (String vs <span class="blsp-spelling-error" id="SPELLING_ERROR_31">CharSequence</span>, NULL for special meanings etc ..)</div>
