function cuadratic_error = eval_fitness(series,A)

global P;
global beta;


%maximo valor de P para formar la matriz
m = max(P);

windowsize = P(1);

index = P(1) -1; %resto -1 para que de bien el index en el vector testing

%Series a tomar en cuenta para entrenamiento

series1 = series;
maxserie = max(abs(series));
series = series./maxserie;

%Variables
x = [];
os=[];
ss=[];
diffs = [];
diffs2 = [];
diffs_square = [];
error=[];
count = 0;

max_diff = 0;
min_diff = inf;
diff = 0;
diff2 = 0;
cuadratic_error = 0;
acceptable_values=0;
    i=1;
	while(i<=(length(series)-windowsize))
		s = series(i+windowsize);
		[s,o] = variable4testing(series(i:i+windowsize-1),A,P,s,beta);
		i=i+1;
		final_s = s * maxserie;
		final_o = o * maxserie;
		
		os = [os final_o];
    	ss = [ss final_s];
    	x = [i x];
        diff = abs(final_s-final_o);
        diff2 = final_s-final_o;
        cuadratic_error = cuadratic_error + (s-o)^2;
        error = [error diff];
        diffs = [diffs diff];
        diffs2 = [diffs2 diff2];
        if(max_diff<diff)
            max_diff = diff;
        end
        if(min_diff>diff)
            min_diff = diff;
        end

    end
    cuadratic_error = cuadratic_error / (i-1);
    

end

