---
layout: post
title: "Subscribe to This Blog by Email"
comments: true
categories:
- blog
tags:
- subscribe
- feedburner
---



![](http://mediaserver.pulse2.com/uploads/2007/05/google_feedburner_logos.png)

I learnt that many people like to subscribe a blog by email. The website usually supplies its feed, but not such subscription service. Actually, it's quite straightford to do so using the [feedburner of Google](http://feedburner.google.com/). After the webmaster sucessfully makes up the feedburner, he or she can look into the Publicize webpage, and click the button of Subscription Management. After it is activated, you can got the url for email subscription. That's it.

Then you can find the html code for email subscription as below:

### Subscription Form

    <form style="border:1px solid #ccc;padding:3px;text-align:center;" action="http://feedburner.google.com/fb/a/mailverify" method="post" target="popupwindow" onsubmit="window.open('http://feedburner.google.com/fb/a/mailverify?uri=github/zoiS', 'popupwindow', 'scrollbars=yes,width=550,height=520');return true"><p>Enter your email address:</p><p><input type="text" style="width:140px" name="email"/></p><input type="hidden" value="github/zoiS" name="uri"/><input type="hidden" name="loc" value="en_US"/><input type="submit" value="Subscribe" /><p>Delivered by <a href="http://feedburner.google.com" target="_blank">FeedBurner</a></p></form>

<form style="border:2px solid #acc;padding:3px;text-align:center;" action="http://feedburner.google.com/fb/a/mailverify" method="post" target="popupwindow" onsubmit="window.open('http://feedburner.google.com/fb/a/mailverify?uri=github/zoiS', 'popupwindow', 'scrollbars=yes,width=550,height=520');return true"><p>Enter your email address:</p><p><input type="text" style="width:140px" name="email"/></p><input type="hidden" value="github/zoiS" name="uri"/><input type="hidden" name="loc" value="en_US"/><input type="submit" value="Subscribe" /><p>Delivered by <a href="http://feedburner.google.com" target="_blank">FeedBurner</a></p></form>

### Subscription Url
     <a href="http://feedburner.google.com/fb/a/mailverify?uri=github/zoiS&amp;loc=en_US">Subscribe to Cheng-Jun Wang by Email</a>

<a href="http://feedburner.google.com/fb/a/mailverify?uri=github/zoiS&amp;loc=en_US">Subscribe to Cheng-Jun Wang by Email</a>
