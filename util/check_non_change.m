%retorna 1 si debe cortar
function stop = check_non_change(changes)

    global changes_n;
    stop = 1;
    n = length(changes);
    i = n;
    if (n >= changes_n )
        while (i>n-changes_n)
            if (changes(i) == 1)
                stop = 0;
            end
            i=i-1;
        end
    else
        stop = 0;
    end
   

end