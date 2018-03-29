---
title: "中国高校间的友谊网络：大学排名、地理位置和演化规律"
date: 2014-07-21
---
<!--more-->

许小可老师和我决定使用可视化的方法分析一下中国高校之间的友谊关系网络。我们是想通过这个图从一个侧面说明各个大学在社交网络上的影响力和关系：所以节点大小表示每个大学在该网络中的友谊关系数量，连边宽度表示节点之间的连接关系，节点颜色的不同可以表示节点的影响力大小（介度中心性指标）。

###数据清洗
现有数据有学校信息。我可以通过构建字典的方式来将user_id和学校信息（以最新的学校信息为主）剥离出来。使用这个字典可以计算学校人数的分布并挑选前一百的学校。然后根据user_id来match社交网络数据和学校数据，构建：university1---university2---date的数据形式。如果该行数据中的学校都在top100的名单中，则保留，否则不保留，这样可以构建所需要的学校和学校的随时间变化的网络，并采用考虑连边权重的贪婪算法来划分网络社团。

###数据分析

数据清洗之后，使用R软件进行数据分析，使用igraph包进行数据的可视化。代码如下：

    library(igraph)
    setwd("F:/xiaonei/")

    ################
    # all data
    ################
    data = read.table("./friends_university_top100_by_all.txt", header = FALSE,
                     sep = '\t', stringsAsFactors = FALSE)

    data = data[which(data[,3] >= mean(data[,3])*1.2), ]
    data = data[which(data[,1] != data[,2]),]
    g =graph.data.frame(data[,1:2],directed=FALSE )
    E(g)$weight = data[,3]
    E(g)$color = "lightgrey"
    # layout
    set.seed(34)   ## to make this reproducable
    l=layout.fruchterman.reingold(g)
    # size
    nodeSize = graph.strength(g)
    V(g)$size = (nodeSize - min(nodeSize))/(max(nodeSize) - min(nodeSize))*20
    centrality = betweenness(g)
    # colors
    colors = heat.colors(37)
    position = rank(-centrality, ties.method = "first")
    V(g)$color = colors[position]
    # width
    E(g)$width = (log(E(g)$weight)- 8)*1.5
    # label
    nodeLabel = V(g)$name
    V(g)$label.cex = log(centrality+1)/20 + 0.5
    V(g)$label.color = "black"
    # community detection
    fc = fastgreedy.community(g); sizes(fc)
    mfc = membership(fc)
    # plot
    drawFigure = function(g){
      plot(g, vertex.label= nodeLabel,  
           edge.curved = FALSE, vertex.frame.color="#FFFFFF",
           layout=l,mark.groups = by(seq_along(mfc), mfc, invisible) )
    }

    drawFigure(g)

    # save png
    png("./all_color.png",
        width=10, height=10,
        units="in", res=700)
    drawFigure(g)
    dev.off()


![](http://chengjun.qiniudn.com/all_color.png)

数据的可视化表明：

1. 学校间的友谊关系的建立取决于学校的排名 （排名越靠前的学校的网络中心性较高）
2. 同一个省的学校之间存在更多的友谊关系 （存在地理上的proximity）


还可以根据月份来可视化，看一下2006年一月的情况吧：

![](http://chengjun.qiniudn.com/month_color_%201.png)

使用R生成24个月的图片，使用[makeagif](http://makeagif.com/)生成GIF动态图片：

![](http://cdn.makeagif.com/media/8-07-2014/iuOvDr.gif)

显然：

- 最早加入这个社交网络的是北京的几所著名高校；
- 2006年4月才走出北京；
- 随后友谊关系开始在全国扩张；
- 扩张的过程围绕着那些著名高校为中心进行。


本文提供[汇总的数据](http://chengjun.qiniudn.com/friends_university_top100_by_all.txt)下载，供感兴趣的同学玩。
