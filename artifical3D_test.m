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
f = @(x1, x2) 2*x1 + 1*x2; % Função base


initial = -5; % Faixa inicial para geração dos dados
final = 5; % Faixa final para geração dos dados
step = 0.01; % Passo entre a faixa inicial e a faixa final

% Inicializando os vetores x1 e x2
x1 = zeros(); 
x2 = zeros();
y = zeros();

k = 1;
for i=initial:step:final
   x1(k) = i;
   k=k+1;
end

x1 = x1(randperm(length(x1)))'; 
x2 = x1(randperm(length(x1)));

% Faixas de ruido
a = -0.7;
b = 0.7;

for i=1:size(x1, 1)
    % Depois adicionar o ruido
    y(i) = f(x1(i), x2(i))+(b-a).*rand(1) + a; % Adicionando ruido
end

% Concatenando os vetores para formar um conjunto de dados do tipo [x1 x2 y]
dataset = [x1 x2 y'];
dataset = normalize(dataset);

x1 = dataset(:,1);
x2 = dataset(:,2);
y = dataset(:,3);

%% PLOTANDO OS DADOS GERADOS ANTERIORMENTE

figure(1)
scatter3(x1, x2, y, 'red', '.')
grid on
title('Dados iniciais')
xlabel('x1')
ylabel('x2')
zlabel('y')
xlim([0 1])
ylim([0 1])
zlim([0 1])

%% CAPTURANDO CONJUNTOS DE TESTE E TREINAMENTO

dataset = dataset(randperm(size(dataset,1)),:); % Permutando as linhas do conjutno de dados

% Capturando 700 amostras aleatoriamente para treinamento da rede
tr_set = dataset(1:size(dataset, 1)-300, :);
% Capturando 300 amostras aleatoriamente para testes da rede
te_set = dataset (size(dataset, 1)-299:end, :);

%% TREINANDO A REDE NEURAL E CAPTURANDO SUA EFICIENCIA

realizations = 20; % Quantidade de realizações
errors = zeros(realizations, 1); % Vetor para capturar os erros em cada realização

inputs = te_set(:, 1:size(te_set, 2)-1); % Entradas do conjunto de dados
tags = te_set(:,size(te_set, 2)); % Tags associadas as entradas

for i=1:realizations
    MSE = 0;
    W = learning_rule(tr_set, 30, 0.01);
    g = @(x1, x2) W(2)*x1+W(3)*x2-W(1); % Função de aproximação
    for j=1:size(te_set, 1)
        l=inputs(i,:);
        MSE = MSE + (g(l(1), l(2)) - tags(i))^2;  
    end
    RMSE = sqrt(MSE/size(te_set, 1));
    errors(i) = RMSE;
    tr_set = tr_set(randperm(size(tr_set, 1)),:);
end

%% IMPRIMINDO DADOS

MEDIA_RMSE = mean(errors) % Média dos erros para 20 realizações
DESVIO_PADRAO = std(errors) % Desvio padrão dos erros para 20 realizações

%% PLOTANDO DOS DADOS JUNTAMENTE COM A SUPERFÍCIE QUE OS APROIXIMA
% Os coeficientes de w são referentes à última realização 

figure(2)

scatter3(x1, x2, y, 'red', '.')
grid on

hold on

[X1, X2] = meshgrid(0:.1:1);
F = X1.*W(2)+X2.*W(3)-W(1);

surf (X1, X2, F);

alpha (0.7)
shading interp

title('Dados juntos ao hiperplano que os aproxima')
xlabel('x1')
ylabel('x2')
zlabel('y')
xlim([0 1])
ylim([0 1])
zlim([0 1])

hold off

%% FIM