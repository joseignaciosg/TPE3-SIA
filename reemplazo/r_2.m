% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [S] = r_2(V, F)


global G;
global pc;
global pm;
global pbpp;

crossover_counter = 0;
mutation_counter = 0;
bpp_counter = 0;

N = length(V(:,1));
l = length(V(1,:));
S = zeros(N, l);

k = round(G * N) + mod(round(G * N), 2);

S = seleccionar(V,F,k); %seleccion. tiene que ser configurable.

if( rand < pc ) % si hay que aparear... apareo!
    crossover_counter = crossover_counter +1;
	i = 1;
	used = zeros(1, k);
	while(i <= k/2)
		[a, b, used] = select2(S, used);
		[S(a,:), S(b,:)] = aparear( S(a,:), S(b,:) ); %apareo. tiene que ser configurable
		i = i + 1;
	end
end

j = 1;
while( j <= 2 )
	
    if  (rand < pm)
        S(j,:) = mutar(S(j,:));
        mutation_counter = mutation_counter +1;
    end
        
    if (rand < pbpp)
        S(j,:) = backpropagation(S(j,:));
        bpp_counter = bpp_counter +1;
    end
	j = j + 1;
end

S( (k + 1) : N, :) = reemplazar(V,F,N-k);
%S( (k + 1) : N, :) = boltzmann(V, F, N - k); %esto esta bien

%print_stats(crossover_counter,mutation_counter,bpp_counter)

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
while( used(b) == 1)
	b = ceil( rand * (N - k) + k);
end
used(b) = 1;

end
