P = [50 150;450 150;50+400*cos(pi/3) 150+400*sin(pi/3); 50 150];
subplot(2, 3, 1); plot(P(:,1), P(:,2));
hold on; axis([0 500 50 550]);
for iter = 1:5
    newP = zeros(size(P,1)*4+1, 2);
    for i=1:size(P,1)-1
        newP(4*i+1,:) = P(i,:);
        newP(4*i+2,:) = (2*P(i,:) + P(i+1,:))/3;
        vector = P(i+1,:)-P(i,:);
        theta = atan2(vector(2), vector(1));
        vectorLen = sqrt(sum(vector.^2));
        newP(4*i+3,:) = newP(4*i+2,:) + (vectorLen/3)*[cos(theta-pi/3), sin(theta-pi/3)];
        newP(4*i+4,:) = (P(i,:) + 2*P(i+1,:))/3;
    end
    newP(4*size(P,1)+1,:) = P(size(P,1),:);
    nonzero = newP(:, 1)>0;
    P = cat(3, newP(nonzero, 1), newP(nonzero, 2));
    subplot(2, 3, iter+1); plot(P(:,1), P(:,2));
end