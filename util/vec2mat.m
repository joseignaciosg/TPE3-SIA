function W = vec2mat(vector)
    global P;
    max_neurons = max(P);
    m = length(P);
    W = zeros(max_neurons,max_neurons+1,m-1);

    
    i=1;j=1;k=1,l=1;
    while(k<m)
        i=1;
        while(i<=P(k+1))
           j=1;
           while(j<=P(k)+1)
               W(i,j,k) = vector(l) ;
               l=l+1;
               j=j+1;
           end
           i=i+1;
        end
        k=k+1;
    end
    
end