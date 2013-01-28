clear('all');clc;

ActiveHeight     = 8 ;                            %[m]
ChimneyHeight    = 30;                            %[m]
TotalHeight      = ActiveHeight + ChimneyHeight;
CVolHeight       = 0.25;                          %[m]
FlowArea         = 3.71612;

CVol      = CVHSetup(FlowArea,CVolHeight,TotalHeight);
Volume    = FillVolumeStructs(CVol);

FPath     = FLSetup(CVol);
Path      = FillFlowPathStructs(FPath);

% 
HStr      = HSSetup(CVol);
Structure = FillStructureStructs(HStr);
% 
WriteCVHDeck(Volume  ,'RCCS-Duct-CVH.inp');
WriteFLDeck(Path     ,'RCCS-Duct-FL.inp' );
WriteHSDeck(Structure,'RCCS-Duct-HS.inp' );
