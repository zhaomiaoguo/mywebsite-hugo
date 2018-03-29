---
title: "Social Entrepreneurs Worldwide: Visualization using WebGL Globe"
---


![](http://chengjun.qiniudn.com/ashoka-globe.PNG)
View it here [http://chengjun.github.io/globe/ashoka.html](http://chengjun.github.io/globe/ashoka.html)

####Social Entrepreneurs Worldwide
`Ashoka is the largest network of social entrepreneurs worldwide. Ashoka Fellows are leading social entrepreneurs who we recognize to have innovative solutions to social problems and the potential to change patterns across society. They demonstrate unrivaled commitment to bold new ideas and prove that compassion, creativity, and collaboration are tremendous forces for change. Ashoka Fellows work in over 70 countries around the globe in every area of human need.`

In this post, I would try to visualize its global distributions using [WebGL Globe](http://www.chromeexperiments.com/globe). `The WebGL Globe is an open platform for geographic data visualization.`

####Data Cleaning
First, I get the country frequency using the following R script:

      dat2 = read.csv("D:/Dropbox/Crystal_RA_Job/Ashoka Project/data/ashoka/ashoka_data_cleaningSep.csv",
                     header = F, sep = "|", quote = "", stringsAsFactors=F); dim(dat2)

      names(dat2) =  c('name', 'category', 'subsectors', 'targets', 'organization', 'location1',
      				'location2', 'profileIntro', 'year_fellowship', 'introduction', 'idea',
      				'problem', 'strategy', 'person', 'rnames', 'rorgs')    

      # country
      country = NULL
      for (i in 1:length(dat2$name)){
        country[[i]] = gsub( ", ", "", dat2$location1[i], fixed = T)
      }


      ids = which(nchar(country) > 30)
      for (i in ids){
        cat(dat2$name[i], country[i], '\n')
      }

      country[ids] = c('United States', 'Belgium', 'Czech Republic', 'Paraguay')

      data = data.frame(table(country))
      write.table(data, 'D:/Dropbox/Crystal_RA_Job/Ashoka Project/data/ashoka/ashoka_country.csv', sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)

Second, we can get the geolocation coordinates using Google's Geo API. In this post, I use the pygeocoder module of Python to fetch the geo information for countries.

     from pygeocoder import Geocoder
     import time
     import os

     # change work directory
     os.chdir('D:/Dropbox/Crystal_RA_Job/Ashoka Project/data/ashoka/')

     # read country data
     with open('./ashoka_country.csv') as f:
         location = {}
         for line in f:
             country, freq = line.strip().split('\t')
             location[country] = int(freq)

     maxFreq = max(location.values())    

     #get geo coordinates
     results = []    
     for i in location.keys():
         time.sleep(1)
         latitude, longtitude = Geocoder.geocode(i)[0].coordinates
         results.extend([latitude, longtitude, location[i]/maxFreq])

     # make json
     data = [["data",results]]

     # save json
     import json
     with open('./ashoka_locations.json', 'w') as outfile:
       json.dump(data, outfile)



####visualization
In this visualization, each pillar stands for one country. By the year of 2013, there are 2334 fellows from 76 countries. The top 3 countries are India (N = 303), Brazil (N = 286), and United States(N = 160).

Using python, we can sort the country frequency like this:

      sorted(location.items(), key=lambda x: x[1])

And here is the result:

     #[('Italy', 1), ('Netherlands', 1), ('Iceland', 1), ('Togo', 1), ('Saudi Arabia', 1),
     # ('Latvia', 1), ('Guinea-Bissau', 1), ('Mozambique', 1), ('Niger', 1), ('Botswana', 1),
     #('Hong Kong S.A.R.China', 1), ('Norway', 2), ('Singapore', 2), ('Denmark', 2),
     #('Morocco', 2), ('Japan', 2), ('Timor-Leste', 2), ('Austria', 2), ('Zambia', 2),
     # ('Afghanistan', 3), ('Sweden', 3), ('Nicaragua', 3), ('Cameroon', 4),
     #('Ivory Coast', 4), ('Lebanon', 5), ('Ghana', 5), ('Israel', 5), ('Guatemala', 5),
     # ('Belgium', 5), ('Switzerland', 5), ('El Salvador', 6), ('Gambia', 6),
     #('Tanzania', 6), ('Lithuania', 7), ('Palestinian Territory', 7), ('Jordan', 8),
     # ('Costa Rica', 10), ('Ireland', 10), ('Mali', 13), ('United Kingdom', 13),
     #('Zimbabwe', 13), ('Venezuela', 15), ('Paraguay', 16), ('Slovakia', 18),
     #('Sri Lanka', 18), ('Senegal', 20), ('Uganda', 20), ('Uruguay', 20),
     # ('Bolivia', 23), ('Kenya', 24), ('Turkey', 24), ('Spain', 25), ('Czech Republic', 26),
     # ('Hungary', 27), ('Burkina Faso', 28), ('Ecuador', 31), ('France', 33), ('Peru', 36),
     # ('Canada', 40), ('Germany', 40), ('Egypt', 40), ('Chile', 41), ('Nepal', 41),
     #('Pakistan', 45), ('Colombia', 50), ('Argentina', 53), ('Bangladesh', 61),
     #('Poland', 69), ('Nigeria', 70), ('Thailand', 88), ('South Africa', 94),
     #('Indonesia', 123), ('Mexico', 153), ('United States', 160), ('Brazil', 286), ('India', 303)]




 <iframe src='http://chengjun.github.io/globe/ashoka.html' scrolling="no" width="800" height = "600" allowfullscreen></iframe>
