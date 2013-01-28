function [] = MakePDF(Filename)
	MyPlotSettings('land')
	print('-dpdf','-r400',Filename)
end