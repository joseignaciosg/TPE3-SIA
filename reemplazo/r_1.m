% V es una matriz que en cada fila tiene uno de los individuos (pesos de la red) ordenados con el de mayor fitness primero
% F es un vector con los fitness correspondientes a las entradas de V
function [R] = r_1(V, F)

global pc; %probabilidad de cross over

N = length(V(:,1));
i = 1;
R = zeros(N,length(1,:));

while ( i < N/2 )

	S = ruleta(V, F, 2); %seleccion. tiene que ser configurable
	if( rand > pc )
		[S(1,:), S(2,:)] = anular( S(1,:), S(2,:) ); %apareo. tiene que ser configurable
	end
	
	j = 1;
	while( j <= 2 )
		S(j,:) = mutar(S(j,:));
		j = j + 1;
	end

	R(i,:) = S(1,:);
	R(i + 1,:) = S(2,:);

	i = i + 1;
end

end
