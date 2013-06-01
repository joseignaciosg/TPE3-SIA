function [a, b] = aparear(a, b)

global apareo;

 if ( apareo == 1 ) %anular
        [a, b] = anular(a, b);
    end
    
    if ( apareo == 2 ) %cup
        [a, b] = cup(a, b);
    end
    
    if ( apareo == 3 ) %one_point
        [a, b] = one_point(a, b);
    end
    
    if ( apareo == 4 ) %Two points
         [a, b] = two_points(a, b);
    end


end