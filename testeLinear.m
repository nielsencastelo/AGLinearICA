clear;clc;close all;

N = 150;
t = linspace(0,10,N);  % gera N pontos entre 0 e 10
%  Cria  3 sinais
f1 = sin(2*t);
f1 = f1/norm(f1)/N;
f2 = sign(sin(3*t));
f2 = normalizacao(f2,f1);
f3 = 0.5*randn(size(t));
f3 = normalizacao(f3,f1);
s = [f1;f2;f3];

% Misturas linear
a = randn(3);
x = a * s;
% Parâmetros do AG-ICA
kernel = 0.5;
npop = 100;
n_geracao = 50;

disp('Negentropia das fontes');
n_ok = negentropia(s(1,:),kernel)* negentropia(s(2,:),kernel)*negentropia(s(3,:),kernel);
disp(n_ok);
tic;
[y,w] = AG_ICA(x,npop,n_geracao,kernel);
tempo = toc;

y = branqueamento(y);

y1(1,:) = y(1,:)/norm(y(1,:))/N;
y2(2,:) = y(2,:)/norm(y(2,:))/N;
y3(3,:) = y(3,:)/norm(y(3,:))/N;

% Visualiza o resultado
subplot(3,3,1)
plot(s(1,:));
title('fonte 1');
subplot(3,3,2)
plot(s(2,:),'r');
title('fonte 2');
subplot(3,3,3)
plot(s(3,:),'k');
title('fonte 3');
subplot(3,3,4)
plot(x(1,:));
title('mistura 1');
subplot(3,3,5)
plot(x(2,:),'r');
title('mistura 2');
subplot(3,3,6)
plot(x(3,:),'k');
title('mistura 3');
subplot(3,3,7)
plot(y(1,:));
title('negentropia rényi 1');
subplot(3,3,8)
plot(y(2,:),'r');
title('negentropia rényi 2');
subplot(3,3,9)
plot(y(3,:),'k');
title('negentropia rényi 3');
