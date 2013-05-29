%a y b son los individuos que se reciben como parametro
function [a, b] = two_point(a, b)

l = length(V(:,1));
r = ceil( rand * l );
s = ceil( rand * l );
min = min(r, s);
max = max(r,s);
i = min;
while ( i <= max )

	aux = a(i);
	a(i) = b(i);
	b(i) = aux;

	i = i + 1;
end

end
