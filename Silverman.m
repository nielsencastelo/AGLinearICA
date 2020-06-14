% A seguinte função estima o tamanho ideal do kernel
% usando o método de Silverman
% Entrada:  x é mistura uma matriz(dxn)
%
% Saída: 	sigma é o tamanho do kernel
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function sigma = Silverman(x)
    % Busca um número de pontos de dados
    d = size(x,1);N=size(x,2);
    
    % Estima o tamanho ideal do kernel
    sigmaX = sqrt(trace(cov(x.'))/d);
    sigma = sigmaX*(4/(N*(2*d+1)))^(1/(d+4));
end