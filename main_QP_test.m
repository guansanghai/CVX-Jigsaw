close all
clear

photo{1} = imread('lena_std.tif');
photo{2} = imread(['ImageDB-432parts-MIT',filesep,'8.png']);
photo{3} = imread(['ImageDB-540parts-McGill',filesep,'16.jpg']);
photo{4} = imread(['ImageDB-540parts-McGill',filesep,'14.jpg']);
photo{5} = imread(['ImageDB-540parts-McGill',filesep,'2.jpg']);

for casenum = 1:numel(photo)
    
    image = photo{casenum};
    blocksize = 64;
    image = im2double(image);
    [imageblocks,M,N] = disorg(image,blocksize);
    n = M * N;
    [x1,y1] = meshgrid(1:N,1:M);
    puzzleimage = jointblocks(imageblocks,x1(:),y1(:));
    hold on
    stop = uicontrol('style','toggle','string','Stop','background','white');
    
    D = MGC_compute_cvx3(imageblocks);
    A = MGC2A(D,M,N);
    p = ones(n^2,1)/n;
    Active = true(n^2,1);
    
    Aeq1 = double(bsxfun(@eq,(1:n).',reshape(repmat(1:n,n,1),1,[])));
    Aeq2 = repmat(eye(n),1,n);
    Aeq = [Aeq1; Aeq2];
    Aeq(end,:) = [];
    Aineq = sparse(eye(n^2));
    
    max_iter = 500;
    iternum = 0;
    
    while (~get(stop,'value') && iternum < max_iter)
        
        iternum = iternum + 1;
        
        d = A * p;
        MT = [Aineq(p<1e-5,:); Aeq];
        if det(MT*MT.') == 0
            break
        end
        K = eye(n^2) - MT.'*inv(MT*MT.')*MT;%#ok
        s = K * d;
        
        t = (1-p)./s.*(s>=0) - p./s.*(s<0);
        step = min(t(Active));
        p = p + step .* s .* Active;
        Active(t==step) = false;
        
        P = reshape(p,n,n);
        [x,y] = P2xy(P,M,N);
        jointimage = jointblocks(imageblocks,x,y,'hold');
        title([num2str(iternum) ' Iterations']);
        drawnow;
        
    end
    
    stop = uicontrol('style','pushbutton','string','Continue','callback','close all');
    drawnow;
    uiwait(gcf);
end
