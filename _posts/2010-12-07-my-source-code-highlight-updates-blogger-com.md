---
layout: post
title: My source code highlight updates - blogger.com
date: 2010-12-07
comments: false
permalink: 2010/12/my-source-code-highlight-updates.html

---

Hi everyone,<br /><br />After updating my template I noticed that I have JS source code highlighting broken.<br />What do do - setup once again :)<br /><br />So,m after a little research I found one I liked the most - <a href="http://softwaremaniacs.org/soft/highlight/en/">Highlight.js</a> - See <a href="http://softwaremaniacs.org/media/soft/highlight/test.html">Demo Page</a>.<br /><div><br /></div><div>So, step by step instruction on putting this in Your blog:</div><div><ol><li>Go To <u><i>Design</i></u></li><li>Goto <u><i>Edit HTML</i></u></li><li>&lt;/head&gt; tag</li><li>Place the code just before the closing &lt;/head&gt; tag<br /><pre><code class="html">&lt;script src='http://yandex.st/highlightjs/5.16/highlight.min.js'/&gt;<br />&lt;link href='http://yandex.st/highlightjs/5.16/styles/school_book.min.css'<br />           rel='stylesheet'/&gt;<br /><br />&lt;script language='javascript'&gt;<br />hljs.tabReplace = &amp;quot;    &amp;quot;;<br />hljs.initHighlightingOnLoad();<br />&lt;/script&gt;<br /></code></pre></li><li>Save the template - the result you mas see above. Note: put you code in &lt;pre&gt;&lt;code class="html"&gt; tags (or whatsever is your language name)</li></ol></div>
