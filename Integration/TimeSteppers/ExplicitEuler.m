function [Tend,Phi] = ExplicitEuler(Xval,dx,Dcoef,Tmax,Phi0,BC,dt)
	
% Setup -----------------------------------------------
	Dbar      = Dcoef*dt/dx.^2 ; % constant 
	Time      = 0:dt:Tmax      ; 
	TimeSteps = length(Time)   ;
	Nx        = length(Xval)   ;
	I         = 2:Nx-1         ; % work indices
	B(1)   = Dbar              ; % multiplicity constant
	B(2)   = (1-2*Dbar)        ; % multiplicity constant
	B(3)   = Dbar              ; % multiplicity constant
	
	
% Boundary Condition Tests ----------------------------
	DircDirc = isnumeric(BC.xlow) && isnumeric(BC.xhi);
	DircNeum = isnumeric(BC.xlow) &&    iscell(BC.xhi);
	NeumDirc =    iscell(BC.xlow) && isnumeric(BC.xhi);
	NeumNeum =    iscell(BC.xlow) &&    iscell(BC.xhi);
	
	
% Get Solution ----------------------------------------
	if     (DircDirc)
		Phi = WithDD(Phi0,TimeSteps,B,I,Nx,BC.xlow(1),BC.xhi(1));
		
	elseif (DircNeum)
		Phi = WithDN(Phi0,TimeSteps,B,I,Nx,BC.xlow(1),BC.xhi{1},dx,Dbar);
		
	elseif (NeumDirc)
		Phi = WithND(Phi0,TimeSteps,B,I,Nx,BC.xlow{1},BC.xhi(1),dx,Dbar);
		
	elseif (NeumNeum)
		Phi = WithNN(Phi0,TimeSteps,B,I,Nx,BC.xlow{1},BC.xhi{1},dx,Dbar);
		
	else
		error('Unsupported set of boundary conditions passed.')
	end
	
% Return Tend -----------------------------------------
	Tend = Time(end);
	
	
	
%{
 ==============================================================================
                                 Sub Functions
 ==============================================================================
%}
	
	
% Dirchlet-Dirchlet	---------------------------------------
	function Phi = WithDD(Phi0,TimeSteps,B,I,Nx,Blo,Bhi)
		Phi     = Phi0;
		Phi(1)  = Blo;
		for k = 1:TimeSteps
			Phi(I)  = B(1)*Phi(I-1) + B(2)*Phi(I) + B(3)*Phi(I+1)     ;
		end
		Phi(Nx) = Bhi;
	end
	
% Dirchlet-Neumann	---------------------------------------	
	function Phi = WithDN(Phi0,TimeSteps,B,I,Nx,Blo,Bhi,dx,Dbar)
		Phi     = Phi0;
		Phi(1)  = Blo;
		for k = 1:TimeSteps
			Phi(I)  =   B(1)*Phi(I-1)  + B(2)*Phi(I)  + B(3)*Phi(I+1)  ;
			Phi(Nx) = 2*B(1)*Phi(Nx-1) + B(2)*Phi(Nx) +  2*Dbar*dx*Bhi ;
		end
	end
	
% Neumann-Dirchlet	---------------------------------------
	function Phi = WithND(Phi0,TimeSteps,B,I,Nx,Blo,Bhi,dx,Dbar)
		Phi     = Phi0;
		for k = 1:TimeSteps
			Phi(1) =  B(1)*Phi(1)  + 2*B(3)*Phi(3) - 2*Dbar*dx*Blo    ;
			Phi(I) = B(1)*Phi(I-1) +  B(2)*Phi(I)  + B(3)*Phi(I+1)    ;
		end
		Phi(Nx) = Bhi;
	end
	
% Neumann-Neumann	---------------------------------------
	function Phi = WithNN(Phi0,TimeSteps,B,I,Nx,Blo,Bhi,dx,Dbar)
		Phi     = Phi0;
		for k = 1:TimeSteps
			Phi(1)  =   B(1)*Phi(1)    + 2*B(3)*Phi(3)  - 2*Dbar*dx*Blo ;
			Phi(I)  =   B(1)*Phi(I-1)  +   B(2)*Phi(I)  + B(3)*Phi(I+1) ;
			Phi(Nx) = 2*B(1)*Phi(Nx-1) +   B(2)*Phi(Nx) + 2*Dbar*dx*Bhi ;
		end
	end
	
end