%levantando la serie temporal
load('TimeSeries/TimeSerie_G2.mat');

%levantadno la matriz de pesos iniciales
load individuos;

%params |cant_indv,max_generations,gap, mut_prob,cross_prob,
%       | sel_crit,rem_crit, tipo_apar, metodo_rem,error,criterio_estructura
%       | ,criterio_contenido, pm_decrease, mix_type)

%casos de prueba
params = [10 ,50  ,10 ,0.8,0.005,0.75,1,1,1,1,0.000000000001,0,0,0,0; %probando elite
          20 ,60 ,20 ,0.6,0.005,0.75,1,1,1,2,0.000000000001,0,0,0,0;
          30 ,40 ,30 ,0.5,0.005,0.75,1,1,1,3,0.000000000001,0,0,0,0;
          30 ,50 ,30 ,0.9,0.005,0.75,1,1,1,1,0.000000000001,0,0,0,0;
          40 ,200,40 ,0.8,0.005,0.75,1,1,1,2,0.000000000001,0,0,0,0;
          50 ,100,50 ,0.8,0.005,0.75,1,1,1,3,0.000000000001,0,0,0,0;
          100,50 ,100,0.8,0.005,0.75,1,1,1,1,0.000000000001,0,0,0,0;
          10 ,50 ,10 ,0.8,0.005,0.75,2,2,2,1,0.000000000001,0,0,0,0; % probando ruleta
          20 ,50 ,20,0.8,0.005,0.75 ,2,2,2,2,0.000000000001,0,0,0,0;
          30 ,20 ,30,0.8,0.005,0.75 ,2,2,2,3,0.000000000001,0,0,0,0;
          100,50 ,100,0.8,0.005,0.75,2,2,2,1,0.000000000001,0,0,0,0;
          200,20 ,200,0.8,0.005,0.75,2,2,2,2,0.000000000001,0,0,0,0;
          10 ,20 ,10 ,0.8,0.005,0.75,2,2,2,1,0.000000000001,0,0,0,0; %probando boltzman
          20 ,20 ,20,0.9,0.005,0.75 ,3,3,1,2,0.000000000001,0,0,0,0;
          200,20 ,200,0.5,0.005,0.75,3,3,1,3,0.000000000001,0,0,0,0;
          200,30 ,200,0.6,0.005,0.75,3,3,1,1,0.000000000001,0,0,0,0;
          200,40 ,200,0.8,0.005,0.75,3,3,1,2,0.000000000001,0,0,0,0;
          200,100,200,0.9,0.005,0.75,3,3,1,3,0.000000000001,0,0,0,0;
          200,100,200,0.9,0.005,0.75,3,3,1,3,0.000000000001,0,0,0,0; 
          200,100,200,0.9,0.005,0.75,4,4,1,3,0.000000000001,0,0,0,0; %probando torneo
          10 ,5  ,10 ,0.8,0.005,0.75,4,4,1,1,0.000000000001,0,0,0,0; 
          20 ,10 ,20 ,0.6,0.005,0.75,4,4,1,2,0.000000000001,0,0,0,0;
          30 ,20 ,30 ,0.5,0.005,0.75,4,4,1,3,0.000000000001,0,0,0,0;
          30 ,20 ,30 ,0.9,0.005,0.75,4,4,1,1,0.000000000001,0,0,0,0;
          40 ,200,40 ,0.8,0.005,0.75,4,4,1,2,0.000000000001,0,0,0,0;
          50 ,100,50 ,0.6,0.005,0.75,4,4,1,3,0.000000000001,0,0,0,0;
          10 ,20 ,10 ,0.8,0.005,0.75,2,2,2,1,0.000000000001,0,0,0,0; %probando mixto
          20 ,20 ,20 ,0.9,0.005,0.75,5,5,1,2,0.000000000001,0,0,0,0;
          200,20 ,200,0.5,0.005,0.75,5,5,3,1,0.000000000001,0,0,0,0;
          200,30 ,200,0.6,0.005,0.75,5,5,1,2,0.000000000001,0,0,0,0;
          200,40 ,200,0.8,0.005,0.75,5,5,1,2,0.000000000001,0,0,0,0;
          200,100,200,0.9,0.005,0.75,5,5,1,3,0.000000000001,0,0,0,0;
          20 ,20 ,20 ,0.9,0.005,0.75,1,2,1,1,0.000000000001,0,0,0,0; %probando metodo 1
          200,20 ,200,0.5,0.005,0.75,3,5,3,1,0.000000000001,0,0,0,0;
          200,30 ,200,0.6,0.005,0.75,5,2,1,1,0.000000000001,0,0,0,0;
          200,40 ,200,0.8,0.005,0.75,2,1,1,1,0.000000000001,0,0,0,0;
          200,100,200,0.9,0.005,0.75,5,3,1,1,0.000000000001,0,0,0,0;
          20 ,20 ,20 ,0.9,0.005,0.75,1,2,1,2,0.000000000001,0,0,0,0; %probando metodo 2
          200,20 ,200,0.5,0.005,0.75,3,5,3,2,0.000000000001,0,0,0,0;
          200,30 ,200,0.6,0.005,0.75,5,2,1,2,0.000000000001,0,0,0,0;
          200,40 ,200,0.8,0.005,0.75,2,1,1,2,0.000000000001,0,0,0,0;
          200,100,200,0.9,0.005,0.75,5,3,1,2,0.000000000001,0,0,0,0;
          20 ,20 ,20 ,0.9,0.005,0.75,1,2,1,3,0.000000000001,0,0,0,0; %probando metodo 3
          200,20 ,200,0.5,0.005,0.75,3,5,3,3,0.000000000001,0,0,0,0;
          200,30 ,200,0.6,0.005,0.75,5,2,1,3,0.000000000001,0,0,0,0;
          200,40 ,200,0.8,0.005,0.75,2,1,1,3,0.000000000001,0,0,0,0;
          200,100,200,0.9,0.005,0.75,5,3,1,3,0.000000000001,0,0,0,0;];
i=1;
test_counter=1;
N = size(params,1);
while (i <= N)
    os1 = sprintf('results/test%d.txt', test_counter); 
    fileID = fopen(os1,'w'); 
    os2 = sprintf('Test %d\n\n', test_counter); 
    
    %imprimendo parámetros
    fprintf(fileID,os2);
    fprintf(fileID,'Parameters:\n');
    fprintf(fileID,'Cantidad de Individuos    :%d\n', params(i,1));
    fprintf(fileID,'Cantidad de Generaciones  :%d\n', params(i,2));
    fprintf(fileID,'Brecha Generacional       :%f\n', params(i,4));
    fprintf(fileID,'Probabilidad de Mutacion  :%f\n', params(i,5));
    fprintf(fileID,'Probabilidad de CrossOver :%f\n', params(i,6));
    fprintf(fileID,'Criterio de Seleccion     :%d\n', params(i,7));
    fprintf(fileID,'Criterio de Reemplazo     :%d\n', params(i,8));
    fprintf(fileID,'Metodo de Apareo          :%d\n', params(i,9));
    fprintf(fileID,'Metodo de Reemplazo       :%d\n', params(i,10));
    fprintf(fileID,'Error                     :%f\n', params(i,11));
    fprintf(fileID,'Criterio corte estructura :%d\n', params(i,12));
    fprintf(fileID,'Criterio corte contenido  :%d\n', params(i,13));
    fprintf(fileID,'Pm decrease               :%d\n', params(i,14));
    fprintf(fileID,'Mix Type                  :%d\n', params(i,15));
    
    %corriendo caso de prueba
    [minimo, mejor_individuo,crossover_counter_total,mutation_counter_total,bpp_counter_total]...
        = genetical( individuos(1:params(i,1)),x, params(i,2),params(i,3), params(i,4), params(i,5),...
        params(i,6), params(i,7), params(i,8), params(i,9), params(i,10), params(i,11), params(i,12),...
        params(i,13), params(i,14),params(i,15) );
    
    %imprimiendo estadísticas
    fprintf(fileID,'\nminimo\t\t crossover total\t mutation total\t\t bpp total\t\n');
    fprintf(fileID,'%f\t\t %d\t\t %d\t\t\t %d\n\n',minimo,crossover_counter_total,...
        mutation_counter_total,bpp_counter_total);
    
    %imprimiendo mejor individuo
    fprintf(fileID,'Individuo mas apto:\n');
    dlmwrite(os1, mejor_individuo,'-append')
    fclose(fileID);
    
    %todas las pruebas se hacen dos veces para probar mejor
    if( mod(test_counter,2) == 0 )
        i=i+1;
    end
   
    test_counter = test_counter+1;
end
