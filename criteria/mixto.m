% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
% k es la cantidad de individuos que quiero seleccionar (tiene que ser menor o igual al total)
function [S] = mixto(V, F, k)

global mx_type;

S = zeros(k, length( V(1,:) ));

a = 1.7;
m = round(k/a);

if(mx_type == 1)
	S(1 : m, :) = elite(V, F, m);
	S(m + 1 : k, :) = ruleta(V, F, k - m);
else
	S(1 : m, :) = elite(V, F, m);
	S(m + 1 : k, :) = boltzmann(V, F, k - m);
end

end
