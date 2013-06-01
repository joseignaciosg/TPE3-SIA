function jump = ifErrorsAreSimilar(errores, jump)

    i=2;
    contador = 1;
    valor=errores(1);
    while(i<=length(errores)-1)
        if( (errores(i) <= (valor + 0.001)) && (errores(i) >= (valor - 0.001)) )
            contador = contador + 1;
        end
        i = i + 1;
    end

    if ( contador >= 49)
        jump = 1;
    end
    if (contador < 49)
        jump = 0;
    end

end