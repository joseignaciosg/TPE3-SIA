function increment_total_counters(crossover_counter,mutation_counter,bpp_counter)

global crossover_counter_total;
global mutation_counter_total;
global bpp_counter_total;

crossover_counter_total = crossover_counter_total + crossover_counter;
mutation_counter_total = mutation_counter_total + mutation_counter;
bpp_counter_total = bpp_counter_total + bpp_counter;

end 