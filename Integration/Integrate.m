function Integral = Integrate(Indep,Dep,Method,IC)
	
	error(nargchk(2,4,nargin));
	if (nargin == 2)
		Method = 'cumulative';
	elseif(nargin == 3)
		IC = 0;
	end
	
	End       = size(Indep,1);                          % - Number of values to find
	
	switch(lower(Method))
		case({'cumulative','c'})
			LeftMask  = 1:End-1;                                % - All columns but last
			RightMask = 2:End;                                  % - All columns but first
			dIndep    = Indep(RightMask,:) - Indep(LeftMask,:); % - Independent delta values
			Bases     = Dep(RightMask,:) + Dep(LeftMask,:);     % - Dependent   delta values
			Integral  = 0.5*sum(dIndep.*Bases);               % - Trapezoidal summation
		case({'differential','d'})
			LocIndep   = Indep*ones(1,End);
			LocDep     = Dep*ones(1,End);
			UTriIndep  = triu(LocIndep);
			DiagVec    = diag(UTriIndep);
			DiagIndep  = diag(DiagVec);
			LTriIndep  = tril(ones(End,1)*DiagVec');
			SLTriIndep = LTriIndep-DiagIndep;
			LocIndep   = SLTriIndep + UTriIndep;
			Integral   = Integrate(LocIndep,LocDep,'cumulative')'+IC;
	end