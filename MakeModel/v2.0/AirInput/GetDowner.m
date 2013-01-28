function [Downer,Node,State] = GetDowner()
	% -----------------------------------------------------------
	% Duct Information
	%
	Downer.Name    = 'Downer'	;
	Downer.Type    = 'RCCS'		;
	Downer.Hnaught =   40.0		;
	Downer.deltaH  =  -40.0		;
	
	% -----------------------------------------------------------
	% Nodal Information
	%
	Node.deltaH    = 0.25		;
	Node.FlowArea  = 8.9806272	;
	Node.HydroDiam = 0.35859	;
	Node.FracOpen  = 1.0		;
	
	% -----------------------------------------------------------
	% State Information
	%
	State.Equilibrium      = 'No'					;
	State.Fog              = 'No'					;
	State.Activity         = 'Active'				;
	State.PoolAtmo         = 'Pool'			        ;
	State.Atmo.State       = 'Subcooled'			;
	State.Atmo.Pressure    = 101325.0				;
	State.Atmo.Temperature = 300.00					;	 % future version: {'Update',Guess}
	State.NCG.State        = {'H2O';0.0}			;
	State.NCG.Gases        = {'N2',0.8;'O2',0.2}	;
	
end