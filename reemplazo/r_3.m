% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [S] = r_3(V, F)


crossover_counter = 0;
mutation_counter = 0;
bpp_counter = 0;

global pc;
global pm;
global pbpp;
global G;
global series;
global crossover_counter_total;
global mutation_counter_total;
global bpp_counter_total;

N = length(V(:,1)); %cantidad de individuos
k = round(G * N) - mod(round(G * N), 2);
l = length(V(1,:)); %cantidad de focus
S = zeros(N + k, l); %vector columna


S = seleccionar(V,F,k);%S = boltzmann(V, F, k); %seleccion. tiene que ser configurable.

if( rand < pc ) % si hay que aparear... apareo!
    crossover_counter = crossover_counter + 1;
	i = 1;
	used = zeros(1, k);
	limit = k/2 - mod(k, 2);
	while(i <= limit)
		[a, b, used] = select2(S, used);
		[S(a,:), S(b,:)] = aparear( S(a,:), S(b,:) ); %apareo. tiene que ser configurable
		i = i + 1;
	end
end

j = 1;
while( j <= k )
    
	[S(j,:),mutation_counter] = mutar(S(j,:));
        
    if (rand < pbpp)
        S(j,:) = backpropagation(S(j,:));
        bpp_counter = bpp_counter +1;
    end
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

hasChanged = true;
while(hasChanged == true) 
    hasChanged = false;
	itemCount=itemCount-1;
	for i = 1 : itemCount
		if ( f(i) > f(i+1) )
			M = R(i+1, :);
			R(i+1, :) = R(i, :);
			R(i, :) = M;
			f([i,i+1]) = f([i+1,i]);  % swap
			hasChanged = true;
        end
    end
end
f=1./f;

S = zeros(N, l);

increment_total_counters(crossover_counter,mutation_counter,bpp_counter);

S(1 : N, :) = reemplazar(R, f, N);

print_stats(crossover_counter,mutation_counter,bpp_counter);

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
