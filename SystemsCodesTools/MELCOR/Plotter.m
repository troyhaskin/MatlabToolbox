%clc;
clear('all');
% 
Data	= load('EnergyBalance.output')											;

N		= 1																		;
End		= size(Data,1)															;
Mask	= N : End																;


Time	= Data(Mask,1)															;

MdotA	= Data(Mask,2)															;
HoutAR	= Data(Mask,3)															;
HoutAL	= Data(Mask,4)															;
HinAR	= Data(Mask,5)															;
HinAL	= Data(Mask,6)															;

Tin		= Data(Mask,7)															;
Tout	= Data(Mask,8)															;

% MdotB	= Data(Mask,7)															;
% HoutBR	= Data(Mask,8)															;
% HoutBL	= Data(Mask,9)															;
% HinBR	= Data(Mask,10)															;
% HinBL	= Data(Mask,11)															;

Pactual		= 82894.7368421053 												;
PremoveA1	= MdotA .* (HoutAR - HinAL)										;
PremoveA2	= MdotA .* (HoutAL - HinAR)											;
ErrorA1		= (Pactual - PremoveA1) / Pactual									;
ErrorA2		= (Pactual - PremoveA2) / Pactual									;

% ErrorA1Prime	=Deriv(Time,ErrorA1);
% ErrorA2Prime	=Deriv(Time,ErrorA2);

Green = GetColor('green');

subplot(3,1,1);
 plot(Time,PremoveA1,'r','LineWidth',2.0);
axis([Time(1),Time(end),min(PremoveA1) - abs(min(PremoveA1)/10),...
	                    max(PremoveA1) + abs(max(PremoveA1)/10)]);
%plot(Time,PremoveA1,'-','LineWidth',2.0);
%  axis([Time(1),Time(end),min(PremoveA1) - abs(max(PremoveA1)/3),...
%  	                    max(PremoveA1) + abs(max(PremoveA1)/3)]);
grid('on')																		;
% hold('off')																		;

subplot(3,1,2);
plot(Time,MdotA);
axis([Time(1),Time(end),min(MdotA) - abs(min(MdotA)/3000),...
	                    max(MdotA) + abs(max(MdotA)/3000)]);
					
subplot(3,1,3)
plot(Time,Tout-Tin);

% Error	= ErrorA1(End-N+1:-1:1)														;
% Eps		= 0.0001*ones(End-N+1,1)														;
% ERR		= trapz(Time,abs(Error))													;
% IntErr	= cumtrapz(Time,abs(Error))													;
% IntErr	= IntErr - ERR + IntErr(end)												;
% IntEps	= cumtrapz(Time,abs(Eps))													;
% TimeP	= Time(End-N+1:-1:1)														;
% TimeSS	= TimeP(min(IntErr-IntEps)==(IntErr-IntEps))
% 
% figure()																			;
% plot(Time,ErrorA1,'r')								;
% hold('on')																			;
% plot( [TimeSS,TimeSS]   ,[-3*Eps(1),3*Eps(1)],'--k')								;
% plot([Time(1),Time(end)],      [Eps,Eps]     ,'--','Color',Green,'LineWidth',2.0)	;
% plot([Time(1),Time(end)],     -[Eps,Eps]     ,'--','Color',Green,'LineWidth',2.0)	;
% plot([Time(1),Time(end)],     [0.0,0.0]           ,'Color',Green,'LineWidth',2.0)	;
% 
% axis([Time(1),Time(end),-3*Eps(1),3*Eps(1)])										;
% hold('off')																			;
