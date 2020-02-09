%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [eigvector, eigvalue] =ILSDA(data,gnd,options)
% data   - Data matrix. Each column vector of data is a data point.
% gnd    - Label vector.
%options - Struct value in Matlab. The fields in options that can be set:
%   k is a nearest neighborhood parameter
%     Wb:Put an edge between two nodes if they belong to different classes
%        and they are among the k nearst neighbors of each other.
%     Ww:Put an edge between two nodes if they belong to same class and they
%        are among the k nearst neighbors of each other.
%   alpha is a tradeoff parameter in Eq.(18)
%   t is a parameter which determines the rate of decay of heat kernel function in Eq.(10) or Eq.(11)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%=====Construct the within-class graph(Gw)and between-class graph(Gb)====
[Wb,Ww]=ILSDA_Graph(data,gnd,options);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%====Compute Laplacian Matrice Lb and Lw according to Eqs.(15) and (16)
Db=diag(sum(Wb,2));
Lb=data*(Db-Wb)*data';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dw=diag(sum(Ww,2));
Lw=data*(Dw-Ww)*data';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%==Compute Matrix P in Eq.(18)
P=Lb-Lw;
P=max(P,P');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%====Compute Within-class Scatter Matrix according to Eq.(17)
Sw= GetScatter(data,gnd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%==Compute Matrix P according to Eq.(19)
M=P-options.alpha*Sw;
M=max(M,M');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[eigvector, eigvalue] = eig(M);
[eigvalue, ind] = sort(diag(eigvalue),'descend');
eigvector = eigvector(:,ind);
for i = 1:size(eigvector,2)
    eigvector(:,i) = eigvector(:,i)./norm(eigvector(:,i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%