function s = structFilter(s,indices)
    
    fieldNames = fieldnames(s);
    for k = 1:numel(fieldNames);
        fieldName = fieldNames{k};
        if not(isstruct(s.(fieldName)))
            s.(fieldName) = s.(fieldName)(indices);
        else
            s.(fieldName) = structFilter(s.(fieldName),indices);
        end
    end

end