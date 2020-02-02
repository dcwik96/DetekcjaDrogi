%Skrypt binaryzujacy obraz nastepnie otwiera go i zamyka
% [I, map] = imread("snow.png");
% I = rgb2gray(I);

binarized = imbinarize(med);
gornyprog = med > 140;

ST = strel('line',3,90);
open = imopen(binarized, ST);
close = imclose(open, ST);
 
ST = strel('disk',5);
open2 = imopen(close, ST);
close2 = imclose(open2, ST);
 
BW2 = bwareaopen(close2, 500);

% subplot(2,2,1)
% imshow(med)
% title("Obraz podstawowy")
% subplot(2,2,2)
% imshow(I2)
% title("Binaryzacja")
% 
% subplot(2,2,3)
% imshow(open)
% title("Otwarcie binaryzacji")
% subplot(2,2,4)
% imshow(close)
% title("Zamkniecie otwarcia ")



montage({med, binarized ...
    gornyprog, open2 ...
    close2, BW2})
