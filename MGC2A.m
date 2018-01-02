function A = MGC2A(D,M,N)
%MGC2A 将 MGC 距离转换为 A 矩阵
%   D: MGC 距离矩阵
%   M: 拼图行数
%   N: 拼图列数
%
%   CVX-Jigsaw

n = M*N;

DH = (D(:,:,2) + D(:,:,4).') / 2;
[DHsort,iH] = sort(DH,2);
qH = DHsort(:,round(n/4));
[~,phiH] = sort(iH,2);
CH = exp(-phiH*2 - DH./qH);
CH(CH<1e-6) = 0;

DV = (D(:,:,3) + D(:,:,1).') / 2;
[DVsort,iV] = sort(DV,2);
qV = DVsort(:,round(n/4));
[~,phiV] = sort(iV,2);
CV = exp(-phiV*2 - DV./qV);
CV(CV<1e-6) = 0;

blockind = (reshape((1:M*N),N,M)).';
A = sparse(n^2,n^2);

for ii = 1:M
    for jj = 1:N-1
        indrow = blockind(ii,jj);
        indcol = blockind(ii,jj+1);
        rangerow = n*(indrow-1)+1 : n*indrow;
        rangecol = n*(indcol-1)+1 : n*indcol;
        A(rangerow,rangecol) = CH; %#ok  
    end
end

for ii = 1:N
    for jj = 1:M-1
        indrow = blockind(jj,ii);
        indcol = blockind(jj+1,ii);
        rangerow = n*(indrow-1)+1 : n*indrow;
        rangecol = n*(indcol-1)+1 : n*indcol;
        A(rangerow,rangecol) = CV; %#ok 
    end
end

A = A + A.';

end

