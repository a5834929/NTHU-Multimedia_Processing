function [y, filter] = createFilter(in, fs, N, window, pass, fc)

% Normalization
fc=fc/fs;
middle=round(N/2);
fltr=zeros(1, N);

% filter
if strcmp(pass,'low-pass')==1
    for n=-round(N/2)+1:round(N/2)
        if n==0
            fltr(middle)=1;
        else
            fltr(n+middle)=sin(2*pi*fc*n)/(pi*n);
        end
    end
    fltr(middle)=2*fc;
elseif strcmp(pass,'high-pass')==1
    for n=-round(N/2)+1:round(N/2)
        if n==0
            fltr(middle)=1;
        else
            fltr(n+middle)=-sin(2*pi*fc*n)/(pi*n);
        end
    end
    fltr(middle)=1-2*fc;
elseif strcmp(pass,'band-pass')==1
    for n=-round(N/2)+1:round(N/2)
        if n==0
            fltr(middle)=1;
        else
            fltr(n+middle)=(sin(2*pi*fc(2)*n)-sin(2*pi*fc(1)*n))/(pi*n);
        end
    end
    fltr(middle)=2*(fc(2)-fc(1));
end

% window
if strcmp(window,'Hanning')==1
    for n = -round(N/2)+1:round(N/2)
    fltr(middle+n) = fltr(middle+n)*(0.5+0.5*cos((2*pi*n)/N));
    end
elseif strcmp(window,'Hamming')==1
    for n = -round(N/2)+1:round(N/2)
    fltr(middle+n) = fltr(middle+n)*(0.54+0.46*cos((2*pi*n)/N));
    end
elseif strcmp(window,'Blackman')==1
    for n = -round(N/2)+1:round(N/2)
    fltr(middle+n) = fltr(middle+n)*(0.42+0.5*cos((2*pi*n)/(N-1))+0.08*cos((4*pi*n)/(N-1)));
    end
end

filter=fltr;
leni=length(in);
lenj=length(fltr);
y=zeros(1, leni);

for i=1:leni
    for j=1:lenj
        if(i-j>0)
            y(i) = y(i) + in(i-j)*fltr(j);
        end
    end
end

