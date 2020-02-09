% �������
clear all;
clc;

% ��������
ratio = 5;

path = 'ORL_L';
% path = 'Yale_L';

% ��������ͼ
path_pca = [path, num2str(ratio), '_acc_1to45_pca'];
pca = load(path_pca,'acc');
path_mmc = [path,num2str(ratio),'_acc_1to45_mmc'];
mmc = load(path_mmc,'acc');
path_mfa = [path,num2str(ratio),'_acc_1to45_mfa'];
mfa = load(path_mfa,'acc');
lda = [path,num2str(ratio),'_acc_1to45_lda'];
lda = load(lda,'acc');

wlda = [path,num2str(ratio),'_acc_1to45_wlda'];
wlda = load(wlda,'acc');

% ȡ�ṹ���е�ֵ
Yale_pca = getfield(pca,'acc');
Yale_mmc = getfield(mmc,'acc');
Yale_mfa = getfield(mfa,'acc');
lda = getfield(lda,'acc');

wlda = getfield(wlda,'acc');

x = 1:45;
plot(x,Yale_pca,x,Yale_mmc,x,Yale_mfa,x,lda,x,wlda);
xlabel('ά��');
ylabel('׼ȷ��');
legend('PCA','MMC','MFA','LDA','WLDA','Location','Best');

[Y_pca,I_pca] = max(Yale_pca)
[Y_mmc,I_mmc] = max(Yale_mmc)
[Y_mfa,I_mfa] = max(Yale_mfa)
[Y_lda,I_lda] = max(lda)

[Y_wlda,I_wlda] = max(wlda)

% % ��ʾͼƬ
% load('./���ݼ�/Yale_32x32.mat');
% faceW = 32; 
% faceH = 32; 
% numPerLine = 11; 
% ShowLine = 7; 
% 
% Y = zeros(faceH*ShowLine,faceW*numPerLine); 
% for i=0:ShowLine-1 
%   	for j=0:numPerLine-1 
%     	Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]); 
%   	end 
% end 
% 
% imagesc(Y);colormap(gray);

