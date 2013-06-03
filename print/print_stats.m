function print_stats(crossover_counter,mutation_counter,bpp_counter)

os = sprintf('# apareamientos        : %d\n', crossover_counter);
disp(os);
os = sprintf('# mutaciones           : %d\n', mutation_counter);
disp(os);
os = sprintf('# backpropagations     : %d\n', bpp_counter);
disp(os);

end
