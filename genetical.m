function [minimo, mejor_individuo] = genetical(series,P,err,epochs,beta,cantidad_individuos)

%maximo valor de P para formar la matriz
m = max(P);

%para resear a un paso anterior la matriz de pesos
%global reset
%reset = 0;

%difference_weight = zeros(m,m+1,length(P)-1); %Delta_Peso

%Variables
individuos = [];
fitness = [];

%Cantidad total de individuos
N = cantidad_individuos;

%Serie
max_serie = max(series);
series = series(1:750)./max_serie;

%Se crea un vector con N individuos
while(N > 0)
    individuos = [individuos randommatrix(P,2,0.25)];
    N = N - 1;
end

while(minimo > err && count < epochs)
    %EVALUAR CADA UNA Y OBTENER EL FITNESS DE LAS MISMAS
    N = cantidad_individuos;
    while(N > 0)
        fitness = [fitness eval_fitness(individuos(pattern,N,P,beta,max_serie))];
        N = N - 1;
    end

    %windowsize = P(1);


    %ORDENAR ESE VECTOR POR FITNESS
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
end

mejor_individuo = individuos(iminimo);

