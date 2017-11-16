X = double(imread('panda_gray.jpg'));
X = X(:, :, 1);
[w, l] = size(X);
X(w+1, :) = X(w, :);
X(:, l+1) = X(:, l);
W = 4*w; L = 4*l;
NN = zeros(W, L);
BI = zeros(W, L);

for i=1:W
    for j=1:L
        a = i/4;
        b = j/4;
        NNi = round(a); NNj = round(b);
        BIi = floor(a); BIj = floor(b);
        if(NNi==0) NNi = 1; end 
        if(NNj==0) NNj = 1; end
        if(BIi==0) BIi = 1; end
        if(BIj==0) BIj = 1; end
        NN(i, j) = X(NNi, NNj);
        for ii=BIi:BIi+1
            for jj=BIj:BIj+1
                BI(i, j) = BI(i, j) + X(ii, jj)*abs((1-abs(a-ii))*(1-abs(b-jj)));
            end
        end
    end
end

subplot(1, 2, 1);imshow(uint8(NN));axis image;
title('Nearest Neighbor');
subplot(1, 2, 2);imshow(uint8(BI));axis image;
title('Bilinear');
