%a y b son los individuos que se reciben como parametro
function [a, b] = anular(a, b)

l = length(a);
start = ceil( rand * l );
L = ceil( rand * l/2 );
i = 0;
while ( i <= L )

	aux = a(mod(start + i, l) + 1); %si no pongo el 1, el modulo puede dar 0 y no es un indice valido en octave.
	a(mod(start + i, l) + 1) = b(mod(start + i, l) + 1);
	b(mod(start + i, l) + 1) = aux;

	i = i + 1;
end

end
