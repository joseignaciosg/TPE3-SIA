% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
% k es la cantidad de individuos que quiero seleccionar (tiene que ser menor o igual al total)
% S es una matriz con los individuos seleccionados
function [S] = ruleta(V, F, k)

f_total = sum(F);
l = length(V(:,1));
used = zeros(1,l);
p = zeros(1, l); %probabilidad de cada uno
q = zeros(1, l); %probabilidad acumulada
S = zeros(k, length( V(1,:) ));

i = 1;
while ( i <= l ) %se calculan la probabilidad de cada uno y la acumulada de cada uno.
	f = F(i);
	p(i) = f/f_total;	
	q(i) = sum(p);
	i = i + 1;
end

i = 1;
while (i <= k)
	r = rand;
	j = 1;
	while (q(j) < r )
		j = j + 1;
	end;
	if(used(j) == 0)
		used(j) = 1;
		S(i, :) = V(j, :);
		i = i + 1;
	end

end

end
