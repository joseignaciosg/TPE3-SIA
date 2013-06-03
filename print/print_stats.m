function print_stats(crossover_counter,mutation_counter,bpp_counter)
    


os = sprintf('# apareamientos        : %d', crossover_counter);
disp(os);
os = sprintf('# mutaciones           : %d', mutation_counter);
disp(os);
os = sprintf('# backpropagations     : %d', bpp_counter);
disp(os);


end