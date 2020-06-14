% A seguinte função faz a seleção de uma população
%
% Entrada:  populacao é uma matriz(nxd)
%           tiposelec é o tipo de seleção
%           fav é a função de avaliação do AG
%           melhor_cromossomo armazena o melhor individuo do AG
%           fontes é o número de sinais de fontes
% Saída: 	Novapopulacao
%
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function novapopulacao = selecao(populacao,tiposelec,fav,melhor_cromossomo,fontes)

    npop = size(populacao,1);
    
    switch lower(tiposelec)
        case 'roleta'
            % verifica se tem um valor negativo na função de avaliação
            neg = min(fav);
            if neg <= 0
                % Cria uma constante para mudar o valor negativo da função
                const = abs(neg) + rand;
                % Cria nova função de avaliação com valore agora positivos através
                % da constante.
                fav = fav + const;
                % soma de todas as funções de avaliação
                % utilizada no cálculo da adequabilidade
            end
            somafav = sum(fav);
            % Vetor das adaptabilidade relativa
            adr = zeros(npop,1);

            % Calculo das adaptabilidade relativas
            % a soma das adaptabilidade é igual a 1
            for i = 1:npop
                adr(i) = fav(i)/somafav;                    
            end

            % Processo de roleta
            roleta = zeros(npop,1);
            roleta(1) = adr(1);
            for i = 2:npop
                roleta(i) = roleta(i-1)+adr(i);
            end

            % Começando a selecionar os individuos da proxima populacao
            % Operador de Selecao - Metodo da Roleta
            % A probabilidade de ser "sorteado" é dos indivíduos com maior
            % adequabilidade relativa
            selecionado = zeros(npop,1);
            for r = 1:npop
                bola    = rand(1);
                posicao = 1;
                flag    = 0;
                while(1)
                    if (bola <= roleta(posicao))
                        selecionado(r) = posicao;
                        flag = 1;
                    end
                    posicao = posicao + 1;
                    if (flag == 1) 
                        break;
                    end
                end
             end
            cjselecionado = hist(selecionado,npop);  % Em cada posicao do vetor o numero de vezes que o elemento foi selecionado
            indice = 1;
            for i = 1:npop
                if (cjselecionado(i) ~= 0)
                    nobt = cjselecionado(i);           % Numero de copias obtidas
                    for c = 1:nobt
                        novapopulacao(indice,:) = populacao(selecionado(i),:); % Elemento da nova populacao é igual ao elemento selecionado da 
                        indice = indice + 1;                                   % populacao anterior
                    end
                end
            end
    case 'elitismo'
        % Elitismo em 30% da populacao
        for i = 1:npop * 0.3                          % Estrategia Elitista
            l = ceil(rand*npop-1)+1;
            populacao(l,:) = melhor_cromossomo;     % populacao(melhorindividuo,:)
        end
        % Gerando novos individuos aleatoriamente para a população 20% (estratégia)
        for i = 1:npop * 0.2  
            novosindividuo(i,:) = rand(1,fontes*fontes);
            l = ceil(rand*npop-1)+1;
            populacao(l,:) = novosindividuo(i,:);   
        end 
    otherwise
        disp('Tipo de seleção não reconhecida!!!');
    end
    novapopulacao = populacao;
end