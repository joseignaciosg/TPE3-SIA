% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [R] = r_2(V, F, k)

global pc; %probabilidad de cross over

N = length(V(:,1));
R = zeros(N,length(1,:));


S = ruleta(V, F, k); %seleccion. tiene que ser configurable.

if( rand > pc ) % si hay que aparear... apareo!
	i = 1;
	used = zeros(1, k);
	while(i <= k/2)
		[a, b, used] = select2(S, used);
		[S(a,:), S(b,:)] = anular( S(a,:), S(b,:) ); %apareo. tiene que ser configurable
		i = i + 1;
	end
end

j = 1;
while( j <= 2 )
	if( rand > pm )
		mutar(S(j,:));
	end
	j = j + 1;
end

S(k + 1, N) = ruleta(V, F, N - k); %esto esta bien

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
