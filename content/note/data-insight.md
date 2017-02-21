+++
title="数据洞察：掘地三尺的研究路径"
date = "2017-02-17"
+++

最近一年多一直和令飞折腾`团队合作`的东西，也在思考如何进行团队合作。之前是把开会当成头脑风暴，后来发现太浪费时间，尤其是团队成员超过三个人之后（也要兼顾别人没有那么多时间），合作的成本开始上升，如何高效地进行合作就成了一个重要的问题。我们研究的主题也就是这个东西。

# 直接表达claim
团队成员的意见只是帮助我思考，我要领导这个研究项目向前。直接地表达claim，然后使用数据证明自己的观点，就会发现其中的断裂的逻辑链条，进而不断完善。

**Polish your claim** 比如，我去统计了用户在不同的repos里的push的次数计算其multi-tasking的香农熵和core team ratio，发现：
> Github用户倾向于比较平均但深入地参与到团队项目（`claim`）。

# Abstract

找一个novelty的点，需要一个narrow down的concrete的research question。要避免一开始要有一个想法，somehow connect to something, 挖来挖去做出来很多unconnected的findings。

apparent team不是真实的team， 我们想要找到real team， 因此可以去分析workload distribution and skill set overlapped，及其对于impact的影响。

我们想要找一个metric to correct team size. team的**充水**程度。story！what is a real team is research topic。怎么定义水分就靠近hypothesis。

我之前说的一大堆只是想说一个论点：因为我们不是duncan watts，所以我们还是要用正轨的research道路。define topics, narrow it down, implement, provide prospects四部曲的方式。令飞之前说的“什么样是真正有效的合作，从技能的重合度和贡献量来衡量”是research topic, 不是一篇文章的research question。

general trend， team up. No real collaboration. How to measure


从workload的分布定义一个metric，

core team size or effective team size
- 加一个时间维度， 新陈代谢， m(t)
- diversity，做过多少个不同的项目，experience好测量
- repeated collaboration

组织为什么会失败。

junior和senior scholar合作效果不错。

C(t)=A(1-exp(-t/tau))

可以先把10个人的team的代码总量随（绝对）时间的变化看一下

C是t时刻的代码总量，A是无穷远时代码总量，tau大概就是半衰期。然后画一个所有大team的tau的分布，如果是双峰的分布，说明确实有两种team。20120311之后出现的team好像都有显示代码量。


Uzzi B, Mukherjee S, Stringer M, Jones B. 2013. Atypical combinations and scientific impact. Science 342:468–72

Lee Y N, Walsh J P, Wang J. Creativity in scientific teams: Unpacking novelty and impact. Research Policy, 2015, 44(3):684-697.

## 因公出国护照办理

[http://wb.nju.edu.cn/zzbl/list.htm](http://wb.nju.edu.cn/zzbl/list.htm)

一、公务（普通）护照办理
（一）办证要求
1、在办结因公出国校内审批后，由申请者本人到仙林校区行政楼818室采集指纹，并提交以下材料：
（1）身份证原件
（2）身份证复印件（标明出生地所在省、直辖市或自治区名）
（3）两寸白底彩照1张
2、现无公务（普通）护照/护照过期/护照有效期不足（本次出访后，距护照到期不足6个月；部分国家所需有效期更长）
（二）办理时间：1至2周（不含节假日）

### 因公出国人员申报流程及材料须知

[http://wb.nju.edu.cn/splc/list.htm](http://wb.nju.edu.cn/splc/list.htm)

因公临时出国人员根据“OA申报材料清单”,通过OA系统提交申报材料；


### 从异速增长率开始！

俗话说用志不分乃凝于神。最近有点分心，精力不集中，产生了很多问题。一个问题是计算士这边的活落下来了。昨天跟小可聊天，也因为不熟悉整个脉络被抢白了半天。于是自己也在思索：解决了什么问题？研究的意义是什么？

从异速增长率开始！It all starts with a big allowmetric growth rate! 异速增长率：这是一个重要的问题。比如一个流系统的节点是N， 产出是P,那么满足 $P = N^\theta$的关系。在互联网中，它就是PV和UV的关系。它提出了一个问题，即：为什么生物、城市、互联网都满足一个普世规律？它定量地表达了投入和产出的关系。

![](http://wiki.swarma.net/images/thumb/c/c5/Allowmetric_growht_digg_36_days.png/400px-Allowmetric_growht_digg_36_days.png)


为什么会有异速增长？一个可能的答案是流网络的自相似性。自己的哪里相似？究竟是什么地方？注意：异速增长是一个时间维度的系统状态的变化。它满足标度率，那么它本身就是自相似的。可以究竟什么才是自相似？（似乎马上回到了以前的问题：什么是无标度网络？）

引入耗散的视角：耗散阻碍了生长。每个小时里流网络而言，可以算每个节点i的耗散与流入。流入$T_{i}$和耗散$D_i$的差值就是节点i的流存量。

我们知道$T_i$和耗散 $D_i$的关系同样满足一个标度规律。放在直角坐标系中，我们可以画出这种关系。

![](http://wiki.swarma.net/images/d/d9/Dissipation_digg_36_days.png)

直角坐标系隐含了一些潜在的假设：我们要按照从小到大的顺序（我称之为序假设，rank assumption）排列才能看到这种规律。坐标轴的作用就是这样。但要注意：流冰不是这样从耗散小的节点留到耗散大的节点。

### 几何化

将流网络几何化，看成是一个由源向外的耗散。一个流网络，就可以算出任一节点到源头的流距离$L_{i}$。算法暂时省略。

整个网络按照半径重排：保持了网络的自相似性。这里的自相似是指Dreyer球意义上的自相似，即沿着半径由球心向外走，每个半径上的$T_i$和耗散$D_i$各自的积分（即流的累加）保持标度关系。这个时候，尺度便成了球半径（流距离），而不是直角坐标系里的序了。

![](http://wiki.swarma.net/images/thumb/5/58/Hour23.png/400px-Hour23.png)


但是，换成了流距离作序参量（这里我是乱用的）的话，这种效果依然不好：

![](http://wiki.swarma.net/images/thumb/8/84/Les.png/800px-Les.png)

看到数据里的平行四边形，而不是相互遮盖成为一个直线。

结果导致了拟合的耗散率$\mu$和异速增长率$\theta$之间的关系具有较大的噪音：

![](http://wiki.swarma.net/images/thumb/c/ce/MuAndTheta.png/600px-MuAndTheta.png)

怎么办？引入系统规模UV。

$$T\(r) = A D_{rmax}^a D\(r)^b$$

T\(r)和D\(r)代表沿半径r从source到sink对节点的直接流通量$t_i$和耗散量$d_i$进行积分。当r=rmax时，D\(r)=D(rmax)=UV。

果然效果好了。

![](http://wiki.swarma.net/images/thumb/c/c1/Dreyerballscaling.png/800px-Dreyerballscaling.png)

看到这里我自愧弗如远甚。

![](http://wiki.swarma.net/images/7/7e/Addjustedthetaprediction.png)
