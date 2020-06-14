% A seguinte função implementa o AG-ICA linear
%
% Entrada:  x é mistura uma matriz(dxn)
%           tampop é o tamanho da população
%           n_geracao é o número maximo de geração no AG
%           kernel é o tamanho do kernel da negentropia de rényi
%
% Saída: 	W é matriz de separação
%           y é os sinais estimados
%           ex: kernel = 0.5;
%
%
% Author:   Nielsen C. Damasceno
% Date:     20.12.2010
function [y,W] = AG_ICA(x,tampop,n_geracao,kernel)

    fontes   = size(x,1);
    gene = fontes*fontes;
    populacao       = rand(tampop,gene); 
    novapopulacao   = zeros(tampop,gene);
    melhorpopulacao = zeros(tampop,gene);
    fav  = zeros(tampop,1);                             % Vetor das funcaoes de adaptabilidade
    prec = 0.8;                                         % percentual de recombinação 80% da populacao
    pmut = 0.01;                                        % percentual de mutação de 1% da populacao
    cromossomo_aux = zeros(1,gene);      % Para troca de partes do cromossomo no crossover
    novosindividuo = zeros(tampop*0.2,gene);
    melhor_cromossomo = zeros(1,gene);   % Para guardar e melhor individuo (elitismo)
    melhoradp_ant = 0;
    estagnacao  = 0;
    variancia   = 1;
    h           = zeros(n_geracao,1);
    p           = zeros(tampop,1);
    melhores    = zeros(n_geracao,1);
    epoca       = 1;
    while(1)
        % Condicao de parada para o numero de geracoes
        if (epoca == n_geracao)
            break; 
        end
    
        %Função de avaliação
        for i = 1 : size(populacao,1)
            p = populacao(i,:);
            W = reshape(p,fontes,fontes)';
            xt = mistura(x,W);
            %kernel = Silverman(xt);
            n = negentropia(xt(1,:),kernel) * negentropia(xt(2,:),kernel) * negentropia(xt(3,:),kernel);
            fav(i) = n;
        end        
        %Seleciona-se o pior individuo da população atual
        [pioradp, piorindividuo] = min(fav);
    
        % Guarda o melhor individuo
        if (epoca ~= 1)
            melhoradp_ant = melhoradp;
        end
    
        %Seleciona-se o melhor indivíduo da população atual
        [melhoradp, melhorindividuo] = max(fav);
        %Guarda-se a cada época(geração) qual foi o melhor indivíduo 
        melhores(epoca)   = melhoradp;
        melhor_cromossomo = populacao(melhorindividuo,:);
        
        % Se os melhores indivíduos começam a aparecer (repetir) nas gerações 
        % futuras, então houve uma estagnação da população 
        if (melhoradp == melhoradp_ant)
            estagnacao = estagnacao + 1;
        end

        % Condicao de parada para o criterio de estagnacao da populacao
%         if(estagnacao > n_geracao * 0.8)
%            break;
%         end
    
        novapopulacao = selecao(populacao,'roleta',fav, melhor_cromossomo, fontes);
        novapopulacao = selecao(novapopulacao,'elitismo',fav, melhor_cromossomo, fontes);
        novapopulacao = recombinacao(novapopulacao,prec);
        novapopulacao = mutacao(novapopulacao,pmut);
    
        populacao = novapopulacao;
    
        % Estima o kernel usando Silverman
        kernel = Silverman(x);
        epoca = epoca + 1;
        disp(epoca);
     
        disp('Negentropia');
        disp(max(fav));
    end
    
    % Temos o melhor cromossomo vamos usar para achar o melhor y
    [melhoradp, melhorindividuo]= max(fav);
    d = populacao(melhorindividuo,:);
    W = reshape(d,fontes,fontes)';
    y = branqueamento(mistura(branqueamento(x),W));
end