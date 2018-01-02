function [jointimage,x,y,D] = LPsolve(imageblocks,M,N,iternum,D)
%LPsolve 线性规划拼图程序
%   imageblocks: 拼图小块
%   M: 拼图行数
%   N: 拼图列数
%   iternum: 最大迭代次数
%   D: 预先准备的 D 矩阵
%
%   CVX-Jigsaw

% Use 'cvx_version' to return environment information
CVX_VERSION = 3.0;
% CVX_VERSION = 2.1;

n = M * N;

if nargin < 5
    if CVX_VERSION >= 3
        % For cvx version 3.0 beta or higher (recommended)
        D = MGC_compute_cvx3(imageblocks);
    else
        % For cvx version 2.1 or higher
        D = MGC_compute_cvx2(imageblocks);
    end
end

w = dis2weight(D);

delta_x = [0; -1; 0; 1];
delta_y = [1; 0; -1; 0];

U = true(n,n,4);

for ii = 1:iternum
    
    [~,indj] = min(D.*U,[],2);
    i = repmat((1:n)',4,1);
    j = indj(:);
    o = reshape(repmat(1:4,n,1),[],1);
    indA = sub2ind([n,n,4],i,j,o);

    cvx_begin
        variables x(n) hx(4*n);
        minimize ( w(indA).' * hx );
        subject to
            -hx <= x(i) - x(j) - delta_x(o) <= hx;%#ok
            1 <= x <= N;%#ok
    cvx_end
    
    cvx_begin
        variables y(n) hy(4*n);
        minimize ( w(indA).' * hy );
        subject to
            -hy <= y(i) - y(j) - delta_y(o) <= hy;%#ok
            1 <= y <= M;%#ok
    cvx_end
    
%{    
%     cvx_begin
%         variables x(n) y(n) hx(4*n) hy(4*n);
%         minimize ( w(indA).' * hy +  w(indA).' * hx );
%         subject to
%             -hx <= x(i) - x(j) - delta_x(o) <= hx;%#ok
%             -hy <= y(i) - y(j) - delta_y(o) <= hy;%#ok
%             %1 <= x <= N;%#ok
%             %1 <= y <= M;%#ok
%     cvx_end
%}
    
    subA = [i, j, o];
    subR = subA(max(hx,hy)>1e-5,:);
    indR = sub2ind([n,n,4],subR);
    U(indR) = false;

    jointimage = jointblocks(imageblocks,x,y);
    title('Restored Image - LP Method');
    drawnow;
    
    fprintf(['CVX-Jigsaw image: ' num2str(size(jointimage,1)) ' x '...
        num2str(size(jointimage,2)) ' pixels\n']);

end

end

