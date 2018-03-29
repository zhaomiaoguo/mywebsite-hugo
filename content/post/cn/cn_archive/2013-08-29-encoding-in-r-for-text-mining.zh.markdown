---
title: "使用R做主题模型：举一个处理Encoding问题的例子"
date: 2013-08-29
---

<!--more-->

## 引言

### 遭遇“邪恶的拉丁引号”

我遇到的问题比较复杂，因为原文里混合了latin1和UTF-8两种encoding的字形，最初我统一再读入text数据的时候采用encoding ="UTF-8"的方法，结果发现了很多奇诡的单引号和双引号错误。在生成的DocumentTermMatrix里出现了很多以引号开始或结束的terms，例如：“grandfather， “deputy with the constitution” 。用Encoding命令看一下它的原形是：

	> Encoding("“")
	[1] "latin1"


只所以说是原形，是因为它们可以变形！"â€œ"， "â€™"， "â€\u009d"， "â€"都是它在不设定Encoding的环境下的形状。但我觉得不足以刻画我对它的厌恶，特别附图一张：

![](http://farm6.staticflickr.com/5521/9621347348_c9b66db982_o.png)

直到最后，我也没彻底搞定这些邪恶的拉丁引号，但我使用了一些tricks解决的我的问题。

![](http://farm4.staticflickr.com/3703/9618226049_b87d57c266.jpg)

## 1. 读入数据不设定encoding！

因为邪恶的拉丁引号在UTF-8格式下根本就无法对付，在不设encoding方法的时候，它们现身为â€“, â€™, â€œ等形式，还可以对付。

	dat1 = read.csv("D:/chengjun/Crystal/Schwab_data_cleaningSep.csv",
	               header = F, sep = "|", quote = "", stringsAsFactors=F,
			   fileEncoding = "") # , encoding ="UTF-8"); dim(dat1)

	names(dat1) = c('name', 'organization', 'year', 'country', 'website',
			       'shortIntro', 'focus', 'geo', 'model', 'benefit', 'budget',
				 'revenue', 'recognization', 'background',
				 'innovation', 'entrepreneur')


## 2. 文本数据清理第一步：载入R包，选取变量

	library(tm)
	library(topicmodels)

	text = dat1$entrepreneur


## 3. 终于可以删除部分邪恶的拉丁引号

	text = gsub(".", " ", text, fixed = TRUE )
	text = gsub("!", " ", text, fixed = TRUE )
	text = gsub("?", " ", text, fixed = TRUE )
	text = gsub("â€œ", " ", text, fixed = TRUE )
	text = gsub("â€™", " ", text, fixed = TRUE )
	text = gsub("â€\u009d", " ", text, fixed = TRUE )
	text = gsub("â€", " ", text,  fixed = TRUE )
	text = gsub("</b>", " ", text,  fixed = TRUE )
	text = gsub("<b>", " ", text,  fixed = TRUE )

注意：1. 这些不规则的latin表达在r的script里再次打开会改变。所以，每次使用都要来这个网页里粘贴复制，也算是一种state-of-art，markdown都比R script保存的持久啊。2.使用gsub的代价是corpus被再度转化为character。所以这段代码如放在下面使用还要用Corpus命令再度转回来。

	corpus <- Corpus(   VectorSource( text )  )  # corpus[[1]] ## inspect the first corpus
	# make each letter lowercase
	corpus <- tm_map(corpus, tolower)


## 4. 我这里根据研究需要，要剔除人名、地名、组织名。

	# remove generic and custom stopwords
	human_find_special_cases = c("Fundação Pró-Cerrado", "Fundação PróCerrado", "FundaÃ§Ã£o PrÃ³-Cerrado")
	my_stopwords <- c(dat1$country,
			      dat1$organization,
				dat1$name,
				human_find_special_cases)

	my_stopwords <- Corpus(   VectorSource(my_stopwords)  )
	my_stopwords <- tm_map(my_stopwords, tolower) # to lowercase my_stopwords here

	# Finally we can delete the country/org/person names
	corpus <- tm_map(corpus, removeWords, my_stopwords); corpus[[1]]

	corpus <- tm_map(corpus, removePunctuation)


## 5. 将语料转化为DocumentTermMatrix

	# install.packages("SnowballC")
	Sys.setlocale("LC_COLLATE", "C") # set this for reproducible results

	corpus <- Corpus(   VectorSource( corpus )  )  # corpus[[1]] ## inspect the first corpus


另外，到这里还是会有孤立的邪恶的拉丁单引号存在，但已经和其它term分开了，在以下DocumentTermMatrix的通过设置minWordLength = 3可以将其完全清理。

	# corpus = tm_map(corpus, function(x) iconv(enc2utf8(x), sub = "byte")) # very important to convert encoding
	JSS_dtm <- DocumentTermMatrix(corpus, control = list(stemming = TRUE,  stopwords = TRUE,
									     minWordLength = 3, removeNumbers = TRUE,
									     removePunctuation = TRUE
									     # weighting =
	                                         	 #	function(x)
	                                        	 #	weightTfIdf(x, normalize =FALSE),
	                                     ,encoding = "UTF-8"
	                               )  )

	findFreqTerms(JSS_dtm, lowfreq=0) # 一定要看一下还有没有错误。inspect all the words for errors


## 6. 你需要的一些背景知识

### 6.1 如何识别和转化encoding的类型?

	iconvlist() # 看一下玲琅满目的encoding方法
	iconv(x, from, to, sub=NA) # Convert Character Vector between Encodings

	## convert from Latin-2 to UTF-8: two of the glibc iconv variants.
	iconv(x, "ISO_8859-2", "UTF-8")
	iconv(x, "LATIN2", "UTF-8")

	## Both x below are in latin1 and will only display correctly in a
	## latin1 locale.
	(x <- "fa\xE7ile")
	charToRaw(xx <- iconv(x, "latin1", "UTF-8"))
	## in a UTF-8 locale, print(xx)

	iconv(x, "latin1", "ASCII")          #   NA
	iconv(x, "latin1", "ASCII", "?")     # "fa?ile"
	iconv(x, "latin1", "ASCII", "")      # "faile"
	iconv(x, "latin1", "ASCII", "byte")  # "fa<e7>ile"

	# Extracts from R help files
	(x <- c("Ekstr\xf8m", "J\xf6reskog", "bi\xdfchen Z\xfcrcher"))
	iconv(x, "latin1", "ASCII//TRANSLIT")
	iconv(x, "latin1", "ASCII", sub="byte")
	## End(Not run)


### 6.2 如何看DocumentTermMatrix的内容？
	inspect(JSS_dtm)
	colnames(JSS_dtm) # we can find that: [3206]   "works\u009d"    [3207]      "work\u009d"
	inspect(JSS_dtm[,3206])
	inspect(JSS_dtm[,"works\u009d"])


### 6.3 关于一些需要跳出的符号

	unlist(strsplit("a.b.c", "."))
	## [1] "" "" "" "" ""
	## Note that 'split' is a regexp!
	## If you really want to split on '.', use
	unlist(strsplit("a.b.c", "[.]"))
	## [1] "a" "b" "c"
	## or
	unlist(strsplit("a.b.c", ".", fixed = TRUE))


同理，gsub查找替换掉句点comma的时候也有类似的问题。我在使用python处理相邻多个段落的时候，直接使用了list的append的方法，导致两个自然段之间没有空格。这可要害苦我了。很多可以作为段落结尾的标点都要转化为空格。幸好老外写文章没有那么多问号和叹号结尾。

fixed = TRUE意味着要use exact matching.

	text1 = gsub("[.]", " ", text）
	text1 = gsub("[.]", " ", text, fixed = TRUE )
