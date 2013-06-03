% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [S] = r_2(V, F)


global G;
global pc;
global pm;
global pbpp;
global crossover_counter_total;
global mutation_counter_total;
global bpp_counter_total;

crossover_counter = 0;
mutation_counter = 0;
bpp_counter = 0;

N = length(V(:,1));
l = length(V(1,:));
S = zeros(N, l);

k = round(G * N) - mod(round(G * N), 2);
disp 'seleccionando';
S(1:k, :) = seleccionar(V,F,k); %seleccion. tiene que ser configurable.

if( rand < pc ) % si hay que aparear... apareo!
    disp 'haciendo crossing over'
    crossover_counter = crossover_counter + 1;
	i = 1;
	used = zeros(1, k);
	limit = k/2 - mod(k, 2); %sino puedo tener una cantidad impar y no puedo aparear
	while(i <= limit)
		[a, b, used] = select2(S, used, k);
		[S(a,:), S(b,:)] = aparear( S(a,:), S(b,:) ); %apareo. tiene que ser configurable
		i = i + 1;
	end
end

j = 1;
while( j <= k )
	[S(j,:),mutation_counter] = mutar(S(j,:));
        
    if (rand < pbpp)
        disp 'back propagating'
        S(j,:) = backpropagation(S(j,:));
        bpp_counter = bpp_counter +1;
    end
	j = j + 1;
end
%N
%k
%H = reemplazar(V, F, N-k)
%size(H)
%k+1
%N
disp 'reemplazando'
if ( N>k )
    S( (k + 1) : N, :) = reemplazar(V, F, N-k);
end

print_stats(crossover_counter,mutation_counter,bpp_counter);
increment_total_counters(crossover_counter,mutation_counter,bpp_counter);

end

%calcula la posicion de dos valores no usados en la matriz
function [a, b, used] = select2(S, used, N)
k = 1;

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
