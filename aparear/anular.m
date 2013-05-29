%a y b son los individuos que se reciben como parametro
function [a, b] = anular(a, b)

l = length(V(:,1));
start = ceil( rand * l );
L = ceil( rand * l/2 );
i = 0;
while ( i <= L )

	aux = a(start + i);
	a(start + i) = b(start + i);
	b(start + i) = aux;

	i = i + 1;
end

end
