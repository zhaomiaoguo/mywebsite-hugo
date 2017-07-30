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



# 回到起点

2017年7月18日 09:19只有研读营才能做的事情；大家因为项目的压力，每一个人都想得是一个可以deliver的东西。

虫洞和weak tie有什么关联？boltzmann machine与社会计算？

ising model与图灵机：一个社会系统在做计算。


## Boltzmann Machine

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

## word2vec

https://www.tensorflow.org/tutorials/word2vec


The humans working behind the ai curtain



## experiment


McCombs, M; Shaw, D (1972). "The agenda-setting function of mass media". Public Opinion Quarterly. 36 (2): 176. doi:10.1086/267990.

hz2@princeton.edu


# The agenda-setting function of mass media

In choosing and displaying news, editors, newsroom staff, and broadcasters play an important part in shaping political reality. Readers learn not only about a given issue, but also how much importance to attach to that issue from the amount of information in a news story and its position. In reflecting what candidates are saying during a campaign, the mass media may well determine the important issues—that is, the media may set the “agenda” of the campaign.

# The Threshold of Public Attention

The analysis reviews time series data for the period 1945 to 1980 on media coverage and corresponding public attention to a set of ten political issues including poverty, racial problems, Watergate, and Vietnam. The study focuses on the early stages of public awareness and the need for a “critical mass” or threshold to move a matter from the status of private concern to a public, political issue. The pattern of evolving public awareness varies dramatically for different types of issues. In some cases, the public appears to have a much steeper “response function” in reacting to real-world cues than the media; in other cases, the media seem to be more responsive. Modeling the growth of attention to public issues with the logistic curve met with modest success. The article concludes with a call for much closer coordination between agenda-setting research and the study of political cognition.


# Social network thresholds in the diffusion of innovations

Threshold models have been postulated as one explanation for the success or failure of collective action and the diffusion of innovations. The present paper creates a social network threshold model of the diffusion of innovations based on the Ryan and Gross (1943) adopter categories: (1) early adopters; (2) early majority; (3) late majority; (4) laggards. This new model uses social networks as a basis for adopter categorization, instead of solely relying on the system-level analysis used previously. The present paper argues that these four adopter categories can be created either with respect to the entire social system, or with respect to an individual's personal network. This dual typology is used to analyze three diffusion datasets to show how external influence and opinion leadership channel the diffusion of innovations. Network thresholds can be used (1) to vary the definition of behavioral contagion, (2) to predict the pattern of diffusion of innovations, and (3) to identify opinion leaders and followers in order to understand the two-step flow hypothesis better.


# Diffusion of Innovations and Policy Decision-Making

This article presents a general mathematical model of the diffusion of innovations, which incorporates mass media and interpersonal influence. The model is applied to three classic diffusion data sets: (a) use of hybrid corn, (b) knowledge of Eisenhower's stroke, and (c) doctors’prescription of a new drug. Nonlinear regression is used to estimate the mathematical model. The results show that diffusion of hybrid corn occurred via interpersonal influence, whereas the diffusion of knowledge of Eisenhower's stroke occurred via the mass media. For the diffusion of the new drug, the model shows that doctors who subscribed to few medical journals learned about the drug primarily through interpersonal influence, while doctors who subscribed to many medical journals learned about the drug through both mass media and interpersonal channels. Policy decision-makers can use diffusion models to (a) evaluate the effectiveness of media versus interpersonal campaigns, (b) make comparisons between subgroups, and (c) evaluate the effect of a policy.
