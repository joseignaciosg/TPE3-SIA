%creates a weigth matrix of the correct dimensions

%P is the vector with the layers of the net
function [W] = randommatrix(divisor,delta)
global P;

    max_neurons = max(P);
    m = length(P);
    W = zeros(max_neurons,max_neurons+1,m-1);
    
    i=1;j=1;k=1;
    while(k<m)
        i=1;
        while(i<=P(k+1))
           j=1;
           while(j<=P(k)+1)
               W(i,j,k) = rand()/divisor - delta;
               j=j+1;
           end
           i=i+1;
        end
        k=k+1;
    end


end