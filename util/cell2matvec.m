%Recibe el cell con las matrices de pesos y lo transforma en una matrix que
%tiene en cada fila cada matriz de pesos(individuo) vectorizado

function [V] = cell2matvec(individuos)

global P;
n = length(individuos);
i=1;
l = 0;
m = length(P);
while(i < m)
	l = l + (P(i) + 1) * P(i+1);
	i = i + 1;
end

V = zeros(l,n);

i = 1;
while(i<=n)
    W = individuos{i};
    V(:,i) = mat2vec(W)';
    i=i+1;
end
