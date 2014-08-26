% clc;
clear('all');

Nall = 200;
x = rand(Nall,1);
Nloop = 1E3;
[F1,F2,F3,F4] = Closure(Nall);

% 
% tic;
% for k = 1:N
%     b = F1(x);
% end
% toc
% 
% tic;
% for k = 1:N
%     b = F2(x);
% end
% toc
% 
% tic;
% for k = 1:N
%     b = F3(x);
% end
% toc

tic;
b = F4.run(x,Nloop);
toc

tic;
b = F6(x,Nloop,Nall);
toc


