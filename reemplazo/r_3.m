% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [S] = r_3(V, F)

global pc; %probabilidad de cross over
global G;
global series;

N = length(V(:,1));
k = round(G * N) + mod(round(G * N), 2);
l = length(V(1,:));
S = zeros(N + k, l);


S = boltzmann(V, F, k); %seleccion. tiene que ser configurable.

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

%creo una matriz con los k y los N
R(1:N, :) = V;
R(N + 1 : N + k, :) = S;

%le calculo el fitness a todos
j = 1;
while( j <= N + k)
	A = vec2mat(R(j,:));
	new_fitness = eval_fitness(series,A);
	f(j) = new_fitness;
	j = j + 1;
end

%ordeno todos
itemCount = length(f);
do
	hasChanged = false;
	itemCount--;
	for i = 1 : itemCount
		if ( f(i) > f(i+1) )
			M = R(i+1, :);
			R(i+1, :) = R(i, :);
			R(i, :) = M;
			f([i,i+1]) = f([i+1,i]);  % swap
			hasChanged = true;
		end
	endfor
until(hasChanged == false)

S = zeros(N, l);
S( 1 : N, :) = boltzmann(R, f, N); %esto esta bien

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
