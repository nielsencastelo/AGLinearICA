% Operador de Mutacao
% Garante que todo o material genetico esteja representado nas proximas geracoes,
% ou seja, que nenhum alelo desapareca para sempre da populacao
%
% Entrada:  populacao é uma matriz(nxd)
%           pmut é a taxa de mutação geralmente um número pequeno
%
% Saída: 	Novapopulacao
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function novapopulacao = mutacao(populacao,pmut)
    
    
    novapopulacao = populacao;
    [npop gene] = size(populacao);
    prob = rand * 1;
    if (prob <= pmut)
        for i= 1:pmut * npop * gene
            l = ceil(rand * npop - 1)+1;
            c = ceil(rand * gene - 1)+1;
            if novapopulacao(l,c) == 0
                novapopulacao(l,c) = 1;
            else
                novapopulacao(l,c) = 0;
            end
        end
    end
end