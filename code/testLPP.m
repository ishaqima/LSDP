% �����������
clear
clc

% ����Yale���ݼ�
% load('./���ݼ�/Yale_64x64.mat');
% classNum = 15;

% % ����ORL���ݼ�
% load('./���ݼ�/ORL_32x32.mat');
% classNum = 40;

% % ����YaleB���ݼ�
% load('./���ݼ�/YaleB_32x32.mat');
% classNum = 38;
ratio = 5;
maxDim = 45;
for dim=1:maxDim
    for i = 1:10
        % ����ѵ���������Լ�
        [X_train, y_train, X_test, y_test] = Mysplit_train_test(fea, gnd, classNum, ratio);
        % ����LPP
        options = [];
        options.k = ratio-1;
        W = constructW(X_train,options);
        options.PCARatio = 40;
        options.ReducedDim=dim;
        if dim > classNum-1
            options.ReducedDim = classNum-1;
        end
        [eigvector, eigvalue] = LPP(W, options, X_train);
        X_train_LPP = X_train*eigvector;
        X_test_LPP = X_test*eigvector;
        
        accuracy(i) = KNN(X_train_LPP,y_train,X_test_LPP,y_test,1);
    end
    acc(dim) = mean(accuracy);
    std_acc(dim) = std(accuracy);
end


path = ['Yale_L',num2str(ratio),'_acc_1to45_lpp'];
% path = ['ORL_L',num2str(ratio),'_acc_1to45_lpp'];
save(path,'acc','std_acc');
plot(1:maxDim,acc);

[maxAcc,idx] = max(acc)