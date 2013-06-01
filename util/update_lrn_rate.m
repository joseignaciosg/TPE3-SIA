function [eta, contador] = update_lrn_rate (lrn_type, eta, error, prev_error, contador, jump)
	
	global etta_limit;

	lrn_decay = 0.75;
    lrn_sum = 0.005;
    lrn_consist = 3;
    
    global reset;
	if(lrn_type ==2)
		contador = contador + 1;
		if(contador == etta_limit)
			contador =0;
			eta = lrn_decay * eta;
		end
	end
	if(lrn_type == 3)
		if(error > prev_error)
			contador = 0;
			eta = lrn_decay * eta;
			if( eta < 0.02)
				eta = 0.02;
			end
		elseif( error < prev_error)
			contador = contador + 1;
			if(contador >= lrn_consist)
				eta = eta + lrn_sum;
				if(eta > 0.6)
					eta = 0.6;
				end
			end
		end

	end

	%Si el eta es bajo y hace mucho tiempo que se esta en el mismo error entonces jump es igual a 1 y pega el salto.

	if(lrn_type == 3 && error > 0.05 && jump == 1 && eta < 0.03)
		prev_error = Inf;
		eta = 0.8;
	else
		prev_error = error;
	end
	
end