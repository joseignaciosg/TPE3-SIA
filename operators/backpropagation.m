%a es el vector con los pesos 
%function [V,D,A,s,o,count,dif] = backpropagation( a )
function [a] = backpropagation( a )

%convierto el vector a matriz
A = vec2mat(a);

global series;
global P;
global beta;
eta = 0.045;
epochs = 100;
lrn_type = 3; %dinamico
 
%maximo valor de P para formar la matriz
m = max(P);


windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%normalizacion
max_serie = max(abs(series));
series = series./max_serie;

dif = 10;
old = 11;
errors = [];
x = [];
etas = [];
os=[];
ss=[];
os_x=[0];
count = 0;

%Almacenamiento de Errores cuadraticos para realizar el dinamic learning rate.
cuadratic_errors = 0;
cuadratic_error = 0;
contar = 0;
jump = 0;



while(count < epochs && abs(dif-old) > 1e-10)
	i=1;
	old = dif;
	cuadratic_error = 0;
	dif = 0;
    os = [];
    ss = [];
    os_x = [];
    [patterns]  = shufflePatterns(series,windowsize);
    while(i<=size(patterns,1))
        pattern = patterns(i,1:windowsize);
        s = patterns(i,windowsize+1); 
		[A,s,o] = variable3(pattern,A,s,eta);			
		final_s = s * max_serie;
		final_o = o * max_serie;
		os = [final_o os];
        ss = [final_s ss];
        os_x = [i os_x];
        i=i+1;
        cuadratic_error = cuadratic_error + (s-o).^2;
		dif = dif + (s-o).^2;
    end
    dif = dif / (i-1); % #patterns;
    cuadratic_error = cuadratic_error/(i-1); % #patterns
    errors = [dif errors];
    x = [count x];
    etas = [etas eta];
   
    cuadratic_errors = [cuadratic_errors cuadratic_error];

    %Modifico el eta en caso de ser necesario
    [eta, contar] = update_lrn_rate(lrn_type, eta, cuadratic_error, cuadratic_errors(length(cuadratic_errors)-1), contar, jump);


    if(count > 50)
        jump = ifErrorsAreSimilar(errors(1,1:50));
    end

    count = count+1;
    end

    a = mat2vec(A);
    
    
end



