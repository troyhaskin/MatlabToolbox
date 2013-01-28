function [] = WriteCVHDeck(Volume,FileName)
	FileID = fopen(FileName,'w');
	fprintf(FileID,'AllowReplace\r\n!\r\n');
	fprintf(FileID,'CVH_INPUT\r\n');
	
	String = GetFormatStrings('Control Volume');

	for k = 1:length(Volume)
		PrintHeader(FileID,Volume(k).ID);
		fprintf(FileID,String.ID ,Volume(k).Name,Volume(k).ID);
		fprintf(FileID,String.TYP,Volume(k).Type);
		fprintf(FileID,String.VAT,Volume(k).Sub.Num);
		for m = 1:Volume(k).Sub.Num
			fprintf(FileID,String.VATn,m,Volume(k).Sub.Alt(m),Volume(k).Sub.Volume(m));
		end
		fprintf(FileID,String.THR);
		fprintf(FileID,String.VEL);
		fprintf(FileID,String.PAS);
		fprintf(FileID,String.PTD,Volume(k).Pressure);
		fprintf(FileID,String.AAD,Volume(k).Temperature);
		fprintf(FileID,String.NCG,Volume(k).NCG.Num);
		for n = 1:Volume(k).NCG.Num
			fprintf(FileID,String.NCGn,n,Volume(k).NCG.Gas(n,:),Volume(k).NCG.Amt(n));
		end
		fprintf(FileID,'!\r\n');
	end
	fclose(FileID);
	
	function [] = PrintHeader(FileID,ID)
		fprintf(FileID,'!\r\n');
		fprintf(FileID,'!');
		SpanEql(FileID);
		fprintf(FileID,'\tControl Volume %G\t',ID);
		SpanEql(FileID);
		fprintf(FileID,'\r\n');
		
		function [] = SpanEql(FileID)
			for z = 1:18
				fprintf(FileID,'=');
			end
		end
	end
end