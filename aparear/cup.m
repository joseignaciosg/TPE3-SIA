%a y b son los individuos que se reciben como parametro
function [a, b] = cup(a, b)

l = length(V(:,1));

ratio = 0.6;

while ( i <= l )

	if(rand > ratio)
		aux = a(i);
		a(i) = b(i);
		b(i) = aux;
	end

	i = i + 1;
end

end
