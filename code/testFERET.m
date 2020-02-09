% �����������
clear
clc

% dataset = 'Yale';
% dataset = 'ORL';
dataset = 'FERET';
classNum = 200;
% persons = 11;
% ratio = 2;
maxDim = 120;

% ����Yale���ݼ�
% path = ['./���ݼ�/',dataset,'_64x64.mat'];
% path = ['./���ݼ�/',dataset,'_32x32.mat'];
% load('.\���ݼ�\FERET_80x80_col.mat');
% % load('.\���ݼ�\FERET_32x32.mat')
% fea = double(FERET_80_80_col');
% load('.\���ݼ�\FERET3\gnd');
% load('.\���ݼ�\FERET3\trainIdx');
% load('.\���ݼ�\FERET3\testIdx');

% ����64x64���ݼ�
load('.\���ݼ�\FERET\fea');
load('.\���ݼ�\FERET\gnd');
load('.\���ݼ�\FERET\trainIdx');
load('.\���ݼ�\FERET\testIdx');

for ratio=3:3
    acc = [];
    max_idx = [];
    for rept=1:1
        X_train = [];
        y_train = [];
        X_test = [];
        y_test = [];
%         splitPath = ['./���ݼ�/',dataset,'/',num2str(ratio),'Train/',num2str(times)];
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
% %             ����LGSDP
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
            %             PCAԤ����
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
% %             ����baseline
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

% %             ����SLSDA
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

% %             ����PCA
%             options = [];
%             options.ReducedDim = dim;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train_PCA = X_train*eigvector;
%             X_test_PCA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_PCA,y_train,X_test_PCA,y_test,1);

% %             ����LDA
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
