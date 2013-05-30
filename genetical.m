function [minimo, mejor_individuo] = genetical(series,generations,cantidad_individuos)

global P; 
global beta; 
P = [3 5 1];
beta = 0.3;
err = 0.001;

%maximo valor de P para formar la matriz
m = max(P);

%para resear a un paso anterior la matriz de pesos
%global reset
%reset = 0;

%difference_weight = zeros(m,m+1,length(P)-1); %Delta_Peso

%Variables
individuos = cell(50);
fitness = [];
minimo = 1;
count = 1;


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
    itemCount
    hasChanged = true;
    while(hasChanged == true && itemCount > 0)
      itemCount = itemCount - 1;
      itemCount
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
    count = count + 1
end
 


mejor_individuo = individuos{iminimo};

