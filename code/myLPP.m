function [eigvector] = myLPP(options, data)
% data：每一行为一个样本点，data形状为 n*m
% option：
%   k:构造近邻图时k-nn中k的取值
%   t:根据近邻图计算权重时若用到HotKernel,需要的参数t
%   r:降维的维数 r
% Output:eigvector,所要求的投影矩阵，shape为 m*d
% 根据Cai Deng的论文实现的LPP(Locality Preserving Projection)算法

% 样本数目n,原始维数m
[nSmp,mFea] = size(data);

% 计算样本之间的欧氏距离来构建近邻图
W_dist = zeros(nSmp,nSmp);
for i = 1:nSmp
    for j = 1:nSmp
      W_dist(i,j) = norm(data(i,:)-data(j,:));
    end
end

t = mean(mean(data));
if isfield(options,'t')
   t = options.t*t; 
end

% 计算权重矩阵
k = options.k;
W = zeros(nSmp,nSmp);
for i = 1:nSmp
    dist = W_dist(i,:);
    dist(1,i) = inf;
    [~,idx] = sort(dist);
    for j = 1:k
        W(i,idx(j))= exp(-W_dist(i,idx(j))/t);
    end
end

W = max(W,W');
% 计算对角矩阵D与Laplacian矩阵L
D = diag(sum(W));
L = D - W;

% % 分解矩阵inv（data'*D*data）(data'*L*data)求投影向量
% [V,D] = eig((data'*D*data)\(data'*L*data));
% [~,idx] = sort(diag(D));
% eigvector = [];
% r = options.r;
% for i = 1:r
%     eigvector = [eigvector,real(V(:,idx(i)))];
% end

% opt = [];
% opt.ReducedDim = options.r;
% [eigvector,eigvalue] = LGE(W, D, opt, data);
% 
% eigIdx = find(eigvalue < 1e-3);
% eigvalue(eigIdx) = [];
% eigvector(:,eigIdx) = [];


opt = [];
opt.ReducedDim = options.r;
opt.PCARatio = options.PCARatio;

[eigvector, eigvalue] = LPP(W, opt, data);
% r = options.r;
% [m,d] = size(eigvector);
% if r > d
%     r = d;
% end
% eigvector = eigvector(:,1:r);

end