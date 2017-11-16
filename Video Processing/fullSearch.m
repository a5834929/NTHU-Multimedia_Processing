function [minBlock, totalSAD]= fullSearch(blockSize, searchRange, reference, frames, f1, f2)
    frameSize = size(frames);
    height = frameSize(1);
    width = frameSize(2);
    offset = blockSize-1;
    minBlock = zeros(height, width, f2-f1+1);
    totalSAD = zeros(f2-f1+1);
    
    for f = f1:f2
        for x = 1:blockSize:width
            for y = 1:blockSize:height
                minSAD = inf;
                macroBlock = frames(y:y+offset, x:x+offset, f);
                for i = x-searchRange:x+searchRange    
                    for j = y-searchRange:y+searchRange
                        if i>0 && j>0 && i+offset<=width && j+offset<=height
                            refBlock = frames(j:j+offset, i:i+offset, reference);
                            diff = abs(macroBlock-refBlock);
                            SAD = sum(sum(diff));
                            if SAD < minSAD
                                minSAD = SAD;
                                minBlock(y:y+offset, x:x+offset, f-f1+1) = refBlock;
                            end
                        end
                    end
                end
                totalSAD(f-f1+1) = totalSAD(f-f1+1) + minSAD;
            end
        end
    end
  
end

