% ---------------------------------------------------------------------- %
%                    Get Control Volume Geometry                         %
% ---------------------------------------------------------------------- %
function Duct = GetThermoDynamState(Duct,StateInfo)
	
	% ---------------------------------------------------------------
	%  Equilibrium assignment
	%
	switch(lower(StateInfo.Equilibrium))
		case('no')
			Duct.CV.State.Equilibrium = 'NonEquil';
		case('yes')
			Duct.CV.State.Equilibrium = 'Equil';
		otherwise
			error('Unrecognized equilibirum state passed to MakeDuct');
	end
	% ---------------------------------------------------------------
	
	
	% ---------------------------------------------------------------
	%  Fog assignment
	%
	switch(lower(StateInfo.Fog))
		case('no')
			Duct.CV.State.Fog = 'NoFog';
		case('yes')
			Duct.CV.State.Fog = 'Fog';
		otherwise
			error('Unrecognized fog state passed to MakeDuct');
	end
	% ---------------------------------------------------------------
	
	% ---------------------------------------------------------------
	%  Activity assignment
	%
	switch(lower(StateInfo.Activity))
		case({'active','a','act'})
			Duct.CV.State.Activity = 'Active';
			
		case({'timeindependent','t','ti','timeindep'})
			Duct.CV.State.Activity = 'Time-Indep';
			
		case({'propertyspecified','propspec','p'})
			Duct.CV.State.Activity = 'Prop-Specified';
			
		case({'delayedactive','d','da','delact'})
			Duct.CV.State.Activity = 'Delayed-Active';
			
			CheckForRequiredField(Duct.CV.State,'PropDelayTime');
			
			Duct.CV.State.PropDelay = Duct.CV.State.PropDelayTime;
			
		otherwise
			error('Unrecognized activity state passed to MakeDuct');
	end
	% ---------------------------------------------------------------
	
	% ---------------------------------------------------------------
	%  PoolAtmo assignment
	%
	Duct.CV.State.PoolAtmoModel = 'Separate';
	switch(lower(StateInfo.PoolAtmo))
		
		case({'pool','onlypool'})
			Duct.CV.State.PoolAtmo = 'OnlyPool';
			
			CheckForRequiredField(StateInfo,'Pool');
			CheckForRequiredField(StateInfo.Pool,'State');
			
			% ---------------------------------------------------------------
			%  WaterState assignment
			%
			switch(lower(StateInfo.Pool.State))
				case({'sat','saturated'})
					Duct.CV.State.Pool.Regime = 'Saturated';
				case({'sub','subcooled'})
					Duct.CV.State.Pool.Regime = 'Subcooled';
				otherwise
					error('Invalid waterstate passed to MakeDuct.')
			end
			% ---------------------------------------------------------------
			
		case({'atmo','atmosphere','onlyatmo','onlyatmosphere'})
			Duct.CV.State.PoolAtmo = 'OnlyAtm';
			
			CheckForRequiredField(StateInfo,'Atmo');
			CheckForRequiredField(StateInfo.Atmo,'State');
			
			% ---------------------------------------------------------------
			%  VaporState assignment
			%
			switch(lower(StateInfo.Atmo.State))
				case({'sat','saturated'})
					Duct.CV.State.Atmo.Regime = 'Saturated';
				case({'sup','superheated'})
					Duct.CV.State.Atmo.Regime = 'Superheated';
				otherwise
					error('Invalid vaporstate passed to MakeDuct.')
			end
			% ---------------------------------------------------------------
			
		case({'poolatmo','poolandatmosphere','poolandatm'})
			Duct.CV.State.PoolAtmo = 'PoolandAtm';
			
			CheckForRequiredField(StateInfo     ,'Pool' );
			CheckForRequiredField(StateInfo.Pool,'State');
			CheckForRequiredField(StateInfo     ,'Atmo' );
			CheckForRequiredField(StateInfo.Atmo,'State');
			
			% ---------------------------------------------------------------
			%  WaterState assignment
			%
			switch(lower(StateInfo.Pool.State))
				case({'sat','saturated'})
					Duct.CV.State.Pool.Regime = 'Saturated';
				case({'sub','subcooled'})
					Duct.CV.State.Pool.Regime = 'Subcooled';
				otherwise
					error('Invalid waterstate passed to MakeDuct.')
			end
			% ---------------------------------------------------------------
			
			% ---------------------------------------------------------------
			%  VaporState assignment
			%
			switch(lower(StateInfo.Atmo.State))
				case({'sat','saturated'})
					Duct.CV.State.Atmo.Regime = 'Saturated';
				case({'sup','superheated'})
					Duct.CV.State.Atmo.Regime = 'Superheated';
				otherwise
					error('Invalid vaporstate passed to MakeDuct.')
			end
			% ---------------------------------------------------------------
			
		otherwise
			error('Unrecognized pool-atmosphere state passed to MakeDuct');
	end
	
	Duct = GetThermoDynamPressAndTemp(Duct,StateInfo);
	% ---------------------------------------------------------------
	
	% ---------------------------------------------------------------
	%  Non-Condensible gas assignment
	%
	Exists = CheckForField(StateInfo,'NCG');
	switch(Exists)
		case('yes')
			Duct.CV.NCG.Num = size(StateInfo.NCG.Gases,1);
			
			switch(lower(StateInfo.NCG.State{1}))
				case('ncg')
					Duct.CV.NCG.State = {'PNCG',StateInfo.NCG.State{2}};
				case({'h2o','h20'})
					Duct.CV.NCG.State = {'PH2O',StateInfo.NCG.State{2}};
				case('dew')
					Duct.CV.NCG.State = {'Tdew',StateInfo.NCG.State{2}};
				otherwise
					error('Invalid non-condensible gas state property passed to MakeDuct.');
			end
			
			MolarFracTotal = sum([StateInfo.NCG.Gases{:,2}]);
			if (MolarFracTotal ~= 1)
				error('NCG molar fractions do not add to 1.0');
			end
			
			Duct.CV.NCG.Gases = StateInfo.NCG.Gases;
		case('no')
			Duct.CV.NCG = 'none';
	end
	% ---------------------------------------------------------------
	
	
	% ---------------------------------------------------------------------- %
	%                    Check for a Requied Field                           %
	% ---------------------------------------------------------------------- %
	function Duct = GetThermoDynamPressAndTemp(Duct,State)
		switch(lower(Duct.CV.State.PoolAtmo))
			
			% ----------------------------------------------------------------
			%  Atmosphere Properties
			%
			case('onlyatm')
				Pressure            = State.Atmo.Pressure               ;
				Temperature         = State.Atmo.Temperature            ;
				Guess.Press         = GetGuess(Pressure,Duct.CV.Num)    ;
				Guess.Temp          = GetGuess(Temperature,Duct.CV.Num) ;
				Duct.CV.State.Pressure    = Guess.Press                 ;
				Duct.CV.State.Temperature = Guess.Temp                  ;
				
				% ----------------------------------------------------------------
				%  Pool Properties
				%
			case('onlypool')
				Pressure            = State.Pool.Pressure               ;
				Temperature         = State.Pool.Temperature            ;
				Guess.Press         = GetGuess(Pressure,Duct.CV.Num)    ;
				Guess.Temp          = GetGuess(Temperature,Duct.CV.Num) ;
				Duct.CV.State.Pressure    = Guess.Press                 ;
				Duct.CV.State.Temperature = Guess.Temp                  ;
				
				
				% ----------------------------------------------------------------
				%  Pool and Atmosphere Properties
				%
			case('poolandatm')
				Pressure                 = State.Pool.Pressure                 ;
				Guess.Press              = GetGuess(Pressure,Duct.CV.Num)      ;
				Temperature.P            = State.Pool.Temperature              ;
				Temperature.A            = State.Atmo.Temperature              ;
				Guess.Temp.P             = GetGuess(Temperature.P,Duct.CV.Num) ;
				Guess.Temp.A             = GetGuess(Temperature.A,Duct.CV.Num) ;
				Duct.CV.State.Pressure         = Guess.Press                   ;
				Duct.CV.State.Temperature.Pool = Guess.Temp.P                  ;
				Duct.CV.State.Temperature.Atmo = Guess.Temp.A                  ;
		end
	end
	% ---------------------------------------------------------------------- %
	
	
	% ---------------------------------------------------------------------- %
	%                 Get the initial/guess state values                     %
	% ---------------------------------------------------------------------- %
	function Guess = GetGuess(Input,Count)
		if (isscalar(Input))
			Guess = linspace(Input,Input,Count);
		elseif(numel(Input) == 2)
			Guess = Input(1):(Input(2) - Input(1))/(Count-1):Input(2);
		elseif(numel(Input) == Count)
			Guess = Input;
		else
			error('Invalid number of guesses passed to MakeDuct');
		end
	end
	% ---------------------------------------------------------------------- %
	
	
	% ---------------------------------------------------------------------- %
	%                    Check for a Requied Field                           %
	% ---------------------------------------------------------------------- %
	function [] = CheckForRequiredField(Struct,DesiredField)
		Check = isfield(Struct,DesiredField);
		if (Check ~= 1)
			error('Required field ''%s'' not present in CV state definition',...
				DesiredField);
		end
	end
	% ---------------------------------------------------------------------- %
	
	% ---------------------------------------------------------------------- %
	%                    Check for a Requied Field                           %
	% ---------------------------------------------------------------------- %
	function Exists = CheckForField(Struct,DesiredField)
		Check = isfield(Struct,DesiredField);
		if (Check ~= 1)
			Exists = 'no';
		else
			Exists = 'yes';
		end
	end
	% ---------------------------------------------------------------------- %
end
% ---------------------------------------------------------------------- %