function [a, mutation_counter] = mutar(a)

global pm;
mutation_counter=0;
i = 1;
l = length(a);
while(i < l)

	if(rand < pm)
		a(i) = rand * ( abs(max(a)) + abs(min(a)) ) - abs(min(a));
        mutation_counter = mutation_counter + 1;
	end

	i = i + 1;

end

end
