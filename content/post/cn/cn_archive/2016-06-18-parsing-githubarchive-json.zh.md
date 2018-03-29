---
title: "Parsing Githubarchive Data using Python"
---
<!--more-->

Githubarchive整理了github的历史数据，每一个小时一个数据文件，我下载了2011-2014年四年的数据，结果发现2012年的多数数据存在错误换行的问题，需要清洗。一般而言，正确的情况是一个字典格式的数据占一行，错误的情况就会是所有的字典格式的数据合并为了一行。似乎是缺乏换行符造成的。

http://stackoverflow.com/questions/10432432/yajl-parse-error-with-githubarchive-org-json-stream-in-python# 这里详细记录了这个问题。

按照这个帖子，我尝试了很多方法，yajl和ijson，但是都不能很优雅的解决我的问题。不妨采用暴力的方法。

rirwin利用了{和}出现的偶数关系来分割字符串，但是这种方法容易遗漏数据且速度较慢。

仔细思考这个问题就是：Parse multiple json objects that are in one line。 搜索之，发现了http://stackoverflow.com/questions/36967236/parse-multiple-json-objects-that-are-in-one-line

其中，Francesco的解决方法比较高效：

    f = '/Users/chengjun/百度云同步盘/githubarchive/2012-03-10-22.json.gz'
    f = gzip.open(f, 'rb')
    f = f.readline()
    r = re.split('(\{.*?\})(?= *\{)', f)
    accumulator = ''
    res = []
    for subs in r:
        accumulator += subs
        try:
            res.append(json.loads(accumulator))
            accumulator = ''
        except:
            pass
    len(res)

> Out [29]: 1270


基于这种方法，可以写一个函数来实现对于数据的正确读取。

    #f = '/Users/chengjun/百度云同步盘/test.json'
    #f = open(f)

    f = '/Users/chengjun/百度云同步盘/githubarchive/2012-06-01-15.json.gz'
    f = gzip.open(f, 'rb')
    files = f.readlines()
    length = len(files)
    if  length > 1:
        print 'Correct: ' + str(length)
    else:
        f2 = files[0]
        r = re.split('(\{.*?\})(?= *\{)', f2)
        r = [i for i in r if i] # delete the ''
        accumulator = ''
        acts = []
        for subs in r:
            accumulator += subs
            try:
                acts.append(json.loads(accumulator))
                accumulator = ''
            except Exception, e:
                print e
                pass
        print 'Wrong: ' + str(len(acts))

  > Out [30]: Wrong: 4491
