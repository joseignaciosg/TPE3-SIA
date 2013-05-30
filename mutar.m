function [a] = mutar(a)

global pm;

i = 1;
l = length(a);
while(i < l)

	if(rand > pm)
		a(i) = rand * ( abs(max(a)) + abs(min(a)) ) - abs(min(a));
	end

	i = i + 1;

end

end
