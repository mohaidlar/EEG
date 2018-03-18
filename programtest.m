clear;clc;
% load dataujialpha7.mat;
load dataujialpha3.mat;
datauji=database;

% load databasealpha7.mat;
load databasealpha3.mat;
k=5;

hasilknn = [];
kelaserror = 0;
[n m] = size(datauji);

Xtrain = database;
Ltrain = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ...
    2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
Ltrain = Ltrain';
Xtest = datauji;
% Ltest = kelas;
% Ltest = Ltrain;
Ltest = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

for i = 1:n
    Xtest = datauji(i,:);
    output = KNN(Xtrain,Ltrain,Xtest, k);
    hasilknn = [hasilknn;output];
end

for j = 1:n
    if Ltest(j) ~= hasilknn(j)
        kelaserror = kelaserror+1;
    end
end

akurasi = ((n - kelaserror)/n)*100;
testacc = 'Done!\nAccuracy = %8.3f%%\n';
fprintf(testacc,akurasi);