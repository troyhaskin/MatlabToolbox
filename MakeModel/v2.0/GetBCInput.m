function BoundaryString = GetBCInput(BCType,TabFunName,BoundVol,MassTransfer)

	switch(lower(BCType(1,:)))
		case('symmetry')
			Name  = [];
			BVol  = 'No';
			MXOpt = 'No';
		case('calccoefhs')
			Name  = [];
			BVol  = BoundVol;
			MXOpt = MassTransfer;
		case({'sourtimetf','fluxtimetf','coeftimetf','coeftemptf',...
				'coefcf','sourcf','fluxcf'})
			Name  = TabFunName;
			BVol  = BoundVol;
			MXOpt = MassTransfer;
		case({'temptimetf','tempcf'})
			switch(nargin)
				case(2)
					Name  = TabFunName;
					BVol  = 'No';
					MXOpt = 'No';
				case(3)
					Name  = TabFunName;
					BVol  = BoundVol;
					MXOpt = 'No';
				case(4)
					Name  = TabFunName;
					BVol  = BoundVol;
					MXOpt = MassTransfer;
			end
	end
	
	BS1 = BCType;
	BS2 = GetQuotes(Name);
	BS3 = GetQuotes(BVol);
	BS4 = MXOpt;
	BoundaryString = strcat(BS1,'\t',BS2,'\t',BS3,'\t',BS4);
	
	function OutString = GetQuotes(InString)
		if (~isempty(InString))
			OutString = strcat('''',InString,'''');
		else
			OutString = [];
		end
	end
end