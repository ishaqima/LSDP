function [eigvector] = DMMP(X_train,y_train,options)
% DMMP�㷨ʵ��
% 1. ����ÿ��������k��������
% 2. ����k������������ǩ����Ȩ��
% 3. ���о��������ֽ�

% ������Ŀ
[n,d] = size(X_train);
nm = size(y_train,1)/size(unique(y_train),1);
% k���ڲ���
k = 3;
if isfield(options,'k')
   k = options.k; 
end

beta = 0.06;
if isfield(options,'beta')
   beta = options.beta; 
end

% ����֮��ľ���D
D = EuDist2(X_train,X_train,0);

% ����knn����ѡȡ��Ч�ľ���
Ww = zeros(n,n);
Wb = zeros(n,n);

[dump,idx] = sort(D,2);
% idx = idx(:,1:k+1);
% dump = dump(:,1:k+1);

% Ȩ�ؼ���
% ���Ȩ��
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

% ����Ȩ��
for i=1:n
    for j=1:n
        if y_train(i)==y_train(idx(i,j))
            Ww(i,idx(i,j)) = 1/nm;
        else
            Wb(i,idx(i,j)) = 0;
        end
    end
end


% ����ֽ�
Db = full(sum(Wb,2));
Dw = diag(sum(Ww,2));
Wb = -Wb;
for i=1:size(Wb,1)
    Wb(i,i) = Wb(i,i) + Db(i);
end
W = sparse((beta/(1-beta))*Wb+Ww);

% ============================ %
% ���������ֽ�
[eigvector, eigvalue] = LGE(W, Dw, options, X_train);
eigIdx = find(eigvalue < 1e-10);
eigvalue (eigIdx) = [];
eigvector(:,eigIdx) = [];






