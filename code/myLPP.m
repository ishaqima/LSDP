function [eigvector] = myLPP(options, data)
% data��ÿһ��Ϊһ�������㣬data��״Ϊ n*m
% option��
%   k:�������ͼʱk-nn��k��ȡֵ
%   t:���ݽ���ͼ����Ȩ��ʱ���õ�HotKernel,��Ҫ�Ĳ���t
%   r:��ά��ά�� r
% Output:eigvector,��Ҫ���ͶӰ����shapeΪ m*d
% ����Cai Deng������ʵ�ֵ�LPP(Locality Preserving Projection)�㷨

% ������Ŀn,ԭʼά��m
[nSmp,mFea] = size(data);

% ��������֮���ŷ�Ͼ�������������ͼ
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

% ����Ȩ�ؾ���
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
% ����ԽǾ���D��Laplacian����L
D = diag(sum(W));
L = D - W;

% % �ֽ����inv��data'*D*data��(data'*L*data)��ͶӰ����
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