+++
highlight = true
math = false
date = "2017-07-18T14:32:07+08:00"
title = "集智俱乐部暑期研读营"
tags = ['news']
summary = """

"""
[header]
  image = ""
  caption = ""

+++



![evening7.17](http://oaf2qt3yk.bkt.clouddn.com/2fd6341c3b8203ef4cef54f7dbd6472f.png)



今年的研读营主要由吴令飞和尤亦庄负责。吴令飞主张研读营应该解决只有研读营才能做的事情。最初大家想分组搞一些研究项目，但考虑到大家因为项目的压力，每一个人都想得是一个可以deliver的东西。虫洞和weak tie有什么关联？boltzmann machine与社会计算？ising model与图灵机：一个社会系统在做计算。就人员组成而言，主要分成了社会科学组合物理学组两大阵营。

# 社科与物理两大阵营是否可以理解对方的工作？

社科和物理两大阵营作为两个组，每个组提议五对文献，任意一对论文有一篇好的，一篇是相对差的。于是两组分别出了一套题目，仅仅给出标题和摘要。

- [社会科学组出的题目](http://wiki.swarma.net/images/4/48/Group-social-papers.pdf)  
- [物理组出的题目](http://wiki.swarma.net/images/7/7d/Group-physics-papers.pdf)

过程如下：首先，每个人选出自己认为正确的选项；然后，汇总并公示组内结果，每个人发表意见；最后，小组决议，投票决定。最终的结果如下图所示，社科组错了一个，物理组错了三个。

这个结果略微让人吃惊，因为一般人认为物理组比较难，社科的人难以理解。结果却是对于那些发表出来的文章而言，物理组更搞不清楚社科的难度（“水”）有多深。当然，第二种解读就是，社会科学太软、太水，需要太多的口耳相传的训练，仅仅习得表面的功夫就只能做表面文章。

![社科与物理两大阵营是否可以理解对方的工作](http://oaf2qt3yk.bkt.clouddn.com/bd53c2608f5ec559393a88dd7dba0ea2.png)


## 玻尔兹曼机

![boltzman-machine-graph](http://oaf2qt3yk.bkt.clouddn.com/36eda36920ae58ce5a77995d72cef623.png)

> A graphical representation of an example Boltzmann machine. Each undirected edge represents dependency. In this example there are 3 hidden units and 4 visible units. This is not a restricted Boltzmann machine.

They are named after the **Boltzmann distribution** in statistical mechanics, which is used in their sampling function. It was invented by `Geoffrey Hinton` and Terry Sejnowski in 1985.

- **unsupervised** machine learning
  - unsupervised learning需要记住所有的东西
  - supervised learning是建立mapping
- ising model
  - graph as the background geometric structure
    - node
      - there is a binary **spin** on each node
        - $\sigma_v = 1 \; or -1$
    - edge
      - hamiltonian (energy)

$$E = -\left(\sum_{i<j} w_{ij} \, s_i \, s_j + \sum_i \theta_i \, s_i \right)$$

Where:
* $w_{ij}$ is the connection strength between unit $j$ and unit $i$.
* $s_i$ is the state, $s_i \in \{0,1\}$, of unit $i$.
* $\theta_i$ is the bias of unit $i$ in the global energy function. ($-\theta_i$ is the activation threshold for the unit.)

Often the weights are represented as a symmetric matrix $W$, with zeros along the diagonal.


Newmann **q modularity** hamiltonian on the network

sbm stochastic block model

- deepwalk http://www.perozzi.net/publications/14_kdd_deepwalk.pdf
- node2vector http://snap.stanford.edu/node2vec/

闭上眼猜测，睁开眼观察，比较二者的差别。

## 袁行远介绍雾霾预报

![雾霾](http://oaf2qt3yk.bkt.clouddn.com/fee8f8445f3dbf217887e078ed18ac81.png)

## 肖达介绍RNN原理

![rnn](http://oaf2qt3yk.bkt.clouddn.com/a94dd5e7b694f5bcb5ae680122ba5c9d.png)

![xiaoda](http://oaf2qt3yk.bkt.clouddn.com/3b4701e0d6860abbb78959216c3b1d2d.png)

## word2vec

https://www.tensorflow.org/tutorials/word2vec

## 为什么深度学习有效?

![为什么深度学习有效](http://oaf2qt3yk.bkt.clouddn.com/c577e1dc974990e2d7b7893293d15ea6.png)

The humans working behind the ai curtain

## 董磊介绍城市研究

![董磊](http://oaf2qt3yk.bkt.clouddn.com/90ef9b65b37fc877336c25e72113f1f4.png)

![制造业](http://oaf2qt3yk.bkt.clouddn.com/ba1cceabb662ea98c1c629363f3c6736.png)

制造业的衰落

![poverty](http://oaf2qt3yk.bkt.clouddn.com/74c1ad741f419d67ca138f463f2b4dc1.png)

贫穷

# 回到北京

结束了四天古北水镇的研读营，来到清华参加集智年会。

![红杉假日酒店](http://oaf2qt3yk.bkt.clouddn.com/e7d31bd4fcfe761a74e217a8e7e9b07a.png)

![yinyian](http://oaf2qt3yk.bkt.clouddn.com/15856c7ae7e5f065630ba2d673495ce1.png)

![james](http://oaf2qt3yk.bkt.clouddn.com/bb3f2ecdbbd34e663ea4e8fd07b20882.png)

![substitutions](http://oaf2qt3yk.bkt.clouddn.com/18eaee1d9c2c9c48cd0895ba502d06a4.png)

![dashun](http://oaf2qt3yk.bkt.clouddn.com/d65fa3234c4acc2d6ff49a6a8e492260.png)

![dashun2](http://oaf2qt3yk.bkt.clouddn.com/1636c0143f9fd911f1407c92ba936b44.png)

# 浮光掠影

![戚家牛杂](http://oaf2qt3yk.bkt.clouddn.com/05ec192dccf36de80f11b36ccc7fc38d.png)

参加了夜游长城的活动。
