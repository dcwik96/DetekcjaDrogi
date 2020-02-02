I = imread("bright.png");
I2 = rgb2gray(I);

wiener = wiener2(I2);
K = filter2(fspecial('average',3),I2)/255;
med = medfilt2(I2);
K2 = filter2(fspecial('average',3),wiener)/255;
med2 = medfilt2(K2);

imLAB = rgb2lab(I);

patch = imcrop(imLAB,[34,71,60,55]);
patchSq = patch.^2;
edist = sqrt(sum(patchSq,3));
patchVar = std2(edist).^2;
DoS2 = 4*patchVar;
smoothedLAB2 = imbilatfilt(imLAB,DoS2,7);
smoothedRBG2 = lab2rgb(smoothedLAB2,'Out','uint8');

% subplot(3,2,1);
% imshow(I);
% title("Oryginalny")
% 
% 
% subplot(3,2,2);
% imshow(wiener);
% title("Wiener")
% 
% subplot(3,2,3);
% imshow(K);
% title("Usredniajacy")
% 
% subplot(3,2,4);
% imshow(med);
% title("medianowa")
% 
% subplot(3,2,5);
% imshow(smoothedRBG2);
% title("Wygładzenie z zachowaniem krawędzi")
% 
% subplot(3,2,6);
% imshow(med2);
% title("wien medianowa")

montage({I, wiener ...
    K, med ...
    smoothedRBG2, med2})
