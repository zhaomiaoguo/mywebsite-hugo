---
title: "Markdown名称中有字母才会显示"
date: 2010-01-10
---

我今天又将博客改回原来的设置，结果上传的900多个模板都没有显示出来，我后来突然想起来，原来html的地址才是最重要的。

一般而言，一个post的物理地址：chengjun.github.io / _posts / 2010-01-01.md， 经过试验，这并不会被显示。只有当010-01-01.md被修改为010-01-01-test.md之后，才显示！居然是这样。好吧，以后写东西更方便了。呵呵。

## mathjax 设定

    <!--mathjax start-->
    <script type="text/x-mathjax-config">
     MathJax.Hub.Config({
       tex2jax: {
         inlineMath: [ ['$','$'], ["\\(","\\)"] ],
         processEscapes: true
       },
      TeX: {
         equationNumbers: { autoNumber: "AMS" }
      }
     });
    </script>
    <script type="text/javascript"
                src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
    </script>
    <!--mathjax end-->
