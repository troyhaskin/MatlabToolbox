function TheCurrentDirectory = CurrentFileDirectory()
    
    TheCurrentDirectory = CallerDirectory('parent');
    
end