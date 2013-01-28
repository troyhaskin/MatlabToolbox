%function [Downer,Node,State] = GetDowner()
	% -----------------------------------------------------------
	% Duct Information
	%
	Downer.Name    = 'Downer';
	Downer.Type    = 'RCCS'  ;
	Downer.Hnaught =   38.0  ;
	Downer.deltaH  =  -38.0  ;
	
	% -----------------------------------------------------------
	% Nodal Information
	%
	Node.deltaH            = 0.25       ;
	Node.FlowArea          = 2.94648604 ;
	Node.HydraulicDiameter = 0.07062611 ;
	Node.FractionOpen      = 1.0        ;
	
	% -----------------------------------------------------------
	% State Information
	%
	State.Equilibrium      = 'No'                ;
	State.Fog              = 'No'                ;
	State.Activity         = 'Active'            ;
	State.PoolAtmosphere   = 'Atmosphere'        ;
	State.Atmo.State       = 'Superheated'       ;
	State.Atmo.Pressure    = 101325.0            ;
	State.Atmo.Temperature = 300.00              ;  % future version: {'Update',Guess}
	State.NCG.State        = {'H2O';0.0}         ;
	State.NCG.Gases        = {'N2',0.8;'O2',0.2} ;
	
%end