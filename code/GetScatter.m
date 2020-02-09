function [Sw] = GetScatter(data,gnd)
[Di,M]	= size(data);
Sw= zeros(Di, Di);
aa=unique(gnd);
for i=1:size(aa,2)
    l=aa(1,i);
    indices	= find(gnd==l);
    m_i = mean(data(:,indices),2);
    Sw_i = (data(:, indices) - m_i*ones(1,length(indices)))*(data(:, indices) - m_i*ones(1,length(indices)))';
    Sw=Sw+Sw_i;
end;

