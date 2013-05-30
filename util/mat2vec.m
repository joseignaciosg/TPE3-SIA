function vector = mat2vec(W)
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
