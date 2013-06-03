function print_stats(crossover_counter,mutation_counter,bpp_counter)
    
fid = fopen("testdata", "a"); # Open and clear the file

os = sprintf('# apareamientos        : %d\n', crossover_counter);
%disp(os);
fprintf(fid, "%s ", os);
os = sprintf('# mutaciones           : %d\n', mutation_counter);
%disp(os);
fprintf(fid, "%s ", os);
os = sprintf('# backpropagations     : %d\n', bpp_counter);
%disp(os);
fprintf(fid, "%s ", os);

fclose(fid);

end
