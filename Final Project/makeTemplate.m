function [chordTemplate, chordKey] = makeTemplate()

X = zeros(12, 12); 
X(1, :) = [1 0 0 0 1 0 0 1 0 0 0 0];    

Xmin = zeros(12, 12);   
Xmin(1, :) = [1 0 0 1 0 0 0 1 0 0 0 0];

for family = 2:12
    for bin = 1:12
        i = bin-1;
        if i==0, i = 12; end
        X(family, bin) = X(family-1, i);
        Xmin(family, bin) = Xmin(family-1, i);
    end
end

chordTemplate = [X;Xmin];
chordKey = {'C', 'C#', 'D', 'Eb', 'E', 'F', 'F#', 'G', 'G#', 'A', 'Bb', 'B'};

end

