function [Riser,Node,State] = GetRiser(Component)
	%{
	%}
	
	
	% -----------------------------------------------------------
	% Duct Information
	%
	Riser.Type    = 'RCCS'		;
	
	switch(lower(Component))
		case('riser')
			Riser.Name				= 'Riser'           ;
			Riser.Hnaught			= -4.803081                   ;
			Riser.deltaH			=  1.8288           ;
			State.Pool.Pressure		= [450000 , 300000.0]	;
			State.Pool.Temperature	= [300.0  , 310     ]   ;
			
			R						= 5.11175E-2            ;
			Ntubes					= 1						;
			Node.deltaH				= 0.5					;
			Node.FlowArea			= Ntubes * pi * R^2		;
			Node.HydroDiam			= 2 * R					;
			Node.FracOpen			= 1.0					;
		case('header')
			Riser.Name				= 'LoBrdg1'				;
			Riser.Hnaught			= -37.7952				;
			Riser.deltaH			=  0.3556				;
			State.Pool.Pressure		= [322134.6 , 320914.5 , 319695.3 , 318476.9 , 317258.9 , 316038.5 , 314820.6 , 313601.3 , 312381.8 , 311162.7 , 309943.3 , 308724 , 307504.3 , 306286.5 , 305065.9 , 303847.6 , 302629.6 , 301411.1 , 300192.6 , 298972.7 , 297754.4 , 296535.5];
			State.Pool.Temperature	= 307.603155			;
		case('chimney')
			Riser.Name				= 'HotChim'				;
			Riser.Hnaught			=  -12.8016				;
			Riser.deltaH			=   15.3924				;
			State.Pool.Pressure		= [226.0E3 , 101.325E3]	;
			State.Pool.Temperature	= 310.00				;
			
			R						= 0.0254 * 2			;
			Ntubes					= 1						;
			Node.deltaH				= 0.25					;
			Node.FlowArea			= Ntubes * pi * R^2		;
			Node.HydroDiam			= 2 * R					;
			Node.FracOpen			= 1.0					;
	end
	
	
	% -----------------------------------------------------------
	% Nodal Information
	%
	
	% -----------------------------------------------------------
	% State Information
	%
	State.Equilibrium      = 'No'					;
	State.Fog              = 'No'					;
	State.Activity         = 'Active'				;
	State.PoolAtmo         = 'Pool'				    ;
	State.Pool.State       = 'Subcooled'			;
	% 	State.Pool.Pressure    = [532077.9 , 530854.4 , 529633.9 , 528410.8 , 527190.3 , 525966.8 , 524745.7 , 523523.3 , 522301.5 , 521079.2 , 519857.6 , 518636 , 517414.5 , 516192 , 514968.8 , 513748.4 , 512526.2 , 511304.5 , 510083.3 , 508861.5 , 507639.2 , 506416.8 , 505195.8 , 503975.8 , 502752.4 , 501530.9 , 500309.3 , 499087.3 , 497866.6 , 496645.2 , 495424 , 494201.1 , 492978.3 , 491758 , 490536.2 , 489315.6 , 488094.8 , 486872.8 , 485650.3 , 484428.9 , 483206.8 , 481986.2 , 480765.6 , 479544.8 , 478323 , 477100.6 , 475879.6 , 474657.2 , 473437.8 , 472216.2 , 470995 , 469774.8 , 468551.8 , 467331.1 , 466109.8 , 464887.3 , 463666.8 , 462446.9 , 461226.2 , 460003.6 , 458783.3 , 457563.4 , 456340.7 , 455119.3 , 453898.3 , 452677.3 , 451457.3 , 450236.4 , 449016.1 , 447793.4 , 446573.5 , 445352.1 , 444130.9 , 442909.7 , 441688.5 , 440468.8 , 439248.4 , 438028.2 , 436807 , 435585.6 , 434364.2 , 433143.6 , 431923.5 , 430702.6 , 429482.8 , 428262.4 , 427041.2 , 425820.9 , 424600 , 423378.2 , 422157.7 , 420938 , 419717.8 , 418497.5 , 417276.6 , 416056.6 , 414836 , 413613.7 , 412393.8 , 411174.4 , 409954 , 408734 , 407512.8 , 406293.3 , 405071.8 , 403851 , 402631.9 , 401412 , 400191.2 , 398972.7 , 397751.9 , 396530.8 , 395309.3 , 394090.1 , 392869.7 , 391650.6 , 390430.2 , 389210.7 , 387990.1 , 386769.8 , 385550 , 384330.4 , 383109 , 381890.1 , 380670.3 , 379451.3 , 378230.3 , 377010.8 , 375788.6 , 374569.5 , 373350 , 372131.8 , 370911.2 , 369692.6 , 368471.7 , 367252 , 366033.2 , 364811 , 363592.3 , 362372.9 , 361152.5 , 359932 , 358712.9 , 357494.3 , 356276.3 , 355054.9 , 353837.6 , 352616.2 , 351397.8 , 350178.1 , 348958 , 347736.9 , 346518 , 345298.6 , 344079.6 , 342860.7 , 341642.6 , 340422.1 , 339204.7 , 337983.4 , 336764.4 , 335544.6 , 334324.9 , 333106.3 , 331887.3 , 330666.9 , 329448.9 , 328230.3 , 327010.1 , 325791.6 , 324572.3 , 323354.4];
	% 	State.Pool.Pressure    = [322134.6 , 320914.5 , 319695.3 , 318476.9 , 317258.9 , 316038.5 , 314820.6 , 313601.3 , 312381.8 , 311162.7 , 309943.3 , 308724 , 307504.3 , 306286.5 , 305065.9 , 303847.6 , 302629.6 , 301411.1 , 300192.6 , 298972.7 , 297754.4 , 296535.5];
	% 	State.Pool.Pressure    = [295314.1 , 294094 , 292874.3 , 291656.2 , 290436.9 , 289218.5 , 288000.2 , 286781.2 , 285563.8 , 284342.4 , 283123.5 , 281904.3 , 280684.6 , 279466.2 , 278246.3 , 277027.7 , 275808.8 , 274591.2 , 273371.5 , 272153.9 , 270933.3 , 269714.4 , 268494.8 , 267274.6 , 266056.6 , 264836.8 , 263619.4 , 262400.4 , 261182.5 , 259962.3 , 258744.1 , 257525.5 , 256305.3 , 255085.8 , 253866.2 , 252647.6 , 251426.8 , 250210.7 , 248990.3 , 247771.6 , 246552.6 , 245335.6 , 244115.1 , 242897.6 , 241678.1 , 240457.6 , 239238.6 , 238018.8 , 236800.3 , 235580.8 , 234363.1 , 233141.9 , 231924.5 , 230706.3 , 229487.6 , 228268.7 , 227050.3 , 225831.1 , 224611.7 , 223390.3 , 222172.9 , 220953.3 , 219733.8 , 218514.7 , 217297 , 216078.3 , 214860.8 , 213640.9 , 212420.4 , 211201.5 , 209983.5 , 208763.9 , 207544.2 , 206326.8 , 205105.8 , 203888.7 , 202669.2 , 201450.3 , 200232.3 , 199013.1 , 197793.5 , 196574.3 , 195353.4 , 194137.2 , 192918.1 , 191698.8 , 190478.8 , 189259 , 188041.5 , 186821.5 , 185601.5 , 184384.1 , 183165.5 , 181947.6 , 180729.1 , 179505.3 , 178290 , 177072.5 , 175852.3 , 174632.2 , 173413 , 172194.8 , 170974.8 , 169755 , 168538.2 , 167320.3 , 166100 , 164882.8 , 163663 , 162445 , 161224.9 , 160006.4 , 158786.6 , 157566.6 , 156348.1 , 155128.5 , 153910 , 152692.3 , 151473.6 , 150254 , 149036 , 147817.3 , 146598.7 , 145378.8 , 144159.8 , 142940.3 , 141719.9 , 140501.6 , 139283 , 138062.8 , 136846.8 , 135627.6 , 134407.9 , 133190.6 , 131971 , 130753.6 , 129531.7 , 128313];
	% 	State.Pool.Temperature = [299.9499 , 299.9942 , 300.0391 , 300.0836 , 300.1287 , 300.1732 , 300.218 , 300.2627 , 300.3075 , 300.3524 , 300.3968 , 300.4416 , 300.4865 , 300.5312 , 300.5755 , 300.6202 , 300.6648 , 300.7095 , 300.7543 , 300.7991 , 300.8438 , 300.8882 , 300.9329 , 300.9778 , 301.0227 , 301.0674 , 301.1121 , 301.1567 , 301.2016 , 301.2466 , 301.2917 , 301.3363 , 301.3809 , 301.4252 , 301.4698 , 301.5146 , 301.5597 , 301.6046 , 301.6491 , 301.6937 , 301.7381 , 301.7827 , 301.8276 , 301.8726 , 301.9175 , 301.9621 , 302.0067 , 302.0514 , 302.096 , 302.1408 , 302.1856 , 302.2308 , 302.2754 , 302.3202 , 302.3649 , 302.4092 , 302.4537 , 302.4986 , 302.5436 , 302.5882 , 302.633 , 302.6781 , 302.7228 , 302.7673 , 302.8119 , 302.8564 , 302.9013 , 302.9462 , 302.9912 , 303.0358 , 303.0806 , 303.1253 , 303.1699 , 303.2144 , 303.2591 , 303.3035 , 303.3483 , 303.3933 , 303.4383 , 303.483 , 303.5275 , 303.5721 , 303.6168 , 303.6614 , 303.7064 , 303.7513 , 303.7962 , 303.8411 , 303.8859 , 303.9304 , 303.9749 , 304.0197 , 304.0645 , 304.1094 , 304.1541 , 304.1991 , 304.2439 , 304.2886 , 304.3331 , 304.3776 , 304.4223 , 304.4672 , 304.5119 , 304.5568 , 304.6013 , 304.6457 , 304.6904 , 304.7353 , 304.7799 , 304.8251 , 304.8701 , 304.9148 , 304.9592 , 305.0038 , 305.0484 , 305.0929 , 305.138 , 305.1829 , 305.2277 , 305.2724 , 305.3172 , 305.362 , 305.4065 , 305.4513 , 305.4961 , 305.5412 , 305.586 , 305.6309 , 305.6751 , 305.7199 , 305.7642 , 305.8091 , 305.8539 , 305.899 , 305.9438 , 305.9886 , 306.0337 , 306.0784 , 306.1227 , 306.1674 , 306.212 , 306.2563 , 306.3007 , 306.3454 , 306.3903 , 306.4352 , 306.4801 , 306.5251 , 306.5702 , 306.6151 , 306.6599 , 306.7043 , 306.7488 , 306.7933 , 306.838 , 306.8827 , 306.9277 , 306.9725 , 307.0177 , 307.0625 , 307.1073 , 307.152 , 307.1965 , 307.2412 , 307.286 , 307.3304 , 307.3752 , 307.4201 , 307.4647 , 307.5095 , 307.5542 , 307.5992];
	% 	State.Pool.Temperature = 307.5996				;
	State.NCG.State        = {'H2O';0.0}			;
	State.NCG.Gases        = {'N2',0.8;'O2',0.2}	;
	
end