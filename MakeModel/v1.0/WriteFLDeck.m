function [] = WriteFLDeck(Path,FileName)
	FileID = fopen(FileName,'w');
	fprintf(FileID,'AllowReplace\r\n!\r\n');
	fprintf(FileID,'FL_INPUT\r\n');
	
	String = GetFormatStrings('Flow Path');
	
	for k = 1:length(Path)
		PrintHeader(FileID,Path(k).ID);
		Info.Geom    = [Path(k).FlowArea,Path(k).Length,Path(k).OpenFrac];
		fprintf(FileID,String.ID,Path(k).Name,Path(k).ID);
		fprintf(FileID,String.FT1,Path(k).VolFrom);
		fprintf(FileID,String.FT2,Path(k).VolTo);
		fprintf(FileID,String.FT3,Path(k).ZFrom,Path(k).ZTo);
		fprintf(FileID,String.GEO,Info.Geom);
		fprintf(FileID,String.USL);
		fprintf(FileID,String.SEG,Path(k).Seg.Num);
		for m = 1:Path(k).Seg.Num
			CardInfo = [Path(k).Seg.FlowArea(m),Path(k).Seg.Length(m),Path(k).Seg.Dh(m)];
			fprintf(FileID,String.SEGn,m,CardInfo);
		end
	end
	fclose(FileID);
	
	function [] = PrintHeader(FileID,ID)
		fprintf(FileID,'!\r\n');
		fprintf(FileID,'!');
		SpanEql(FileID);
		fprintf(FileID,'\tFlow Path %G\t',ID);
		SpanEql(FileID);
		fprintf(FileID,'\r\n');
		
		function [] = SpanEql(FileID)
			for z = 1:18
				fprintf(FileID,'=');
			end
		end
	end
	
end