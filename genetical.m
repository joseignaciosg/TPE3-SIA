%Forma de invocación
%
%[minimo, [minimo, mejor_individuo] = genetical(serie,max_generations,cantidad_individuos,gap,mp,cp, cs,cr, tipo_apareo,metodoReemplazo,error,error_estructura,error_contenido)
%
%* serie : Serie a predecir, propuestas por la catedra en el TP anterior.
%* max_generations : Cantidad máxima de generaciones a correr 
%* cantidad_individuos : Cantidad de Individuos que van a conformar la poblacion
%* gap : Brecha Generacional
%* mp :  Probabilidad de Mutuacion
%* cp :  Probabilidad de CrossOver
%* cs : Identifica al criterio de seleccion a utilizar
%* cr : Identifica al criterio de reemplazo a utilizar
%* tipo_apareo : Metodo de Apareo
%* metodoReemplazo : Corresponde al metodo de Reemplazo visto en clase
%* error : Cota de corte por error.
%* error_estructura: Margen de error para cortar la ejecución si una parte de
%la pobación (parte_pobl)  no cambia de generacion
%en generacion
%* error_contenido: Margen de error para cortar la ejecución si el mejor 
%fitness de la poblacion  no progresa mas que ese error

%
%Criterio de Seleccion y Reemplazo 
%    
%    * 1 : Elite
%    * 2 : Ruleta
%    * 3 : Boltzmann
%    * 4 : Torneo
%    * 5 : Mixto
%
%Tipo de Apareo
%
%    * 1 : Anular
%    * 2 : Cup
%    * 3 : One-Point
%    * 4 : Two-Points
%
%Metodos de Reemplazo
%
%    * 1 : Algoritmo de Reemplazo 1
%    * 2 : Algoritmo de Reemplazo 2
%    * 3 : Algoritmo de Reemplazo 3
%
%   PARA EJEMPLOS DE INVOCACION RECURRIR AL README
%

function [minimo, mejor_individuo] = genetical(serie,max_generations,cantidad_individuos,gap,mp,cp, cs,cr, tipo_apareo,metodoReemplazo,error,error_estructura,error_contenido)

%para que se pueda ejecutar las funciones en las siguientes carpetas
addpath(genpath('./util'));
addpath(genpath('./reemplazo'));
addpath(genpath('./operators'));
addpath(genpath('./criteria'));
addpath(genpath('./aparear'));
addpath(genpath('./print'));


global P;
global beta;
global pc; %probabilidad de cross over
global pm; %probabilidad de mutar
global pbpp; %probabilidad de hacer 100 pasos de backpropagation
global T; %para boltzmann
global G; %generation gap
global series;
global criterio_reemplazo;%criterio de seleccion
global criterio_seleccion;%criterio de reemplazo
global apareo;%aparear
global parte_pobl; %pocentaje de la población para el criterio de corte por estructura
global error_estruc;
global error_cont;
%Parametros Fijos
T = 1000;
P = [3 5 1];
beta = 0.3;

%Paremtros Variables
pc = cp;
pm = mp;
pbpp = 0.01;
err = error;
G = gap;
series = serie;

criterio_reemplazo = cr;
criterio_seleccion = cs;
metodo_reemplazo = metodoReemplazo;

apareo = tipo_apareo;
parte_pobl = 0.75;
error_estruc = error_estructura;
error_cont = error_estructura;


%maximo valor de P para formar la matriz
m = max(P);

%Variables
individuos = cell(cantidad_individuos,1);
fitness = [];
minimo = 1;
count = 1;
minimos = [];
maximos = [];
x = [];

%Cantidad total de individuos
N = cantidad_individuos;

%Serie
max_serie = max(series);
series = series(1:750)./max_serie;

%Se crea un vector con N individuos
h=1;
while ( h <= N)
    individuos{h} = randommatrix(1,0.25);
    h = h + 1;
end


print(metodoReemplazo,criterio_seleccion,criterio_reemplazo,apareo,count)   

content_criteria = inf;
struct_criteria = inf;
while(minimo > err && count <= max_generations && content_criteria > error_contenido && struct_criteria > error_estructura )
    outputString = sprintf('---- Generación  %d -------', count);
    disp(outputString);

    %EVALUAR CADA UNA Y OBTENER EL FITNESS DE LAS MISMAS
    j = 1;
    while(j <= cantidad_individuos)
        A = individuos{j};
        new_fitness = eval_fitness(series,A);
        fitness(j) = new_fitness;
        j = j + 1;
    end
  

    itemCount = length(fitness);
    hasChanged = false;
    while(hasChanged == false && itemCount > 0)
      itemCount = itemCount - 1;
      hasChanged= true;
      for i = 1:itemCount
           if ( fitness(i) > fitness(i+1) )
            %swap de individuos
             M = individuos{i+1};
             individuos{i+1} = individuos{i};
             individuos{i} = M;
             fitness([i,i+1]) = fitness([i+1,i]);  % swap de fitness
            hasChanged = false;
           end
      end
    end

    x = [count x];
    [minimo, iminimo] = min(fitness);
    [maximo, imaximo] = max(fitness);
    count = count + 1;
    minimos = [minimo minimos];
    maximos = [maximo maximos];
    mejor_individuo = individuos{iminimo};
    
    V = cell2matvec(individuos);

    %se hace la selección y las mutaciones
    %TODO: r_1.m no se si anda bien. Si, anda bien, pero hay que trasponer la matriz capo, si la pasas al reves no anda nada...
    V = V';

    
    switch metodoReemplazo

        case 1
            R = r_1(V, 1./fitness);
        case 2
            R = r_2(V, 1./fitness);        
        case 3
            R = r_3(V, 1./fitness);            
    end
        
    for i=1:cantidad_individuos
        W = vec2mat(R(i,:));
        individuos{i} = W;
    end
    outputString2 = sprintf('\n\n');
    disp(outputString2);
end


%plot(minimos)

plot(x,maximos,x,minimos)

end
