akurasi=[];
nama=('databasebeta');
for i=1:4
 angka=num2str(i);
 namaangka=[nama angka];
 load(namaangka);
 for j=1:15
     k=j;
     akurasitemp=pelatihan(k,database);
     akurasi(i,j)=akurasitemp;
 end
end
save akurasilatihbeta.mat akurasi