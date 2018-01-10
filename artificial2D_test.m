%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                       %
%%% Instituto Federal do Ceara, Campus Maracanau                          %
%%% Bacharelado em Ciencia da Computacao                                  %
%%% Disciplina: Redes Neurais Artificiais, Prof. Ajalmar Rocha            %
%%% Aluno: Jose Igor de Carvalho                                          %
%%%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all;

%% GERANDO UM CONJUNTO DE DADOS ALEATÓRIO

f = @(x) 2*x + 3; % Função base

initial = -5; % Faixa inicial para geração dos dados
final = 5; % Faixa final para geração dos dados
step = 0.01; % Passo entre a faixa inicial e a faixa final

% Inicializando vetores para armazenar os dados
x = zeros(); 
y = zeros();

% Faixas de ruido
a = -0.5;
b = 0.5;

k = 1;
for i=initial:step:final    
    x(k) = i;
    y(k) = f(i)+(b-a).*rand(1) + a;
    k = k + 1;
end

% Concatenando os vetores para formar um conjunto de dados do tipo [x y]
dataset = [x' y'];

% Normalizando o conjunto de dados
dataset = normalize(dataset);

% Capturando os novos y e x
x = dataset(:,1);
y = dataset(:,2);

%% PLOTANDO OS DADOS GERADOS ANTERIORMENTE

figure(1)

scatter(x, y,'.', 'red')
grid on
title('Dados iniciais')
xlabel('x')
ylabel('y')
%legend('Data')

%% CAPTURANDO CONJUNTOS DE TESTE E TREINAMENTO

dataset = dataset(randperm(size(dataset,1)),:); % Permutando as linhas do conjutno de dados

% Capturando 700 amostras aleatoriamente para treinamento da rede
tr_set = dataset(1:size(dataset, 1)-300, :);
% Capturando 300 amostras aleatoriamente para testes da rede
te_set = dataset (size(dataset, 1)-299:end, :);

%% TREINANDO A REDE NEURAL E CAPTURANDO SUA EFICIENCIA

realizations = 20; % Quantidade de realizações
errors = zeros(realizations, 1); % Vetor para capturar os erros em cada realização

inputs = te_set(:, 1:size(te_set, 2)-1); % Entradas do conjunto de testes
tags = te_set(:,size(te_set,2)); % Tags associadas as entradas do conjunto de testes

for i=1:realizations
    MSE = 0;
    W = learning_rule(tr_set, 20, 0.01);
    g = @(x) W(2)*x - W(1); % Função de aproximação
    p = 0;
    for j=1:size(te_set, 1)
        l=inputs(i,:); % Valores do conjunto de dados
        MSE = MSE + (g(l(1))-tags(i))^2; % Calculando MSL 
        p = p+1;
    end
    RMSE = sqrt(MSE/size(te_set, 1)); % Calculando RMSL 
    errors(i) = RMSE;
    tr_set = tr_set(randperm(size(tr_set, 1)),:);
end

%% IMPRIMINDO DADOS

MEDIA_RMSE = mean(errors) % Média dos erros para 20 realizações
DESVIO_PADRAO = std(errors) % Desvio padrão dos erros para 20 realizações

%% PLOTANDO DOS DADOS JUNTAMENTE COM A SUPERFICIE QUE OS APROIXIMA
% Os coeficientes de w são referentes à última realização 

figure(2)
scatter(x, y,'.', 'red')

hold on
grid on

t = 0:step:1;
F = t*W(2) - W(1);
plot(t, F, 'blue', 'LineWidth', 1);

% Configurações do plot
title('Dados juntos a reta que os aproxima')
xlabel('x')
ylabel('y')
hold off;
%% FIM