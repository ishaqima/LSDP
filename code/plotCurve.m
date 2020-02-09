% 清除环境
clear all;
clc;

% 样本个数
ratio = 4;

path = 'ORL';

% 绘制曲线图
path_pca = [path, num2str(ratio), '_acc_1to40_LSDP0.1p4.mat'];
alpha01 = load(path_pca,'acc_avg1');
path_lsda = [path,num2str(ratio),'_acc_1to40_LSDP0.05p4.mat'];
alpha005 = load(path_lsda,'acc_avg1');
path_mmc = [path,num2str(ratio),'_acc_1to40_LSDP0.01p4.mat'];
alpha001 = load(path_mmc,'acc_avg1');
path_lda = [path,num2str(ratio),'_acc_1to40_LSDP0.001p4.mat'];
alpha0001 = load(path_lda,'acc_avg1');


% 取结构体中的值
alpha01 = getfield(alpha01,'acc_avg1');
alpha005 = getfield(alpha005,'acc_avg1');
alpha001 = getfield(alpha001,'acc_avg1');
alpha0001 = getfield(alpha0001,'acc_avg1');

alpha01 = alpha01(10:40)*100;
alpha005 = alpha005(10:40)*100;
alpha001 = alpha001(10:40)*100;
alpha0001 = alpha0001(10:40)*100;

x = 10:40;
plot(x,alpha01,'-o',x,alpha005,'-*',x,alpha001,'-^',x,alpha0001,'-V');
xlabel('Dimensions');
ylabel('Accuracy rate(%)');
legend('\alpha=0.1','\alpha=0.05','\alpha=0.01','\alpha=0.001','Location','Best');


% % 显示图片
% load('./数据集/ORL_64x64.mat');
% faceW = 64; 
% faceH = 64; 
% numPerLine = 10; 
% ShowLine = 2; 
% 
% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
% 
% imagesc(Y);colormap(gray);

