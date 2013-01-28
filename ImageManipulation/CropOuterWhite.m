function [] = CropOuterWhite(Path,ImageName)
	Image = imread([Path,'\',ImageName,'.png']);
	FlatImage = sum(Image,3);
	CropMat   = (FlatImage ~= 255*3);
	SumCol    = sum(CropMat,1);
	SumRow    = sum(CropMat,2);
	Ymin      = find(SumCol~=0,1,'first');
	Xmin      = find(SumRow~=0,1,'first');
	Xmax      = find(SumRow~=0,1,'last');
	Ymax      = find(SumCol~=0,1,'last');
	Width     = abs(Xmax - Xmin);
	Height    = abs(Ymax - Ymin);
	NewImage  = imcrop(Image,[Ymin,Xmin,Height,Width]);
% 	NewImage  = imrotate(NewImage,-90);
	imwrite(NewImage,[ImageName,'.png']);
end