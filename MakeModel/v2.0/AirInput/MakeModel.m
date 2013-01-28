clear('all');clc;

% -----------------------------------------------------------
%  Get geometry info
%
[Downer,Node1,State1] = GetDowner() ;
[Riser1,Node2,State2] = GetRiser()  ;
[Riser2,Node3,State3] = GetRiser()  ;
Riser1.Name           = 'Riser1'    ;
Riser2.Name           = 'Riser2'    ;
Riser1.Type           = 'RCCS'      ;
Riser2.Type           = 'RCCS'      ;
Front1                = GetFront()  ;
Front2                = GetFront()  ;
Front1.Type           = 'Riser1'    ;
Front2.Type           = 'Riser2'    ;
Span                  = [0.0,8.5]   ;

% -----------------------------------------------------------
% Make the duct and heat structures
%
Downer = MakeDuct(Downer,Node1,State1)                   ;
Riser1 = MakeDuct(Riser1,Node2,State2)                   ;
Riser2 = MakeDuct(Riser2,Node3,State3)                   ;
Front1 = Attach(Front1,'Right','to',Riser1,'over',Span) ;
Front2 = Attach(Front2,'Right','to',Riser2,'over',Span) ;

WriteDuct(Downer,[Downer.Name,'_CVH-FL_Model.inp']);
WriteDuct(Riser1,[Riser1.Name,'_CVH-FL_Model.inp']);
WriteDuct(Riser2,[Riser2.Name,'_CVH-FL_Model.inp']);
WriteHSComponent(Front1,'Front1_HS_Model.inp');
WriteHSComponent(Front2,'Front2_HS_Model.inp');
