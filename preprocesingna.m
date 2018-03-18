clear;clc;close all
load Waveletfams.mat
waveletfamily=waveletfamily';
simpanakurasi=[];
for kocak=1:length(waveletfamily)
family_folder = [cd, '\database'];
dirFamily_folder = dir(family_folder);
database=[];
fiturlatih=[];
fituruji=[];
jumlah=0;
jumlah1=0;
waveletFunction=waveletfamily{kocak};

for i=3:length(dirFamily_folder)
    
    folder=[family_folder, '\' dirFamily_folder(i).name];
    dirFolder = dir(folder);
    
    for j=3:length(dirFolder)
        
        dirfile=[folder, '\', dirFolder(j).name];
        load(dirfile);
        avrg_rawEEG=mean(rawEEG,2);
        normalized=rawEEG-avrg_rawEEG;
        for i=1:length(normalized)
            if normalized(i)>=200
                normalized(i)=0;
            elseif normalized(i)<=-200
                normalized(i)=0;
            else
                normalized(i)=normalized(i);
            end
        end
        
        extractedalfa=ekstraksialpha(normalized,waveletFunction);
        
        [meannya,varnya,stdnya,frekuensinya,amplitudomax,amplitudomin,mfcc]=ekstraksiciriEEG(extractedalfa);
        
        jumlah=jumlah+1;
        Ekstraksiciri1(jumlah).Means = meannya;
        Ekstraksiciri1(jumlah).Varians = varnya;
        Ekstraksiciri1(jumlah).STD = stdnya;
        Ekstraksiciri1(jumlah).frekuensi = frekuensinya;
        Ekstraksiciri1(jumlah).amplitudomax = amplitudomax;
        Ekstraksiciri1(jumlah).amplitudomin = amplitudomin;
        Ekstraksiciri1(jumlah).mfcc = mfcc;
        
        extractedbeta=ekstraksibeta(normalized,waveletFunction);
        
        [meannya1,varnya1,stdnya1,frekuensinya1,amplitudomax1,amplitudomin1,mfcc1]=ekstraksiciriEEG(extractedbeta);
        
        %Mengelompokan fitur berdasarkan data
        if (jumlah>=1 && jumlah<=15)
            group(jumlah)={'ngantuk'};
        elseif (jumlah>=16 && jumlah<=30)
            group(jumlah)={'normal'};
        end
        
        %ekstraksi ciri
        %1. mean
        %2. var
        %3. std
        %4. frekuensi
        %5. ampl max
        %6. ampl min
        %7. mfcc
        %kalau mau ganti ciri yang mau diklasifikasikan untuk data latih
        cirinya=[varnya stdnya varnya1 stdnya1];
        fiturlatih=[fiturlatih;cirinya];
        %
        %         subplot(2,1,1)
        %         plot(normalized)
        %         title('Sinyal EEG ternormalisasi');
        %         ylim([-200 200])
        %         xlim([0 30720])
        %         subplot(2,1,2)
        %         plot(extracted)
        %         ylim([-200 200])
        %         xlim([0 30720])
        %         title('Sinyal EEG pada frekuensi alfa');
    end
end
% save CiriTheta.mat Ekstraksiciri
group=group';



family_folder = [cd, '\datauji'];
dirFamily_folder = dir(family_folder);
database=[];

for i=3:length(dirFamily_folder)
    
    folder=[family_folder, '\' dirFamily_folder(i).name];
    dirFolder = dir(folder);
    
    for j=3:length(dirFolder)
        
        dirfile=[folder, '\', dirFolder(j).name];
        load(dirfile);
        avrg_rawEEG=mean(rawEEG,2);
        normalized=rawEEG-avrg_rawEEG;
        for i=1:length(normalized)
            if normalized(i)>=200
                normalized(i)=0;
            elseif normalized(i)<=-200
                normalized(i)=0;
            else
                normalized(i)=normalized(i);
            end
        end
        
        extractedalfa=ekstraksialpha(normalized,waveletFunction);
        [meannya,varnya,stdnya,frekuensinya,amplitudomax,amplitudomin,mfcc]=ekstraksiciriEEG(extractedalfa);
        
        extractedbeta=ekstraksibeta(normalized,waveletFunction);
        [meannya1,varnya1,stdnya1,frekuensinya1,amplitudomax1,amplitudomin1,mfcc1]=ekstraksiciriEEG(extractedbeta);
        
        %ekstraksi ciri
        %1. mean
        %2. var
        %3. std
        %4. frekuensi
        %5. ampl max
        %6. ampl min
        %7. mfcc
        %kalau mau ganti ciri yang mau diklasifikasikan untuk data uji
        ciriuji=[varnya stdnya varnya1 stdnya1];
        
        fituruji=[fituruji;ciriuji];
        jumlah=jumlah+1;
    end
end

cl = fitcsvm(fiturlatih,group);

c = fitcknn(fiturlatih,group,'NumNeighbors',3,...
    'NSMethod','exhaustive','Distance','euclidean',...
    'Standardize',1); %Untuk Matlab di Atas Versi 2017a
%Melakukan klasifikasi dengan K-NN yang telah terlatih sebelumnya

class=predict(cl,fituruji);
akurasi=0;
for l=1:length(class)
    kelas=class{l};
    if l>=1 && l<=15
        cek=strcmp(kelas,'ngantuk');
        if cek==1
            akurasi=akurasi+1;
        end
    elseif l>=16 && l<=30
        cek=strcmp(kelas,'normal');
        if cek==1
            akurasi=akurasi+1;
        end
    end
end

% r = xcorr(fiturlatih,fituruji);

persenakurasi=akurasi/length(class)*100
simpanakurasi=[simpanakurasi;persenakurasi];
end
