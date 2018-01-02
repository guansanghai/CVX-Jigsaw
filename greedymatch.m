function [jointimage,x,y] = greedymatch(x,y,M,N,D,imageblocks,method)
%GREEDYMATCH 对少数未匹配成功方块进行贪婪匹配
%   x: 横坐标
%   y: 纵坐标
%   M: 拼图行数
%   N: 拼图列数
%   D: 距离矩阵
%   imageblocks: 拼图小块
%   method: 贪婪匹配方法 'mgc' 或 'rgb'(默认)
%
%   CVX-Jigsaw

if nargin < 7
    method = 'rgb';
end

x = x - min(x(:));
x = round(x);
x = x + 1;
x(x<1) = 1;
x(x>N) = N;

y = y - min(y(:));
y = round(y);
y = y + 1;
y(y<1) = 1;
y(y>M) = M;

n = M * N;
kposind = sub2ind([M,N],y,x);
kposmat = zeros(M,N);
kmatchedlist = false(n,1);

for k = 1:n
    if sum(kposind == kposind(k)) == 1
        kposmat(kposind(k)) = k;
        kmatchedlist(k) = true;
    end
end

iternum = 0;
tic();

while (~all(kmatchedlist)) && (iternum < 10*n) && (toc() < 10)
    iternum = iternum + 1;
    
    emptyposlist = find(kposmat==0);
    emptyposind = emptyposlist(randi(length(emptyposlist)));
    [row,col] = ind2sub([M,N],emptyposind);
    jpos = [0;0;0;0];
    if row ~= 1
        jpos(1) = kposmat(row-1,col);
    end
    if row ~= M
        jpos(3) = kposmat(row+1,col);
    end
    if col ~= 1
        jpos(4) = kposmat(row,col-1);
    end
    if col ~= N
        jpos(2) = kposmat(row,col+1);
    end
    
    if sum(jpos) == 0
        continue
    end
    
    knotmatchlist = find(~kmatchedlist);

    if strcmp(method,'rgb')     
        blknotmatch = imageblocks(:,:,:,knotmatchlist);
        blkrgberror = 0 * imageblocks(1,:,:,knotmatchlist); 
        for color = 1:3
            if jpos(1) ~= 0
                iblk = blknotmatch(1,:,:,:);
                jblk = imageblocks(end,:,:,jpos(1));
                blkrgberror = blkrgberror + abs(iblk-jblk);
            end
            if jpos(2) ~= 0
                iblk = blknotmatch(:,end,:,:);
                jblk = imageblocks(:,1,:,jpos(2));
                blkrgberror = blkrgberror + permute(abs(iblk-jblk),[2,1,3,4]);
            end
            if jpos(3) ~= 0
                iblk = blknotmatch(end,:,:,:);
                jblk = imageblocks(1,:,:,jpos(3));
                blkrgberror = blkrgberror + abs(iblk-jblk);
            end
            if jpos(4) ~= 0
                iblk = blknotmatch(:,1,:,:);
                jblk = imageblocks(:,end,:,jpos(4));
                blkrgberror = blkrgberror + permute(abs(iblk-jblk),[2,1,3,4]);
            end
        end
        
        blkmeanrgberror = mean(mean(blkrgberror,2),3);
        blkmeanrgberror = reshape(blkmeanrgberror,[],1);
        tempind = find(blkmeanrgberror==min(blkmeanrgberror),1);
        
    else
        method = 'mgc';
        Dsum = zeros(length(knotmatchlist),1);
        for o = 1:4
            if jpos(o) ~= 0
                Dsum = Dsum + D(knotmatchlist,jpos(o),o);
            end
        end
        tempind = find(Dsum==min(Dsum),1);
    end

    kfillind = knotmatchlist(tempind);
    kmatchedlist(kfillind) = true;
    
    kposmat(row,col) = kfillind;
    y(kfillind) = row;
    x(kfillind) = col;
    
end

jointimage = jointblocks(imageblocks,x,y);
title(['Restored Image - LP Method + Greedy Filling (' upper(method) ')']);
drawnow;
    
end

