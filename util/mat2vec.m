function vector = mat2vec(W)
    global P;
    m = length(P);
    vector = [];
	i = 1;
	while(i < m)
		j = 0;
		while( j < P(i) )
			vector( ((j*P(i))+1) : ((j+1)*P(i) + 1) ) = W(j+1,1:P(i)+1,i);
			j = j + 1;
		end
	i = i + 1;
	end
end


function vector = mat2vec2(W)
    global P;
    max_neurons = max(P);
    m = length(P);

    vector = [];
    i=1;j=1;k=1;l=1;
    while(k<m)
        i=1;
        while(i<=P(k+1))
           j=1;
           while(j<=P(k)+1)
               vector(l) = W(i,j,k);
               l=l+1;
               j=j+1;
           end
           i=i+1;
        end
        k=k+1;
    end
    
end

