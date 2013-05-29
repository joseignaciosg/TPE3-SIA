function cuadratic_error = eval_fitness(patterns,A,P,beta)

cuadratic_error = 0;

while(i<=size(patterns,1))
    
    pattern = patterns(i,1:windowsize);
    s = patterns(i,windowsize+1);
    
    max_neurons =max(P);
    m = length(P); %layers number
    V = zeros(m, max_neurons + 1); %+1 for the threshold
    
    %the first row of V are the inputs
    aux = zeros(1,length(V(1,:))-length(E)-1);
    if (length(aux)>=1)
        E = [-1 E aux];
        V(1,:) =  E;
    else
        E = [-1 E];
        V(1,:) = E;
    end
  
    %computes outputs 
    i = 1;
    while(i<m)
       membrane_potential = A(:,:,i)*V(i,:)';
       V(i+1,:) =  [-1 tanh(membrane_potential'.* beta)];
       i=i+1;
    end
    
    %final output
    o = V(m,2);
    i=i+1;
    cuadratic_error = cuadratic_error + (s-o)^2;
end

cuadratic_error = cuadratic_error/(i-1); %patterns
end