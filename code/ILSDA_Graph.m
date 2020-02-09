function [Wb,Ww]=ILSDA_Graph(data,gnd,options)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D=EuDist2(data',data');
N=size(D,1);
[~, ind]=sort(D);
G=zeros(N,N);
k=options.k;
for i=1:size(D, 1)
    G(ind((2:k+1),i),i) = 1;
end
G=max(G,G');
D=exp(-D./options.t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Wb=zeros(N,N);
Ww=zeros(N,N);
for i=1:N
    for j=i:N
        if G(i,j)==1
            if gnd(i)==gnd(j)
                Ww(i,j)=D(i,j);
                Ww(j,i)=Ww(i,j);
            else
                Wb(i,j)=D(i,j);
                Wb(j,i)=Wb(i,j);
            end
        end
    end
end;
Wb=max(Wb,Wb');
Ww=max(Ww,Ww');

