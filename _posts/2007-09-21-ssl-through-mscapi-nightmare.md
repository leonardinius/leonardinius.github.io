---
layout: post
title: SSL through MSCAPI nightmare
date: 2007-09-21
comments: false
permalink: 2007/09/ssl-through-mscapi-nightmare.html
tags: [java, ssl]

---

Hi everybody,
Have everyone of you worked with SSL? It's really nightmare I tell you. Java+SSL stack (JKS and more and more abbreviations) seemed fine to me until our customer proposed the Windows user native keystore usage.

**The UC (use-case) outline summary:**

* Users authenticates in Windows environment using some sort of the [SSO](http://en.wikipedia.org/wiki/Single_sign-on) software installed onto client's machine.
* SSO puts it's certificate into Windows-MY keystore ([CAPI](http://en.wikipedia.org/wiki/MS_CAPI)).
* We provide some sort of service, which needs to access some data onto network using those authentication and authorization data (through HTTPS/SSL).

**Problem description:**

Yep, we could use [MSCAPI provider](http://java.sun.com/javase/6/docs/technotes/guides/security/SunProviders.html#SunMSCAPI) bundled with Jre1.6+. But in real case it doesn't work. For some strange reasons Sun's MSCAPI provider does not allow HTTPS through SSL. For more deatiled information please visit: [http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6578658](http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6578658). The same issues is discussed at the:

*   [http://forum.java.sun.com/thread.jspa?forumID=60&threadID=786782](http://forum.java.sun.com/thread.jspa?forumID=60&threadID=786782)
*   [http://forum.java.sun.com/thread.jspa?forumID=2&threadID=5170899](http://forum.java.sun.com/thread.jspa?forumID=2&threadID=5170899)

So, the straightforward solution: JKS framework + HTTPS - doesn't really work. Some other possible solutions could be: some 3rd papty JKS provider usage. For some strange reasons they all are not Open Source and Free/Beer-ware :) and they do not work either:

*   [CAPIProv](http://rcardon.free.fr/websign)
*   [JNICapi SSL interface](http://sourceforge.net/projects/jnicapi/)
*   [KeyOn JaCAPI](http://www.keyon.ch/en/Produkte/JavaJCE/JACAPI/index.htm)
*   [Pheox JaCAPI](http://pheox.com/products/jcapi/)

**Solutions proved to work well:**

- We could export MS CAPI My-Keystore certificates using MMC interface or through IE explorer /Tools/ Content / Certificates interface:
![](https://lh4.googleusercontent.com/-Jv9f9GyF-NM/TXXseJKSeJI/AAAAAAAAEKU/Pat9SemtDSE/s1600/2011-03-08_0938.png)

At the image (img. 1.) we could clearly see the certificate beuing imported into My-keystore by SSO software.<span style="font-weight: bold;">
</span>
By initiating export operation we could access the certificate chain + private key in the underlaying [.PFX](http://en.wikipedia.org/wiki/PKCS) format. After that we could just to use standard JKS stack to authenticate and authorize using HTTPS over SSL. <span style="font-weight: bold;">But.</span> Problem still remains: how to do this authomativally from JAVA side?
The solutions I have think out and developed is: some JNI code to export certificate to local file system. So:

*   [CryptUIWizExport](http://msdn2.microsoft.com/en-us/library/aa380395.aspx) is used to export MsCAPI certificates
*   [CreateEvent](http://msdn2.microsoft.com/en-us/library/ms682396.aspx) and [WaitForSingleObjectEx](http://msdn2.microsoft.com/en-us/library/ms687036.aspx) are used for change listener cycle together with [CertControleStore](http://msdn2.microsoft.com/en-us/library/aa376031.aspx).

**Conclusion, Java Part**

The part of our projet's semi-"official" wiki page:

> All the logics and the functioality maximally is implemented onto JAVA side; among another things - listener cycle logics and so on. The only thing being implemented onto the JNI part is WinAPI32 calls + a few functions to allocate/free/write to memory.
>
> *   JAVA side uses JNI's provided calls to WinAPI to load and export all the certificates + their private keys to local temporaly files (with strong random password protection.)
> *   Then those files are loaded into memory and gets removed.
> *   SSL context is initialized from the memory.
> *   A change listener is attached to the MsCAPI keystore. Then the Windows-MY keystore is changed (the certificate is added or loaded), a change event occurs and the overall SSL context state is reloaded and initialized again, resulting in completely new WS-SSO state.

