%retorna 1 si debe cortar
function stop = check_struck_non_change()

    stop = 1;
    global structure_changes;
    n = length(structure_changes);
    i = n;
    if (n >= 5 )
        while (i>n-5)
            if (structure_changes(i) == 1)
                stop = 0;
            end
            i=i-1;
        end
    else
        stop = 0;
    end
   

end