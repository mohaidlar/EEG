akurasi=[];
base=('databasealpha');
uji=('dataujialpha');
for i=1:4
 angka=num2str(i);
 baseangka=[base angka];
 ujiangka=[uji angka];
 load(ujiangka);
 datauji=database;
 load(baseangka);
 for j=1:15
     k=j;
     akurasitemp=pengujian(k,database,datauji);
     akurasi(i,j)=akurasitemp;
 end
end
save akurasiujialpha.mat akurasi