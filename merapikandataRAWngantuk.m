clear;clc;close all;
family_folder = [cd, '\baru'];
dirFamily_folder = dir(family_folder);
database=[];
jumlah=1;

for i=3:length(dirFamily_folder)
    dirfile=[family_folder, '\', dirFamily_folder(i).name];
    load(dirfile);
    normalized=rawEEG;
%     avrg_rawEEG=mean(rawEEG,2);
%     normalized=rawEEG-avrg_rawEEG;
    panjang=length(normalized);
    posisiakhir=0;
    posisiawal=1;
    cekframe=1;
    if panjang>=30720
        while posisiakhir<=panjang
            posisiakhir=posisiawal-1+30720;
            if posisiakhir<=panjang
                cekframe=cekframe+1;
                frame=normalized(posisiawal:posisiakhir);
                lebihTH=find(frame>200);
                kurangTH=find(frame<-200);
                hasil=[lebihTH kurangTH];
                kalau=length(hasil);
                rawEEG=frame;
                if kalau<=50
                    eval(['save ngantukRAW' num2str(jumlah) '.mat rawEEG']);
                    jumlah=jumlah+1
                    figure
                    plot(rawEEG)
                    ylim([-200 200])
                    xlim([0 30720])
                    title('data RAW ngantuk belum ternormalisasi')
                end
                posisiawal=posisiawal+10000;
            end
        end
    end
end
%     for i=1:1100
%         if normalized(i)>=200;
%             normalized(i)=0;
%         elseif normalized(i)<=-200;
%             normalized(i)=0;
%         else normalized(i)=normalized(i);
%         end
%     end
% %     extracted = ekstraksialpha(normalized);
%     extracted = ekstraksibeta(normalized);
%     extractedfft=abs(fft(extracted));

%
% save databasealphasym1.mat database
% clear
% clc