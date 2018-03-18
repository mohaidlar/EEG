function [meannya,varnya,stdnya,frekuensinya,amplitudomax,amplitudomin,mfcc]=ekstraksiciriEEG(sinyal)

meannya=mean(sinyal);

varnya=var(sinyal);

stdnya=std(sinyal);

amplitudomax=max(sinyal);

amplitudomin=min(sinyal);

nfft = 2^nextpow2(length(sinyal));
df = fft(sinyal,nfft);
freq = 512/2*linspace(0,1,nfft/2+1);
mdf = abs(df(1:nfft/2+1));
[~,posisi_f]=max(mdf);
frekuensinya=freq(1,posisi_f);

mfcc=mfcc_calc(sinyal);

