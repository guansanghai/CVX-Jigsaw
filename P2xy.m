function [x,y] = P2xy(P,M,N)
%P2XY 将 P 矩阵转换为 x,y 坐标
%   P: P 矩阵
%   M: 拼图行数
%   N: 拼图列数
%
%   CVX-Jigsaw

blockind = (reshape((1:M*N),N,M)).';
n = M * N;
x = zeros(n,1);
y = zeros(n,1);

for ii = 1:n
    ind = find(P(ii,:)==max(P(ii,:)),1);
    [y(ii),x(ii)] = find(blockind==ind);
end

end

