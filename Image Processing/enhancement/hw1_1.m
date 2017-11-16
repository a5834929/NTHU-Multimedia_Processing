RGB = imread('ChangKungLake.jpg');
subplot(2,3,1); imshow(uint8(RGB));
title('Original');
[w, l, d] = size(RGB);
RGB = double(RGB);
R = RGB(:, :, 1);
G = RGB(:, :, 2);
B = RGB(:, :, 3);
RGB = cat(1, R(:)', G(:)', B(:)');

theta = [0.299 0.587 0.114;0.596 -0.275 -0.321;0.212 -0.523 0.311];
YIQ = theta*RGB;
Y = YIQ(1, :);
I = YIQ(2, :);
Q = YIQ(3, :);
YIQ = cat(3, reshape(Y, w, l), reshape(I, w, l), reshape(Q, w, l));  
subplot(2,3,2); imshow(uint8(YIQ));
title('Original YIQ');
subplot(2,3,5);
hist(Y(:), 0:255);
title('Original Y Channel');
gt150 = sum(Y>150)
percentage = gt150/(l*w)

r =  4;
Y = ((Y./255).^r).*255;
YIQ = cat(3, reshape(Y, w, l), reshape(I, w, l), reshape(Q, w, l));
subplot(2,3,3); imshow(uint8(YIQ));
title('YIQ with Gamma = 4');
subplot(2,3,6); 
hist(Y(:), 0:255);
title('Y Channel with Gamma = 4');
gt150 = sum(Y>150)
percentage = gt150/(l*w)

RGB = theta\[Y;I;Q];
RGB = cat(3, RGB(1, :), RGB(2, :), RGB(3, :));
RGB = reshape(RGB, w, l, 3);
subplot(2,3,4); imshow(uint8(RGB));
title('Final Image');

