clc; clear all;

dataset = [1, 1.5, 2; 1, 3, 4]';

w = [0.5; 0.5];

w = rand(2, 1);

training_set = horzcat(-ones(size(dataset, 1), 1), dataset);

k = training_set(:, 1:size(training_set, 2)-1);

p = training_set (:,size(training_set,2));

% %% ITERAÇÃO 1
% u = dot (k(1,:), w);
% erro = p(1)-u
% 
% w = w+0.1*erro*k(1,:)'
% 
% %% ITERAÇÃO 2
% u = dot (k(2,:), w);
% erro = p(2)-u
% 
% w = w+0.1*erro*k(2,:)'
% 
% %% ITERAÇÃO 3

%% PLOTANDO GRAFICO DA TAXA DE ACERTOS
figure(1)

plot(dataset, 'b', 'LineStyle', '--')
hold on
grid on
scatter(dataset(:,1), dataset(:,2), 'black')

hold off

% while(1)
%     for i=1:size(dataset,  1)
%         u = dot (k(i,:), w);
%         erro = p(i)-u;
% 
%         w = w+0.1*erro*k(i,:)';
%     end
% end

passo = 0.01;
inicio = -5;
fim = 5;

f = @(x)2*x+2*x+1;

a = -0.5;
b = 0.5;
%r = (b-a).*rand(1000,1) + a;

k = 1;
for i=inicio: passo: fim
    
    x(k) = i;
    y(k) = f(i)+(b-a).*rand(1) + a;
%     y(k) = f(i)
    k = k+1;

end

dataset = [x' y'];


dataset = dataset(randperm(size(dataset,1)),:);

dataset
figure (1)
scatter(x, y,'.')

grid on

hold on


training_set = horzcat(-ones(size(dataset, 1), 1), dataset);

% k = training_set(:, 1:size(training_set, 2)-1);
% 
% p = training_set (:,size(training_set,2));

% for l=1:100
%     dataset = dataset(randperm(size(dataset,1)),:);
%     k = training_set(:, 1:size(training_set, 2)-1);
%     p = training_set (:,size(training_set,2));
%     for i=1:size(dataset,  1)
%         
%         u = dot (k(i,:), w);
%         erro = p(i)-u;
% 
%         w = w+0.01*erro*k(i,:)';
%     end
% end

% Usando a regra de aprendiagem do Perceptron com algumas alterações
w = learning_rule(dataset, 50, 0.01)


t = inicio: .5: fim;
y1 = -w(1)+t*w(2);

plot(t, y1, 'LineWidth', 1);

hold off;
g = @(x)-w(1)*w(2)*x;

w

%%
soma = 0

k = dataset(:, 1:size(dataset, 2)-1);
p = dataset (:,size(dataset,2));

for i=1:size(dataset, 1)
    
    l=k(i,:);
    soma = soma + (g(l(1))-p(i))^2;
    
end

MSL = soma/size(dataset, 1)

sqrt(MSL)














