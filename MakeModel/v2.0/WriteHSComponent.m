function [] = WriteHSComponent(Struct,varargin)
	
	if ((nargin == 1) || isempty(varargin))
		FileName = [Struct.Name,'_HS_Model.inp'];
	else
		FileName = varargin{1};
	end
	
	FileID = fopen(FileName,'w');
	
	String = GetFormatStrings('HS');
	fprintf(FileID,'AllowReplace\r\n!\r\n');
	fprintf(FileID,'HS_INPUT\r\n');
	
	NodeNum = size(Struct.Nodes,1);
	
	for k = 1:Struct.Num
		PrintHeader(FileID,Struct.IDs(k));
		fprintf(FileID,String.ID,Struct.Name{k},Struct.IDs(k));
		fprintf(FileID,String.GD,Struct.Geometry,Struct.SSI);
		fprintf(FileID,String.EOD,Struct.Hnaughts(k),Struct.Orientation);
		fprintf(FileID,String.SRC,Struct.Source);
		fprintf(FileID,String.ND,NodeNum);
		for m = 1:NodeNum-1
			fprintf(FileID,String.NDn,m,m,Struct.Nodes{m,1,k},...
				                          Struct.Nodes{m,2,k},...
				                          Struct.Nodes{m,3,k});
		end
		fprintf(FileID,String.NDend,NodeNum,NodeNum,...
		         Struct.Nodes{NodeNum,1,k},Struct.Nodes{NodeNum,2,k} );
			 
		if (~ischar(Struct.Left.BC))
		fprintf(FileID,'HS_LB\t%s\t''%s''\t%s\r\n',Struct.Left.BC.Type    ,...
			                            Struct.Left.BC.CVs{k}  ,...
									    Struct.Left.BC.Opt1   );
		else
			fprintf(FileID,'HS_LB\t%s\r\n',Struct.Left.BC);
		end

		fprintf(FileID,String.LBR,Struct.Left.Radiation{1} ,...
			                      Struct.Left.Radiation{2} ,...
			                      Struct.Left.Radiation{3} );
		fprintf(FileID,String.LBP,Struct.Left.Flow{1} ,...
			                      Struct.Left.Flow{2} ,...
			                      Struct.Left.Flow{3});
		fprintf(FileID,String.LBS,Struct.Left.Surface{1} ,...
			                      Struct.Left.Surface{2} ,...
			                      Struct.Heights(k)      );
		
		if (~ischar(Struct.Right.BC))
		fprintf(FileID,'HS_RB\t%s\t''%s''\t%s\r\n',Struct.Right.BC.Type    ,...
			                            Struct.Right.BC.CVs{k}  ,...
									    Struct.Right.BC.Opt1   );
		else
			fprintf(FileID,'HS_RB\t%s\r\n',Struct.Right.BC);
		end

		fprintf(FileID,String.RBR,Struct.Right.Radiation{1} ,...
			                      Struct.Right.Radiation{2} ,...
			                      Struct.Right.Radiation{3} );
		fprintf(FileID,String.RBP,Struct.Right.Flow{1} ,...
			                      Struct.Right.Flow{2} ,...
			                      Struct.Right.Flow{3});
		fprintf(FileID,String.RBS,Struct.Right.Surface{1} ,...
			                      Struct.Right.Surface{2} ,...
			                      Struct.Heights(k)      );
		fprintf(FileID,String.FT,Struct.FilmTrack);
	end
	
	fclose(FileID);
	
	function [] = PrintHeader(FileID,ID)
		fprintf(FileID,'!\r\n');
		fprintf(FileID,'!');
		SpanEql(FileID);
		fprintf(FileID,'\tHeat Struct %G\t',ID);
		SpanEql(FileID);
		fprintf(FileID,'\r\n');
		
		function [] = SpanEql(FileID)
			for z = 1:18
				fprintf(FileID,'=');
			end
		end
	end
	
end