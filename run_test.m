%levantando la serie temporal
load('TimeSeries/TimeSerie_G2.mat');

%levantadno la matriz de pesos iniciales
load individuos;

%params |cant_indv,max_generations,gap, mut_prob,cross_prob,
%       | sel_crit,rem_crit, tipo_apar, metodo_rem,error,criterio_estructura
%       | ,criterio_contenido, pm_decrease, mix_type)

params = [10,1,10,0.8,0.005,0.75,2,4,1,2,0.000000000001,0,0,0,0;
          20,1,20,0.8,0.005,0.75,2,4,1,2,0.000000000001,0,0,0,0;  ]
i=1;
N = size(params,1);
while (i <= N)
    os1 = sprintf('results/test%d.txt', i); 
    fileID = fopen(os1,'w'); 
    os2 = sprintf('Test %d\n\n', i); 
    
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
    fprintf(fileID,'Metodo de Reemplazo       :%d\n', params(i,9));
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
    
    %imprimiento estadísticas
    fprintf(fileID,'\nminimo\t\t crossover total\t mutation total\t\t bpp total\t\n');
    fprintf(fileID,'%f\t\t %d\t\t %d\t\t\t %d\n\n',minimo,crossover_counter_total,...
        mutation_counter_total,bpp_counter_total);
    
    %imprimiento mejor individuo
    fprintf(fileID,'Individuo mas apto:\n\n');
    dlmwrite(os1, mejor_individuo,'-append')
    fclose(fileID);
    i=i+1;
end
