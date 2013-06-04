function compute_change_content(content_criteria,error_cont)

        global content_changes;
        if content_criteria > error_cont 
            content_changes = [content_changes 1];
        else
            content_changes = [content_changes 0];
        end

end
