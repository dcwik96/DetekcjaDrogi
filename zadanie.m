% Wczytanie obrazów
% I = imread('bright.png');
 I = imread('park.png');
% I = imread('snow.png');

% Przekształcenie obrazka do skali szarości
BW = rgb2gray(I);

% Dostosowanie kontrastu do obrazu RGB
contrast = imadjust(BW);

% Wygładzenie obrazka z wykorzystaniem filtru Wienera
% a następnie filtracji medianowej
wiener = wiener2(contrast);
med = medfilt2(wiener);

% Binaryzacja
binarized = imbinarize(med);

ST = strel('line',3,90);
open = imopen(binarized, ST);
close = imclose(open, ST);
 
ST = strel('disk',5);
open = imopen(close, ST);
close = imclose(open, ST);
 
BW2 = bwareaopen(close, 500);

% Wykrywanie krawędzi Canny
canny = edge(BW2, 'canny',0.3);

% Rysowanie linii metoda Hough
[H,theta,rho] = hough(canny);
P = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(canny,theta,rho,P,'FillGap',30,'MinLength',1);

imshow(med), hold on;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','white');


   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
hold off;
