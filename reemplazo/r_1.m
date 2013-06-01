% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [R] = r_1(V, F)

global pc;
global pm;
global pbpp;

M = length(V(:,1));
R = zeros(M, length(V(1,:)));
i = 1;

crossover_counter = 0;
mutation_counter = 0;
bpp_counter = 0;


while ( i <= M )
	S = seleccionar(V,F,2); %S = ruleta(V, F, 2); %seleccion. tiene que ser configurable
	if( rand < pc )        
		[S(1,:), S(2,:)] = aparear( S(1,:), S(2,:) ); %apareo. tiene que ser configurable
        crossover_counter = crossover_counter+1;
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
    
	R(i,:) = S(1,:);
	if(i < M)
		R(i + 1,:) = S(2,:);
	end

	i = i + 2;
    
end


%print_stats(crossover_counter,mutation_counter,bpp_counter)




end
