function [imageBlocks,rows,cols] = disorg(image,blockSize)
%DISORG 将原图像打乱，划分为 blocksize x blocksize x 3 x n 小块
%   image: 原图像（imdouble）
%   blockSize: 拼图正方形小块边长
%   imageblocks: 拆分并打乱后的小块
%   rows: 拼图行数
%   cols: 拼图列数
%
%   CVX-Jigsaw

imageSize = size(image);
rows = floor(imageSize(1) / blockSize);
cols = floor(imageSize(2) / blockSize);
partsNum = rows * cols;

image = image(1:rows*blockSize,1:cols*blockSize,:);

rgbPartsArray = zeros([blockSize,blockSize,3,partsNum],class(image));

for i = 1:partsNum
    rowStartIndex = (ceil(i/cols)-1) * blockSize + 1;
    rowEndIndex = rowStartIndex + (blockSize-1);
    colStartIndex = mod(i-1, cols)  * blockSize + 1;
    colEndIndex = colStartIndex + (blockSize-1);
    rgbPartsArray(:,:,:,i) = image(rowStartIndex:rowEndIndex,colStartIndex:colEndIndex,:);
end

partsOrder = randperm(partsNum);
imageBlocks = rgbPartsArray(:,:,:,partsOrder);

end

