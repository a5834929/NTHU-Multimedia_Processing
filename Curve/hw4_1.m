P = textread('Points.txt');
P(end+1, :) = P(1, :);
M = [-1 3 -3 1; 3 -6 3 0; -3 3 0 0 ; 1 0 0 0 ];
n = 100;
t = linspace(0, 1, n)';
T = [t.^3 t.^2 t ones(n, 1)];
XY = [];

for i = 1:3:50     
   if i+3<=50
        XY = cat(1, XY, T * M * P(i:i+3, :));
   end
end
XY(end, :) = P(1, :);
figure, plot(XY(:, 1), -XY(:, 2)+600, 'b-', 'lineWidth', 2); hold on;
plot(P(:, 1), -P(:, 2)+600, 'ro');
axis ([0 600 0 600]);

newP = P*4;
newXY = [];
for i = 1:3:50     
   if i+3<=50
        newXY = cat(1, newXY, T * M * newP(i:i+3, :));
   end
end
newXY(end, :) = newP(1, :);
figure, plot(newXY(:, 1), -newXY(:, 2)+2500, 'b-', 'lineWidth', 2); hold on;
plot(newP(:, 1), -newP(:, 2)+2500, 'ro');
axis ([0 2500 0 2500]);
