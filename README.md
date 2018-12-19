# LSDP代码结构  
2018-10月论文SubspaceLearning代码说明  
## 1. 代码结构：  
> testTemp.m为最终的测试文件，测试各个算法在ORL、Yale、FERET上的准确率  
> drawCurve.m为绘制准确率关于降维维数曲线的文件，实验中绘制的是ORL数据集上超参数 $\alpha=0.1,0.05,0.001,0.0001$ 时的准确率VS降维维数曲线  
> 


---
# 常用知识快速查找
## 1. 快速创建github远程仓库
> 在github网站上，Repositories->New，新建项目；  
> 在本地文件夹中，git clone ...，将远程仓库克隆到本地； 
> 克隆之后直接在本地文件夹中修改、更新即可；  
> [参考博客](https://www.jianshu.com/p/7f8c80056233)

## 2. Markdown常用语法  
> 数学符号及公式：类似Latex语法，```$x^2$```用于“内嵌型”公式，```$$a+b$$```用于“显示型”公式，```\(x^2\)```用于靠左模式  
\\(\alpha\\)，$$a+b$$，$x^2$  
> 参考博客：  
> [1] [chrome浏览器安装MathJax插件，可支持github上的公式](https://chrome.google.com/webstore/detail/mathjax-plugin-for-github/ioemnmodlmafdkllaclgeombjnmnbima)  
> [2] https://www.zhihu.com/question/26887527   
> [3] https://github.com/xiahouzuoxin/notes/blob/master/essays/Markdown%E4%B8%AD%E6%8F%92%E5%85%A5%E6%95%B0%E5%AD%A6%E5%85%AC%E5%BC%8F%E7%9A%84%E6%96%B9%E6%B3%95.md  
> [4] http://cwiki.apachecn.org/pages/viewpage.action?pageId=8159393  
> 换行：在一行结尾添加两个空格;  
> 分割线：连续三个***、---、___  
***
> 标题：一级(#)、二级(##)、...、六级（######）；  
> 访问链接：```[文字](网址)```；  
> 引用：一级(>)、二级(>>)，可嵌套引用；  
> 无序列表：*、+、-；  
> 有序列表：1.、2.、...；  
> 列表状态：
```- [ ] 不勾选、- [x] 勾选```  
- [ ] 不勾选  
- [x] 勾选  
> 内联图片：
```![Alt text](./picture/xyjy.jpg)```  
![Alt text](./picture/xyjy.jpg)  

> 代码：三个顿号括起来的区域  
```
%% matlab代码
% 清除环境变量
clear all
clc

% 显示图片
I = imread('happy.jpg');
imshow(I);
```  
> [参考博客](https://coding.net/help/doc/project/markdown.html)  

