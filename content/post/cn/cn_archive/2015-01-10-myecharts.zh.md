---
title: "Echarts使用简介"
date: 2015-01-10
---
<!--more-->

昨天听谈和讲解了echarts的使用，他的讲解非常直接简单，就是直接修改echarts的实例。之后，我发现林峰将echarts的实例的html代码写得非常复杂，但其实单独调用一个js的时候，却非常简单。具体做法如下：

- 准备工作：建立一个js子文件夹，将esl，echarts，pie，bar，map等各种js放入其中。在js文件夹外新建一个空的html文件。
- 首先，调用esl.js，它提供了echarts图片的载体。
- 其次，使用require方法调用echarts.js和具体使用的类型图的js（比如map.js）。
- 再次，输入需要输入的数据。
- 最后，封装。



            <!DCOTYPE html>
            <html>
            	<head>
            		<meta charset="utf-8">
            		<title>echarts testing page</title>
            		<script src="./js/esl.js"></script>
            		<script src="./js/echarts.js" type="text/javascript"></script>
            	</head>
            	<body>
            		<div id="main" style="height:400px;"></div>
            		<script type="text/javascript">
            			require.config({
            				paths:{
            					"echarts":"js/echarts",
            					"echarts/chart/map":"js/map"
            				}
            			});

            			//using
            			require(
            				[
            					"echarts",
            					"echarts/chart/map"
            				],
            				function(ec){
            					var myChart=ec.init(document.getElementById("main"));  
                                <!--Input your code below-->					

                                <!--Input your code above-->					
            			//loading data
            					myChart.setOption(option);
            				}
            			);
            		</script>
            	</body>
            </html>


##弦图
http://chengjun.github.io/myecharts/chord.html

<iframe src='http://chengjun.github.io/myecharts/chord.html' scrolling="no" width="600" height = "400"></iframe>

##柱状图
http://chengjun.github.io/myecharts/bar.html

<iframe src='http://chengjun.github.io/myecharts/bar.html' scrolling="no" width="600" height = "400"></iframe>

##饼图
http://chengjun.github.io/myecharts/pie1.html

<iframe src='http://chengjun.github.io/myecharts/pie1.html' scrolling="no" width="600" height = "400"></iframe>

##线图
http://chengjun.github.io/myecharts/line1.html

<iframe src='http://chengjun.github.io/myecharts/line1.html' scrolling="no" width="600" height = "400"></iframe>

##地图
http://chengjun.github.io/myecharts/map9.html

<iframe src='http://chengjun.github.io/myecharts/map9.html' scrolling="no" width="600" height = "400"></iframe>

##力图

http://chengjun.github.io/myecharts/force2

<iframe src='http://chengjun.github.io/myecharts/force2.html' scrolling="no" width="600" height = "400"></iframe>



##后记
发现chrome无法加载，再加入了以下代码后就可以使用了。可惜用了整整一个上午才更正这个问题。


            <script src="./js/echarts.js" type="text/javascript"></script>
