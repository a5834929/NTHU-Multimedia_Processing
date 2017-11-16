function [minBlock, totalSAD] = twoDSearch(blockSize, searchRange, reference, frames, f1, f2)
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
                origx = x; origy = y;
                macroBlock = frames(y:y+offset, x:x+offset, f);
                checked = zeros(height, width);
                dist = floor(log2(searchRange));
                %----------------------------------------------------------
                while dist>1
                    dir = [0 0;dist 0;0 dist;-dist 0;0 -dist];
                    for d = 1:5
                        refx = origx + dir(d); refy = origy + dir(d+5);
                        if refx>0 && refy>0 && refx+offset<=width && refy+offset<=height && checked(refy, refx)==0
                            refBlock = frames(refy:refy+offset, refx:refx+offset, reference);
                            diff = abs(macroBlock-refBlock);
                            SAD = sum(sum(diff));
                            if SAD < minSAD
                                minSAD = SAD;
                                minBlock(y:y+offset, x:x+offset, f-f1+1) = refBlock;
                                minx = refx; miny = refy;
                            end
                            checked(refy, refx) = 1;
                        end
                    end
                    if (minx==origx && miny==origy) || (minx==x-searchRange || miny==y-searchRange || minx==x+blockSize+searchRange || miny==y+blockSize+searchRange)
                        dist = floor(dist/2);
                    else
                        origx = minx; origy = miny;
                    end
                end
                %----------------------------------------------------------
                for d1 = -1:1
                    for d2 = -1:1
                        refx = origx + d1; refy = origy + d2;
                        if refx>0 && refy>0 && refx+offset<=width && refy+offset<=height && checked(refy, refx)==0
                            refBlock = frames(refy:refy+offset, refx:refx+offset, reference);
                            diff = abs(macroBlock-refBlock);
                            SAD = sum(sum(diff));
                            if SAD < minSAD
                                minSAD = SAD;
                                minBlock(y:y+offset, x:x+offset, f-f1+1) = refBlock;
                                minx = refx; miny = refy;
                            end
                            checked(refy, refx) = 1;
                        end
                    end
                end
                %----------------------------------------------------------
                totalSAD(f-f1+1) = totalSAD(f-f1+1) + minSAD;
            end
        end
    end
   
end

