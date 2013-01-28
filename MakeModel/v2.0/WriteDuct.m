function [] = WriteDuct(Duct,varargin)
	
	if ((nargin == 1) || isempty(varargin))
		FileName = [Duct.Name,'_CVH-FL_Model.inp'];
	else
		FileName = varargin{1};
	end
	
	FileID = fopen(FileName,'w');
	
	WriteCVHComponent(Duct,FileID) ;
	WriteSpacer      (FileID)      ;
	WriteFLComponent (Duct,FileID) ;
	fclose(FileID);

	
	function [] = WriteSpacer(FileID)
		fprintf(FileID,'!\r\n!\r\n!\r\n!\r\n!\r\n');
		fprintf(FileID,'!=====================================================\r\n');
	end
end