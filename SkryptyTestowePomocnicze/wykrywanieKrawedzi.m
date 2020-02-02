%Skrypt porównujący działanie metod wykrywania krawędzi


%[I, map] = imread("snow.png");
%I = rgb2gray(I);
I = BW2;

%wykrywanie krawedzi
[sobelVertical, tre] = edge(I, 'sobel', 'vertical');
[sobelHorizontal, tre2] = edge(I, 'sobel', 'horizontal');
%---
sobelVerticalWithParam = edge(I, 'sobel', 0.04, 'vertical');
sobelHorizontalWithParam = edge(I, 'sobel', 0.04, 'horizontal');
%---
sob90 = [0 1 2;
    -1 0 1;
    -2 -1 0;
    ];
sob315 = [1  2  1;
    0  0  0;
    -1 -2 -1;
    ];


sobel90 = imfilter(I, sob90);
sobel90 = mat2gray(sobel90);
sobel315 = imfilter(I, sob315);
sobel315 = mat2gray(sobel315);
%---
[a, threshold] = edge(I);
gausse = edge(I, 'log', 0.005);
canny = edge(I, 'canny',0.3);

% subplot(4,2,1);
% imshow(sobelVertical);
% title("sobel - vertical")
% subplot(4,2,2);
% imshow(sobelHorizontal);
% title("sobel - horizontal")
% subplot(4,2,3);
% imshow(sobelVerticalWithParam);
% title("sobel - vertical param")
% subplot(4,2,4);
% imshow(sobelHorizontalWithParam);
% title("sobel - horizontal param");
% subplot(4,2,5);
% imshow(sobel90);
% title("sobel - 90")
% subplot(4,2,6);
% imshow(sobel315);
% title("sobel - 315");
% subplot(4,2,7);
% imshow(gausse);
% title("gausse 0.005")
% subplot(4,2,8);
% imshow(canny);
% title("canny 0.5");

montage({BW2, sobelVertical, sobelHorizontal ...
    sobelVerticalWithParam, sobelHorizontalWithParam ...
    sobel90, sobel315 ...
    gausse, canny})



