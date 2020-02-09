% 清除环境变量
clear
clc

dataset = 'Yale';
% dataset = 'ORL';

classNum = 15;
persons = 11;
% classNum = 10;
% persons = 40;
% ratio = 2;
maxDim = 40;

% 加载数据集
path = ['./数据集/',dataset,'_64x64.mat'];
% path = ['./数据集/',dataset,'_32x32.mat'];


for ratio=6:6
    acc1 = [];
    acc2 = [];
    acc3 = [];
    acc4 = [];
    
    for times=1:1
        X_train = [];
        y_train = [];
        X_test = [];
        y_test = [];
        %         splitPath = ['./数据集/',dataset,'/',num2str(ratio),'Train/',num2str(orl_repts_5(times))];
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
        % 归一化
        X_train = double(X_train);
        X_test = double(X_test);
        for dim=1:maxDim
            %             % 测试PCA
            %             options = [];
            %             options.ReducedDim = dim;
            %             [eigvector, eigvalue] = PCA(X_train, options);
            %             X_train_PCA = X_train*eigvector;
            %             X_test_PCA = X_test*eigvector;
            
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
            %               X_train_LDA = X_train*eigvector;
            %               X_test_LDA = X_test*eigvector;
            
            %               % 测试LPP
            %             options = [];
            %             options.k = 5;
            %             options.r = dim;
            %             options.t = 4;
            %             options.PCARatio = 120;
            %             [eigvector] = myLPP(options, X_train);
            %             X_train_LPP = X_train*eigvector;
            %             X_test_LPP = X_test*eigvector;
            
%                         %             LSDA
%                                     options = [];
%                                     options.k = ratio-1;
%                                     options.PCARatio = 120;
%                                     options.beta = 0.01;
%                                     options.ReducedDim = dim;
%                                     [eigvector, ~] = LSDA(y_train, options, X_train);
%                                     X_train_LSDA = X_train*eigvector;
%                                     X_test_LSDA = X_test*eigvector;
            
%                         %             ILSDA
%                         %             PCA预处理
%                         options = [];
%                         options.ReducedDim = 120;
%                         [eigvector, eigvalue] = PCA(X_train, options);
%                         X_train = X_train*eigvector;
%                         X_test = X_test*eigvector;
%                         options = [];
%                         options.k = 5;
%                         options.alpha = 500;
%                         options.t = 1;
%                         [eigvector,~] = ILSDA(X_train',y_train',options);
%                         eigvector = eigvector(:,1:dim);
%                         X_train_ILSDA = X_train*eigvector;
%                         X_test_ILSDA = X_test*eigvector;
            
            %             % %             LGSDP
            %                         options = [];
            %                         options.k = 25;
            %                         options.PCARatio = 120;
            %                         options.beta = 0.01;
            %                         options.t = 1;
            %                         options.ReducedDim = dim;
            %                         [eigvector] = LGSDP(X_train,y_train,options);
            %                         X_train_LGSDP = X_train*eigvector;
            %                         X_test_LGSDP = X_test*eigvector;
            
%             % %             DMMP
%             options = [];
%             options.k = 25;
%             options.PCARatio = 120;
%             options.beta = 0.01;
%             options.t = 1;
%             options.ReducedDim = dim;
%             [eigvector] = DMMP(X_train,y_train,options);
%             X_train_DMMP = X_train*eigvector;
%             X_test_DMMP = X_test*eigvector;
            
            % %             LDP
            %             options = [];
            %             options.k = ratio-1;
            %             options.PCARatio = 40;
            %             options.t = 1;
            %             options.ReducedDim=dim;
            %             [eigvector] = LDP(X_train,y_train,options);
            %             X_train_LDP = X_train*eigvector;
            %             X_test_LDP = X_test*eigvector;
            %
            %             % 测试MMC
            %             ReducedDim = dim;
            % %             PCA预处理
            %             options = [];
            %             options.PCARatio = 40;
            %             [eigvector, eigvalue] = PCA(X_train, options);
            %             X_train = X_train*eigvector;
            %             X_test = X_test*eigvector;
            %             [eigvector] = MMC(y_train, ReducedDim, X_train);
            %             X_train_MMC = X_train*eigvector;
            %             X_test_MMC = X_test*eigvector;
            
            %            测试MFA
%             %             PCA预处理
%             options = [];
%             options.ReducedDim = 120;
%             [eigvector, ~] = PCA(X_train, options);
%             X_train = X_train*eigvector;
%             X_test = X_test*eigvector;
%             options = [];
%             options.intraK = 2;
%             options.interK = 25;
%             options.Regu = 1;
%             [~,~,W,eigvalue,~] = MFA(y_train, options, X_train);
%             X_train_MFA = X_train*W;
%             X_test_MFA = X_test*W;
            
            %             accuracy1(dim) = KNN(X_train_LGSDP,y_train,X_test_LGSDP,y_test,1);
%             accuracy2(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
%                         accuracy2(dim) = KNN(X_train_ILSDA,y_train,X_test_ILSDA,y_test,1);
              accuracy2(dim) = KNN(X_train_DMMP,y_train,X_test_DMMP,y_test,1);
%             accuracy2(dim) = KNN(X_train_LSDA,y_train,X_test_LSDA,y_test,1);
            %               accuracy2(dim) = KNN(X_train_LPP,y_train,X_test_LPP,y_test,1);
%             accuracy2(dim) = KNN(X_train_MFA,y_train,X_test_MFA,y_test,1);
            % accuracy3(dim) = KNN(X_train_LDP,y_train,X_test_LDP,y_test,1);
            % accuracy4(dim) = KNN(X_train_MMC,y_train,X_test_MMC,y_test,1);
        end
        [idx,value]= max(accuracy2)
        %         acc1 = [acc1;accuracy1];
        acc2 = [acc2;accuracy2];
        %         acc3 = [acc3;accuracy3];
        %         acc4 = [acc4;accuracy4];
    end
    %     acc_avg1 = mean(acc1,1);
    %     std_acc1 = std(acc1,1);
    acc_avg2 = mean(acc2,1);
    std_acc2 = std(acc2,1);
    %     acc_avg3 = mean(acc3,1);
    %     std_acc3 = std(acc3,1);
    %     acc_avg4 = mean(acc4,1);
    %     std_acc4 = std(acc4,1);
    %     path1 = [dataset,num2str(ratio),'_acc_1to40_LSDP0.1p6.mat'];
    %     save(path1,'acc_avg1','std_acc1');
    %     path2 = [dataset,num2str(ratio),'_acc_1to40_lsda'];
    %     save(path2,'acc_avg2','std_acc2');
    %     path3 = [dataset,num2str(ratio),'_acc_1to40_ldp'];
    %     save(path3,'acc_avg3','std_acc3');
    %     plot(1:maxDim,acc_avg1,1:maxDim,acc_avg2,1:maxDim,acc_avg3,1:maxDim,acc_avg4);
    %     legend('LGSDP','LSDA','LDP','MMC','Location','Best');
    %
    %     [maxAcc1, idx1] = max(acc_avg1)
    %     [maxAcc2, idx2] = max(acc_avg2)
    %     [maxAcc3, idx3] = max(acc_avg3)
    %     [maxAcc4, idx4] = max(acc_avg4)
end
