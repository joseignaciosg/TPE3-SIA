%a y b son los individuos que se reciben como parametro
function [a, b] = anular(a, b)

l = length(a);
start = ceil( rand * l );
L = ceil( rand * l/2 );
i = 0;
while ( i <= L )

	aux = a(mod(start + i, l));
	a(mod(start + i, l)) = b(mod(start + i, l));
	b(mod(start + i, l)) = aux;

	i = i + 1;
end

end
