% A seguinte função faz a recombinação de uma população
%
% Entrada:  populacao é uma matriz(nxd)
%           prec é taxa de recombinação
%
% Saída: 	Novapopulacao
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function novapopulacao = recombinacao(populacao,prec)
    novapopulacao = populacao;
    [npop gene] = size(populacao);
    vezes = 0.8 * npop;
    cromossomo_aux1 = zeros(1,gene);
    cromossomo_aux2 = zeros(1,gene);
    qtd_trocas     = 0;
    
    for r = 1:vezes        % realizada em uma parcela da população 
        prob = rand * 1;   % para testar se esta dentro da probabilidade de recombinar
        if (prob <= prec)
            qtd_trocas = qtd_trocas + 1;
            % Escolha do ponto de corte (limites inferior e superior do
            % corte no cromossomo)
            corte1 = ceil((rand * gene -1)+1);
            corte2 = ceil((rand * gene -1)+1);
            if (corte1 > corte2)
                aux = corte1;
                corte1 = corte2;
                corte2 = aux;
            end
            % Escolha dos individuos a sofrerem a recombinação (crossover)
            individuo1 = ceil((rand*npop-1)+1);
            individuo2 = ceil((rand*npop-1)+1);
            % Troca de Material genetico (crossover) entre os individuos, 
            % substituindo a regiao de corte.
            cromossomo_aux1  =  (novapopulacao(individuo1,corte1:corte2)); 
            cromossomo_aux2  =  (novapopulacao(individuo2,corte1:corte2));
            novapopulacao(individuo1,corte1:corte2)   = cromossomo_aux2;
            novapopulacao(individuo2,corte1:corte2)   = cromossomo_aux1;
       end
    end
end