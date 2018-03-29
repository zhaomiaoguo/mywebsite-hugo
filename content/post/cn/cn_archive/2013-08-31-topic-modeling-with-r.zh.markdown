---
title: "使用R做主题模型：词语筛选和主题数量确定"
date: 2013-08-31
---
<!--more-->

## 1. 筛选单词

在数据清理（pre-processing）之后，需要对数据进行适当筛选。对数据的筛选包括至少两个步骤：

第一步，在DocumentTermMatrix中设定

使用R的topicmodels发现设定在DocumentTermMatrix里的约束条件失效，解决方法[在此](http://stackoverflow.com/questions/13366897/r-documenttermmatrix-control-list-not-working)，其实在topicmodels的包里也粗略提及，只是用习惯了tm包的人觉得二者是无缝对接的。其实还很多差异，比如在tm里相似功能称之为TermDocumentMatrix

	dtm <- DocumentTermMatrix(corpus, control = list(stemming = TRUE,  
	                                                 stopwords = TRUE,
	                                                 wordLengths=c(4, 15),
	                                                 bounds = list(global = c(5,Inf)), # each term appears in at least 5 docs
	                                                 removeNumbers = TRUE,
	                                                 removePunctuation  = list(preserve_intra_word_dashes = FALSE)
	                                                 #,encoding = "UTF-8"
	                                                 )
	                         )


	colnames(dtm)   ##  inspect all the words for errors
	dim(dtm)
{:lang="ruby"}

第二步，通过tf-idf和col_sums选择高频词

这背后的逻辑在于主题模型是要对文本进行分类，频次较少的词的贡献并不大。但会显著的占用计算资源。

	term_tfidf <-tapply(dtm$v/row_sums(dtm)[dtm$i], dtm$j, mean) * log2(nDocs(dtm)/col_sums(dtm > 0))

	l1=term_tfidf >= quantile(term_tfidf, 0.1)       # fix this!
	dtm <- dtm[,l1]
	l2=col_sums(dtm) >= quantile(col_sums(dtm), 0.1)  # fix this!
	dtm <- dtm[,l2]

	dtm = dtm[row_sums(dtm)>0, ]; dim(dtm) # 2246 6210
	range(col_sums(dtm))
{:lang="ruby"}

## 2. 确定主题数量
在对单个词进行筛选之后，就可以正式进行主题模型的设定了。这是一步非常耗时间的工作，但第一步当然是理解主题模型的基本思路。

主题模型是在概率潜在语义分析（probabilistic latent semanticanalysis，PLSI）的基础上发展起来的。从对矩阵进行因子分解的角度而言，可以看做是对离散数据进行主成分分析。其具体内容可以参见Blei发表在Communication of ACM上的[文献回顾文章](http://cacm.acm.org/magazines/2012/4/147361-probabilistic-topic-models/fulltext)（Blei(2012) Probalistic topic models. Communication of ACM, 55, 77-84）。

简而言之，我们看到是单词在文本中的分布。1. 我们认为在单词和文本之间存在潜在的主题，并且每个主题$$β_{1:K}$$可以表达为一些词语在这个文本里的分布；2. 一篇文章可能对应多个主题，假设我们已经知道了存在哪些主题，那么一个主题在一个文本中的比例$$θ_{d:k}$$也应该知道；3. 我们将主题和词语对应起来，建立一个映射$$z_{d:n}$$，这样我们就知道把文章d中的第n个词赋给哪个主题；4.但实际上前三步都是不能直接观察到的，之间看到的就是词语在文本中的分布$$w_{d:n}$$ ，例如文本d当中第n个词语是什么，即词在文本中的分布。

前三个隐变量和第四个先变量之间的联合分布（joint distribution）就是主题生成的过程，这个过程还可以使用概率图模型的方法进行建模。如下图所示：

![](http://farm4.staticflickr.com/3756/9634040055_1bdc1c8013.jpg)


其主要逻辑是机器学习的思路：给定了可以观察到的词语在文本中的分布$$w_{d:n}$$，主题结构可以表达为一个条件分布：$$p(\beta _{1:K},\theta _{1:D},z_{1:D} \mid w_{1:D})$$。这是后验分布的分析思路。因为可能的主题结构太多，这个后验分布无法计算出来，而主题模型的主要目的也只是逼近这个后验分布。

通常逼近这个后验分布的方法可以分为两类：1. 变异算法（variational algorithms）,这是一种决定论式的方法。变异式算法假设一些参数分布，并根据这些理想中的分布与后验的数据相比较，并从中找到最接近的。由此，将一个估计问题转化为最优化问题。最主要的算法是变异式的期望最大化算法(variational expectation-maximization，VEM)。这个方法是最主要使用的方法。在R软件的tomicmodels包中被重点使用。 2. 基于抽样的算法。抽样的算法，如吉布斯抽样（gibbs sampling）主要是构造一个马尔科夫链，从后验的实证的分布中抽取一些样本，以之估计后验分布。吉布斯抽样的方法在R软件的lda包中广泛使用。

常用的主题模型是LDA, 可以使用VEM和gibbs两种方法估计。之后的模型的发展，主要是要放松严格的模型假设，其中之一是允许主题之间存在相关。由此Blei等人提出了相关的主题模型（correalted topic model，CTM），可以使用VEM方法估计。在本文当中，我们采用CTM为例。


	fold_num = 10
	kv_num = c(5, 10*c(1:5, 10))
	seed_num = 2003


	smp<-function(cross=fold_num,n,seed)
	{
	  set.seed(seed)
	  dd=list()
	  aa0=sample(rep(1:cross,ceiling(n/cross))[1:n],n)
	  for (i in 1:cross) dd[[i]]=(1:n)[aa0==i]
	  return(dd)
	}

	selectK<-function(dtm,kv=kv_num,SEED=seed_num,cross=fold_num,sp) # change 60 to 15
	{
	  per_ctm=NULL
	  log_ctm=NULL
	  for (k in kv)
	  {
	    per=NULL
	    loglik=NULL
	    for (i in 1:3)  #only run for 3 replications#
	    {
	      cat("R is running for", "topic", k, "fold", i,
	          as.character(as.POSIXlt(Sys.time(), "Asia/Shanghai")),"\n")
	      te=sp[[i]]
	      tr=setdiff(1:nrow(dtm),te)

	      # VEM = LDA(dtm[tr, ], k = k, control = list(seed = SEED)),
	      # VEM_fixed = LDA(dtm[tr,], k = k, control = list(estimate.alpha = FALSE, seed = SEED)),

	      CTM = CTM(dtm[tr,], k = k,
	                control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3)))  

	      # Gibbs = LDA(dtm[tr,], k = k, method = "Gibbs",
	      # control = list(seed = SEED, burnin = 1000,thin = 100, iter = 1000))

	      per=c(per,perplexity(CTM,newdata=dtm[te,]))
	      loglik=c(loglik,logLik(CTM,newdata=dtm[te,]))
	    }
	    per_ctm=rbind(per_ctm,per)
	    log_ctm=rbind(log_ctm,loglik)
	  }
	  return(list(perplex=per_ctm,loglik=log_ctm))
	}

	sp=smp(n=nrow(dtm),seed=seed_num)

	system.time((ctmK=selectK(dtm=dtm,kv=kv_num,SEED=seed_num,cross=fold_num,sp=sp)))

	## plot the perplexity

	m_per=apply(ctmK[[1]],1,mean)
	m_log=apply(ctmK[[2]],1,mean)

	k=c(kv_num)
	df = ctmK[[1]]  # perplexity matrix
	matplot(k, df, type = c("b"), xlab = "Number of topics",
	        ylab = "Perplexity", pch=1:5,col = 1, main = '')       
	legend("bottomright", legend = paste("fold", 1:5), col=1, pch=1:5)
{:lang="ruby"}

有趣的是计算时间：

	> system.time((ctmK=selectK(dtm=dtm,kv=kv_num,SEED=seed_num,cross=fold_num,sp=sp)))
	R is running for topic 5 fold 1 2013-08-31 18:26:32
	R is running for topic 5 fold 2 2013-08-31 18:26:39
	R is running for topic 5 fold 3 2013-08-31 18:26:45
	R is running for topic 10 fold 1 2013-08-31 18:26:50
	R is running for topic 10 fold 2 2013-08-31 18:27:14
	R is running for topic 10 fold 3 2013-08-31 18:27:36
	R is running for topic 20 fold 1 2013-08-31 18:27:57
	R is running for topic 20 fold 2 2013-08-31 18:29:42
	R is running for topic 20 fold 3 2013-08-31 18:32:00
	R is running for topic 30 fold 1 2013-08-31 18:33:42
	R is running for topic 30 fold 2 2013-08-31 18:37:39
	R is running for topic 30 fold 3 2013-08-31 18:45:46
	R is running for topic 40 fold 1 2013-08-31 18:52:52
	R is running for topic 40 fold 2 2013-08-31 18:57:26
	R is running for topic 40 fold 3 2013-08-31 19:00:31
	R is running for topic 50 fold 1 2013-08-31 19:03:47
	R is running for topic 50 fold 2 2013-08-31 19:04:02
	R is running for topic 50 fold 3 2013-08-31 19:04:52
	R is running for topic 100 fold 1 2013-08-31 19:05:42
	R is running for topic 100 fold 2 2013-08-31 19:06:05
	R is running for topic 100 fold 3 2013-08-31 19:06:28
	   user  system elapsed
	2417.801.13 2419.28
{:lang="ruby"}

看一下最终绘制的perplexity的图，如下可见，在本例当中，当主题数量为30的时候，perplexity最小，模型的最大似然率最高，由此确定主题数量为30。

![](http://farm8.staticflickr.com/7290/9633619385_13a1472d1b.jpg)
