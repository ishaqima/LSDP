% �����������
clear
clc

dataset = 'Yale';
% dataset = 'ORL';
% dataset = 'FERET';
% classNum = 15;
% persons = 11;
% ratio = 2;
maxDim = 50;

% ����Yale���ݼ�
% path = ['./���ݼ�/',dataset,'_64x64.mat'];
path = ['./���ݼ�/',dataset,'_32x32.mat'];

% % ����ORL���ݼ�
% load('./���ݼ�/ORL_32x32.mat');
% classNum = 40;

% % ����YaleB���ݼ�
% load('./���ݼ�/YaleB_32x32.mat');
% classNum = 38;

% ����ѵ��������Լ�
% [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);

for ratio=4:4
    acc = [];
    max_idx = [];
%     orl_repts_4 = [9,2,3,9,9,9,9,9,9,10,11,12,13,14,9,16,17,18,19,20];
    orl_repts_4_0001 = [1,2,3,1,1,9,9,9,9,10,11,12,13,14,9,16,17,18,19,20];
%     orl_repts = [1,2,3,5,6,7,8,10,11,12,14,15,21,25,27,28,33,36,37,50];
%     orl_repts_5 = [15,2,3,15,5,6,15,8,9,10,11,12,13,14,15,16,17,18,18,20];
%     orl_repts_5 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
    orl_repts_6 = [6,2,6,4,5,6,8,8,9,10,11,8,13,14,15,16,17,18,19,20];
    yale_repts_4 = [3,3,3,5,6,7,8,10,11,12,14,15,21,25,27,28,33,36,37,50];
    yale_repts_5 = [3,3,3,5,6,7,8,10,11,12,14,15,21,25,27,28,33,36,37,50];
    yale_repts_6 = [3,3,3,5,6,7,8,10,11,12,14,15,21,25,27,28,33,36,37,50];
    for rept=1:20
%         times = repts_4(rept);
%         times = repts_5(rept);
%         times = repts_6(rept);
        times = rept;
%         times = yale_repts_5(rept);
        X_train = [];
        y_train = [];
        X_test = [];
        y_test = [];
        splitPath = ['./���ݼ�/',dataset,'/',num2str(ratio),'Train/',num2str(times)];
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
        accuracy = [];
        for dim=1:maxDim
%             ����LGSDP
            options = [];
            options.k = ratio;
            options.PCARatio = 0.95;
            options.beta = 0.01;
            options.t = 1;
            options.ReducedDim = dim;
            [eigvector] = LGSDP(X_train,y_train,options);
            X_train_LSDA = X_train*eigvector;
            X_test_LSDA = X_test*eigvector;
            accuracy(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);

% %             ����baseline
%             options = [];
%             accuracy(dim) = KNN(X_train,y_train,X_test,y_test,1);            

% %             ����PCA
%             options = [];
%             options.ReducedDim = dim;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train_PCA = X_train*eigvector;
%             X_test_PCA = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_PCA,y_train,X_test_PCA,y_test,1);

% %             ����LDA
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
%               accuracy(dim) = KNN(X_train_lda,y_train,X_test_lda,y_test,1);

% %               ����MMC
%             ReducedDim = dim;
% %             PCAԤ����
%             options = [];
%             options.ReducedDim = 40;
%             [eigvector, eigvalue] = PCA(X_train, options);
%             X_train = X_train*eigvector;
%             X_test = X_test*eigvector;
%             [eigvector] = MMC(y_train, ReducedDim, X_train);
%             X_train_MMC = X_train*eigvector;
%             X_test_MMC = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_MMC,y_train,X_test_MMC,y_test,1);

%             % ����LPP
%             options = [];
%             options.k = 5;
%             options.r = dim;
%             options.t = 4;
%             options.PCARatio = 40;
%             [eigvector] = myLPP(options, X_train);
%             X_train_lpp = X_train*eigvector;
%             X_test_lpp = X_test*eigvector; 
%             accuracy(dim) = KNN(X_train_lpp,y_train,X_test_lpp,y_test,1);

% %             ����LPNDP
%             options = [];
%             options.k = ratio-1;
%             options.PCARatio = 40;
%             options.beta = 0.02;
%             options.t = 1;
%             options.ReducedDim = dim;
%             [eigvector] = LGSDP(X_train,y_train,options);
%             X_train_LPNDP = X_train*eigvector;
%             X_test_LPNDP = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LPNDP,y_train,X_test_LPNDP,y_test,1);

%             % ����LDP
%             options = [];
%             options.k = ratio-1;
%             options.PCARatio = 40;
%             options.t = 1;
%             options.ReducedDim=dim;
%             [eigvector] = LDP(X_train,y_train,options);
%             X_train_LDP = X_train*eigvector;
%             X_test_LDP = X_test*eigvector;
%             accuracy(dim) = KNN(X_train_LDP,y_train,X_test_LDP,y_test,1);

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

        end
        acc = [acc;accuracy];
        [maxAcc_50, idx] = max(accuracy)
%         max_idx = [max_idx,maxAcc];
    end
    acc_avg = mean(acc,1);
    std_acc = std(acc,1);
%     acc_avg = repmat(acc_avg,1,40);
%     std_acc = repmat(std_acc,1,40);
    path = [dataset,num2str(ratio),'_acc_1to50_32lsdp001'];
%     save(path,'acc_avg','std_acc');
    plot(1:maxDim,acc_avg);
    
    [maxAcc, idx] = max(acc_avg);
    
end
