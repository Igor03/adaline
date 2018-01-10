clear; clc;


f = @(x1, x2) 2*x1 + x2;

% x1 = [1 3 3];
% x2 = [1 2 3];
% y = [4 5 6];

k = 1;
for i=-5:0.01:5
   x1(k) = i;
   k=k+1;
end

k = 1;
for i=-5:0.01:5
   x2(k) = i;
   k=k+1;
end

x1 = x1(randperm(length(x1)))';
x2 = x2(randperm(length(x2)))';

a = -0.5;
b = 0.5;

for i=1:size(x1, 1)
    % Depois adicionar o ruido
    y(i) = f(x1(i), x2(i))+(b-a).*rand(1) + a;
end


dataset = [x1 x2 y'];

figure(1)
scatter3(x1, x2, y, 'red', '.')

hold on



%plot3 (x1, x2, y)

% [X Y] = meshgrid(-5:.1:5);
% R = X.*2+Y.*1;
% %figure(2)
% surf (X, Y, R);
% 
% alpha (0.5)
% shading interp

hold off

w = rand(3, 1)
training_set = horzcat(-ones(size(dataset, 1), 1), dataset);

% for l=1:100
%     training_set = training_set(randperm(size(training_set,1)),:);
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



w = learning_rule(dataset, 50, 0.01)

figure(3)
scatter3(x1, x2, y, 'red', '.')

hold on



%plot3 (x1, x2, y)

[X, Y] = meshgrid(-5:.1:5);
F = X.*w(2)+Y.*w(3)-w(1);

%figure(2)
surf (X, Y, F);

alpha (0.6)
shading interp
hold off

g = @(x1, x2) w(2)*x1+w(3)*x2-w(1);


 k = dataset(:, 1:size(dataset, 2)-1);
 p = dataset (:,size(dataset,2));

% l = k(1,:)
% 
% g(l(1), l(2)) - p(1)
% 
% l = k(2,:);
% 
% g(l(1), l(2)) - p(2)
% 
% 
% l = k(3,:);
% 
% g(l(1), l(2)) - p(3)


soma = 0;
for i=1:size(dataset, 1)
    
    l=k(i,:);
    soma = soma + (g(l(1), l(2))-p(i))^2;
    
end

MSE = soma/size(dataset, 1)
sqrt(MSE)






