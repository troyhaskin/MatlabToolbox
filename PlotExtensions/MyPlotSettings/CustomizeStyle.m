function Style = CustomizeStyle(UserOptions)
	
	Style      = GetDefaultStyle();
	Attributes = fieldnames(UserOptions);
	Style      = OverwriteDefault(Attributes,UserOptions,Style);
	
	
	% =================================================================== %
	%                Font/Size/Color/Weight/Paper/Grid                    %
	% =================================================================== %
	function Style = OverwriteDefault(Attributes,UserOptions,Style)
		for k = 1:length(Attributes)
			AttriField = char(Attributes(k));
			Objects    = fieldnames(UserOptions.(AttriField));
			Style      = OverwriteObjects(AttriField,Objects,UserOptions,Style);
		end
	end
	
	% =================================================================== %
	%              Label/Axis/Title/ColBar/Units/Span/Mode                %
	% =================================================================== %
	function Style = OverwriteObjects(AttriField,Objects,UserOptions,Style)
		for m = 1:length(Objects)
			ObjField = char(Objects(m));
			if (~isstruct(UserOptions.(AttriField).(ObjField)))
				Style.(AttriField).(ObjField) = UserOptions.(AttriField).(ObjField);
			else
				Style = OverwriteSubObjects(AttriField,ObjField,UserOptions,Style);
			end
		end
	end

	% =================================================================== %
	%                                  x/y/z                              %
	% =================================================================== %
	function Style = OverwriteSubObjects(AttriField,ObjField,UserOptions,Style)
		SubObjects    = fieldnames(UserOptions.(AttriField).(ObjField));
		for n = 1:length(SubObjects)
			SubObjField = char(SubObjects(n));
			Value       = UserOptions.(AttriField).(ObjField).(SubObjField);
			Style.(AttriField).(ObjField).(SubObjField) = Value;
		end
	end
end