function ScrnSz = SquareScreenSize()
	Temp = get(0,'ScreenSize');
	Min  = min(Temp(3:4));
	
	ScrnSz = [Temp(1),Temp(2),Min,Min];
end