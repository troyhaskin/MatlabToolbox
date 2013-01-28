function [] = WriteCVHComponent(Duct,FileID)
	String = GetFormatStrings('CVH');
	
	fprintf(FileID,'AllowReplace\r\n!\r\n');
	fprintf(FileID,'CVH_INPUT\r\n');
	
	for k = 1:Duct.CV.Num
		PrintHeader(FileID,Duct.CV.IDs(k));
		fprintf(FileID,String.ID,Duct.CV.Name{k},Duct.CV.IDs(k));
		fprintf(FileID,String.TYP,Duct.Type);
		fprintf(FileID,String.VAT,2);
		
		if (strcmp(Duct.FlowDir,'Upward'))
			fprintf(FileID,String.VATn,1,Duct.CV.Altitude(k,1),0.000);
			fprintf(FileID,String.VATn,2,Duct.CV.Altitude(k,2),Duct.CV.Volumes(k));
		else
			fprintf(FileID,String.VATn,1,Duct.CV.Altitude(k,2),0.000);
			fprintf(FileID,String.VATn,2,Duct.CV.Altitude(k,1),Duct.CV.Volumes(k));
		end
		
		fprintf(FileID,String.THR ,Duct.CV.State.Equilibrium  ,...
			Duct.CV.State.Fog          ,...
			Duct.CV.State.Activity     );
		fprintf(FileID,String.PAS,Duct.CV.State.PoolAtmoModel ,...
			Duct.CV.State.PoolAtmo      ,...
			Duct.CV.State.Pool.Regime   );
		fprintf(FileID,String.PTD,Duct.CV.State.Pressure(k));
		fprintf(FileID,String.PAD,Duct.CV.State.Temperature(k));
		fprintf(FileID,String.VEL);
		%{
		fprintf(FileID,String.NCG,Duct.CV.NCG.Num,Duct.CV.NCG.State{1} ,...
			Duct.CV.NCG.State{2} );
		for m = 1:Duct.CV.NCG.Num
			fprintf(FileID,String.NCGn,m,Duct.CV.NCG.Gases{m,1},...
				Duct.CV.NCG.Gases{m,2});
		end
		%}
	end
	
	
	
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