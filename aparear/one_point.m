%a y b son los individuos que se reciben como parametro
function [a, b] = one_point(a, b)

l = length(a);
r = ceil( rand * l );
i = r;
while ( i <= l )

	aux = a(i);
	a(i) = b(i);
	b(i) = aux;

	i = i + 1;
end

end
