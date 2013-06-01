function [S] = reemplazar(V,F,k)

global criterio_reemplazo;

    if ( criterio_reemplazo == 1 ) %elite
        S = elite(V, F, k);
    end
    
    if ( criterio_reemplazo == 2 ) %ruleta
        S = ruleta(V, F, 2);
    end
    
    if ( criterio_reemplazo == 3 ) %Boltzmann
        S = boltzmann(V, F, k);
    end
    
    if ( criterio_reemplazo == 4 ) %Torneo
        S = torneo(V, F, k);
    end
    
    if ( criterio_reemplazo == 5 ) %Mixto
        S = mixto(V, F, k);
    end

end
