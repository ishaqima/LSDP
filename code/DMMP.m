function [eigvector] = DMMP(X_train,y_train,options)
% DMMP算法实现
% 1. 计算每个样本的k近邻样本
% 2. 根据k近邻与样本标签构建权重
% 3. 进行矩阵特征分解

% 样本数目
[n,d] = size(X_train);
nm = size(y_train,1)/size(unique(y_train),1);
% k近邻参数
k = 3;
if isfield(options,'k')
   k = options.k; 
end

beta = 0.06;
if isfield(options,'beta')
   beta = options.beta; 
end

% 样本之间的距离D
D = EuDist2(X_train,X_train,0);

% 根据knn排序选取有效的距离
Ww = zeros(n,n);
Wb = zeros(n,n);

[dump,idx] = sort(D,2);
% idx = idx(:,1:k+1);
% dump = dump(:,1:k+1);

% 权重计算
% 类间权重
for i=1:n
    for j=2:k+1
%         temp = exp(-dump(i,j)/(t));
        if y_train(i)==y_train(idx(i,j))
            Wb(i,idx(i,j))= 1/n-1/nm;
        else
            Wb(i,idx(i,j))= 1/n;
        end
    end
end

% 类内权重
for i=1:n
    for j=1:n
        if y_train(i)==y_train(idx(i,j))
            Ww(i,idx(i,j)) = 1/nm;
        else
            Wb(i,idx(i,j)) = 0;
        end
    end
end


% 矩阵分解
Db = full(sum(Wb,2));
Dw = diag(sum(Ww,2));
Wb = -Wb;
for i=1:size(Wb,1)
    Wb(i,i) = Wb(i,i) + Db(i);
end
W = sparse((beta/(1-beta))*Wb+Ww);

% ============================ %
% 进行特征分解
[eigvector, eigvalue] = LGE(W, Dw, options, X_train);
eigIdx = find(eigvalue < 1e-10);
eigvalue (eigIdx) = [];
eigvector(:,eigIdx) = [];






