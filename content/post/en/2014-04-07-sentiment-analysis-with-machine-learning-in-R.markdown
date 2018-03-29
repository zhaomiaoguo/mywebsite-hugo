---
title: "Sentiment analysis with machine learning in R"
---

In [an earlier post](http://chengjun.github.io/en/2012/03/sentiment-analysi-with-python/), I tried to reproduce the sentiment analysis using machine learning in Python. Here, I will introduce how to do it in the framework of R.

In the landscape of R, both sentiment analysis package and the general text mining package of machine learning have been well developed by [Timothy P. Jurka](https://github.com/timjurka). You can check out the[ sentiment package](https://github.com/timjurka/sentiment) and the fantastic [RTextTools package](https://github.com/timjurka/RTextTools). Actually, Timothy also writes [an maxent package](https://github.com/timjurka/maxent) for low-memory multinomial logistic regression (also known as maximum entropy).

![](https://www.gravatar.com/avatar/92b11d2b562de1d82bf134c80b4ee925?s=128&d=identicon&r=PG)



 <p style="text-align:center"> Timothy P. Jurka </p>

However, the naive bayes method is not included into RTextTools. Maybe the reason is it's too easy to make it in R, since the e1071 package did a good job. e1071 seems to be a course of the Department of Statistics (e1071), TU Wien. Its primary developer is [David Meyer](http://www.technikum-wien.at/fh/institute/wirtschaftsinformatik/team/meyer/).

![](http://ih1.redbubble.net/image.9785413.8464/fig,royal_blue,mens,ffffff.jpg)

Text analysis in R has been well recognized (see [the R views on natural language processing](http://cran.r-project.org/web/views/NaturalLanguageProcessing.html)). Part of the success belongs to the [tm package](http://cran.r-project.org/web/packages/tm/index.html): A framework for text mining applications within R. It did a good job for text cleaning (stemming, delete the stopwords, etc) and transforming texts to document-term matrix (dtm). There is [one paper](http://www.jstatsoft.org/v25/i05/paper) about it. As you know the most important part of text analysis is to get the feature vectors for each document. The word feature is the most important one. Of course, you can also extend the **unigram** word features to **bigram** and **trigram**, and so on to **n-grams**. However, here for our simple case, we stick to the unigram word features.

Note, it's easy to use ngrams in R. In the past, the package of Rweka supplies functions to do it ([check this example](http://stackoverflow.com/questions/8161167/what-algorithm-i-need-to-find-n-grams)). Now, you can set the `ngramLength` in the function of create_matrix using RTextTools.

The first step is to read data:

	###########################################
	"Sentiment analysis with machine learning"
	##########################################
	library(RTextTools)
	library(e1071)

	pos_tweets =  rbind(
	  c('I love this car', 'positive'),
	  c('This view is amazing', 'positive'),
	  c('I feel great this morning', 'positive'),
	  c('I am so excited about the concert', 'positive'),
	  c('He is my best friend', 'positive')
	)


	neg_tweets = rbind(
	  c('I do not like this car', 'negative'),
	  c('This view is horrible', 'negative'),
	  c('I feel tired this morning', 'negative'),
	  c('I am not looking forward to the concert', 'negative'),
	  c('He is my enemy', 'negative')
	)


	test_tweets = rbind(
	  c('feel happy this morning', 'positive'),
	  c('larry friend', 'positive'),
	  c('not like that man', 'negative'),
	  c('house not great', 'negative'),
	  c('your song annoying', 'negative')
	)

	tweets = rbind(pos_tweets, neg_tweets, test_tweets)


Then we can build the document-term matrix:

	# build dtm
	matrix= create_matrix(tweets[,1], language="english",
	                      removeStopwords=FALSE, removeNumbers=TRUE,  # we can also removeSparseTerms
	                      stemWords=FALSE)

Now, we can train the naive Bayes model with the training set. Note that, e1071 asks the response variable to be numeric or factor. Thus, we convert characters to factors here. This is a little trick.

	# train the model
	mat = as.matrix(matrix)
	classifier = naiveBayes(mat[1:10,], as.factor(tweets[1:10,2]) )

Now we can step further to test the accuracy.

	# test the validity
	predicted = predict(classifier, mat[11:15,]); predicted
	table(tweets[11:15, 2], predicted)
	recall_accuracy(tweets[11:15, 2], predicted)
    > 0.8

Apparently, the result is the same with Python (compare it with the results in [an earlier post](http://chengjun.github.io/en/2012/03/sentiment-analysi-with-python/)).

How about the other machine learning methods? As I mentioned, we can do it using RTextTools. Let's rock!

First, to specify our data:

	# build the data to specify response variable, training set, testing set.
	container = create_container(matrix, as.numeric(as.factor(tweets[,2])),
	                             trainSize=1:10, testSize=11:15,virgin=FALSE)

Second, to train the model with multiple machine learning algorithms:

	models = train_models(container, algorithms=c("MAXENT" , "SVM", "RF", "BAGGING", "TREE"))

Now, we can classify the testing set using the trained models.

	results = classify_models(container, models)

How about the accuracy?

	# accuracy table
	table(as.numeric(as.factor(tweets[11:15, 2])), results[,"FORESTS_LABEL"])
	table(as.numeric(as.factor(tweets[11:15, 2])), results[,"MAXENTROPY_LABEL"])

	# recall accuracy
	recall_accuracy(as.numeric(as.factor(tweets[11:15, 2])), results[,"FORESTS_LABEL"])
	recall_accuracy(as.numeric(as.factor(tweets[11:15, 2])), results[,"MAXENTROPY_LABEL"])
	recall_accuracy(as.numeric(as.factor(tweets[11:15, 2])), results[,"TREE_LABEL"])
	recall_accuracy(as.numeric(as.factor(tweets[11:15, 2])), results[,"BAGGING_LABEL"])
	recall_accuracy(as.numeric(as.factor(tweets[11:15, 2])), results[,"SVM_LABEL"])

To summarize the results (especially the validity) in a formal way:

	# model summary
	analytics = create_analytics(container, results)
	summary(analytics)
	head(analytics@document_summary)
	analytics@ensemble_summary

To cross validate the results:

	N=4
	set.seed(2014)
	cross_validate(container,N,"MAXENT")
	cross_validate(container,N,"TREE")
	cross_validate(container,N,"SVM")
	cross_validate(container,N,"RF")

The results can be found on [my Rpub page](http://rpubs.com/chengjun/sentiment). It seems that maxent reached the same recall accuracy as naive Bayes. The other methods even did a worse job. This is understandable, since we have only a very small data set. To enlarge the training set, we can get a much better results for sentiment analysis of tweets using more sophisticated methods. I will show the results with anther example.


### Sentiment analysis for tweets

The data comes from [https://github.com/victorneo/Twitter-Sentimental-Analysis](https://github.com/victorneo/Twitter-Sentimental-Analysis). victorneo shows how to do sentiment analysis for tweets using Python. Here, I will demonstrate how to do it in R.

![](https://www.volacci.com/files/imce-uploads/twitter-SEO.jpg)


Read data:

	###################
	"load data"
	###################
	setwd("D:/Twitter-Sentimental-Analysis-master/")
	happy = readLines("./happy.txt")
	sad = readLines("./sad.txt")
	happy_test = readLines("./happy_test.txt")
	sad_test = readLines("./sad_test.txt")

	tweet = c(happy, sad)
	tweet_test= c(happy_test, sad_test)
	tweet_all = c(tweet, tweet_test)
	sentiment = c(rep("happy", length(happy) ),
	              rep("sad", length(sad)))
	sentiment_test = c(rep("happy", length(happy_test) ),
	                   rep("sad", length(sad_test)))
	sentiment_all = as.factor(c(sentiment, sentiment_test))


	library(RTextTools)

First, try naive Bayes.

	# naive bayes
	mat= create_matrix(tweet_all, language="english",
	                   removeStopwords=FALSE, removeNumbers=TRUE,
	                        stemWords=FALSE, tm::weightTfIdf)

	mat = as.matrix(mat)

	classifier = naiveBayes(mat[1:160,], as.factor(sentiment_all[1:160]))
	predicted = predict(classifier, mat[161:180,]); predicted

	table(sentiment_test, predicted)
	recall_accuracy(sentiment_test, predicted)
	> 0.65

Then, try the other methods:

	# the other methods
	mat= create_matrix(tweet_all, language="english",
	                   removeStopwords=FALSE, removeNumbers=TRUE,
	                   stemWords=FALSE, tm::weightTfIdf)

	container = create_container(mat, as.numeric(sentiment_all),
	                              trainSize=1:160, testSize=161:180,virgin=FALSE) #可以设置removeSparseTerms

	models = train_models(container, algorithms=c("MAXENT",
	                                              "SVM",
	                                               #"GLMNET", "BOOSTING",
	                                               "SLDA","BAGGING",
	                                              "RF", # "NNET",
	                                              "TREE"
	                                               ))

	# test the model
	results = classify_models(container, models)

	table(as.numeric(as.numeric(sentiment_all[161:180])), results[,"FORESTS_LABEL"])
	>
    	  1  2
       1 10  0
       2  1  9

	recall_accuracy(as.numeric(as.numeric(sentiment_all[161:180])), results[,"FORESTS_LABEL"])
	> 0.95

Here we also want to get the formal test results, including:

- **analytics@algorithm_summary**: SUMMARY OF PRECISION, RECALL, F-SCORES, AND ACCURACY SORTED BY TOPIC CODE FOR EACH ALGORITHM

- **analytics@label_summary**: SUMMARY OF LABEL (e.g. TOPIC) ACCURACY

- **analytics@document_summary**: RAW SUMMARY OF ALL DATA AND SCORING

- **analytics@ensemble_summary**: SUMMARY OF ENSEMBLE PRECISION/COVERAGE. USES THE n VARIABLE PASSED INTO create_analytics()


Now let's see the results:


	# formal tests
	analytics = create_analytics(container, results)
	summary(analytics)

	head(analytics@algorithm_summary)
	head(analytics@label_summary)
	head(analytics@document_summary)
	analytics@ensemble_summary # Ensemble Agreement


	# Cross Validation
	N=3
	cross_SVM = cross_validate(container,N,"SVM")
	cross_GLMNET = cross_validate(container,N,"GLMNET")
	cross_MAXENT = cross_validate(container,N,"MAXENT")

![](https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRug6OmP3_ewf_UUj1nng90QiZbjcMeZoXNnU-RBXHRaCsmr8yREw)


You can find that compared with naive Bayes, the other algorithms did a much better job to achieve a recall accuracy higher than 0.95. Check [the results on Rpub](http://rpubs.com/chengjun/tweets_sentiment_analysis).
