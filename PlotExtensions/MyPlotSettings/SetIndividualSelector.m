function [] = SetIndividualSelector(Selector,Style)
	
	switch (Selector)
		case('land')
			SetLandSelector(Style);
		case('axis')
			SetAxisSelector(Style);
		case({'contour','ylogcontour','xlogcontour'})
			SetContourSelector(Selector,Style);
		otherwise
			error('Plotting method %s is not currently supported.',Selector);
	end
	
end