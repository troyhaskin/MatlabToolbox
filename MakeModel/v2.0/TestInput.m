clear('all');%clc;


% -----------------------------------------------------------
% Duct Information 
%
Downer.Name    = 'Downer';
Downer.Type    = 'RCCS'  ;
Downer.Hnaught =  0.0   ;
Downer.deltaH  =  -38.0   ;

% -----------------------------------------------------------
% Nodal Information 
%
Node.deltaH    = 0.25    ;
Node.FlowArea  = 3.7161  ;
Node.HydroDiam = 1.9367  ;
Node.FracOpen  = 1.0     ;

% -----------------------------------------------------------
% State Information 
%
State.Equilibrium      = 'No'                ;
State.Fog              = 'No'                ;
State.Activity         = 'Active'            ;
State.PoolAtmo         = 'Atmosphere'        ;
State.Atmo.State       = 'Superheated'       ;
State.Atmo.Pressure    = 101325.0            ;
State.Atmo.Temperature = 300.00              ;  % future version: {'Update',Guess}
State.NCG.State        = {'H2O';0.0}         ;
State.NCG.Gases        = {'N2',0.8;'O2',0.2} ;

% -----------------------------------------------------------
%  Heat structure information 
%
Front.Name            = 'Front'                              ;
Front.Geom            = 'Rectangular'                        ;
Front.SSI             = 'No'                                 ;
Front.Orient          = 'Vertical'                           ;
Front.Source          = 'No'                                 ;
Front.Nodes           = {0.0000, 350.00, 'Stainless-Steel'   ;...
						 4.7E-3, 350.00,        ''         } ;
Front.Left.BC         = 'Symmetry'                           ;
Front.Left.Radiation  = {0.9,'Equiv-Band',0.18}              ;
Front.Left.Flow       = {'External',0.9,0.9}                 ;
Front.Left.Surface    = {0.5,0.25}                           ;
Front.Right.BC        = 'Symmetry'                           ;
Front.Right.Radiation = {0.9,'Equiv-Band',0.18}              ;
Front.Right.Flow      = {'External',0.9,0.9}                 ;
Front.Right.Surface   = {0.5,0.25}                           ;
Front.FilmTrack       = 'No'                                 ;

Span = [-8.5,-0.0];

% -----------------------------------------------------------
% Make the duct and heat structures
%
Downer    = MakeDuct(Downer,Node,State)                   ;
Structure = Attach(Front,'Right','to',Downer,'over',Span) ;

% -----------------------------------------------------------
%  Print the deck
%
%WriteDuct(Downer);