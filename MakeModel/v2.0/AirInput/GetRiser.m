function [Downer,Node,State] = GetRiser()
%{
     Control volume flow area/hydraulic diameter  Calculation
	==========================================================
	
	Givens:
		Width Facing Core           = Wc   = 2.0    in/channel       ! by design
		Length Pependicular to Core = Lc   = 10.0   in/channel       ! by design
		Wall Thickness              = tc   = 0.1875 in/channel       ! by design
		Number of Channels          = Nc   = 292 channels            ! by design
		Number of Channels Here     = Neff = 0.5 * NumberOfChannels  ! chosen
		Structure Height            = Hhs  = 0.25 m                  ! chosen
	 
	Weff =      Wc        - 2 *       tc 
		 = 2.0 in/ch - 2 * 0.1875 in/ch
		 = 1.625 in/ch

	Leff =       Lc        - 2 *       tc 
		 = 10.0 in/ch - 2 * 0.1875 in/ch
		 = 9.625 in/ch
	
	FlowAreaTot =      Weff    *      Leff   *   Nc
				=  1.625 in/ch * 9.625 in/ch * 292 ch
				= 4,567.0625 in^2
				= 2.94648604  m^2
	
	FlowAreaEff =      Weff    *      Leff   *   Neff
				=  1.625 in/ch * 9.625 in/ch * 146 ch
				= 2,283.53125 in^2
				= 1.47324302   m^2	<=========================== Used Here
	
	HydroDiam	= 4 *   FlowAreaTot  /     WettedPerimeter
				= 4 * (Weff*Leff*Nc) / (2*Weff*Nc + 2*Leff*Nc)
				= 2 *  (Weff * Leff) /     (Weff + Leff)  <===================
				= 2.7805555 in												||
				= 0.0706261  m     <=========================== Used Here   ||
																			||
									   channel count independent =============
%}
	
	
% -----------------------------------------------------------
% Duct Information
%
	Downer.Name    = 'Riser'	;
	Downer.Type    = 'RCCS'		;
	Downer.Hnaught =  0.0		;
	Downer.deltaH  =  56.0		;
	
% -----------------------------------------------------------
% Nodal Information
%
	Node.deltaH    = 0.25				;
	Node.FlowArea  = 2.94648604 / 2		; % Two risers
	Node.HydroDiam = 0.0706261			;
	Node.FracOpen  = 1.0				;
	
% -----------------------------------------------------------
% State Information
%
	State.Equilibrium      = 'No'                ;
	State.Fog              = 'No'                ;
	State.Activity         = 'Active'            ;
	State.PoolAtmo         = 'Atmosphere'        ;
	State.Atmo.State       = 'Superheated'       ;
	State.Atmo.Pressure    = 101325.0            ;
	State.Atmo.Temperature = [300.00,2000.00]    ;  % future version: {'Update',Guess}
	State.NCG.State        = {'H2O';0.0}         ;
	State.NCG.Gases        = {'N2',0.8;'O2',0.2} ;
	
end