clear('all');clc;

% -----------------------------------------------------------
%  Get geometry info
%
% [CldChimCV,CldChimNode,CldChimState]	= GetDowner('chimney')		;
%[CldHeadCV,CldHeadNode,CldHeadState]	= GetDowner('header')		;
% [DownerCV ,DownerNode ,DownerState]		= GetDowner('downer')		;
[RiserCV  ,RiserNode  ,RiserState]		= GetRiser ('riser')		;
%[HotHeadCV,HotHeadNode,HotHeadState]	= GetRiser ('header')		;
% [HotChimCV,HotChimNode,HotChimState]	= GetRiser ('chimney')		;
% FrontA					= GetFront()		;
% FrontB					= GetFront()		;
% FrontA.Type				= 'RiserA'			;
% FrontB.Type				= 'RiserB'			;
% Span						= [0.0,21.5]		;

% -----------------------------------------------------------
% Make the duct and heat structures
%
% CldChimCV	= MakeDuct(CldChimCV,CldChimNode,CldChimState)		;
% CldHeadCV	= MakeDuct(CldHeadCV,CldHeadNode,CldHeadState)		;
% DownerCV	= MakeDuct(DownerCV ,DownerNode ,DownerState)		;
cd ..
RiserCV		= MakeDuct(RiserCV  ,RiserNode  ,RiserState)		;
% HotHeadCV	= MakeDuct(HotHeadCV,HotHeadNode,HotHeadState)		;
% HotChimCV	= MakeDuct(HotChimCV,HotChimNode,HotChimState)		;
% FrontA	= Attach(FrontA,'Left','to',RiserA,'over',Span)	;
% FrontB	= Attach(FrontB,'Left','to',RiserB,'over',Span)	;

% WriteDuct(CldChimCV,['HD_Model_',CldChimCV.Name,'.inp'])			;
% WriteDuct(CldHeadCV,[CldHeadCV.Name,'_HD_Model.inp'])			;
% WriteDuct(DownerCV ,['HD_Model_',DownerCV.Name ,'.inp'])			;
WriteDuct(RiserCV  ,['HD_Model_',RiserCV.Name  ,'.inp'])			;
% WriteDuct(HotHeadCV,[HotHeadCV.Name,'_HD_Model.inp'])			;
% WriteDuct(HotChimCV,['HD_Model_',HotChimCV.Name,'.inp'])			;

% WriteDuct(DownerB,[DownerB.Name,'_HD_Model.inp'])			;
% WriteDuct(RiserA,[RiserA.Name  ,'_HD_Model.inp'])			;
% WriteDuct(RiserB,[RiserB.Name  ,'_HD_Model.inp'])			;
% WriteHSComponent(FrontA,'FrontA_HS_Model.inp')			;
% WriteHSComponent(FrontB,'FrontB_HS_Model.inp')			;