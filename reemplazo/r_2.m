% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [S] = r_2(V, F)

global pc; %probabilidad de cross over
global G;

N = length(V(:,1));
l = length(V(1,:));
S = zeros(N, l);

k = round(G * N) + mod(round(G * N), 2);

S = mixto(V, F, k); %seleccion. tiene que ser configurable.

if( rand > pc ) % si hay que aparear... apareo!
	i = 1;
	used = zeros(1, k);
	while(i <= k/2)
		[a, b, used] = select2(S, used);
		[S(a,:), S(b,:)] = two_points( S(a,:), S(b,:) ); %apareo. tiene que ser configurable
		i = i + 1;
	end
end

j = 1;
while( j <= 2 )
	S(j,:) = mutar(S(j,:));
	j = j + 1;
end

S( (k + 1) : N, :) = boltzmann(V, F, N - k); %esto esta bien

end

%calcula la posicion de dos valores no usados en la matriz
function [a, b, used] = select2(S, used)
k = 1;
N = length(S(:,1));

while(used(k) == 1)
	k = k + 1;
end
a = k;
used(a) = 1;

b = ceil( rand * (N - k) + k);
while( b == 1)
	b = ceil( rand * (N - k) + k);
end
used(b) = 1;

end
