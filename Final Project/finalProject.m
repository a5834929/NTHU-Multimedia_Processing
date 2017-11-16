clear all;

input = load('InputAudioGTChords.txt');
[y, fs] = audioread('InputAudio.wav');
y = y(:, 1);
time = (1:length(y))/fs;
[chordTemplate, chordKey] = makeTemplate();
range = makeRange();
N = length(input);

%out = getmeasures2('InputAudio.wav');
%N = length(out.measures);

for c=2:N    
    if c<N
        [amp ,freq] = HPS(y(floor(input(c,1)*fs):ceil(input(c,2)*fs)), fs);
    else
        [amp ,freq] = HPS(y(floor(input(c,1)*fs):end), fs);
    end
	
%	if c<N
%        [amp ,freq] = HPS(y(floor(out.measrues(c-1)*fs):ceil(out.measrues(c)*fs)), fs);
%    else
%        [amp ,freq] = HPS(y(floor(out.measrues(c-1)*fs):end), fs);
%    end
    
    amp(length(freq)) = 0;
    
    for b=1:12
        CH(b) = 0;
        for m = 1:8
            target = find(freq>=range(m, b) & freq<=range(m, b+1));
            CH(b) = CH(b) + sum(amp(target)) / size(target, 2);
        end
    end

    CH = (CH-min(CH))./(max(CH)-min(CH)); 
    
    figure, plot(CH);
    set(gca, 'XTick', 1:12);
    set(gca, 'XTickLabel', chordKey);
    
    for i=1:24
        Chord(i) = CH*chordTemplate(i, :)';
    end
    
    [~, maxInd] = max(Chord);
    outNum(c)=maxInd;
end

outChord = '';
outChord{1} = 'N';
for c=2:N-1
    if mod(outNum(c), 12)==0, outChord{c} = chordKey{12};
    else outChord{c} = chordKey{mod(outNum(c), 12)};
    end
    if( outNum(c)>12 ) outChord{c} = strcat(outChord{c},':min');
    else outChord{c} = strcat(outChord{c},':maj');
    end
end
outChord{N} = 'N';

fid = fopen('InputAudio.txt', 'w');
for i=1 : N
    fprintf(fid, '%s\n',outChord{i} );
end
fclose(fid);

