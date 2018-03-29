---
title: "东风夜放花千树：对宋词进行主题分析初探"
date: 2013-09-27
---
<!--more-->

![](http://forum.eedu.org.cn/upload/2008/02/27/90815055.jpg)


邱怡轩在统计之都中展示了对宋词进行的分析（参见http://cos.name/tag/%E5%AE%8B%E8%AF%8D/），因为当时缺乏中文分词的工具，他独辟蹊径，假设宋词中任意两个相邻的汉字构成一个词语，进而找到了宋词当中的高频词。本文则尝试使用他所提供的宋词语料（http://cos.name/wp-content/uploads/2011/03/SongPoem.tar.gz），分析一下使用R进行中文分词、构建词云、高频词语聚类以及主题模型分析。

首先要载入使用的R包并读入数据。

	library(Rwordseg)
	require(rJava)
	library(tm)
	library(slam)
	library(topicmodels)
	library(wordcloud)
	library(igraph)
	setwd("D:/github/text mining/song") # 更改为你的工作路径，并存放数据在此。
	txt=read.csv("SongPoem.csv",colClasses="character")
{:lang="ruby"}

然后进行对数据的操作。当然，第一步是进行中文分词，主要使用Rwordseg这个R包，其分词效果不错。分词的过程可以自动去掉标点符号。

	poem_words <- lapply(1:length(txt$Sentence), function(i) segmentCN(txt$Sentence[i], nature = TRUE))
{:lang="ruby"}

然后，我们将数据通过tm这个R包转化为文本-词矩阵（DocumentTermMatrix）。
	wordcorpus <- Corpus(VectorSource(poem_words), encoding = "UTF-8") # 组成语料库格式

	Sys.setlocale(locale="Chinese")
	dtm1 <- DocumentTermMatrix(wordcorpus,
	                          control = list(
	                            wordLengths=c(1, Inf), # to allow long words
	                            bounds = list(global = c(5,Inf)), # each term appears in at least 5 docs
	                            removeNumbers = TRUE,
	                            # removePunctuation  = list(preserve_intra_word_dashes = FALSE),
	                            weighting = weightTf,
	                            encoding = "UTF-8")
	)

	colnames(dtm1)
	findFreqTerms(dtm1, 1000) # 看一下高频词
{:lang="ruby"}

这里需要注意的是，这里我们默认词语的长度为1到无穷大，稍后，我们可以对其长度进行修改。例如，本文中，作者对改为长度为2以上以及长度为3以上，分别得到另外两个文本-词矩阵：dtm2和dtm3。随后，我们可以在文本-词矩阵进行一系列的分析。这里，先做一个简单的词云分析。为更好展示效果，最多只列出100个词。

	m <- as.matrix(dtm1)
	v <- sort(colSums(m), decreasing=TRUE)
	myNames <- names(v)
	d <- data.frame(word=myNames, freq=v)
	par(mar = rep(2, 4))

	png(paste(getwd(), "/wordcloud50_",  ".png", sep = ''),
	    width=10, height=10,
	    units="in", res=700)

	pal2 <- brewer.pal(8,"Dark2")
	wordcloud(d$word,d$freq, scale=c(5,.2), min.freq=mean(d$freq),
	          max.words=100, random.order=FALSE, rot.per=.15, colors=pal2)
	dev.off()
{:lang="ruby"}

我们可以看一下效果，如下图所示，主要是一个字长度的词。最多的是“人”和“不”， 然后是“春”和“花”。

![](http://farm6.staticflickr.com/5480/9953518693_004590d6e3_z.jpg)

但我们也许对长度大于2的词以及长度大于3的词更感兴趣（同时这样也可以和邱怡轩做的结果做一下比较）。使用前面步骤中生成的dtm2重复构建词云的R程序，我们可以得到以下两个词云：

![](http://farm3.staticflickr.com/2821/9953413634_9a0d9020f7_z.jpg)

同样，对dtm3构建词云，效果如下：

![](http://farm8.staticflickr.com/7442/9953417766_8e6f160461_z.jpg)

以上结果和邱怡轩得到的结果类似，可见对高频词的处理方面，他的方法的确有创见。对词云分析之后，我们还可以尝试根据词与词之间共同出现的概率对词进行聚类。这里我们展示长度大于2的词的聚类结果。

	dtm01 <- weightTfIdf(dtm2)
	N = 0.9
	dtm02 <- removeSparseTerms(dtm01, N);dtm02
	# 注意，为展示方便，这里我调节N的大小，使得dtm02中的词语数量在50左右。
	tdm = as.TermDocumentMatrix(dtm02)
	tdm <- weightTfIdf(tdm)
	# convert the sparse term-document matrix to a standard data frame
	mydata.df <- as.data.frame(inspect(tdm))
	mydata.df.scale <- scale(mydata.df)
	d <- dist(mydata.df.scale, method = "euclidean") # distance matrix
	fit <- hclust(d, method="ward")

	png(paste("d:/chengjun/honglou/honglou_termcluster_50_", ".png", sep = ''),
	    width=10, height=10,
	    units="in", res=700)
	plot(fit) # display dendogram?
	dev.off()
{:lang="ruby"}

对长度大于2的词的聚类结果如下图所示，可见宋词的确注重“风流倜傥”，连分类都和风向有关系。

![](http://farm3.staticflickr.com/2875/9953397625_abdc6e9874_z.jpg)

当然读者还可以尝试对长度大于1词和长度大于3的词聚类，对长度大于1词聚类的效果图如下所示：

![](http://farm6.staticflickr.com/5548/9953397345_05a8944455_z.jpg)

长度大于3的词聚类结果如下：

![](http://farm8.staticflickr.com/7375/9953419256_f80a00e9e8_z.jpg)

完成这一步之后，作者还尝试对宋词进行简单的主题模型分析，首先还是从长度大于2的词开始吧。第一步是确定主题的数量。先对文本-词矩阵进行简单处理，以消除高频词被高估和低频词被低估的问题。

	dtm = dtm2
	term_tfidf <-tapply(dtm$v/row_sums(dtm)[dtm$i], dtm$j, mean) * log2(nDocs(dtm)/col_sums(dtm > 0))
	l1=term_tfidf >= quantile(term_tfidf, 0.5)       # second quantile, ie. median
	dtm <- dtm[,l1]
	dtm = dtm[row_sums(dtm)>0, ]; dim(dtm) # 2246 6210
	summary(col_sums(dtm))
{:lang="ruby"}

之后就可以正式地开始确定主题数量的R程序了。这里，笔者主要参考了朱雪宁《微博名人那些事儿》一文中的R程序（http://cos.name/2013/08/something_about_weibo/）。

	fold_num = 10
	kv_num =  c(5, 10*c(1:5, 10))
	seed_num = 2003
	try_num = 1

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
	    for (i in 1:try_num)  #only run for 3 replications#
	    {
	      cat("R is running for", "topic", k, "fold", i,
	          as.character(as.POSIXlt(Sys.time(), "Asia/Shanghai")),"\n")
	      te=sp[[i]]
	      tr=setdiff(1:dtm$nrow, te) # setdiff(nrow(dtm),te)  ## fix here when restart r session

	      # VEM = LDA(dtm[tr, ], k = k, control = list(seed = SEED)),
	      # VEM_fixed = LDA(dtm[tr,], k = k, control = list(estimate.alpha = FALSE, seed = SEED)),

	      #       CTM = CTM(dtm[tr,], k = k,
	      #                 control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3)))  
	      #       
	      Gibbs = LDA(dtm[tr,], k = k, method = "Gibbs",
	                  control = list(seed = SEED, burnin = 1000,thin = 100, iter = 1000))

	      per=c(per,perplexity(Gibbs,newdata=dtm[te,]))
	      loglik=c(loglik,logLik(Gibbs,newdata=dtm[te,]))
	    }
	    per_ctm=rbind(per_ctm,per)
	    log_ctm=rbind(log_ctm,loglik)
	  }
	  return(list(perplex=per_ctm,loglik=log_ctm))
	}

	sp=smp(n=dtm$nrow, seed=seed_num) # n = nrow(dtm)

	system.time((ctmK=selectK(dtm=dtm,kv=kv_num,SEED=seed_num,cross=fold_num,sp=sp)))

	## plot the perplexity

	m_per=apply(ctmK[[1]],1,mean)
	m_log=apply(ctmK[[2]],1,mean)

	k=c(kv_num)
	df = ctmK[[1]]  # perplexity matrix
	logLik = ctmK[[2]]  # perplexity matrix


	write.csv(data.frame(k, df, logLik), paste(getwd(), "/Perplexity2_","gibbs5_100", ".csv", sep = ""))

	# save the figure
	png(paste(getwd(), "/Perplexity2_",try_num, "_gibbs5_100",".png", sep = ''),
	    width=5, height=5,
	    units="in", res=700)


	matplot(k, df, type = c("b"), xlab = "Number of topics",
	        ylab = "Perplexity", pch=1:try_num,col = 1, main = '')       
	legend("topright", legend = paste("fold", 1:try_num), col=1, pch=1:try_num)

	dev.off()

	png(paste(getwd(), "/LogLikelihood2_", "gibbs5_100",".png", sep = ''),
	    width=5, height=5,
	    units="in", res=700)
	matplot(k, logLik, type = c("b"), xlab = "Number of topics",
	        ylab = "Log-Likelihood", pch=1:try_num,col = 1, main = '')       
	legend("topright", legend = paste("fold", 1:try_num), col=1, pch=1:try_num)
	dev.off()
{:lang="ruby"}

于是可以得到对数似然率和主题数量的关系图，如下所示。可见选择10作为主题数量是比较合适的。

![](http://farm4.staticflickr.com/3727/9953452316_6518296960.jpg)

以下，我们将主要对主题数量为10的主题模型进行估计。topicmodels这个R包是由Bettina Grun和
Johannes Kepler两个人贡献的，目前支持VEM, VEM (fixed alpha)，Gibbs和CTM四种主题模型，关于其详细介绍，可以阅读他们的论文，关于主题模型的更多背景知识可以阅读Blei的相关文章。闲话少叙，看一下R代码：

	# 'Refer to http://cos.name/2013/08/something_about_weibo/'
	k = 10
	SEED <- 2003
	jss_TM2 <- list(
	  VEM = LDA(dtm, k = k, control = list(seed = SEED)),
	  VEM_fixed = LDA(dtm, k = k, control = list(estimate.alpha = FALSE, seed = SEED)),
	  Gibbs = LDA(dtm, k = k, method = "Gibbs",
	              control = list(seed = SEED, burnin = 1000, thin = 100, iter = 1000)),
	  CTM = CTM(dtm, k = k,
	            control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3))) )   
	save(jss_TM2, file = paste(getwd(), "/jss_TM2.Rdata", sep = ""))
	save(jss_TM, file = paste(getwd(), "/jss_TM1.Rdata", sep = ""))

	termsForSave1<- terms(jss_TM2[["VEM"]], 10)
	termsForSave2<- terms(jss_TM2[["VEM_fixed"]], 10)
	termsForSave3<- terms(jss_TM2[["Gibbs"]], 10)
	termsForSave4<- terms(jss_TM2[["CTM"]], 10)

	write.csv(as.data.frame(t(termsForSave1)),
	          paste(getwd(), "/topic-document_", "_VEM_", k, "_2.csv", sep=""),
	          fileEncoding = "UTF-8")

	write.csv(as.data.frame(t(termsForSave2)),
	          paste(getwd(), "/topic-document_", "_VEM_fixed_", k, "_2.csv", sep=""),
	          fileEncoding = "UTF-8")

	write.csv(as.data.frame(t(termsForSave3)),
	          paste(getwd(), "/topic-document_", "_Gibbs_", k, "_2.csv", sep=""),
	          fileEncoding = "UTF-8")
	write.csv(as.data.frame(t(termsForSave4)),
	          paste(getwd(), "/topic-document_", "_CTM_", k, "_2.csv", sep=""),
	          fileEncoding = "UTF-8")
{:lang="ruby"}

对主题模型进行估计之后，一般选择展示每个主题的前10个词语。因为主题之间可以共享相同词语，所以构成网络关系，因此这里我选择用网络的方法展示其结果。首先看一下吉布斯抽样算法得到的主题网络图，其R程序如下：

	#'topic graphs'


	tfs = as.data.frame(termsForSave3, stringsAsFactors = F); tfs[,1]
	adjacent_list = lapply(1:10, function(i) embed(tfs[,i], 2)[, 2:1])
	edgelist = as.data.frame(do.call(rbind, adjacent_list), stringsAsFactors =F)
	# topic = unlist(lapply(1:10, function(i) rep(i, 9)))
	edgelist$topic = topic
	g <-graph.data.frame(edgelist,directed=T )
	l<-layout.fruchterman.reingold(g)
	# edge.color="black"
	nodesize = centralization.degree(g)$res
	V(g)$size = log( centralization.degree(g)$res )

	nodeLabel = V(g)$name
	E(g)$color =  unlist(lapply(sample(colors()[26:137], 10), function(i) rep(i, 9))); unique(E(g)$color)

	# 保存图片格式
	png(  paste(getwd(), "/topic_graph_gibbs.png", sep=""）,
	    width=5, height=5,
	    units="in", res=700)

	plot(g, vertex.label= nodeLabel,  edge.curved=TRUE,
	     vertex.label.cex =0.5,  edge.arrow.size=0.2, layout=l )

	# 结束保存图片
	dev.off()
{:lang="ruby"}

得到的图形如下：

![](http://farm8.staticflickr.com/7330/9953452256_fb1baaa16d_c.jpg)

当然，我们还可以看一下其他算法得到的网络图，这里我们看一下根据VEM和CTM两个主题模型得到的网络图。

CTM模型的主题网络图：

![](http://farm8.staticflickr.com/7425/9953448564_d24b8e348a_c.jpg)

VEM模型的主题网络图：

![](http://farm4.staticflickr.com/3727/9953448704_ec8291a0e3_c.jpg)
