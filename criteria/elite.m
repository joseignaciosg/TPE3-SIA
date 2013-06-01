% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
% k es la cantidad de individuos que quiero seleccionar (tiene que ser menor o igual al total)
function [S] = elite(V, F, k)

i = 1;
while ( i <= k )
	S(i, :) = V(i, :);
	i = i + 1;
end

end
