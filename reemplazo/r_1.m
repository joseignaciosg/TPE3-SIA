% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [R] = r_1(V, F)

global pc;
global pm;
global pbpp;

M = length(V(:,1));
R = zeros(M, length(V(1,:)));
i = 1;

while ( i <= M )
	S = ruleta(V, F, 2); %seleccion. tiene que ser configurable
	if( rand < pc )
		[S(1,:), S(2,:)] = anular( S(1,:), S(2,:) ); %apareo. tiene que ser configurable
	end
	
	j = 1;
	while( j <= 2 )
        if  (rand < pm)
        	S(j,:) = mutar(S(j,:));
        end
        
        if (rand < pbpp)
            S(j,:) = backpropagation(S(j,:));
        end
		j = j + 1;
	end
    
	R(i,:) = S(1,:);
	if(i < M)
		R(i + 1,:) = S(2,:);
	end

	i = i + 2;
    
end

end
