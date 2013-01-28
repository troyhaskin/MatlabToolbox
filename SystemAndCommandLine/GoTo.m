function [] = GoTo(Location)
	switch(lower(Location))
		case('top')
			cd('C:\');
            
		case({'mel','melcor','work'})
			cd('C:\MELCOR\Simulations');
            
		case({'relap','r5','relap5'})
			cd('C:\RELAP');
            
		case('school')
            
		case({'desk','desktop'})
			cd('C:\Users\Troy Haskin\Desktop');
            
		case({'tool','toolbox'})
			cd('C:\MyMatlabToolbox\');
            
        case({'sandbox','sand','scratch'})
            cd('C:\MyMatlabToolbox\Sandbox\Public');
            
		otherwise
			error('Requested location ''%s'' is not supported',Location)
	end
end