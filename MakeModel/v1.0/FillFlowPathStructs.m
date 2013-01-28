function Path = FillFlowPathStructs(FPath)
	TotalNumberOfPaths = FPath.Num;
	Path = repmat(struct(''),TotalNumberOfPaths,1);
	
	for k = 1:TotalNumberOfPaths
		Path(k).ID       = FPath.IDs(k);
		Path(k).Name     = deblank(FPath.Names(k,:));
		Path(k).VolFrom  = FPath.VolFrom(k,:);
		Path(k).VolTo    = FPath.VolTo(k,:);
		Path(k).ZFrom    = FPath.ZFrom(k);
		Path(k).ZTo      = FPath.ZTo(k);
		Path(k).FlowArea = FPath.FlowAreas(k);
		Path(k).Length   = FPath.Lengths(k);
		Path(k).OpenFrac = FPath.OpenFrac(k);
		Path(k).Seg.Num  = FPath.Seg(k);
		for m = 1:Path(k).Seg.Num
			Path(k).Seg.FlowArea(m) = FPath.FlowAreas(k);
			Path(k).Seg.Length(m)   = FPath.Lengths(k);
			Path(k).Seg.Dh(m)       = FPath.Dh(k);
		end
	end
end