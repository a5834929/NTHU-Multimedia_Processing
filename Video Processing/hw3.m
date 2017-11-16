function hw3(blockSize, searchRange, referenceCase, searchMode)
    frames = zeros(400, 512, 20);
    tmp = zeros(400, 512, 3);
    for i=1:20
        if(i<10), str = strcat('hw3_pics/caltrain00',num2str(i),'.bmp');
        else str = strcat('hw3_pics/caltrain0',num2str(i),'.bmp');
        end
        tmp = double(imread(str));
        frames(:, :, i) = tmp(:, :, 1); 
    end
    tic
    %-----fullsearch-----------------------------------------------------
    if strcmp(searchMode, 'full')==1
        str = sprintf('PSNR(blockSize=%d, range=%d)', blockSize, searchRange);
        if referenceCase == 1
            [estimate, SAD] = fullSearch(blockSize, searchRange, 1, frames, 2, 20);
            res = abs(estimate-frames(:, :, 2:20));
            toc
            for j = 1:19
                fprintf('%d ', SAD(j));
                figure, imshow(uint8(res(:, :, j)));
            end
            MSE = sum(sum(res.^2))/400/512;
            PSNR = 10*log10((255^2)/MSE);
            fPSNR(1) = NaN;
            fPSNR(2:20) = PSNR;
            plot(1:20, fPSNR);title(str);

        else
            [estimate1, SAD1]= fullSearch(blockSize, searchRange, 1, frames, 2, 10);
            [estimate2, SAD2]= fullSearch(blockSize, searchRange, 11, frames, 12, 20);
            res1 = abs(estimate1-frames(:, :, 2:10));
            res2 = abs(estimate2-frames(:, :, 12:20));
            toc
            for j = 1:9
                fprintf('%d ', SAD1(j));
                figure, imshow(uint8(res1(:, :, j)));
            end
            for j = 1:9
                fprintf('%d ', SAD2(j));
                figure, imshow(uint8(res2(:, :, j)));
            end
            MSE = sum(sum(res1.^2))/400/512;
            PSNR = 10*log10((255^2)/MSE);
            fPSNR(1) = NaN;
            fPSNR(2:10) = PSNR;
            MSE = sum(sum(res2.^2))/400/512;
            PSNR = 10*log10((255^2)/MSE);
            fPSNR(11) = NaN;
            fPSNR(12:20) = PSNR;
            plot(1:20, fPSNR);title(str);

        end
     %-----2Dsearch-----------------------------------------------------
    else if strcmp(searchMode, '2d')==1
        str = sprintf('PSNR(blockSize=%d, range=%d)', blockSize, searchRange);
        if referenceCase == 1
            [estimate, SAD] = twoDSearch(blockSize, searchRange, 1, frames, 2, 20);
            res = abs(estimate-frames(:, :, 2:20));
            toc
            for j = 1:19
                fprintf('%d ', SAD(j));
                figure, imshow(uint8(res(:, :, j)));
            end
            MSE = sum(sum(res.^2))/400/512;
            PSNR = 10*log10((255^2)/MSE);
            fPSNR(1) = NaN;
            fPSNR(2:20) = PSNR;
            plot(1:20, fPSNR);title(str);
            
        else
            [estimate1, SAD1] = twoDSearch(blockSize, searchRange, 1, frames, 2, 10);
            [estimate2, SAD2] = twoDSearch(blockSize, searchRange, 11, frames, 12, 20);
            res1 = abs(estimate1-frames(:, :, 2:10));
            res2 = abs(estimate2-frames(:, :, 12:20));
            toc
            for j = 1:9
                fprintf('%d ', SAD1(j));
                figure, imshow(uint8(res1(:, :, j)));
            end
            for j = 1:9
                fprintf('%d ', SAD2(j));
                figure, imshow(uint8(res2(:, :, j)));
            end
            MSE = sum(sum(res1.^2))/400/512;
            PSNR = 10*log10((255^2)/MSE);
            fPSNR(1) = NaN;
            fPSNR(2:10) = PSNR;
            MSE = sum(sum(res2.^2))/400/512;
            PSNR = 10*log10((255^2)/MSE);
            fPSNR(11) = NaN;
            fPSNR(12:20) = PSNR;
            plot(1:20, fPSNR);title(str);
        end
    end
end

