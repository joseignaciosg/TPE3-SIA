%Forma de invocación
%
%[minimo, mejor_individuo] = genetical(serie,max_generations,cantidad_individuos,gap,mp,cp, tipo_seleccion,
%                                        tipo_reemplazo, tipo_apareo,algoritmoReemplazo,error)
%
%* serie : Serie a predecir, propuestas por la catedra en el TP anterior.
%* max_generations : Cantidad máxima de generaciones a correr 
%* cantidad_individuos : Cantidad de Individuos que van a conformar la poblacion
%* gap : Brecha Generacional
%* mp :  Probabilidad de Mutuacion
%* cp :  Probabilidad de CrossOver
%* tipo_seleccion : Metodo de Seleccion
%* tipo_reemplazo : Metodo de Reemplazo
%* tipo_apareo : Metodo de Apareo
%* algoritmoReemplazo : Algoritmo de Reemplazo visto en clase
%* error : Cota de corte por error.
%
%Tipo de Seleccion y Reemplazo
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
%Algoritmos de Reemplazo
%
%    * 1 : Algoritmo de Reemplazo 1
%    * 2 : Algoritmo de Reemplazo 2
%    * 3 : Algoritmo de Reemplazo 3
%
%   PARA EJEMPLOS DE INVOCACION RECURRIR AL README
%

function [minimo, mejor_individuo] = genetical(serie,max_generations,cantidad_individuos,gap,mp,cp, tipo_seleccion,tipo_reemplazo, tipo_apareo,algoritmoReemplazo,error)

%para que se pueda ejecutar las funciones en las siguientes carpetas
addpath(genpath('./util'));
addpath(genpath('./reemplazo'));
addpath(genpath('./operators'));
addpath(genpath('./criteria'));
addpath(genpath('./aparear'));


global P;
global beta;
global pc; %probabilidad de cross over
global pm; %probabilidad de mutar
global pbpp; %probabilidad de hacer 100 pasos de backpropagation
global T; %para boltzmann
global G; %generation gap
global series;
global reemplazo;%criterio de seleccion
global seleccion;%criterio de reemplazo
global apareo;%aparear

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
reemplazo = tipo_seleccion;
seleccion = tipo_reemplazo;
algortimo_reemplazo = algoritmoReemplazo;
apareo = tipo_apareo;


%maximo valor de P para formar la matriz
m = max(P);

%Variables
individuos = cell(cantidad_individuos,1);
fitness = [];
minimo = 1;
count = 1;
minimos = [];


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



while(minimo > err && count <= max_generations)
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


    [minimo, iminimo] = min(fitness);
    count = count + 1;
    minimos = [minimo minimos];
    mejor_individuo = individuos{iminimo};
    
    V = cell2matvec(individuos);

    %se hace la selección y las mutaciones
    %TODO: r_1.m no se si anda bien. Si, anda bien, pero hay que trasponer la matriz capo, si la pasas al reves no anda nada...
    V = V';
    if ( algortimo_reemplazo == 1)
        disp '* Utilizando método de reemplazo tipo 1';
        %os = sprintf('---- Generación  %d -------', count);
        %disp(os);
        %disp '* Utilizando criterio de selección tipo 1';
        %disp '* Utilizando criterio de reemplazo tipo 1';        
        R = r_1(V, 1./fitness);
    end
    if ( algortimo_reemplazo == 2)
        disp '* Utilizando método de reemplazo tipo 2';
        %os = sprintf('---- Generación  %d -------', count);
        %disp(os);
        %disp '* Utilizando criterio de selección tipo 1';
        %disp '* Utilizando criterio de reemplazo tipo 1';
        R = r_2(V, 1./fitness);        
    end
    if ( algortimo_reemplazo == 3)
        disp '* Utilizando método de reemplazo tipo 3';
        %os = sprintf('---- Generación  %d -------', count);
        %disp(os);
        %disp '* Utilizando criterio de selección tipo 1';
        %disp '* Utilizando criterio de reemplazo tipo 1';
        R = r_3(V, 1./fitness);
    end
    
    outputString2 = sprintf('\n\n', count);
    disp(outputString2);
    
    for i=1:cantidad_individuos
        W = vec2mat(R(i,:));
        individuos{i} = W;
    end
    
end

minimos

end
