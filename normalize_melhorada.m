%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                       %
%%% Instituto Federal do Ceara, Campus Maracanau                          %
%%% Bacharelado em Ciencia da Computacao                                  %
%%% Disciplina: Redes Neurais Artificiais, Prof. Ajalmar Rocha            %
%%% Aluno: Jose Igor de Carvalho                                          %
%%%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [normalized_dataset] = normalize_melhorada(dataset)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    n = size(dataset, 1);
    menor = repmat(min(dataset), n, 1);
    maior = repmat(max(dataset), n, 1);
    normalized_dataset = (dataset - menor) ./ (maior-menor);

end

