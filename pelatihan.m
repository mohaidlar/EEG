function akurasi=pelatihan(k,database);

hasilknn = [];
kelaserror = 0;
[n m] = size(database);

Xtrain = database;
Ltrain = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ...
    2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
Ltrain = Ltrain';
Xtest = database;
Ltest = Ltrain;

for i = 1:n
    Xtest = database(i,:);
    output = KNN(Xtrain,Ltrain,Xtest, k);
    hasilknn = [hasilknn;output];
end

for j = 1:n
    if Ltest(j) ~= hasilknn(j)
        kelaserror = kelaserror+1;
    end
end

akurasi = ((n - kelaserror)/n)*100;