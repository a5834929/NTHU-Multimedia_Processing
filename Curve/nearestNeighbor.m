X = double(imread('rabbit.jpg'));
[w, l, h] = size(X);
X(w+1, :, :) = X(w, :, :);
X(:, l+1, :) = X(:, l, :);
W = 4*w; L = 4*l;
NN = zeros(W, L, h);

for rgb=1:h
    for i=1:W
        for j=1:L
            a = i/4;
            b = j/4;
            NNi = round(a); NNj = round(b);
            if(NNi==0) NNi = 1; end 
            if(NNj==0) NNj = 1; end
            NN(i, j, rgb) = X(NNi, NNj, rgb);
        end
    end
end

imshow(uint8(NN));

