---
title: "使用Python快速分割数据的方法"
date: 2014-08-31
---

<!--more-->


![](http://chengjun.qiniudn.com/longcat.PNG)

分割数据最慢的过程其实是打开和关闭一个文件，因此尽量减少这种操作可以飞速的提升分割数据的速度。之前在[stackoverflow上看到一种方法](http://stackoverflow.com/questions/519633/lazy-method-for-reading-big-file-in-python?lq=1)非常高效，放在这里研究一下。

     from collections import defaultdict

     path = 'D:/chengjun/Sina Weibo/DepthOverTime/'

     #define a function
     def splitData(f):
         #using dict to 'classify' rows
         E = defaultdict(lambda:[])
         for line in f:
             lists = line.strip().split(',')
             rtmid = lists[0]
             file_save = path + 'single_weibo/'+rtmid
             E[file_save].append(line)
         for key in E.keys():
             try:
                 with open(key,'a') as p:
                     for record in E[key]:
                         p.write(record+"\n")
             except:
                 pass
     # start to read in data by chunks
     bigfile = open(path + 'diffusion_path_date2552.csv')
     chunkSize = 100000000
     chunk = bigfile.readlines(chunkSize)
     while chunk:
         splitData(chunk)
         chunk = bigfile.readlines(chunkSize)

 上面这段代码有两个地方导致非常高效：

 1. 使用dict来将相同的key的行整理到一起， 以便一次将吞进来的某一个key下面的数据全部写入硬盘
 2. 每次使用readlines读入足够多的行，充分发挥内存的作用
