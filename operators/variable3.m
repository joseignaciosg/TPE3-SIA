
function [A,s,o] = variable3(E,A,s,eta)

    global P;
    global beta;
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
    
    
    %computes deltas
    D = zeros(m-1,max_neurons);
    D(1,1) = (s-o);
    
    i=2;
    while(i<m)
       aux = m-i+1;
       auxi = A(:,2:max_neurons+1,aux)'* D(i-1,:)';
       D(i,:) = auxi';
       i=i+1;
    end
    

   %actualizo los pesos de la primera matriz porque uso E en vez de V
    j = 1;
    while(j <= P(2)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
        k = 1;
        x =(1-(tanh(beta.* A(j,1:P(1)+1,1) * E(1:P(1)+1)' ))^2).*beta;
        while(k <= P(1) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
            A(j, k, 1) = A(j, k, 1) + eta * x * D(length(P)-1,j) * E(k);
            k = k+1;
        end
    j=j+1;
    end

    %actualizo las matrices de pesos
    i = 2;
    while(i < length(P)) %cantidad de matrices
        j = 1;
        while(j <= P(i + 1)) %cantidad de neuronas en la capa siguiente. determina la cantidad de filas en mi matriz.
            k = 1;
            x = (1-(tanh(beta.* A(j,1:P(i)+1,i) * V(i,1:P(i)+1)' ))^2).*beta;
            while(k <= P(i) + 1) %cantidad de neuronas en mi capa + 1. determina la cantidad de columnas en mi matriz.
                A(j, k, i) = A(j, k, i) + eta * x * D(length(P)-i,j) * V(i,k);
                k=k+1;
                end
            j=j+1;
        end
    i=i+1;
    end
    

    
    ret = 0;
    if (s == 1)
        if ( o >= 0.5)
            ret = 1;
        end
    else
        if ( o < 0.5)
            ret = 0;
        end
    end


end
