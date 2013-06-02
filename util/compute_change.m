%---- Implementación criterio de corte por estructura
% Una parte relevante de la población no cambia de generación en generación
function changed = compute_change(old_pop, new_pop)

global parte_pobl;
global error_estruc;

changed = 0;
inv_n = size(old_pop,1);
lotus_n = size(old_pop,2);

ind_changed_counter = 0;

for i = inv_n
    %se establece que un individuo cambia si alguno de sus pesos cambió
    %más de error_estruc con respecto a la población anterior
    j = 1;
    ch = 0;
    while ( j <= lotus_n && ch == 0 )
        if  ( abs( old_pop(i,j) - new_pop(i,j) ) > error_estruc )
           ind_changed_counter = ind_changed_counter + 1;
           ch = 1;
           j=j+1;
        end
    end
  
end

if ( (ind_changed_counter/inv_n) > parte_pobl )
    changed = 1;
end

os = sprintf('# individous con cambio: %d (err %f)', ind_changed_counter, error_estruc );
disp(os);


end