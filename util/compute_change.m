function change = compute_change(old_pop, new_pop)
diff_lotus_total = 0;
diff_inv_total = 0;
inv_n = size(old_pop,1);
lotus_n = size(old_pop,2)
for i = inv_n
    for j = lotus_n
        diff_lotus_total = diff_lotus_total + abs( old_pop(i,j) - new_pop(i,j) );
    end
    diff_lotus_total = diff_lotus_total/lotus_n;
    diff_inv_total = diff_inv_total + diff_lotus_total;
end

change = diff_inv_total / inv_n;

end