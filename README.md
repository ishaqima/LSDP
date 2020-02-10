# Locality sensitive discriminant projection for feature extraction and face recognition  
2019-8月论文LSDP代码说明  
## 1. 代码结构：
> * LSDP代码实现为LGSDP.m文件；  
> * testTemp.m为最终的测试文件，测试各个算法在ORL、Yale、FERET上的准确率；  
> * drawCurve.m为绘制准确率关于降维维数曲线的文件，实验中绘制的是ORL数据集上超参数 $\alpha=0.1,0.05,0.001,0.0001$ 时的准确率vs降维维数曲线；  
> * showCurve.m显示不同算法的准确率vs降维维数曲线；  
> * showFERET.m为显示FERET数据集的图像；  
> * resizeFERET.m将FERET_80x80_col的数据缩放至64x64,保存到"./数据集/FERET/fea"文件中,$fea \in R^{200\times4096}$，每一行为一个样本；  
> * splitFERET.m将FERET数据集按照每一类样本前3个划分为训练集，每类的后4个划分为测试集；最终的结果以训练集下标数组$trainIdx \in R^{800}$，测试集下标数组$testIdx \in R^{600}$，样本标签数组$gnd \in R^{1400}$的形式保存在"./数据集/FERET4/"文件夹内；  

