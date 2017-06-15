---
layout: post
title: "Sentiment analysis with Python"
comments: true
categories:
- python
tags:
- sentiment analysis
- nltk
---

Learning To Do Sentiment Analysis Using Python & NLTK

This is my first try to learn sentiment analysis using python. You can find the original post by Laurent Luce [following this link](http://www.laurentluce.com/posts/twitter-sentiment-analysis-using-python-and-nltk/).

I am glad to know that, with the aid of naive Bayes, NLTK could distinguish ‘like’ and ‘does not like’ into 'positive' and 'negative' respectively. I am wondering how R behaves compared with it. The method below employed the procedures depicted in the following figure.

![original author: Laurent Luce](http://weblab.com.cityu.edu.hk/blog/chengjun/files/2012/03/overview-of-sentiment-analysis-using-nltk.png)

Figure created by [Laurent Luce](http://www.laurentluce.com/posts/twitter-sentiment-analysis-using-python-and-nltk/)

Load in the data first.

	# Python script
	import nltk

	pos_tweets = [('I love this car', 'positive'),
		('This view is amazing', 'positive'),
		('I feel great this morning', 'positive'),
		('I am so excited about the concert', 'positive'),
		('He is my best friend', 'positive')]

	neg_tweets = [('I do not like this car', 'negative'),
		('This view is horrible', 'negative'),
		('I feel tired this morning', 'negative'),
		('I am not looking forward to the concert', 'negative'),
		('He is my enemy', 'negative')]

	tweets = []
	for (words, sentiment) in pos_tweets + neg_tweets:
		words_filtered = [e.lower() for e in words.split() if len(e) >= 3]
		tweets.append((words_filtered, sentiment))

	test_tweets = [
		(['feel', 'happy', 'this', 'morning'], 'positive'),
		(['larry', 'friend'], 'positive'),
		(['not', 'like', 'that', 'man'], 'negative'),
		(['house', 'not', 'great'], 'negative'),
		(['your', 'song', 'annoying'], 'negative')]

Then we need to get the unique word list as the features for classification.

	# get the word lists of tweets
	def get_words_in_tweets(tweets):
		all_words = []
		for (words, sentiment) in tweets:
			all_words.extend(words)
		return all_words

	# get the unique word from the word list
	def get_word_features(wordlist):
		wordlist = nltk.FreqDist(wordlist)
		word_features = wordlist.keys()
		return word_features

	word_features = get_word_features(get_words_in_tweets(tweets))


To create a classifier, we need to decide what features are relevant. To do that, we first need a feature extractor.

	def extract_features(document):
	    document_words = set(document)
	    features = {}
	    for word in word_features:
	      features['contains(%s)' % word] = (word in document_words)
	    return features

Then, we can build up the training set and create the classifier:

	training_set = nltk.classify.util.apply_features(extract_features, tweets)

	classifier = nltk.NaiveBayesClassifier.train(training_set)

You may want to know how to define the 'train' method in NLTK here:

	def train(labeled_featuresets, estimator=nltk.probability.ELEProbDist):
	    # Create the P(label) distribution
	    label_probdist = estimator(label_freqdist)
	    # Create the P(fval|label, fname) distribution
	    feature_probdist = {}
	    return NaiveBayesClassifier(label_probdist, feature_probdist)

Now, we can use the naive bayes method to train the data. Have a look:

	tweet_positive = 'Larry is my friend'
	tweet_negative = 'Larry is not my friend'

	print classifier.classify(extract_features(tweet_positive.split()))
	# > positive
	print classifier.classify(extract_features(tweet_negative.split()))
	# > negative

Don't be too positive, let's try another example:

	tweet_negative2 = 'Your song is annoying'
	print classifier.classify(extract_features(tweet_negative2.split()))

Now, we will classify the test_tweets and calculate the recall accuracy.

	def classify_tweet(tweet):
	    return \
	        classifier.classify(extract_features(tweet)) # nltk.word_tokenize(tweet)

	total = accuracy = float(len(test_tweets))

	for tweet in test_tweets:
	    if classify_tweet(tweet[0]) != tweet[1]:
	        accuracy -= 1

	print('Total accuracy: %f%% (%d/20).' % (accuracy / total * 100, accuracy))
    # 0.8

Of course, this is only the starting point. In the future, I will use the same data set, to so [how to do it in R](http://chengjun.github.io/en/2014/04/sentiment-analysis-with-machine-learning-in-R/) using naive Bayes and beyond.
