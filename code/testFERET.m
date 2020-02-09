% 清除环境变量
clear
clc

% dataset = 'Yale';
% dataset = 'ORL';
dataset = 'FERET';
classNum = 200;
% persons = 11;
% ratio = 2;
maxDim = 120;

% 加载Yale数据集
% path = ['./数据集/',dataset,'_64x64.mat'];
% path = ['./数据集/',dataset,'_32x32.mat'];
% load('.\数据集\FERET_80x80_col.mat');
% % load('.\数据集\FERET_32x32.mat')
% fea = double(FERET_80_80_col');
% load('.\数据集\FERET3\gnd');
% load('.\数据集\FERET3\trainIdx');
% load('.\数据集\FERET3\testIdx');

% 加载64x64数据集
load('.\数据集\FERET\fea');
load('.\数据集\FERET\gnd');
load('.\数据集\FERET\trainIdx');
load('.\数据集\FERET\testIdx');

for ratio=3:3
    acc = [];
    max_idx = [];
    for rept=1:1
        X_train = [];
        y_train = [];
        X_test = [];
        y_test = [];
%         splitPath = ['./数据集/',dataset,'/',num2str(ratio),'Train/',num2str(times)];
%         load(splitPath);
        for i=1:size(trainIdx,1)
            X_train = [X_train;fea(trainIdx(i),:)];
            y_train = [y_train;gnd(trainIdx(i))];
        end
        
        for i=1:size(testIdx,1)
            X_test = [X_test;fea(testIdx(i),:)];
            y_test = [y_test;gnd(testIdx(i))];
        end
        accuracy = [];
        for dim=1:maxDim
% %             测试LGSDP
%             options = [];
%             options.k = 10;
%             options.PCARatio = 120;
%             options.beta = 0.01;
%             options.t = 0.5;
%             options.ReducedDim = dim;
%             [eigvector] = LGSDP(X_train,y_train,options);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
    
            %             ILSDA
            %             PCA预处理
            options = [];
            options.ReducedDim = 120;
            [eigvector, eigvalue] = PCA(X_train, options);
            X_train = X_train*eigvector;
            X_test = X_test*eigvector;
            options = [];
            options.k = 20;
            options.alpha = 100;
            options.t = 1;
            [eigvector,~] = ILSDA(X_train',y_train',options);
            eigvector = eigvector(:,1:dim);
            X_train_ILSDA = X_train*eigvector;
            X_test_ILSDA = X_test*eigvector;
            accuracy(dim) = KNN(X_train_ILSDA,y_train,X_test_ILSDA,y_test,1);
% %             测试baseline
%             options = [];
%             accuracy(dim) = KNN(X_train,y_train,X_test,y_test,1);            

%             % LSDA
%             options = [];
%             options.k = ratio-1;
%             options.PCARatio = 40;
%             options.beta = 0.1;
%             options.ReducedDim = dim;
%             [eigvector, ~] = LSDA(y_train, options, X_train);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);

% %             测试SLSDA
%             options = [];
%             options.k = ratio;
%             options.PCARatio = 0.95;
%             options.beta = 0.1;
%             options.t = 1;
%             options.ReducedDim = dim;
%             [eigvector] = SLSDA(X_train,y_train,options);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);

% %             测试PCA
%             options = [];
%             options.ReducedDim = dim;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train_PCA = X_train*eigvector;
%             X_test_PCA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_PCA,y_train,X_test_PCA,y_test,1);

% %             测试LDA
%               options = [];
%               options.ReducedDim = 120;
%               [eigvector, eigvalue] = PCA(X_train, options);
%               X_train = X_train*eigvector;
%               X_test = X_test*eigvector;
%               reduceDim = dim;
%               if(dim>classNum-1)
%                   reduceDim  = classNum-1;
%               end
%               [eigvector] = myLDA(y_train, reduceDim, X_train);
%               X_train_lda = X_train*eigvector;
%               X_test_lda = X_test*eigvector; 
%               accuracy(dim) = KNN(X_train_lda,y_train,X_test_lda,y_test,1);
        end
        acc = [acc;accuracy];
%         [maxAcc_50, idx] = max(accuracy)
%         max_idx = [max_idx,maxAcc];
    end
    [maxAcc_50, idx] = max(acc)
%     acc_avg = mean(acc,1);
%     std_acc = std(acc,1);
%     acc_avg = repmat(acc_avg,1,40);
%     std_acc = repmat(std_acc,1,40);
%     path = [dataset,num2str(ratio),'_acc_1to50_32lsdpk10'];
%     save(path,'acc_avg','std_acc');
%     plot(1:maxDim,acc_avg);
    
%     [maxAcc, idx] = max(acc_avg);
    
end
