---
layout: post
title: Atlassian SAL Plugin Settings
date: 2010-12-21
comments: false
permalink: 2010/12/atlassian-sal-plugin-settings.html
tags: [atlassian, pdk]
---

Has just discovered <a href="http://confluence.atlassian.com/display/SAL/SAL+Services#SALServices-%21package2.gif%21%7B%7Bcom.atlassian.sal.api.pluginsettings%7D%7D">SAL PluginSettings</a>&nbsp;entry point. No more painful plugin configuration storage for me. Good-bye&nbsp;<a href="https://github.com/leonardinius/propertyset-storage-toolkit">propertyset-storage-toolkit</a>, you was so young, so brave, so dumb :)<br /><br />However, if you have more sophisticated needs than&nbsp;<a href="http://docs.atlassian.com/sal-api/2.0.16-SNAPSHOT/com/atlassian/sal/api/pluginsettings/PluginSettings.html">PluginSettings API</a>, smth more than get, put, remove and you want all the power PropertySet could provide you - like lookup, more sophisticated data types, more sophisticated scopes (not like Global and Project-level only, but anything you could map to id, prefix and entityName) then you still might take a look into&nbsp;<a href="https://github.com/leonardinius/propertyset-storage-toolkit">propertyset-storage-toolkit</a>.<br /><br />Note: please you&nbsp;<a href="http://confluence.atlassian.com/display/SAL/SAL+Services#SALServices-%21package2.gif%21%7B%7Bcom.atlassian.sal.api.pluginsettings%7D%7D">SAL PluginSettings</a>&nbsp;until you are <i style="font-weight: bold;">really </i>forced not to.
