function [minimo, mejor_individuo] = genetical(series,P,err,generations,beta,cantidad_individuos)

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
count = 0;

%Cantidad total de individuos
N = cantidad_individuos;

%Serie
max_serie = max(series);
series = series(1:750)./max_serie;

%Se crea un vector con N individuos
h=1;
while ( h < N)
    individuos{h} = randommatrix(P,2,0.25);
    h = h + 1;
    %N = N - 1;
end

individuos{1}

while(minimo > err && count < generations)
    %EVALUAR CADA UNA Y OBTENER EL FITNESS DE LAS MISMAS
    j = 1;
    while(j < cantidad_individuos)
        new_fitness = eval_fitness(series,individuos{N},P,beta);
        fitness = [fitness new_fitness];
       j = j + 1;
    end

    %windowsize = P(1);


    %ORDENAR ESE VECTOR POR FITNESS (BUBBLESORT -> Soy un hdp si)
    itemCount = length(fitness);
    do
      hasChanged = false;
      itemCount = itemCount - 1;
      for i = 1:itemCount
           if ( fitness(i) > fitness(i+1) )
             individuos([i,i+1]) = fitness([i+1,i]); %swap
             fitness([i,i+1]) = fitness([i+1,i]);  % swap
             hasChanged = true;
           end
      end
      until(hasChanged == false)

      [minimo, iminimo] = min(fitness);
      count = count + 1;
end

mejor_individuo = individuos(iminimo);

