function String = GetFormatStrings(CardType)
	switch(RemoveSpaces(lower(CardType)))
		case({'controlvolume','cvh','volume','control'})
			String.ID   = 'CV_ID\t''%s''\t%G\r\n'                     ;
			String.TYP  = 'CV_TYP\t''%s''\r\n'                        ;
			String.VAT  = 'CV_VAT\t%G\t!Number Elevation Volume\r\n'  ;
			String.VATn = '\t\t%G\t%7E\t%7E\r\n'                      ;
			String.THR  = 'CV_THR\t%s\t%s\t\t%s\r\n'                  ;
			String.VEL  = 'CV_VEL\t0.00\t0.00\r\n'                    ;
			String.PAS  = 'CV_PAS\t%s\t%s\t\t%s\r\n'                  ;
			String.PTD  = 'CV_PTD\tPVOL\t%7E\r\n'                     ;
			String.AAD  = 'CV_AAD\tTATM\t%7E\r\n'                     ;
			String.PAD  = 'CV_PAD\t%7E\r\n'                     ;
			String.NCG  = 'CV_NCG\t%G\t%s\t%4f\r\n'                   ;
			String.NCGn = '\t\t%G\t''%s''\t%7E\r\n'                   ;
		case({'flowpath','flow','path','fl'})
			String.ID   = 'FL_ID\t''%s''\t%G\r\n';
			String.FT1  = 'FL_FT\t''%s''';
			String.FT2  = '\t''%s''';
			String.FT3  = '\t%7E\t%7E\r\n';
			String.GEO  = 'FL_GEO\t%7E\t%7E\t%7E\r\n';
			String.USL  = 'FL_USL\t0.00\t0.00\t0.00\t0.00\r\n';
			String.SEG  = 'FL_SEG\t%G\r\n';
			String.SEGn = '\t\t%G\t%7E\t%7E\t%7E\r\n';
		case({'heatstructure','structure','heat','hs'})
			String.ID    = 'HS_ID\t''%s''\t%G\r\n';
			String.GD    = 'HS_GD\t%s\t%s\r\n';
			String.EOD   = 'HS_EOD\t%7E\t%7E\r\n';
			String.SRC   = 'HS_SRC\t%s\r\n';
			String.ND    = 'HS_ND\t%G\r\n';
			String.NDn   = '\t\t%G\t%G\t%7E\t%7E\t%s\r\n';
			String.NDend = '\t\t%G\t%G\t%7E\t%7E\r\n';
			String.LB    = 'HS_LB\t';
			String.LBR   = 'HS_LBR\t%6f\t%s\t%6f\r\n';
			String.LBP   = 'HS_LBP\t%s\t%6f\t%6f\r\n';
			String.LBS   = 'HS_LBS\t%7E\t%7E\t%7E\r\n';
			String.RB    = 'HS_RB\t';
			String.RBR   = 'HS_RBR\t%6f\t%s\t%6f\r\n';
			String.RBP   = 'HS_RBP\t%s\t%6f\t%6f\r\n';
			String.RBS   = 'HS_RBS\t%7E\t%7E\t%7E\r\n';
			String.FT    = 'HS_FT\t%s\r\n';
			String.End   = '\r\n';
	end
end