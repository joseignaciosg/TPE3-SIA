% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
% k es la cantidad de individuos que quiero seleccionar (tiene que ser menor o igual al total)
function [S, T] = boltzmann(V, F, k, T)

global T = 1000; %se tiene que inicializar cuando arranca el programa, no aca!

t_min = 50;
l = length(V(:,1));
used = zeros(1,l);
p = zeros(1, length(V(:,1))); %probabilidad de cada uno
q = zeros(1, length(V(:,1))); %probabilidad acumulada
S = zeros(k, length(V(1,:)));
i = 1;

if(T > t_min)
	T = T * 0.9;
end

b_total = sum(exp(F)/T);

while ( i <= l )
	f = F(i);
	p(i) = exp(f)/T;
	q(i) = sum(p)/b_total;
	i = i + 1;
end

i = 1;
while (i <= k)
	r = rand;
	j = 1;
	while ( q(j) < r )
		j = j + 1;
	end;
	if(used(j) == 0)
		used(j) = 1;
		S(i, :) = V(j, :);
		i = i + 1;
	end

end

end
