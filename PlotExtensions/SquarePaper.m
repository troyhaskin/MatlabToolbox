function [] = SquarePaper()
	
	PaperPos = get(gcf,'PaperPosition');
	P(1)       = PaperPos(1);
	P(2)       = PaperPos(2);
	P(3)       = min(PaperPos(3:4));
	set(gcf,'PaperPosition',[P(1),P(2),P(3),P(3)]);
	
end