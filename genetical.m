function [minimo, mejor_individuo] = genetical(series,generations,cantidad_individuos)

%para que se pueda ejecutar las funciones en las siguientes carpetas
addpath(genpath('./util'));
addpath(genpath('./reemplazo'));
addpath(genpath('./operators'));
addpath(genpath('./evaluar'));
addpath(genpath('./aparear'));


global P; 
global beta; 
global pc; %probabilidad de cross over
global pm; %probabilidad de mutar
P = [3 5 1];
beta = 0.3;
pc = 0.75;
pm = 0.9;
err = 0.001;

%maximo valor de P para formar la matriz
m = max(P);

%para resear a un paso anterior la matriz de pesos
%global reset
%reset = 0;

%difference_weight = zeros(m,m+1,length(P)-1); %Delta_Peso

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
    individuos{h} = randommatrix(2,0.25);
    h = h + 1;
end



while(minimo > err && count <= generations)
    %EVALUAR CADA UNA Y OBTENER EL FITNESS DE LAS MISMAS
    j = 1;
    cantidad_individuos;
    while(j <= cantidad_individuos)
        A = individuos{j};
        new_fitness = eval_fitness(series,A);
        fitness(j) = new_fitness;
        j = j + 1;
    end
  
    %fitness
    %windowsize = P(1);
    
    %ORDENAR ESE VECTOR POR FITNESS (BUBBLESORT -> Soy un hdp si)
    itemCount = length(fitness);
    hasChanged = true;
    while(hasChanged == true && itemCount > 0)
      itemCount = itemCount - 1;
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
    %fitness
    [minimo, iminimo] = min(fitness);
    count = count + 1;
    minimos = [minimo minimos];
    mejor_individuo = individuos{iminimo};
    
    individuos;
    %TODO arreglar esto por que falla aca por que individuos est� mal
    V = cell2matvec(individuos);

    %se hace la selecci�n y las mutaciones
    %TODO: r_1.m no se si anda bien. Si, anda bien, pero hay que trasponer la matriz capo, si la pasas al reves no anda nada...
    V = V';
    R = r_1(V,fitness);
    
    for i=1:cantidad_individuos
        W = vec2mat(R(i,:));
        individuos{i} = W;
    end
    
    individuos;

end

minimos;

end
