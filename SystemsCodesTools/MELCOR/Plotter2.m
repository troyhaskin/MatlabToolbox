%clc;
clear('all');
% 
Data	= load('EnergyBalance.output')											;

N		= 1																		;
End		= size(Data,1)															;
Mask	= N : End																;

Time	= Data(Mask,1)															;
Mdot	= Data(Mask,2)															;
Hout	= Data(Mask,3)															;
Hin		= Data(Mask,4)															;
Tin		= Data(Mask,5)															;
Tout	= Data(Mask,6)															;

Pactual	= 82894.7368421053 /3													;
Premove	= Mdot .* (Hout - Hin)													;
Error	= (Pactual - PremoveA1) / Pactual										;

% ErrorA1Prime	=Deriv(Time,ErrorA1);
% ErrorA2Prime	=Deriv(Time,ErrorA2);

Green = GetColor('green');

subplot(3,1,1);
 plot(Time,ErrorA1,'r','LineWidth',2.0);
axis([Time(1),Time(end),min(Error) - abs(min(Error)/10),...
	                    max(Error) + abs(max(Error)/10)]);
%plot(Time,PremoveA1,'-','LineWidth',2.0);
%  axis([Time(1),Time(end),min(PremoveA1) - abs(max(PremoveA1)/3),...
%  	                    max(PremoveA1) + abs(max(PremoveA1)/3)]);
grid('on')																		;
% hold('off')																		;

subplot(3,1,2);
plot(Time,Mdot);
axis([Time(1),Time(end),min(Mdot) - abs(min(Mdot)/3000),...
	                    max(Mdot) + abs(max(Mdot)/3000)]);
					
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
