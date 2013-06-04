%Forma de invocación
%
%[minimo, [minimo, mejor_individuo] = genetical(serie,max_generations,cantidad_individuos,gap,mp,cp, cs,cr, tipo_apareo,metodoReemplazo,error,criterio_estructura,criterio_contenido, pm_decrease, mix_type)
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
%* criterio_estructura: 1 si se usa el criterio de corte por estructura, 0 si no. 
%* criterio_contenido: 1 si se usa el criterio de corte por contenido, 0 si no. 
%* pm_decrease: cuanto varia pm cada vez que transcurren 10% de las iteraciones totales, 1 si no varia. (0 < pm_decrease <= 1)
%* mix_type: 1 para usar mixto elite-ruleta, de lo contrario se usa elite-boltzmann.
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

function [minimo, mejor_individuo] = genetical(individuos,serie, max_generations, cantidad_individuos, gap, mp, cp, cs, cr, tipo_apareo, metodoReemplazo, error, criterio_estructura, criterio_contenido, pm_decrease, mix_type)
%function [minimo, mejor_individuo] = genetical(serie, max_generations, cantidad_individuos, gap, mp, cp, cs, cr, tipo_apareo, metodoReemplazo, error, criterio_estructura, criterio_contenido, pm_decrease, mix_type)

%para que se pueda ejecutar las funciones en las siguientes carpetas
addpath(genpath('./util'));
addpath(genpath('./reemplazo'));
addpath(genpath('./operators'));
addpath(genpath('./criteria'));
addpath(genpath('./aparear'));
addpath(genpath('./print'));
addpath(genpath('./evaluar'));

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
global structure_changes;%para los cambios en las N generaciones con el criterio de estructura
global content_changes;%para los cambios en las N generaciones con el criterio de contenido
global changes_n;%numero de generaciones que puede quedar la estructura sin cambios
global apareo;%aparear
global parte_pobl; %porcentaje de la población para el criterio de corte por estructura
global error_estruc;
%para las estadísticas totales
global crossover_counter_total;
global mutation_counter_total;
global bpp_counter_total;
global mx_type;

%Parametros Fijos
T = 2;
P = [3 5 1];
beta = 0.3;

%Paremtros Variables
mx_type = mix_type;
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
parte_pobl = 0.70; % porcentaje de población que debe cambiar para que no se corte por criterio de estructura
error_estruc = 1e-07;
error_cont = 1e-04;


structure_changes = []
content_changes  = []
changes_n = 5; 

%maximo valor de P para formar la matriz
m = max(P);

%Variables
%individuos = cell(cantidad_individuos,1);
fitness = [];
minimo = 1;
count = 1;
minimos = [];
maximos = [];
promedios = [];
x = [];

%Cantidad total de individuos
N = cantidad_individuos;

%Serie
max_serie = max(series);
series = series(1:750)./max_serie;

%Se crea un vector con N individuos
%h=1;
%while ( h <= N)
%    individuos{h} = randommatrix(1,0.25);
%    h = h + 1;
%end


print(metodoReemplazo,criterio_seleccion,criterio_reemplazo,apareo,count)   

content_criteria = inf;
struct_criteria = inf;
minimo_anterior = 0;
change = 0;
crossover_counter_total = 0;
mutation_counter_total = 0;
bpp_counter_total = 0;

while(minimo > err && count <= max_generations  )
    outputString = sprintf('------ Generación  %d -------', count);
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
    os = sprintf('- mínimo               : %d',minimo);

    disp(os);
    media = mean(fitness);
    count = count + 1;
    minimos = [minimo minimos];
    maximos = [maximo maximos];
    promedios = [media promedios];
    mejor_individuo = individuos{iminimo};
    if criterio_contenido
        content_criteria = abs(minimo_anterior-minimo);
    end
    minimo_anterior = minimo;
    
    
    V = cell2matvec(individuos);
    %se hace la selección y las mutaciones
    V = V';

	%actualizo pm
	if( pm > 0.001 && mod(count, max_generations * 0.1) == 0)
		pm = pm * pm_decrease;
	end

    switch metodoReemplazo

        case 1
            R = r_1(V, 1./fitness);
        case 2
            R = r_2(V, 1./fitness);        
        case 3
            R = r_3(V, 1./fitness);            
    end

   
        
    %CRITERIOS DE CORTE
    if (criterio_estructura == 1)   
        compute_change(V,R);    
        if ( check_non_change(structure_changes) )
              disp '[TERM] Terminación de ejecución por condición de estructura';
        break
        end
    end
    
    if (criterio_contenido == 1)
        compute_change_content(content_criteria,error_cont)
        if ( check_non_change(content_changes) )
             disp '[TERM] Terminación de ejecución por condición de contenido';
             os = sprintf('Minimo anterior: %f / Mínimo actual: %f / Diferencia: %f', minimo_anterior,minimo, abs(minimo_anterior-minimo));
             disp(os);
             breakerror_cont = 1e-04;
        end
    end
    
    for i=1:cantidad_individuos
        W = vec2mat(R(i,:));
        individuos{i} = W;
    end
    outputString2 = sprintf('\n\n');
    disp(outputString2);
    
	plot(x,maximos,x,minimos,x,promedios);
end

print_total();

end
