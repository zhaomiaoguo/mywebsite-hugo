---
title: "The Rich-club on Sina Weibo"
---


This post is about the opinions tweeted & retweeted by the most influential users of Sina Weibo.

About Sina Weibo, you can refer to the webpage of [wikipedia](http://en.wikipedia.org/wiki/Sina_Weibo#cite_note-3):

> Sina Weibo (Chinese: 新浪微博; pinyin: Xīnlàng Wēibó; literally “Sina Microblog”) is a Chinese microblogging (weibo) website. Akin to a hybrid of Twitter and Facebook, it is one of the most popular sites in China, in use by well over 30% of Internet users, with a similar market penetration that Twitter has established in the USA. It was launched by SINA Corporation on 14 August 2009, and has more than 300 million registered users as of February 2012.

To study the news diffusion of Weibo Users, My collaborator Linwu and I had set up a research project of Weibo Landscape aiming at archiving the historical tweets of 800 verified weibo accounts (Rich club of Sina Weibo) before March 2012. Both the tweets created by them and the tweets retweeted by them are collected and indexed. So this archive can supply you the historical opinions reflected by these most influential users: including 400 media accounts+100 website accounts+ 100 government accounts +100 celebrities accounts+100 grass root accounts

How does the media landscape look like?

![](http://weblab.com.cityu.edu.hk/blog/chengjun/files/2012/04/landscape.png)

### The Opinions of the Rich Club

Understanding the rich club, see [my slides here](http://chengjun.github.io/slides/strut/richclub/):

- the weighted rich-club effect tests whether a select group
of nodes share their strongest ties with each other in a
weighted network (Opsahl et al., 2008)
- 80-20 rule  (Pareto, 1897)
- high degree nodes form many ties with each other
(Borgatti and Everett, 1999; Colizza et al., 2006; Newman, 2002)



![](http://weblab.com.cityu.edu.hk/blog/chengjun/files/2012/04/core-and-periphery.png)

Although Sina Weibo is very densely connected, Individuals are separated from each other but closer to the celebrities. Thus the most influential users become the core of Sina Weibo, and they are followed by the common users. As the core of Sina Weibo, they have great influence on the information diffusion on the social media website.

- 800 Influential Users (400 media accounts+100 website accounts+ 100-government accounts +100 celebrities accounts+100 grass root accounts) are identified by Sina Weibo.

- The data were collected though user timeline api using Python.
The following relationship of the rich club reveals that they are closed connected (see the figure below).

![](http://weblab.com.cityu.edu.hk/blog/chengjun/files/2012/04/social-network.png)

What is the relationship between rich club, random sample, and the unsampled majority in our data?

![](http://chengjun.github.io/slides/strut/richclub/richclub_files/11148691843_63cd8203c3_o.png)

How is the weighted rich-club effect in Sina Weibo?

![](http://chengjun.github.io/slides/strut/richclub/richclub_files/11148617174_4347265242_o.png)

### Have a try!
Unfortunately, this section does not work now. :<

First, open the url: http://weblab.com.cityu.edu.hk/demo/weibo.html

Second, input and query key words (e.g. 占领华尔街，艾未未，汶川地震，动车出轨， 日本地震) and click the search button to see the results. For example, you can query for Occupying Wall Street (占领华尔街), and you can find the items such as:

	related 1-th-weibo:
	mid:3365546399651413
	score:-5.76427445942
	uid:1893278624
	link:source
	time:Thu Oct 06 17:10:59 +0800 2011
	content:【“占领华尔街”继续发酵 全美75所高校学生响应】“占领华尔街”抗议活动进入第19日，活动影响继续发酵，占领运动延伸至高校校园，最新发起的“占领高校”运动，号召全美高校学生5日下午加入上街游行的队伍。图为大批示威者在“占领华尔街”大本营——华尔街附近的祖科提公园Zuccotti Park集会。

If you have login Sina weibo, click the link of source, you can find the [original tweet](http://www.weibo.com/1893278624/xrv9ZEuLX).



### Visualization of diffusion path

Click the source of the top 1000 list of archive items, you can get the url of a given tweet, and then you can further visualize the diffusion path using the apps of Sina Weibo.

- [doodod](http://www.doodod.com/doodod/home)

- [newgraph](http://newgraph.sinaapp.com/)

For example, using the doodod, you can visualize the diffusion path following [this link](http://www.doodod.com/doodod/chuanbo?weiboURL=http://weibo.com/1893278624/xrv9ZEuLX). The figure looks like this:

![](http://weblab.com.cityu.edu.hk/blog/chengjun/files/2012/04/freshnew.png)

######The Landscape of Information Diffusion on Sina Weibo：
Investigating the Rich-Club Effect

This blog post is derived from my project of information diffusion on Sina Weibo. Based on the data of weibo landscape, we find that:

Rich-club as a closely connected community in networks has important influences on the information flow within the online social system. We study the competing mechanisms underlying the information flows within and among different social groups inside the rich club of Sina Weibo. The results demonstrate that: first, there is relatively strong rich-club effect in both influential users and random sampled users; second, social selection, geographic proximity, and social influence have significant influence on the information flow within the rich-club for different social groups, and the impact of social influence is overwhelmingly strong. The implications help shed new light on our knowledge about the underlying mechanisms of information diffusion on the microblog.

In the following post, I will introduce how to scrape data from Sina Weibo using Python.
