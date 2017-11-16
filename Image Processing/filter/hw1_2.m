IMa = double(imread('thinker_gray_noised.jpg'));
[ra, ca] = size(IMa);
subplot(2, 4, 1);
imshow(uint8(IMa));
title('Original Thinker');
IMb = double(imread('bellTower_gray.jpg'));
[rb, cb] = size(IMb);
subplot(2, 4, 2);
imshow(uint8(IMb));
title('Original Tower');
IMc = double(imread('garden_gray.jpg'));
[rc, cc] = size(IMc);
subplot(2, 4, 4);
imshow(uint8(IMc));
title('Original Garden');
%------define all masks-----%
GB3 = [1 2 1;2 4 2;1 2 1];% Gaussian Blur 3x3
GB5 = [1 4 6 4 1;4 16 24 16 4;6 24 36 24 6;4 16 24 16 4;1 4 6 4 1];% Gaussian Blur 5x5
EDx = [1 1 1;0 0 0;-1 -1 -1];% Edge Detection x Direction
EDy = [-1 0 1;-1 0 1;-1 0 1];% Edge Detection y Direction
USp = [0 -1 0;-1 5 -1;0 -1 0];% Unsharp
%------replcate edge value for GB3-----%
tmp = zeros(ra+2, ca+2);
IMa3 = zeros(ra, ca);
for i=2:ra+1
   tmp(i, 2:ca+1) = IMa(i-1, :);
end
tmp(:, 1) = tmp(:, 2);
tmp(:, end) = tmp(:, end-1);
tmp(1, :) = tmp(2, :);
tmp(end, :) = tmp(end-1, :);
%------implement GB3-----%
for i=2:ra+1
   for j=2:ca+1
       sum = 0;
       mi = 1;
       for ii=i-1:i+1
           mj = 1;
           for jj=j-1:j+1
               sum = sum + tmp(ii, jj)*GB3(mi, mj);
               mj = mj + 1;
           end
           mi = mi + 1;
       end
       IMa3(i-1, j-1) = sum/16;
   end
end
subplot(2, 4, 5);
imshow(uint8(IMa3));
title('Gaussian Blur with 3x3 Kernel');
%------replcates edge value for GB5-----%
tmp1 = zeros(ra+4, ca+4);
IMa5 = zeros(ra, ca);
for i=2:ra+3
   tmp1(i, 2:ca+3) = tmp(i-1, :);
end
tmp1(:, 1) = tmp1(:, 2);
tmp1(:, end) = tmp1(:, end-1);
tmp1(1, :) = tmp1(2, :);
tmp1(end, :) = tmp1(end-1, :);
%------implement GB5-----%
for i=3:ra+2
   for j=3:ca+2
       sum = 0;
       mi = 1;
       for ii=i-2:i+2
           mj = 1;
           for jj=j-2:j+2
               sum = sum + tmp1(ii, jj)*GB5(mi, mj);
               mj = mj + 1;
           end
           mi = mi + 1;
       end
       IMa5(i-2, j-2) =  sum/256;
   end
end
subplot(2, 4, 6);
imshow(uint8(IMa5));
title('Gaussian Blur with 5x5 Kernel');
%------replcates edge value for ED-----%
tmp = zeros(rb+2, cb+2);
for i=2:rb+1
   tmp(i, 2:cb+1) = IMb(i-1, :);
end
IMb = zeros(rb, cb);
tmp(:, 1) = tmp(:, 2);
tmp(:, end) = tmp(:, end-1);
tmp(1, :) = tmp(2, :);
tmp(end, :) = tmp(end-1, :);
%------implement EDx-----%
for i=2:rb+1
   for j=2:cb+1
       sum = 0;
       mi = 1;
       for ii=i-1:i+1
           mj = 1;
           for jj=j-1:j+1
               sum = sum + tmp(ii, jj)*EDx(mi, mj);
               mj = mj + 1;
           end
           mi = mi + 1;
       end
       if(sum>255) sum=255;
       else if(sum<0) sum=0;
           end
       end
       IMb(i-1, j-1) =  sum;
   end
end
subplot(2, 4, 3);
imshow(uint8(IMb));
title('Edge Detection in X direction');
%------implement EDy-----%
for i=2:rb+1
   for j=2:cb+1
       sum = 0;
       mi = 1;
       for ii=i-1:i+1
           mj = 1;
           for jj=j-1:j+1
               sum = sum + tmp(ii, jj)*EDy(mi, mj);
               mj = mj + 1;
           end
           mi = mi + 1;
       end
       if(sum>255) sum=255;
       else if(sum<0) sum=0;
           end
       end
       IMb(i-1, j-1) =  sum;
   end
end
subplot(2, 4, 7);
imshow(uint8(IMb));
title('Edge Detection in Y direction');
%------replcates edge value for USp-----%
tmp = zeros(rc+2, cc+2);
for i=2:rc+1
   tmp(i, 2:cc+1) = IMc(i-1, :);
end
IMc = zeros(rc, cc);
tmp(:, 1) = tmp(:, 2);
tmp(:, end) = tmp(:, end-1);
tmp(1, :) = tmp(2, :);
tmp(end, :) = tmp(end-1, :);
%------implement USp-----%
for i=2:rc+1
   for j=2:cc+1
       sum = 0;
       mi = 1;
       for ii=i-1:i+1
           mj = 1;
           for jj=j-1:j+1
               sum = sum + tmp(ii, jj)*USp(mi, mj);
               mj = mj + 1;
           end
           mi = mi + 1;
       end
       IMc(i-1, j-1) =  sum;
   end
end
subplot(2, 4, 8);
imshow(uint8(IMc));
title('Unsharp Mask');


