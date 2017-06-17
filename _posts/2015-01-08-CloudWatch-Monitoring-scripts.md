---
title: "AWS How to - CloudWatch monitoring scripts over HTTPS proxy on Ubuntu Linux (12.04 LTS)"
layout: post
tags: [cloudwatch, aws, devops]
permalink: 2015/01/CloudWatch-Monitoring-scripts/
---

The subject says it all: small intro into WTF? is Amazon CloudWatch and
small how to setup and use Amazon CloudWatch monitoring scripts over HTTPS
proxy on Ubuntu Linux 12.04 LTS.

## tl; dr; ##

* [How-to: Perl https package fix](#perl-https-package-fix)
* [How-to: Execute monitoring script](#launching-amazon-cloudwatch-monitoring-scripts-for-linux-(env-variables))

## WTF? CloudWatch ##

> What Is Amazon CloudWatch?
> 
> Amazon CloudWatch monitors your Amazon Web Services (AWS) resources and the
> applications you run on AWS in real-time. You can use CloudWatch to collect
> and track metrics, which are the variables you want to measure for your
> resources and applications. CloudWatch alarms send notifications or
> automatically make changes to the resources you are monitoring based on rules
> that you define. ... With CloudWatch, you gain system-wide visibility into
> resource utilization, application performance, and operational health.  [What
> is CloudWatch][1]

Certain metrics are available right away out of box, no extra hassle and
no extra fees (please refer to [Amazon CloudWatch Pricing][3] and [Amazon
CloudWatch Namespaces, Dimensions, and Metrics Reference][2] for out of
box available metrics, e.g. CPU usage on EC2 instances).

However, in our case we have immediately discovered we want to monitor more
and definitely want get notifications in such cases as RAM is out, Swap too
high or No free disk space left et cetera ... [Amazon CloudWatch Custom Metrics][4] to
rescue.

So, what to do next? Script it, code it ... What's the most cost effective way
of approaching this?

## Amazon CloudWatch Monitoring Scripts ##

Amazon CloudWatch Developer documentation features [Amazon CloudWatch
Monitoring Scripts][5] (in our case [Linux version][6]), which handle exactly
the case we were looking for: RAM and disk usage metrics.

## The PROXY problem ##

In that particular environment we route ALL (non-loop back) HTTP/HTTPS traffic
 over proxy (squid). It helps us simplify our firewall configuration a lot (we
 have quite a few integrations with external parties) and allows basically just
 perform HTTP/HTTPS host name white listing in centralized manner. So, we use the
 same technique here as well.
 
ALL Amazon API work over HTTPS. So, in this case we need to instruct monitoring
scripts to access CloudWatch API through HTTP/HTTPS proxy.

As it appears, Perl `https` module (or whatever is the correct name for
this) does not handle that case well by default, at least not on Ubuntu
12.04 LTS. And [Amazon CloudWatch Monitoring Scripts for Linux][6] is
implemented using Perl. Damn!

I actually discovered that during that during the roll out deployment
process scheduled to be over the weekend, previous testing somehow missed
that. _Rrrr_. 

I don't recall exact sources, forums and mailing lists I visited that
evening, so I won't be able to credit those and point to original
solutions and technical discussions around the issue.

Bottom line is, at the end of the day I managed to find and implement reliable
configuration workaround, which appears to be to reinstall/rebuild Perl
`LWP::Protocol::https` package and then pass certain environment variables down
to Linux Monitoring script.

### Perl HTTPS package fix ###

{% highlight console %}
# installs CloudWatch Monitoring Scripts for Linux prerequisites, 
# as per documentation
sudo apt-get install -y \
  unzip \
  libwww-perl \
  libcrypt-ssleay-perl \
  libswitch-perl \
 ;

# installs HTTPS proxy fix dependencies
sudo apt-get install -y \
  libssl-dev \
  make \
 ;

# Make and re-install LWP::Protocol::https package
# PERL_MM_USE_DEFAULT=1 - install all dependencies, assume yes ...
sudo env PERL_MM_USE_DEFAULT=1 cpan install LWP::Protocol::https
{% endhighlight %}

### Launching Amazon CloudWatch Monitoring Scripts for Linux (ENV variables) ###

See the sample below

{% highlight console %}
# forces a version 3 SSL connection first, SSL2 after
export HTTPS_VERSION=3 

# which implementation to use
export PERL_NET_HTTPS_SSL_SOCKET_CLASS="Net::SSL"
 
# take proxy parameters from environment variables (placed in /etc/environment in my case)
export PERL_LWP_ENV_PROXY=1 

# Do not perform SSL hostname verification, fails with proxy
export PERL_LWP_SSL_VERIFY_HOSTNAME=0 

/opt/aws-mon-scripts/v1.1.0/aws-scripts-mon/mon-put-instance-data.pl \
    --mem-util        \
    --swap-util       \
    --disk-space-util \
     \
    --disk-path=/ \
     \
     \
     \ # <<removed>> AWS credentials details ...
    ;

# >> Successfully reported metrics to CloudWatch. Reference Id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx 
{% endhighlight %}

**Vuala**

<!-- references -->
[1]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/WhatIsCloudWatch.html "What is CloudWatch"
[2]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html "Amazon CloudWatch Namespaces, Dimensions, and Metrics Reference"
[3]: http://aws.amazon.com/cloudwatch/pricing/ "Amazon CloudWatch Pricing"
[4]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/publishingMetrics.html "Amazon CloudWatch Cutom Metrics" 
[5]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts.html "Amazon CloudWatch Monitoring Scripts"
[6]: http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts-perl.html "Amazon CloudWatch Monitoring Scripts for Linux"

