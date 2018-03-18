clear;clc;
load('databasealpha4.mat')         %load sinyal
% y=rawEEG;
y = database(1,:);                      %sinyal keberapa masukin ke y
% avrg_rawEEG=mean(rawEEG,2);
%         a=rawEEG-avrg_rawEEG;
%         normalized=a;
%         for i=1:1100
%             if normalized(i)>=200;
%                 normalized(i)=0;
%             elseif normalized(i)<=-200;
%                 normalized(i)=0;
%             else normalized(i)=normalized(i);
%             end
%         end
% y=normalized;
% figure;plot(y);
% axis ([0 35000 -1000 1000]);
L = length(y);
Fs=512;

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
sdbajsb=linspace(0,1,NFFT/2+1);
f = Fs/2*sdbajsb;


% Plot single-sided amplitude spectrum.
figure;plot(f,2*abs(Y(1:NFFT/2+1)));
% axis ([0 256 0 10]);
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%I added the next lines to find the value
%find maximum value, it should be the fundamental frequency (approximated)
[C,I]=max(2*abs(Y(1:NFFT/2+1)))
f(I)
