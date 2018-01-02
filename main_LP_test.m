% CVX-Jigsaw
% LP solve test

% Configure the cvx version (2.1 or 3.0) firstly in 'LP_solve.m'
clear
close all
dbstop if error

%% Lena - 64x64 block - 64 pieces
image = imread('lena_std.tif');
image = im2double(image);
blocksize = 64;

[imageblocks,M,N] = disorg(image,blocksize);
[x,y] = meshgrid(1:N,1:M);
puzzleimage = jointblocks(imageblocks,x(:),y(:));
title('Lena - 64x64 block - 64 pieces');
% imwrite(puzzleimage,'puzzleimage.jpg');

[restoredimage,x,y,D] = LPsolve(imageblocks,M,N,1);
% imwrite(restoredimage,'restoredimage.jpg');
jointimage = greedymatch(x,y,M,N,D,imageblocks);

uicontrol('style','pushbutton','string','Continue','callback','close all');
drawnow;
uiwait(gcf);

%% Lena - 32x32 block - 256 pieces
image = imread('lena_std.tif');
image = im2double(image);
blocksize = 32;

[imageblocks,M,N] = disorg(image,blocksize);
[x,y] = meshgrid(1:N,1:M);
puzzleimage = jointblocks(imageblocks,x(:),y(:));
title('Lena - 32x32 block - 256 pieces');

[restoredimage,x,y,D] = LPsolve(imageblocks,M,N,1);
jointimage = greedymatch(x,y,M,N,D,imageblocks);

uicontrol('style','pushbutton','string','Continue','callback','close all');
drawnow;
uiwait(gcf);

%% MIT Dataset
dataset = 'ImageDB-432parts-MIT';
filenum = 1:5;
filetype = '.png';
blocksize = 28;
maxiter = 1;

for ii = filenum
    image = imread([dataset,filesep,num2str(ii),filetype]);
    image = im2double(image);
    pieces = size(image,1) * size(image,2) / blocksize^2;
    
    [imageblocks,M,N] = disorg(image,blocksize);
    [x,y] = meshgrid(1:N,1:M);
    puzzleimage = jointblocks(imageblocks,x(:),y(:));
    title(['Dataset (' dataset ') - ' num2str(blocksize) 'x' num2str(blocksize)...
        ' block - ' num2str(pieces) ' pieces - ',num2str(ii),filetype]);
    drawnow;
    
    [restoredimage,x,y,D] = LPsolve(imageblocks,M,N,maxiter);
    jointimage = greedymatch(x,y,M,N,D,imageblocks);
    
    uicontrol('style','pushbutton','string','Continue','callback','close all');
    drawnow;
    uiwait(gcf);
end

%% MCGill Dataset
dataset = 'ImageDB-540parts-McGill';
filenum = 1:5;
filetype = '.jpg';
blocksize = 28;
maxiter = 1;

for ii = filenum
    image = imread([dataset,filesep,num2str(ii),filetype]);
    image = im2double(image);
    pieces = size(image,1) * size(image,2) / blocksize^2;
    
    [imageblocks,M,N] = disorg(image,blocksize);
    [x,y] = meshgrid(1:N,1:M);
    puzzleimage = jointblocks(imageblocks,x(:),y(:));
    title(['Dataset (' dataset ') - ' num2str(blocksize) 'x' num2str(blocksize)...
        ' block - ' num2str(pieces) ' pieces - ',num2str(ii),filetype]);
    drawnow;
    
    [restoredimage,x,y,D] = LPsolve(imageblocks,M,N,maxiter);
    jointimage = greedymatch(x,y,M,N,D,imageblocks);
    
    uicontrol('style','pushbutton','string','Continue','callback','close all');
    drawnow;
    uiwait(gcf);
end

%% BGU Dataset
dataset = 'ImageDB-805parts-BGU';
filenum = 5;
filetype = '.jpg';
blocksize = 28;
maxiter = 1;

for ii = filenum
    image = imread([dataset,filesep,num2str(ii),filetype]);
    image = im2double(image);
    pieces = size(image,1) * size(image,2) / blocksize^2;
    
    [imageblocks,M,N] = disorg(image,blocksize);
    [x,y] = meshgrid(1:N,1:M);
    puzzleimage = jointblocks(imageblocks,x(:),y(:));
    title(['Dataset (' dataset ') - ' num2str(blocksize) 'x' num2str(blocksize)...
        ' block - ' num2str(pieces) ' pieces - ',num2str(ii),filetype]);
    drawnow;
    
    [restoredimage,x,y,D] = LPsolve(imageblocks,M,N,maxiter);
    jointimage = greedymatch(x,y,M,N,D,imageblocks);

    uicontrol('style','pushbutton','string','Continue','callback','close all');
    drawnow;
    uiwait(gcf);
end

%% BGU Dataset
clear;
dataset = 'ImageDB-2360parts-BGU';
filenum = 1;
filetype = '.jpg';
blocksize = 28;
maxiter = 1;

for ii = filenum
    image = imread([dataset,filesep,num2str(ii),filetype]);
    image = im2double(image);
    pieces = size(image,1) * size(image,2) / blocksize^2;
    
    [imageblocks,M,N] = disorg(image,blocksize);
    [x,y] = meshgrid(1:N,1:M);
    puzzleimage = jointblocks(imageblocks,x(:),y(:));
    title(['Dataset (' dataset ') - ' num2str(blocksize) 'x' num2str(blocksize)...
        ' block - ' num2str(pieces) ' pieces - ',num2str(ii),filetype]);
    drawnow;
    
    [restoredimage,x,y,D] = LPsolve(imageblocks,M,N,maxiter);
    jointimage = greedymatch(x,y,M,N,D,imageblocks,'rgb');

    uicontrol('style','pushbutton','string','Continue','callback','close all');
    drawnow;
    uiwait(gcf);
end

%% BGU Dataset
clear;
dataset = 'ImageDB-3300parts-BGU';
filenum = 1;
filetype = '.jpg';
blocksize = 28;
maxiter = 1;

for ii = filenum
    image = imread([dataset,filesep,num2str(ii),filetype]);
    image = im2double(image);
    pieces = size(image,1) * size(image,2) / blocksize^2;
    
    [imageblocks,M,N] = disorg(image,blocksize);
    [x,y] = meshgrid(1:N,1:M);
    puzzleimage = jointblocks(imageblocks,x(:),y(:));
    title(['Dataset (' dataset ') - ' num2str(blocksize) 'x' num2str(blocksize)...
        ' block - ' num2str(pieces) ' pieces - ',num2str(ii),filetype]);
    drawnow;
    
    [restoredimage,x,y,D] = LPsolve(imageblocks,M,N,maxiter);
    jointimage = greedymatch(x,y,M,N,D,imageblocks,'rgb');

    uicontrol('style','pushbutton','string','Continue','callback','close all');
    drawnow;
    uiwait(gcf);
end
