function [S] = reemplazar(V,F,k)

global reemplazo;

    if ( reemplazo == 1 ) %elite
        S = elite(V, F, k);
    end
    
    if ( reemplazo == 2 ) %ruleta
        S = ruleta(V, F, 2);
    end
    
    if ( reemplazo == 3 ) %Boltzmann
        S = boltzmann(V, F, k);
    end
    
    if ( reemplazo == 4 ) %Torneo
        S = torneo(V, F, k);
    end
    
    if ( reemplazo == 5 ) %Mixto
        S = mixto(V, F, k);
    end

end
