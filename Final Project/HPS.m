function [amp, freq] = HPS(frame, fs)

windowed = frame .* hanning(length(frame));

L = 2^nextpow2(max(size(windowed)));
FFT = fft(windowed, L);
FFT = FFT(1:L/2+1);
x = fs/2*linspace(0,1,L/2+1);
FFT = abs(FFT);

%figure, plot(x, FFT);title('after FFT');

%hps1 = downsample(FFT,1);
%hps2 = downsample(FFT,2);
%hps3 = downsample(FFT,3);
%hps4 = downsample(FFT,4);
%hps5 = downsample(FFT,5);

hps1 = downsample(FFT, 1);
hps2 = downsample(FFT, 2);
hps3 = downsample(FFT, 4);
hps4 = downsample(FFT, 8);

y = zeros(1, length(hps4));
for i=1:length(hps4)
      product = hps1(i) * hps2(i) * hps3(i) * hps4(i);% * hps5(i);
      y(i) = product;
end

%[m, n] = sort(y, 'descend');
%figure, plot(x(1:length(y)), y);title('after HPS');hold on;
%plot(x(n(1:4)), m(1:4), 'ro');
amp = y;
freq = x;

end

