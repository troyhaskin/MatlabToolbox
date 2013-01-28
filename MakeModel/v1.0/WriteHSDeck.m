function [] = WriteHSDeck(Structure,FileName)
	FileID = fopen(FileName,'w');
	fprintf(FileID,'AllowReplace\r\n!\r\n');
	fprintf(FileID,'HS_INPUT\r\n');
	
	String = GetFormatStrings('Heat Structure');
	
	for k = 1:length(Structure)
		PrintHeader(FileID,Structure(k).ID);
		fprintf(FileID,String.ID,deblank(Structure(k).Name),Structure(k).ID);
		fprintf(FileID,String.GD,Structure(k).Geom,Structure(k).SSI);
		fprintf(FileID,String.EOD,Structure(k).Bottom,Structure(k).Orien);
		fprintf(FileID,String.SRC,Structure(k).Source);
		fprintf(FileID,String.ND,Structure(k).Sub.Num);
		for m = 1:Structure(k).Sub.Num
			LocalNode = Structure(k).Node;
			CardInfo1 = [m,m,LocalNode.Loc(m),LocalNode.Temp(m)];
			if (m ~= Structure(k).Sub.Num)
				CardInfo2 = LocalNode.Mat(m,:);
			else
				CardInfo2 = [];
			end
			fprintf(FileID,String.NDn,CardInfo1,CardInfo2);
		end
		fprintf(FileID,String.LB);
		fprintf(FileID,Structure(k).Left.BC);
		fprintf(FileID,String.End);
		fprintf(FileID,String.LBR);
		fprintf(FileID,Structure(k).Left.Rad);
		fprintf(FileID,String.End);
		fprintf(FileID,String.LBP);
		fprintf(FileID,Structure(k).Left.FlowType);
		fprintf(FileID,String.End);
		fprintf(FileID,String.LBS,Structure(k).Left.Dim);
		fprintf(FileID,String.RB);
		fprintf(FileID,Structure(k).Right.BC);
		fprintf(FileID,String.End);
		fprintf(FileID,String.RBR);
		fprintf(FileID,Structure(k).Right.Rad);
		fprintf(FileID,String.End);
		fprintf(FileID,String.RBP);
		fprintf(FileID,Structure(k).Right.FlowType);
		fprintf(FileID,String.End);
		fprintf(FileID,String.RBS,Structure(k).Right.Dim);
		fprintf(FileID,String.FT,Structure(k).FilmTrack);
	end
	fclose(FileID);
	
	function [] = PrintHeader(FileID,ID)
		fprintf(FileID,'!\r\n');
		fprintf(FileID,'!');
		SpanEql(FileID);
		fprintf(FileID,'\tHeat Structure %G\t',ID);
		SpanEql(FileID);
		fprintf(FileID,'\r\n');
		
		function [] = SpanEql(FileID)
			for z = 1:18
				fprintf(FileID,'=');
			end
		end
	end
end