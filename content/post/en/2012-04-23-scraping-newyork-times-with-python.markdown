---
layout: post
title: "Scraping New York Times & The Guardian using Python"
comments: true
categories:
- python
tags:
- news media
---

I have read the blog post about Scraping New York Times Articles with R. It’s great. I want to reproduce the work with python.
First, we should learn about nytimes article search api.

[http://developer.nytimes.com/docs/article_search_api/](http://developer.nytimes.com/docs/article_search_api/)

Second, we need to register and get the key which will be used in python script.

[http://developer.nytimes.com/apps/register](http://developer.nytimes.com/apps/register)

	# !/usr/bin/env python
	# -*- coding: UTF-8  -*-
	# Scraping New York Times using python
	# 20120421@ Canberra
	# chengjun wang

	import json
	import urllib2

	'''
	About the api and the key, see the links above.
	'''

	'''step 1: input query information'''
	apiUrl='http://api.nytimes.com/svc/search/v1/article?format=json'
	query='query=occupy+wall+street'                            # set the query word here
	apiDate='begin_date=20110901&end_date=20120214'             # set the date here
	fields='fields=body%2Curl%2Ctitle%2Cdate%2Cdes_facet%2Cdesk_facet%2Cbyline'
	offset='offset=0'
	key='api-key=c2c5b91680.......2811165'  # input your key here

	'''step 2: get the number of offset/pages'''
	link=[apiUrl, query, apiDate, fields, offset, key]
	ReqUrl='&'.join(link)
	jstr = urllib2.urlopen(ReqUrl).read()  # t = jstr.strip('()')
	ts = json.loads( jstr )
	number=ts['total'] #  the number of queries  # query=ts['tokens'] # result=ts['results']
	print number
	seq=range(number/9)  # this is not a good way
	print seq

	'''step 3: crawl the data and dump into csv'''
	import csv
	addressForSavingData= "D:/Research/Dropbox/tweets/wapor_assessing online opinion/News coverage of ows/nyt.csv"
	file = open(addressForSavingData,'wb') # save to csv file
	for i in seq:
	    nums=str(i)
	    offsets=''.join(['offset=', nums]) # I made error here, and print is a good way to test
	    links=[apiUrl, query, apiDate, fields, offsets, key]
	    ReqUrls='&'.join(links)
	    print "*_____________*", ReqUrls
	    jstrs = urllib2.urlopen(ReqUrls).read()
	    t = jstrs.strip('()')
	    tss= json.loads( t )  # error no joson object
	    result = tss['results']
	    for ob in result:
	        title=ob['title']  # body=ob['body']   # body,url,title,date,des_facet,desk_facet,byline
	        print title
	        url=ob['url']
	        date=ob['date'] # desk_facet=ob['desk_facet']  # byline=ob['byline'] # some author names don't exist
	        w = csv.writer(file,delimiter=',',quotechar='|', quoting=csv.QUOTE_MINIMAL)
	        w.writerow((date, title, url)) # write it out
	file.close()
	pass


see the result:

![](http://weblab.com.cityu.edu.hk/blog/chengjun/files/2012/04/nyt1.png)

Similarly, you can crawl the article data from The Guardian. See the link below.

[http://explorer.content.guardianapis.com/#/?format=json&order-by=newest](http://explorer.content.guardianapis.com/#/?format=json&order-by=newest)

After you have registered you app and got the key, we can work on the python script.


	# !/usr/bin/env python
	# -*- coding: UTF-8 -*-
	# Scraping The Guardian using Python
	# 20120421@ Canberra
	# chengjun wang

	import json
	import urllib2

	'''

	http://content.guardianapis.com/search?q=occupy+wall+street&from-date=2011-09-01&to-date=2012-02-14&page=2

	&page-size=3&format=json&show-fields=all&use-date=newspaper-edition&api-key=m....g33gzq
	'''

	'''step 1: input query information'''
	apiUrl='http://content.guardianapis.com/search?q=occupy+wall+street' # set the query word here
	apiDate='from-date=2011-09-01&to-date=2011-10-14'           # set the date here
	apiPage='page=2'   # set the page
	apiNum=10       # set the number of articles in one page
	apiPageSize=''.join(['page-size=',str(apiNum)])
	fields='format=json&show-fields=all&use-date=newspaper-edition'
	key='api-key=mudfuj...g33gzq' # input your key here

	'''step 2: get the number of offset/pages'''
	link=[apiUrl, apiDate, apiPage, apiPageSize, fields, key]
	ReqUrl='&'.join(link)
	jstr = urllib2.urlopen(ReqUrl).read() # t = jstr.strip('()')
	ts = json.loads( jstr )
	number=ts['response']['total'] # the number of queries # query=ts['tokens'] # result=ts['results']
	print number
	seq=range(number/(apiNum-1)) # this is not a good way
	print seq

	'''step 3: crawl the data and dump into csv'''
	import csv
	addressForSavingData= "D:/Research/Dropbox/tweets/wapor_assessing online opinion/News coverage of ows/guardian.csv"
	file = open(addressForSavingData,'wb') # save to csv file
	for i in seq:
		nums=str(i+1)
		apiPages=''.join(['page=', nums]) # I made error here, and print is a good way to test
		links= [apiUrl, apiDate, apiPages, apiPageSize, fields, key]
		ReqUrls='&'.join(links)
		print "*_____________*", ReqUrls
		jstrs = urllib2.urlopen(ReqUrls).read()
		t = jstrs.strip('()')
		tss= json.loads( t )
		result = tss['response']['results']
		for ob in result:
			title=ob['webTitle'].encode('utf-8') # body=ob['body']  # body,url,title,date,des_facet,desk_facet,byline
			print title
			section=ob["sectionName"].encode('utf-8')
			url=ob['webUrl']
			date=ob['fields']['newspaperEditionDate'] # date=ob['webPublicationDate'] # byline=ob['fields']['byline']
			w = csv.writer(file,delimiter=',',quotechar='|', quoting=csv.QUOTE_MINIMAL)
			w.writerow((date, title, section, url)) # write it out
	file.close()
	pass
