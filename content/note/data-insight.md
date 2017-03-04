+++
title="团队合作中的任务分配"
date = "2017-02-17"
math = true
+++

最近一年多一直和令飞折腾`团队合作`的东西，也在思考如何进行团队合作。之前是把开会当成头脑风暴，后来发现太浪费时间，尤其是团队成员超过三个人之后（也要兼顾别人没有那么多时间），合作的成本开始上升，如何高效地进行合作就成了一个重要的问题。我们研究的主题也就是这个东西。

# 直接表达claim
直接地表达claim，然后使用数据证明自己的观点，就会发现其中的断裂的逻辑链条，进而不断完善。**Polish your claim** 比如，我去统计了用户在不同的repos里的push的次数计算其multi-tasking的香农熵和core team ratio，发现：
> Github用户倾向于比较平均但深入地参与到团队项目（`claim`）。

## 为什么水分可以增加影响？

找一个novelty的点，需要一个narrow down的concrete的research question。要避免一开始要有一个想法，somehow connect to something, 挖来挖去做出来很多unconnected的findings。apparent team不是真实的team， 我们想要找到real team， 因此可以去分析workload distribution and skill set overlapped，及其对于impact的影响。我们想要找一个metric to correct team size. team的**充水**程度。story！为什么充了水的team的impact更大？what is a real team is research topic。怎么定义水分就靠近hypothesis。

![water team](http://oaf2qt3yk.bkt.clouddn.com/64335d80b0fc78f1bdaef76612e11750.png)

我之前说的一大堆只是想说一个论点：因为我们不是duncan watts，所以我们还是要用正轨的research道路。define topics, narrow it down, implement, provide prospects四部曲的方式。令飞之前说的“什么样是真正有效的合作，从技能的重合度和贡献量来衡量”是research topic, 不是一篇文章的research question。从workload的分布定义一个metric，core team size or effective team size

- 加一个时间维度， 新陈代谢， m(t)
- diversity，做过多少个不同的项目，experience好测量
- repeated collaboration

组织为什么会失败。junior和senior scholar合作效果不错。

### Task Assignment

勾勒一个图景，早期/核心用户对任务的分配是如何切割了任务空间的。我们其实是观察不到用户之间的交流，所以只能通过用户各自的工作来推测他们协商任务分配的结果。一种分析角度是，大的任务会由核心用户在早起就“认领”吗？还是大任务（大修改）随时间分配是均匀的。

[Roberta Sinatra](http://www.robertasinatra.com/)等人2016年发表Quantifying the evolution of individual scientific impact [^Sinatra]， 把一个科学家当一个sample,发现impact的分布无法简单用sample size N（发文章数量）rescale到一起。于是给每个sample一个参数Qi，这样就能把所有科学家的所有论文的影响力分布collapse 到一起，解释了为什么高量产的科学家，论文影响力极大值比根据样本规模随机从系统取还要大的问题-其实没有解释，就是管这个叫Q 了。

- [Science paths](ttp://sciencepaths.kimalbrecht.com/) 网页可视化
- [Is a scientific career predictable?](https://www.youtube.com/watch?v=qlnxM-ld4BU) nature视频

科学探索和合作写代码还不一样，前者有可能真的不知道最重要的工作什么时候出现，后者的任务空间是个有限集合，任务的重要性和完成度是排他性的

[^Sinatra]: Sinatra, R., Wang, D., Deville, P., Song, C., & Barabási, A. L. (2016). Quantifying the evolution of individual scientific impact. Science, 354(6312), aaf5239-aaf5239.

Team Assembly Mechanisms Determine Collaboration Network Structure and Team Performance[^Guimerà] 一文题目应该叫“学术圈”。三个结论1. ）科学家是有圈子的，类似于渗流模型的giant cluster 好几个学科都是这样，越是好刊物的合作者数据，越能看到这个圈子存在2. ）模型参数m 团队规模, p 选择已经发表过文章老鸟合作的概率，q 选择已经合作过的人再次合作的概率，发现要想发高影响力的文章，p要大，q要小，也就是不要轻易和菜鸟合作，但也不要总是和同一批人合作；3）该模型可以复现团队规模的相变-稳定增长到收敛在一个优化值，和学科内部合作网络出现精英圈子的消息。

[^Guimerà]: Guimerà R, Uzzi B, Spiro J, et al. Team Assembly Mechanisms Determine Collaboration Network Structure and Team Performance. Science, 2005, 308(5722):697-702

- 哈佛商业评论 Using the Crowd as an Innovation Partner
- Management Science上的Incentives and Problem Uncertainty in Innovation Contests: An Empirical Analysis
- Uzzi B, Mukherjee S, Stringer M, Jones B. 2013. Atypical combinations and scientific impact. Science 342:468–72
- Lee Y N, Walsh J P, Wang J. Creativity in scientific teams: Unpacking novelty and impact. Research Policy, 2015, 44(3):684-697.

## 拟合代码量的累积增长

可以先把10个人的team的代码总量随（绝对）时间的变化看一下C是t时刻的代码总量，A是无穷远时代码总量，tau大概就是半衰期。然后画一个所有大team的tau的分布，如果是双峰的分布，说明确实有两种team。20120311之后出现的team好像都有显示代码量。

$$C(t)=A(1-e^{-t/\tau})$$

两边求导再离散化,先求导的：$\frac{dC (t)}{dt} =\frac{A}{\tau} e^{-t/\tau}$

左边的导数可以用两点间的斜率近似， $\frac{dC (t)}{dt} =\frac{(C (t+\delta t)-C (t))}{\delta t} $，离散一下 $\delta t =1$，即：

$$C(t+1)-C(t) = \frac{A}{\tau} e^{-t/\tau}$$

两边取对数，$log(C(t+1)-C(t))= log\frac{A}{\tau} - t/\tau$

令$\beta = -1/\tau$，$y = log(C(t+1)-C(t))$, $constant = log\frac{A}{\tau}$, 则存在:

$y = constant + \beta t$

对数据进行处理得到$y$和$t$，采用线性回归进行拟合，即可得到constant和$\beta$。那么显然：$\tau = -1/\beta$, $ A = e^{constant} $, $\tau = - e^{constant}/\beta $

我尝试去拟合了tau和A, 结果产生了大量的负的tau和A，另外，多数R方都不大，效果不好。这里的$\tau$与这个代码增长速度随时间变化是负的反比关系。因为挺多项目的代码增长速度是非线性的，比如相邻两次的变化量是先递增，后减小，或者一直增加。都会导致线性拟合的效果不好。

一个例子见以下代码：

```python
import statsmodels.api as sm
import numpy as np
import matplotlib.cm as cm
from datetime import datetime

def interpolating(data):
    # To interpoloate data
    bad_indexes = np.isnan(data)
    good_indexes = np.logical_not(bad_indexes)
    good_data = data[good_indexes]
    interpolated = np.interp(bad_indexes.nonzero()[0], good_indexes.nonzero()[0], good_data)
    data[bad_indexes] = interpolated
    return data


d = ['2014-01', '2012-09', '2013-08', '2013-09', '2012-10', '2013-05', '2013-06']
v = ['1192' ,'163', '605', '1189', '167' ,'199', '199']
d = [datetime.strptime(i+'-01', "%Y-%m-%d") for i in d]
d = [(i - np.min(d)).days/30 + 1 for i in d]
v = [int(i) for i in v]
dv = zip(d, v)
dv = sorted(dv,key=lambda x:x[0])
d, v = np.array(dv).T
yt = np.array(v[1:]) - np.array(v[:-1])
t = d[:-1]
x = t#np.log(t)
y = np.log(yt+1)
y = interpolating(y)
# fit
xx = sm.add_constant(x, prepend=True)
res = sm.OLS(y,xx).fit()
constant, beta = res.params
r2 = res.rsquared
tau = - 1.0/beta
A = tau*np.exp(constant)
print 'Tau = ',tau,'A=',  A, 'constant = ',constant, 'beta =', beta,'rsquare = ', r2

fig = plt.figure(figsize=(10, 5))
ax = plt.subplot(1,2,1)  
plt.plot(d, v, 'r-s')
plt.xlabel(r'month');plt.ylabel(r'size')
ax = plt.subplot(1,2,2)  
plt.plot(x, y, 'rs')
plt.plot(xx, constant+xx*beta,"red")
plt.xlabel(r't');plt.ylabel(r'log(c(t+1)-c(t))')
plt.show()
```

![tau](http://oaf2qt3yk.bkt.clouddn.com/19d58b4deb8a292c287dc692898a89af.png)


To-do:

- 最大的push次数的人和最多push代码量的人是否一个人，计算一个rate
- 算sleeping beauty index
- 如果把每个人的工作量换算成绝对代码增减量, 还是可以仿照m的定义计算熵。熵小的大石头放好了，大部分人都是添沙子。大石头什么时候放进去的也很有信息量。


尽快确定一下最大代码贡献者和最频繁贡献者的重合率，感觉这个还是比较影响整个故事走向的。另外，试一下最大代码出现时间的分布。

![overlap rate](http://oaf2qt3yk.bkt.clouddn.com/bd3743ee8842b10dcd0e33142af77b5e.png)

![overlap rate single size](http://oaf2qt3yk.bkt.clouddn.com/c315dfd9d7cbab768b9c5615813d00df.png)

结论：随着团队规模增加，团队内部的确变得多元化，有人频繁参与，有人则高强度参与，二者未必相同。的确可能出现大象🐘和老鼠🐭并存的情况。按照`“固定”任务空间`的假设，在位者有累积优势（经验、任务分配、责任心），但人多了竞争激烈，也会给在位者带来冲击，尤其是大象的进入，他们可以靠少数的push，贡献大量的代码。

![water](http://oaf2qt3yk.bkt.clouddn.com/71219d7043e62aed77d1761afceb73cf.png)

水分不仅在活跃次数衡量的有效团队中发挥作用，同样在代码量衡量的有效团队中发挥作用，应该有点深刻的东西在这里。Lakhani (2011)发表在Management Science上的文章要回答一个问题[^Lakhani]，像Netflix 这样的竞赛，团队多好还是少好？传统经济学理论认为参与团队越多，单个团队获奖概率越低，团队越没有积极性，平均表现越差。他们分析数据发现，扩大参赛团队数后，平均表现变差，但最强团队的表现变好。

[^Lakhani]: Boudreau, K. J., Lacetera, N., & Lakhani, K. R. (2011). Incentives and problem uncertainty in innovation contests: an empirical analysis. Management Science, 57(5), 843-863.

### 数据

**arXiv bulk data access amazon S3**


# 因公出国护照办理

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

# Reference
