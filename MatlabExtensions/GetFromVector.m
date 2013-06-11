function Values = GetFromVector(HandleVector,Property)
    
    StructArray = get(HandleVector);
    Values      = cell2mat({StructArray.(Property)}');

end