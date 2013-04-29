clc;
clear('all');

% Low N-solution
Nrho = 128;
Nphi = 64;

rho = linspace(1,2 ,Nrho);
phi = linspace(0,pi,Nphi);

[rho,phi] = meshgrid(rho,phi);
B = rho*0 + 0.5;
B = SolveSystem(rho,phi,B,1E-14);


% figure(1);
% ScatterPolar(rho(:),phi(:),10,B(:));


% Projection to finer grid
rhoOld    = rho                 ;
phiOld    = phi                 ;
Nrho      = 64                 ;
Nphi      = 32                 ;
rho       = linspace(1,2 ,Nrho) ;
phi       = linspace(0,pi,Nphi) ;
[rho,phi] = meshgrid(rho,phi)   ;

B = interp2(rhoOld,phiOld,B,rho,phi,'spline');
B = SolveSystem(rho,phi,B,1E-14);

% figure(2);
% ScatterPolar(rho(:),phi(:),10,B(:));


% Projection to coarser grid
rhoOld    = rho                 ;
phiOld    = phi                 ;
Nrho      = 128                 ;
Nphi      = 64                  ;
rho       = linspace(1,2 ,Nrho) ;
phi       = linspace(0,pi,Nphi) ;
[rho,phi] = meshgrid(rho,phi)   ;

B = interp2(rhoOld,phiOld,B,rho,phi,'spline');
B = SolveSystem(rho,phi,B,1E-14);

% figure(3);
% ScatterPolar(rho(:),phi(:),10,B(:));



% Projection to finer grid
rhoOld    = rho                 ;
phiOld    = phi                 ;
Nrho      = 256                 ;
Nphi      = 128                 ;
rho       = linspace(1,2 ,Nrho) ;
phi       = linspace(0,pi,Nphi) ;
[rho,phi] = meshgrid(rho,phi)   ;

B = interp2(rhoOld,phiOld,B,rho,phi,'spline');
B = SolveSystem(rho,phi,B,1E-8);

% figure(4);
% ScatterPolar(rho(:),phi(:),10,B(:));
