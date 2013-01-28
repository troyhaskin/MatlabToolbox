%function Front = GetFront()
	
	
%{
     Heat Structure Surface Area Calculation
	=============================================
	
	Givens:
		WidthFacing Core     = 2  in/channel               ! by design
		LengthFacing Core    = 10 in/channel               ! by design
		NumberOfChannels     = 292 channels                ! by design
		NumberofChannelsHere = 0.5 * NumberOfChannels      ! chosen
		ActiveHeight         = 8.5 m                       ! Kind of chosen
		StructureHeight      = 0.25 m                      ! chosen
	 

	Widthc		= (2 in/channel - 2*0.1875 in/channel) * (1 m /39.3700787 in)
				=  0.041275 m/channel
	
	Lengthc		= (10 in/channel - 2*0.1875 in/channel) * (1 m /39.3700787 in)
				=  0.244475 m/channel
	
	RiserSAtot	=      Widthc        * ActiveHeight * NumberOfChannelsHere
				= 0.041275 m/channel *    8.5 m     *   292/2 channels
				= 51.222275 m^2
	
	SidesSAtot	= 2   *   Lengthc    * ActiveHeight * NumberOfChannelsHere
				= 0.244475 m/channel *    8.5 m     *   292 channels
				= 606.78695 m^2
	
	RiserSAhs	=  RiserSAtot   * (StructureHeight / ActiveHeight)
				= 51.222275 m^2 * (     0.25 m     /     8.5 m   )  
				= 1.5065375 m^2
	
	SidesSAhs	=  SidesSAtot   * (StructureHeight / ActiveHeight)
				= 606.78695 m^2 * (     0.25 m     /     8.5 m   )  
				= 17.846675 m^2
	
	SAhsTot     = RiserSAhs + SidesSAhs
				= 19.3532125
%}
	
	
% -----------------------------------------------------------
%  Heat structure information
%
	Front.Name            = 'Front'                              ;
	Front.Type            = 'Riser'                              ;
	Front.Geom            = 'Rectangular'                        ;
	Front.SSI             = 'No'                                 ;
	Front.Orientation     = 'Vertical'                           ;
	Front.HeatSource      = 'No'                                 ;
	
% -----------------------------------------------------------
%  Temperature nodalization
%
	Front.Nodes           = {0.0000, 350.00, 'Stainless-Steel'   ;...
							 4.7E-3, 350.00,        ''         } ;
						 
% -----------------------------------------------------------
%  Boundary Conditions
%						
	Front.Left.BC         = 'Symmetry'                           ;
	Front.Right.BC        = 'Convective'                         ;
	
% -----------------------------------------------------------
%  Radiation to control volume
%	
%       {Emissivity to volume, Model, Characteristic Length }
%
	Front.Left.Radiation  = {0.9,'Equiv-Band',0.18}              ;
	Front.Right.Radiation = {0.9,'Equiv-Band',0.18}              ;
	
% -----------------------------------------------------------
%  Flow conditions in control volume
%	
	Front.Left.Flow       = {'External',0.9,0.9}                 ;
	Front.Right.Flow      = {'Internal',0.9,0.9}                 ;
	
% -----------------------------------------------------------
%  Heat structure surface information
%	
	Front.Left.SurfaceArea     = 1.5065375                       ;
	Front.Left.SurfaceHeight   = 0.25                            ;
	Front.Right.SurfaceArea    = 1.5065375                       ;
	Front.Right.SurfaceHeight  = 0.25                            ;
	
	
% -----------------------------------------------------------
%  Heat structure film tracking
%	
	Front.FilmTrack       = 'Off'                                ;
	
	
%end