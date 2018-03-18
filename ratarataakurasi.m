load('akurasiujialpha.mat');
avrg_akurasi=mean(akurasi,2);
avrg_akurasi=[akurasi avrg_akurasi];
save avrg_akurasiujialpha.mat avrg_akurasi