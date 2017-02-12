---
layout: post
title: "数据洞察：掘地三尺的研究路径"
date: 2014-08-13
comments: true
categories:
- 学术
tags:
- 数据
---


俗话说用志不分乃凝于神。最近有点分心，精力不集中，产生了很多问题。一个问题是计算士这边的活落下来了。昨天跟小可聊天，也因为不熟悉整个脉络被抢白了半天。于是自己也在思索：解决了什么问题？研究的意义是什么？

### 从异速增长率开始！

从异速增长率开始！It all starts with a big allowmetric growth rate! 异速增长率：这是一个重要的问题。比如一个流系统的节点是N， 产出是P,那么满足 $$P = N^\theta$$的关系。在互联网中，它就是PV和UV的关系。它提出了一个问题，即：为什么生物、城市、互联网都满足一个普世规律？它定量地表达了投入和产出的关系。

![](http://wiki.swarma.net/images/thumb/c/c5/Allowmetric_growht_digg_36_days.png/400px-Allowmetric_growht_digg_36_days.png)


为什么会有异速增长？一个可能的答案是流网络的自相似性。自己的哪里相似？究竟是什么地方？注意：异速增长是一个时间维度的系统状态的变化。它满足标度率，那么它本身就是自相似的。可以究竟什么才是自相似？（似乎马上回到了以前的问题：什么是无标度网络？）

引入耗散的视角：耗散阻碍了生长。每个小时里流网络而言，可以算每个节点i的耗散与流入。流入$$T_{i}$$和耗散$$D_{i}$$的差值就是节点i的流存量。

我们知道$$T_{i}$$和耗散$$D_{i}$$的关系同样满足一个标度规律。放在直角坐标系中，我们可以画出这种关系。

![](http://wiki.swarma.net/images/d/d9/Dissipation_digg_36_days.png)

直角坐标系隐含了一些潜在的假设：我们要按照从小到大的顺序（我称之为序假设，rank assumption）排列才能看到这种规律。坐标轴的作用就是这样。但要注意：流冰不是这样从耗散小的节点留到耗散大的节点。

### 几何化

将流网络几何化，看成是一个由源向外的耗散。一个流网络，就可以算出任一节点到源头的流距离$$L_{i}$$。算法暂时省略。

整个网络按照半径重排：保持了网络的自相似性。这里的自相似是指Dreyer球意义上的自相似，即沿着半径由球心向外走，每个半径上的$$T_{i}$$和耗散$$D_{i}$$各自的积分（即流的累加）保持标度关系。这个时候，尺度便成了球半径（流距离），而不是直角坐标系里的序了。

![](http://wiki.swarma.net/images/thumb/5/58/Hour23.png/400px-Hour23.png)


但是，换成了流距离作序参量（这里我是乱用的）的话，这种效果依然不好：

![](http://wiki.swarma.net/images/thumb/8/84/Les.png/800px-Les.png)

看到数据里的平行四边形，而不是相互遮盖成为一个直线。

结果导致了拟合的耗散率$$\mu$$和异速增长率$$\theta$$之间的关系具有较大的噪音：

![](http://wiki.swarma.net/images/thumb/c/ce/MuAndTheta.png/600px-MuAndTheta.png)

怎么办？引入系统规模UV。

$$
T(r) = A*D_{rmax}^aD(r)^b
$$

T(r)和D(r)代表沿半径r从source到sink对节点的直接流通量$$t_{i}$$和耗散量$$d_{i}$$进行积分。当r=rmax时，D(r)=D(rmax)=UV。

果然效果好了。

![](http://wiki.swarma.net/images/thumb/c/c1/Dreyerballscaling.png/800px-Dreyerballscaling.png)

看到这里我自愧弗如远甚。

![](http://wiki.swarma.net/images/7/7e/Addjustedthetaprediction.png)
