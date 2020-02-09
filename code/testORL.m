% 清除环境变量
clear
clc

dataset = 'Yale';
% dataset = 'ORL';
% dataset = 'FERET';
classNum = 15;
persons = 11;
% ratio = 2;
maxDim = 40;

% 加载数据集
% path = ['./数据集/',dataset,'_64x64.mat'];
path = ['./数据集/',dataset,'_32x32.mat'];


for ratio=5:5
    acc1 = [];
    acc2 = [];
    acc3 = [];
    acc = [];
    for times=6:16
        X_train = [];
        y_train = [];
        X_test = [];
        y_test = [];
        splitPath = ['./数据集/',dataset,'/',num2str(ratio),'Train/',num2str(times)];
        load(path);
        load(splitPath);
        for i=1:size(trainIdx,1)
            X_train = [X_train;fea(trainIdx(i),:)];
            y_train = [y_train;gnd(trainIdx(i))];
        end
        
        for i=1:size(testIdx,1)
            X_test = [X_test;fea(testIdx(i),:)];
            y_test = [y_test;gnd(testIdx(i))];
        end
        for dim=1:maxDim
%             LGSDP
%             PCA预处理，降至40维
            options = [];
            options.k = 5;
            options.PCARatio = 1;
            options.beta = 0.01;
            options.t = 1.1;
            options.ReducedDim = dim;
            [eigvector] = LGSDP(X_train,y_train,options);
            X_train_LGSDP = X_train*eigvector;
            X_test_LGSDP = X_test*eigvector;
            
% %             LSDA
%             options = [];
%             options.k = ratio-1;
%             options.PCARatio = 40;
%             options.beta = 500;
%             options.ReducedDim = dim;
%             [eigvector, ~] = LSDA(y_train, options, X_train);
%             X_train_LSDA = X_train*eigvector;
%             X_test_LSDA = X_test*eigvector;

% %             LDP
%             options = [];
%             options.k = ratio-1;
%             options.PCARatio = 40;
%             options.t = 1;
%             options.ReducedDim=dim;
%             [eigvector] = LDP(X_train,y_train,options);
%             X_train_LDP = X_train*eigvector;
%             X_test_LDP = X_test*eigvector;
            
%               %             测试PCA
%             options = [];
%             options.ReducedDim = dim;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train_PCA = X_train*eigvector;
%             X_test_PCA = X_test*eigvector;
% 
% %             测试LDA
%               options = [];
%               options.ReducedDim = 40;
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
% 
% %               测试MMC
%             ReducedDim = dim;
% %             PCA预处理
%             options = [];
%             options.ReducedDim = 40;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train = X_train*eigvector;
%             X_test = X_test*eigvector;
%             [eigvector] = MMC(y_train, ReducedDim, X_train);
%             X_train_MMC = X_train*eigvector;
%             X_test_MMC = X_test*eigvector;

%             accuracy1(dim) = KNN(X_train_PCA,y_train,X_test_PCA,y_test,1);
%             accuracy2(dim) = KNN(X_train_lda,y_train,X_test_lda,y_test,1);
%             accuracy3(dim) = KNN(X_train_MMC,y_train,X_test_MMC,y_test,1);
%             accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
              accuracy(dim) = KNN(X_train_LGSDP,y_train,X_test_LGSDP,y_test,1);
        end
%         acc1 = [acc1;accuracy1];
%         acc2 = [acc2;accuracy2];
%         acc3 = [acc3;accuracy3];
         acc = [acc;accuracy];
    end
%     acc_avg1 = mean(acc1,1);
%     std_acc1 = std(acc1,1);
%     acc_avg2 = mean(acc2,1);
%     std_acc2 = std(acc2,1);
%     acc_avg3 = mean(acc3,1);
%     std_acc3 = std(acc3,1);
    acc_avg = mean(acc,1);
    std_acc = std(acc,1);
%     path1 = [dataset,num2str(ratio),'_acc_1to40_32pca'];
%     save(path1,'acc_avg1','std_acc1');
%     path2 = [dataset,num2str(ratio),'_acc_1to40_32lda'];
%     save(path2,'acc_avg2','std_acc2');
%     path3 = [dataset,num2str(ratio),'_acc_1to40_32mmc'];
%     save(path3,'acc_avg3','std_acc3');
    path3 = [dataset,num2str(ratio),'_acc_1to40_32lgsdp'];
    save(path3,'acc_avg','std_acc');
    plot(1:maxDim,acc_avg);
    legend('LGSDP','Location','Best');
%     
%     [maxAcc1, idx1] = max(acc_avg1)
%     [maxAcc2, idx2] = max(acc_avg2)
%     [maxAcc3, idx3] = max(acc_avg3)
    [maxAcc3, idx3] = max(acc_avg)
    
end
