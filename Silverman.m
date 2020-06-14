% A seguinte fun��o estima o tamanho ideal do kernel
% usando o m�todo de Silverman
% Entrada:  x � mistura uma matriz(dxn)
%
% Sa�da: 	sigma � o tamanho do kernel
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function sigma = Silverman(x)
    % Busca um n�mero de pontos de dados
    d = size(x,1);N=size(x,2);
    
    % Estima o tamanho ideal do kernel
    sigmaX = sqrt(trace(cov(x.'))/d);
    sigma = sigmaX*(4/(N*(2*d+1)))^(1/(d+4));
end