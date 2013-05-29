% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
% k es la cantidad de individuos que quiero seleccionar (tiene que ser menor o igual al total)
function [S] = ruleta(V, F, k)

f_total = sum(F);
p = zeros(1, length(V(:,1))); %probabilidad de cada uno
q = zeros(1, length(V(:,1))); %probabilidad acumulada
S = zeros(k, length(V(1,:)));
i = 1;
while ( i <= k )
	f = F(i);
	p(i) = f/f_total;
	
	j = 1;
	while ( j <= i)
		q(i) = q(i) + p(j);
		j = j + 1;
	end;

	r = rand;
	j = 1;
	S(i, :) = V(j, :);
	while ( j < length(q) && q(j) < r )
		j = j + 1;
		S(i, :) = V(j, :);
	end;

	i = i + 1;
end

end
