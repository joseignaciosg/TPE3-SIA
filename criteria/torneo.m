% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
% k es la cantidad de individuos que quiero seleccionar (tiene que ser menor o igual al total)
function [S] = torneo(V, F, k)

used = zeros(1, length(V(:,1) ));
S = zeros(k, length(V(1,:)));
i = 1;

while ( i <= k )

	ind_1 = ceil ( rand * length(V(:,1)) );
	while( used(ind_1) == 1 )
		ind_1 = ceil ( rand * length(V(:,1)) );
	end
	ind_2 = ceil ( rand * length(V(:,1)) );
	while( used(ind_2) == 1 )
		ind_2 = ceil ( rand * length(V(:,1)) );
	end

	if ( F(ind_1) > F(ind_2) )
		max = ind_1;
		min = ind_2;
	else
		max = ind_2;
		min = ind_1;
	end

	r = rand;

	if ( rand > 0.75 )
		S(i, :) = V(min, :);
	else
		S(i, :) = V(max, :);
	end

	i = i + 1;
end

end
