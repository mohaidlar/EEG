function feature = ekstraksibeta(s,waveletFunction)

[C,L] = wavedec(s,8,waveletFunction);

D1 = wrcoef('d',C,L,waveletFunction,1);
D2 = wrcoef('d',C,L,waveletFunction,2);
D3 = wrcoef('d',C,L,waveletFunction,3);
D4 = wrcoef('d',C,L,waveletFunction,4);
D5 = wrcoef('d',C,L,waveletFunction,5);
D6 = wrcoef('d',C,L,waveletFunction,6);
D7 = wrcoef('d',C,L,waveletFunction,7);
D8 = wrcoef('d',C,L,waveletFunction,8);
A8 = wrcoef('a',C,L,waveletFunction,8);


feature=[D4];