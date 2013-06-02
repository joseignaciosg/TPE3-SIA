function [S] = seleccionar(V,F,k)

global criterio_seleccion;

    if ( criterio_seleccion == 1 ) %elite
        S = elite(V, F, k);
    end
    
    if ( criterio_seleccion == 2 ) %ruleta
        S = ruleta(V, F, k);
    end
    
    if ( criterio_seleccion == 3 ) %Boltzmann
        S = boltzmann(V, F, k);
    end
    
    if ( criterio_seleccion == 4 ) %Torneo
        S = torneo(V, F, k);
    end
    
    if ( criterio_seleccion == 5 ) %Mixto
        S = mixto(V, F, k);
    end

end
