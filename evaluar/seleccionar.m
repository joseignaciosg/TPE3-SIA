function [S] = seleccionar(V,F,k)

global seleccion;

    if ( seleccion == 1 ) %elite
        S = elite(V, F, k);
    end
    
    if ( seleccion == 2 ) %ruleta
        S = ruleta(V, F, 2);
    end
    
    if ( seleccion == 3 ) %Boltzmann
        S = boltzmann(V, F, k);
    end
    
    if ( seleccion == 4 ) %Torneo
        S = torneo(V, F, k);
    end
    
    if ( seleccion == 5 ) %Mixto
        S = mixto(V, F, k);
    end

end
