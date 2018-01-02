function D = MGC_compute_cvx3(imageblocks)
%MGC_COMPUTE_CVX3 计算拼图块间各方向的 MGC 距离
%   For CVX verion 3.0 beta or higher
%   imageblocks: 拆分并打乱后的小块 (blocksize x blocksize x 3 x n)
%   D: MGC Distance matrix (n x n x 4) 
%
%   CVX-Jigsaw

    blksize = size(imageblocks,1);
    n = size(imageblocks,4);
    D = zeros(n, n, 4);

    B = 1e-6*[0,0,1; 1,1,1; 1,0,0];
    B = repmat(B,1,1,n);
    
    h = waitbar(0,'Computing MGC Distance...');
    
    for o = 1:4
        blk = rot90(imageblocks,o-2);
        GiL = blk(:,end,:,:) - blk(:,end-1,:,:);
        GiL = reshape(GiL,blksize,3,n);
        GiL = [GiL; B];%#ok        
        muiL = mean(GiL);
        invSiL = zeros(3,3,n);
        for k = 1:n
            SiL = (GiL(:,:,k)-muiL(:,:,k)).'*(GiL(:,:,k)-muiL(:,:,k));
            invSiL(:,:,k) = inv(SiL);
        end
        for i = 1:n
            waitbar(((o-1)*n+i) / (4*n));
            GijLR = blk(:,1,:,:) - blk(:,end,:,i);
            GijLR = reshape(GijLR,blksize,3,n);
            for j = 1:n
                temp = GijLR(:,:,j) - muiL(:,:,i);
                D(i,j,o) = trace( temp * invSiL(:,:,i) * temp.' );
            end
        end
    end

    Dtemp = D;
    D(:,:,1) = (Dtemp(:,:,1) + Dtemp(:,:,3).') / 2;
    D(:,:,2) = (Dtemp(:,:,2) + Dtemp(:,:,4).') / 2;
    D(:,:,3) = D(:,:,1).';
    D(:,:,4) = D(:,:,2).';
    
    close(h);
    
end

