function [] = WriteTabularFunction(Information)
	
	FileID = fopen('TF-Container.inp','r');
	
	if (FileID == -1)
		
		FileID  = fopen('TF-Container.inp','w')  ;
		Duct.ID = 1                              ;
		fprintf(FileID,'AllowReplace \r\n!\r\n') ;
		fprintf(FileID,'!\r\nTF_INPUT\r\n!\r\n') ;
		
	else
		
		Duct.ID = fscanf(FileID,'%d')   ;
		fclose(FileID)                  ;
		FileID = fopen('TF-Container.inp','a') ;
		
	end
	
	fprintf(FileID,'TF_ID\t%s\t%9f\t0.0\r\n',Information.Name,Information.Val) ;
	fprintf(FileID,'TF_BND\tConst-Bnd\tConst-Bnd\r\n')                         ;
	fprintf(FileID,'TF_TAB\t2\t!\r\n')                                         ;
	fprintf(FileID,'\t\t1\t\t0.0\t\t1.0\r\n')                                  ;
	fprintf(FileID,'\t\t2\t\t1.0\t\t1.0\r\n')                                  ;
	fprintf(FileID,'!\r\n')                                                    ;
	fprintf(FileID,'!\r\n')                                                    ;
	
	fclose(FileID);
end