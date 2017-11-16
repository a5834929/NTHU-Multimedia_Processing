function hw2(window)
[x, fs] = wavread('hw2_mix.wav');

%---graph--------------------
L = 2^nextpow2(max(size(x)));
FFT = fft(x,L);
xx = fs/2*linspace(0,1,L/2+1);
plot(xx,abs(FFT(1:L/2+1)));title('Spectrum of input');
axis([0, 1600, 0, 25000]);


%filtering
[y1, filter1]=createFilter(x, fs, 1001, window, 'low-pass', 360);
[y2, filter2]=createFilter(x, fs, 1001, window, 'high-pass', 800);
[y3, filter3]=createFilter(x, fs, 1001, window, 'band-pass', [450,720]);

%---graph--------------------
time = (1:length(filter1))/fs;
figure;subplot(3, 3, 1);
plot(time, filter1); title('Shape of low-pass filter');
axis([0.002, 0.020, -0.005, 0.02]);

time = (1:length(filter2))/fs;
subplot(3, 3, 2);
plot(time, filter2); title('Shape of high-pass filter');
axis([0.002, 0.020, -0.04, 0.02]);

time = (1:length(filter3))/fs;
subplot(3, 3, 3);
plot(time, filter3); title('Shape of band-pass filter');
axis([0.002, 0.020, -0.012, 0.012]);



L = 2^nextpow2(max(size(filter1)));
FFT = fft(filter1,L);
xx = fs/2*linspace(0,1,L/2+1);
subplot(3, 3, 4);
plot(xx,abs(FFT(1:L/2+1))); title('Spectrum of low-pass filter');
axis([0, 1200, 0, 1.2]);

L = 2^nextpow2(max(size(filter2)));
FFT = fft(filter2,L);
xx = fs/2*linspace(0,1,L/2+1);
subplot(3, 3, 5);
plot(xx,abs(FFT(1:L/2+1))); title('Spectrum of high-pass filter');
axis([400, 1400, 0, 1.2]);

L = 2^nextpow2(max(size(filter3)));
FFT = fft(filter3,L);
xx = fs/2*linspace(0,1,L/2+1);
subplot(3, 3, 6);
plot(xx,abs(FFT(1:L/2+1))); title('Spectrum of band-pass filter');
axis([0, 1200, 0, 1.2]);


L = 2^nextpow2(max(size(y1)));
FFT = fft(y1,L);
xx = fs/2*linspace(0,1,L/2+1);
subplot(3, 3, 7);
plot(xx,abs(FFT(1:L/2+1))); title('Spectrum of output-low-pass');
axis([0, 1600, 0, 5000]);

L = 2^nextpow2(max(size(y2)));
FFT = fft(y2,L);
xx = fs/2*linspace(0,1,L/2+1);
subplot(3, 3, 8);
plot(xx,abs(FFT(1:L/2+1))); title('Spectrum of output-high-pass');
axis([0, 1600, 0, 5000]);

L = 2^nextpow2(max(size(y3)));
FFT = fft(y3,L);
xx = fs/2*linspace(0,1,L/2+1);
subplot(3, 3, 9);
plot(xx,abs(FFT(1:L/2+1))); title('Spectrum of output-band-pass');
axis([0, 1600, 0, 5000]);

% wavwrite(y1, fs, 'output_low_pass.wav');
% wavwrite(y2, fs, 'output_high_pass.wav');
% wavwrite(y3, fs, 'output_band_pass.wav');

end

