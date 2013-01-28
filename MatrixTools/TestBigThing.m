clc;
clear('all');

N = 6;
s1 = randi(10,N,N);

Ntest = 10;
Ncv   = 40;
tic
for k = 1:Ntest
    for m = 1:Ncv
        [V,D] = eig(s1);
    end
end
Tindividual = toc;
Show(Tindividual,'%13.7E');

S1 = blkdiag(s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1,s1);
tic
for k = 1:Ntest
    [V,D] = eig(S1);
end
Tblock = toc;
Show(Tblock,'%13.7E');





