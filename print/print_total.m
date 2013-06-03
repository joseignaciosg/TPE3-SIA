function print_total()

global crossover_counter_total;
global mutation_counter_total;
global bpp_counter_total;
disp '------ Stats  Totales -------';
os = sprintf('# apareamientos totales     : %d', crossover_counter_total);
disp(os);
os = sprintf('# mutaciones totales        : %d', mutation_counter_total);
disp(os);
os = sprintf('# backpropagations totales  : %d', bpp_counter_total);
disp(os);


end