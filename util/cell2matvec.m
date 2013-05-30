%Recibe el cell con las matrices de pesos y lo transforma en una matrix que
%tiene en cada fila cada matriz de pesos(individuo) vectorizado

function [V] = cell2matvec(individuos)

global P;
i=1;
n = length(individuos);
%TODO sacar este magic number (funciona para la conf P elegida)
V = zeros(26,n);

while(i<=n)
    W = individuos{i};
    V(:,i) = mat2vec(W)';
    i=i+1;
end
