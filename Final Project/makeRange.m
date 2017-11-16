function range = makeRange()

range = zeros(8, 13);
range(1, :) = [15.892, 16.838, 17.839, 18.899, 20.023, 21.214, 22.476, 23.812, 25.228, 26.728, 28.317, 30, 31.785];
for n = 2:8
    range(n, :) = range(n-1, :)*2;
end

end
