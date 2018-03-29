---
title: "文本挖掘基础：使用openNLP进行词性标注"
date: 2013-09-07
---
<!--more-->

![](http://upload.wikimedia.org/wikipedia/en/thumb/6/62/LF_OpenNLP_Parser.jpg/800px-LF_OpenNLP_Parser.jpg)

使用R软件进行自然语言处理（文本挖掘）是比较方便的。其中一个比较基础的分析是采用part-of-speech tagging的思路进行词性标注。在本文中，我将简单地介绍使用R软件及其子包openNLP进行词性标注。这里的测试语料依然是英文，采用的算法主要是最大熵的方法。

openNLP的发展开始回归到底层的基本功能，之前搭建起来的比较方便实用的函数被取消了，比如tagPOS命令消失了。所以，需要自己来重新写这个方程。这也不太难，根据R文档对Maxent_POS_Tag_Annotator的介绍中的例子重新组合一下，就可以得到。

动词和名词的使用在文本挖掘中异常重要，单纯的名词语料可以用于进一步的文本挖掘，如我要做的是采用它们继续做主题挖掘（topic modeling）。

第一步，当然是重组这个tagPOS命令。

	library(openNLP)
	library(tm)
	require(NLP)

	# Compose the tagPOS function
	tagPOS <-  function(text.var, pos_tag_annotator, ...) {
	  s <- as.String(text.var)  
	  ## Set up the POS annotator if missing (for parallel)
	  PTA <- Maxent_POS_Tag_Annotator()
	  ## Need sentence and word token annotations.
	  word_token_annotator <- Maxent_Word_Token_Annotator()
	  a2 <- Annotation(1L, "sentence", 1L, nchar(s))
	  a2 <- annotate(s, word_token_annotator, a2)
	  a3 <- annotate(s, PTA, a2)
	  ## Determine the distribution of POS tags for word tokens.
	  a3w <- a3[a3$type == "word"]
	  pos_tag <- unlist(lapply(a3w$features, "[[", "POS"))
	  ## Extract token/POS pairs (all of them): easy.
	  pos_term <- list(term = s[a3w], tag = pos_tag)
	  return (pos_term)
	}
{:lang="ruby"}

第二步，为了保留文本序列，这里还需要一个函数。

	# run tagPOS function for a list of texts
	# do so to facilitate the conversion to generate corpus for topic modeling
	run_pos = function(n){
	  cat("R is running for part-of-speech tagging", n,
	      as.character(as.POSIXlt(Sys.time(), "Asia/Shanghai")), sep = "\n")
	  df = tagPOS(text[n])
	  nn = (df$term[which(df$tag == "NN")])
	  vb = (df$term[which(df$tag == "VB")])
	  nnvb = (c(nn, vb))
	  result = list(nn, vb, nnvb)
	  return(result)
	}
{:lang="ruby"}

第三步，开始测试结果（这里用一个很短的语料），并将其转化为三个tm下的Corpus。

	# test with a simple collection of text
	text <- c("I like it.", "This is outstanding soup!",  
	          "I really must get the recipe.")

	# run the functions
	df = lapply(c(1:3), run_pos)

	data = data.frame(do.call(rbind, df))
	names(data) = c("nn", "vb", "nnvb")

	# make three corpus of nouns, verbs, and both of them
	corpus_nn <- Corpus(   VectorSource( data$nn )  )  
	corpus_vb <- Corpus(   VectorSource( data$vb )  )  
	corpus_nnvb <- Corpus(   VectorSource( data$nnvb )  )   
{:lang="ruby"}
