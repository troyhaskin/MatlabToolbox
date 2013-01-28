function Volume = FillVolumeStructs(CVol)
	TotalNumberOfVolumes = length(CVol.IDs);
	Volume = repmat(struct(''),TotalNumberOfVolumes,1);
	
	for k = 1:TotalNumberOfVolumes
		Volume(k).ID      = CVol.IDs(k);
		Volume(k).Type    = CVol.Types(k,:);
		Volume(k).Name    = deblank(CVol.Names(k,:));
		Volume(k).Sub.Num = CVol.FineDivs;
		for m = 1:CVol.FineDivs
			Weight                  = (CVol.FineDivs-m)/(CVol.FineDivs-1);
			Volume(k).Sub.Alt(m)    = CVol.CoarseHeight(k) - CVol.RelHeight(k)*Weight;
			Volume(k).Sub.Volume(m) = -(m ~= 1)*CVol.FineVolume(k)/(CVol.FineDivs-1);
		end
		Volume(k).Pressure    = CVol.Press(k);
		Volume(k).Temperature = CVol.Temps(k);
		NCGs                  = char(fieldnames(CVol.NCG));
		Volume(k).NCG.Num     = size(NCGs,1);
		for m=1:Volume(k).NCG.Num
			Volume(k).NCG.Gas(m,:) = NCGs(m,:);
			Volume(k).NCG.Amt(m) = CVol.NCG.(NCGs(m,:));
		end
	end
	
end