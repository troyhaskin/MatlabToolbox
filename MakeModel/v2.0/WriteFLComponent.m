function [] = WriteFLComponent(Duct,FileID)
	String = GetFormatStrings('FL');
	
	fprintf(FileID,'FL_INPUT\r\n');
	
	for k = 1:Duct.CV.Num - 1
		PrintHeader(FileID,Duct.FL.IDs(k));
		fprintf(FileID,String.ID,Duct.FL.Name{k},Duct.FL.IDs(k));
		fprintf(FileID,String.FT1,Duct.CV.Name{k});
		fprintf(FileID,String.FT2,Duct.CV.Name{k+1});
		fprintf(FileID,String.FT3,Duct.CV.Altitude(k,2),Duct.CV.Altitude(k+1,1));
		fprintf(FileID,String.GEO,Duct.CV.FlowArea(k) ,...
			                      Duct.FL.Length      ,... 
								  Duct.CV.FracOpen(k) );
		fprintf(FileID,String.USL);
		fprintf(FileID,String.SEG,1);
		CardInfo = [Duct.CV.FlowArea(k),Duct.FL.Length,Duct.CV.HydroDiam(k)];
		fprintf(FileID,String.SEGn,1,CardInfo);
	end
	
	
	
	
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