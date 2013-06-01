function print( metodo_reemplazo, criterio_seleccion, criterio_reemplazo, apareo,generation)


switch metodo_reemplazo
    case 1
        disp '* método de reemplazo  : tipo 1';
    case 2
        disp '* método de reemplazo  : tipo 2';
    case 3
        disp '* método de reemplazo  : tipo 3';
end

switch criterio_seleccion
    case 1
        disp '* criterio de selección: Elite';
    case 2
        disp '* criterio de selección: Ruleta';
    case 3
        disp '* criterio de selección: Boltzmann';
    case 4
        disp '* criterio de selección: Torneo';
    case 5
        disp '* criterio de selección: Mixto';
end

switch criterio_reemplazo
    case 1
        disp '* criterio de reemplazo: Elite';
    case 2
        disp '* criterio de reemplazo: Ruleta';
    case 3
        disp '* criterio de reemplazo: Boltzmann';
    case 4
        disp '* criterio de reemplazo: Torneo';
    case 5
        disp '* criterio de reemplazo: Mixto';
end


switch apareo
    case 1
        disp '* tipo de apareo       : Anular';
    case 2
        disp '* tipo de apareo       : Cup';
    case 3
        disp '* tipo de apareo       : One-Point';
    case 4
        disp '* tipo de apareo       : Two-Points';
end


outputString2 = sprintf('\n\n');
disp(outputString2);




