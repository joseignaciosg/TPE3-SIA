%a y b son los individuos que se reciben como parametro
function [a, b] = cup(a, b)

l = length(a);

ratio = 0.6;

i = 1;
while ( i <= l )
	
	r = rand
	if(r > ratio)
		disp("cambiando..");
		aux = a(i);
		a(i) = b(i);
		b(i) = aux;
	end

	i = i + 1;
end

end
