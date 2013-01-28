function Phi = ImplicitEuler(Xval,dx,Dcoef,Tmax,Phi0,BC,dt)
	
% Setup ---------------------------------------------------
	Dbar      = Dcoef*dt/dx.^2;
	Time      = 0:dt:Tmax     ;
	TimeSteps = length(Time)  ;
	Nx        = length(Xval)  ;
	
% Boundary Condition Tests --------------------------------
	DircDirc = isnumeric(BC.xlow) && isnumeric(BC.xhi);
	DircNeum = isnumeric(BC.xlow) &&    iscell(BC.xhi);
	NeumDirc =    iscell(BC.xlow) && isnumeric(BC.xhi);
	NeumNeum =    iscell(BC.xlow) &&    iscell(BC.xhi);
	
% Get Solution --------------------------------------------
	if     (DircDirc)
		Phi = WithDD(Phi0,TimeSteps,Nx,BC.xlow(1),BC.xhi(1),   Dbar);
		
	elseif (DircNeum)
		Phi = WithDN(Phi0,TimeSteps,Nx,BC.xlow(1),BC.xhi{1},dx,Dbar);
		
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
	function Phi = WithDD(Phi0,TimeSteps,Nx,Blo,Bhi,Dbar)
		
		Sizer   = ones(Nx,1)         ; % allocates memory
		Lower   =   -Dbar    * Sizer ; % lower diagonal
		Upper   =   -Dbar    * Sizer ; % upper diagonal
		Diag    = (1+2*Dbar) * Sizer ; % diagonal
		
		% BC considerations --------------------------
		Soln      = Phi0 ;
		Upper(1)  = 0    ; Diag(1)  = 1; Soln(1)  = Blo;
		Lower(Nx) = 0    ; Diag(Nx) = 1; Soln(Nx) = Bhi;
		
		% Solve --------------------------------------
		for k = 1:TimeSteps
			R    = Soln;
			Soln = ThomasSolve(Lower,Diag,Upper,R);
		end
		Phi = Soln;
	end
	
% Dirchlet-Neumann	---------------------------------------
	function Phi = WithDN(Phi0,TimeSteps,Nx,Blo,Bhi,dx,Dbar)
		
		Sizer   = ones(Nx,1)         ;
		Lower   =   -Dbar    * Sizer ;
		Upper   =   -Dbar    * Sizer ;
		Diag    = (1+2*Dbar) * Sizer ;
		
		% BC considerations --------------------------
		Soln      = Phi0    ;
		Upper(1)  =    0    ; Diag(1) = 1; Soln(1)  = Blo;
		Lower(Nx) = -2*Dbar ;
		
		for k = 1:TimeSteps
			R     = Soln;
			R(Nx) = Soln(Nx) - 2*dx*Dbar*Bhi;
			Soln  = ThomasSolve(Lower,Diag,Upper,R);
		end
		Phi = Soln;
	end
	
% Neumann-Dirchlet	---------------------------------------
	function Phi = WithND(Phi0,TimeSteps,Nx,Blo,Bhi,dx,Dbar)
		
		Sizer   = ones(Nx,1)         ;
		Lower   =   -Dbar    * Sizer ;
		Upper   =   -Dbar    * Sizer ;
		Diag    = (1+2*Dbar) * Sizer ;
		
		% BC considerations --------------------------
		Soln      =    Phi0  ;
		Upper(1)  =  -2*Dbar ;
		Lower(Nx) =    0     ; Diag(Nx) = 1; Soln(Nx) = Bhi;
		
		for k = 1:TimeSteps
			R    = Soln;
			R(1) = Soln(1) + 2*dx*Dbar*Blo;
			Soln = ThomasSolve(Lower,Diag,Upper,R);
		end
		Phi = Soln;
	end
	
% Neumann-Neumann	---------------------------------------
	function Phi = WithNN(Phi0,TimeSteps,Nx,Blo,Bhi,dx,Dbar)
		
		Sizer   = ones(Nx,1)         ;
		Lower   =   -Dbar    * Sizer ;
		Upper   =   -Dbar    * Sizer ;
		Diag    = (1+2*Dbar) * Sizer ;
		
		% BC considerations --------------------------
		Soln      =   Phi0  ;
		Upper(1)  = -2*Dbar ;
		Lower(Nx) = -2*Dbar ;
		
		for k = 1:TimeSteps
			R     = Soln;
			R(1)  = Soln(1)  + 2 * dx * Dbar * Blo ;
			R(Nx) = Soln(Nx) - 2 * dx * Dbar * Bhi ;
			Soln  = ThomasSolve(Lower,Diag,Upper,R);
		end
		Phi = Soln;
	end
	
end