function Phi = CrankNicolson(Xval,dx,Dcoef,Tmax,Phi0,BC,dt)
	
% Setup ---------------------------------------------------
	Dbar      = Dcoef*dt/dx.^2;
	Time      = 0:dt:Tmax     ;
	TimeSteps = length(Time)  ;
	Nx        = length(Xval)  ;
	I         = 2:(Nx-1)      ;
	
% Boundary Condition Tests --------------------------------
	DircDirc = isnumeric(BC.xlow) && isnumeric(BC.xhi);
	DircNeum = isnumeric(BC.xlow) &&    iscell(BC.xhi);
	NeumDirc =    iscell(BC.xlow) && isnumeric(BC.xhi);
	NeumNeum =    iscell(BC.xlow) &&    iscell(BC.xhi);
	
% Get Solution --------------------------------------------
	if     (DircDirc)
		Phi = WithDD(Phi0,TimeSteps,Nx,BC.xlow(1),BC.xhi(1),   Dbar,I);
		
	elseif (DircNeum)
		Phi = WithDN(Phi0,TimeSteps,Nx,BC.xlow(1),BC.xhi{1},dx,Dbar,I);
		
	elseif (NeumDirc)
		Phi = WithND(Phi0,TimeSteps,Nx,BC.xlow{1},BC.xhi(1),dx,Dbar);
		
	elseif (NeumNeum)
		Phi = WithNN(Phi0,TimeSteps,Nx,BC.xlow{1},BC.xhi{1},dx,Dbar);
		
	else
		error('Unsupported set of boundary conditions passed.');
	end
	

%{
 ==============================================================================
                                 Sub Functions
 ==============================================================================
%}

% Dirchlet-Dirchlet	---------------------------------------
	function Phi = WithDD(Phi0,TimeSteps,Nx,Blo,Bhi,Dbar,I)
		
		Sizer   = ones(Nx,1)        ;
		Lower   = -0.5*Dbar * Sizer ;
		Upper   = -0.5*Dbar * Sizer ;
		Diag    =  (1+Dbar) * Sizer ;
		
		Soln      = Phi0 ;
		R         = Phi0 ;
		Upper(1)  =   0  ;    Diag(1)  = 1 ;    R(1)  = Blo ;
		Lower(Nx) =   0  ;    Diag(Nx) = 1 ;    R(Nx) = Bhi ;
		
		B(1) = 0.5*Dbar ;    B(2) = (1-Dbar) ;    B(3) = 0.5*Dbar ;
		
		for k = 1:TimeSteps
			R(I) = B(1)*Soln(I-1) + B(2)*Soln(I) + B(3)*Soln(I+1);
			Soln = ThomasSolve(Lower,Diag,Upper,R);
		end
		Phi = Soln;
	end
	
% Dirchlet-Neumann	---------------------------------------
	function Phi = WithDN(Phi0,TimeSteps,Nx,Blo,Bhi,dx,Dbar,I)
		
		Sizer   = ones(Nx,1)        ; % allocates memory
		Lower   = -0.5*Dbar * Sizer ; % lower diagonal
		Upper   = -0.5*Dbar * Sizer ; % upper diagonal
		Diag    =  (1+Dbar) * Sizer ; % diagonal
		
		% BC considerations and allocation ----------------
		Phi       = Phi0 ;
		R         = Phi0 ;
		Upper(1)  =   0  ;    Diag(1)  = 1 ;    R(1)  = Blo ;
		Lower(Nx) = -Dbar;
		
		% Weight for right-hand side upon update ----------
		B(1) = 0.5*Dbar ;    B(2) = (1-Dbar) ;    B(3) = 0.5*Dbar      ;
		C(1) = Dbar     ;    C(2) = (1-Dbar) ;    C(3) = 2*Dbar*Bhi*dx ;

		% Solve -------------------------------------------
		for k = 1:TimeSteps
			R(I)  = B(1)*Phi(I-1)  + B(2)*Phi(I)  + B(3)*Phi(I+1) ;
			R(Nx) = C(1)*Phi(Nx-1) + C(2)*Phi(Nx) + C(3)          ;
			Phi   = ThomasSolve(Lower,Diag,Upper,Temp,R,Nx)            ;
		end
	end
	
% Neumann-Dirchlet	---------------------------------------
	function Phi = WithND(Phi0,TimeSteps,Nx,Blo,Bhi,dx,Dbar)
		
		Sizer   = ones(Nx,1)         ;
		Lower   =   -Dbar    * Sizer ;
		Upper   =   -Dbar    * Sizer ;
		Diag    = (1+2*Dbar) * Sizer ;
		
		Soln      =    Phi0  ;
		Upper(1)  =  -2*Dbar ;
		Lower(Nx) =    0     ; Diag(Nx) = 1; Soln(Nx) = Bhi;
		
		for k = 1:TimeSteps
			Soln(1) = Soln(1) + 2*dx*Dbar*Blo;
			Soln    = ThomasSolve(Lower,Diag,Upper,Temp,Soln,Nx);
		end
		Phi = Soln;
	end
	
% Neumann-Neumann	---------------------------------------
	function Phi = WithNN(Phi0,TimeSteps,Nx,Blo,Bhi,dx,Dbar)
		
		Sizer   = ones(Nx,1)         ;
		Lower   =   -Dbar    * Sizer ;
		Upper   =   -Dbar    * Sizer ;
		Diag    = (1+2*Dbar) * Sizer ;
		
		Soln      =   Phi0  ;
		Upper(1)  = -2*Dbar ;
		Lower(Nx) = -2*Dbar ;
		
		for k = 1:TimeSteps
			Soln(1)  = Soln(1)  + 2 * dx * Dbar * Blo ;
			Soln(Nx) = Soln(Nx) - 2 * dx * Dbar * Bhi ;
			Soln     = ThomasSolve(Lower,Diag,Upper,Soln);
		end
		Phi = Soln;
	end
end