function [] = RadiationEnclosureInputGenerator(VFMatrix,FileName,varargin)
% RadiationEnclosureInputGenerator(VFMatrix,FileName)  will generate a
% single RELAP5 radiation enclosure input for the view factor matrix VFMatrix;
% the matrix must be square.
%
% RadiationEnclosureInputGenerator(VFMatrix,FileName,'Emissivities',EmissVec) will 
% generate a single RELAP5 radiation enclosure input for the view factor matrix 
% VFMatrix and the emissivity vector EmissVec; the matrix must be square, and the 
% vector must be a scalar or have length equal to the number of surfaces in the
% enclosure (Nsurfaces = length(VFMatrix)).
%
% RadiationEnclosureInputGenerator(VFMatrix,FileName,Options)  will generate a 
% single RELAP5 radiation enclosure input for the view factor matrix VFMatrix and
% any options passed in the Options struct; the matrix must be square.  
%
    
    % Input checking and variable assignment
    Enclosure       = ParseInput(VFMatrix,FileName,varargin)    ;
    VFMatrix        = Enclosure.VFMatrix                        ;
    FileName        = Enclosure.FileName                        ;
    SurfaceAreas    = Enclosure.SurfaceAreas                    ;
    Emissivities    = Enclosure.Emissivities                    ;
    CheckSumRecip   = Enclosure.CheckSumRecip                   ;
    EnforceSumRecip = Enclosure.EnforceSumRecip                 ;
    Nsets           = Enclosure.Nsets                           ;
    Append          = Enclosure.Append                          ;
    Buffer          = Enclosure.Buffer                          ;
    NormRecip       = Enclosure.NormRecip                       ;
    NormEnforce     = Enclosure.NormEnforce                     ;
    RelTolSum       = Enclosure.RelTolSum                       ;
    RelTolRecip     = Enclosure.RelTolRecip                     ;
    RelTolEnforce   = Enclosure.RelTolEnforce                   ;
    EnclosureModel  = Enclosure.EnclosureModel                  ;
    
    
    switch(lower(EnclosureModel))
    % -------------------------------------------------------------- %
    %               Radiation Enclosure Checks and Warnings          %
    % -------------------------------------------------------------- %
        case('radiation')
        % ----------------------------------- %
        %           Summation Check           %
        % ----------------------------------- %
            if (CheckSumRecip)
                FailedSum = CheckSummation(VFMatrix,RelTolSum);
                
                if FailedSum
                    ThrowWarning('FailedSummation');
                end
            end
            
            
        % ----------------------------------- %
        %          Reciprocity Check          %
        % ----------------------------------- %
            if (CheckSumRecip && not(isempty(SurfaceAreas)))
                FailedRecip = CheckReciprocity(VFMatrix,SurfaceAreas,NormRecip,RelTolRecip);
                
                if FailedRecip
                    ThrowWarning('FailedReciprocity');
                end
                
            elseif (CheckSumRecip && isempty(SurfaceAreas))
                ThrowWarning('ReciprocityCheckSkipped:EmptySurfaceAreas');
                
            end
            
            
        % ----------------------------------- %
        %  Summation-Reciprocity Enforcement  %
        % ----------------------------------- %
            if     (EnforceSumRecip && (FailedRecip || FailedSum) && not(isempty(SurfaceAreas)))
                VFMatrix = EnforceConsistency(VFMatrix,SurfaceAreas,NormEnforce,RelTolEnforce);
                
            elseif (EnforceSumRecip && (FailedRecip || FailedSum) && isempty(SurfaceAreas))
                ThrowWarning('EnforcementSkipped:EmptySurfaceAreas');
            end
            
            

    % -------------------------------------------------------------- %
    %              Conduction Enclosure Checks and Warnings          %
    % -------------------------------------------------------------- %
        case('conduction')
    
            if CheckSumRecip
                ThrowWarning('ReciprocityCheckSkipped:ConductionEnclosure');
            end
            
            if EnforceSumRecip
                ThrowWarning('EnforcementSkipped:ConductionEnclosure');
            end
            
            
            
    % -------------------------------------------------------------- %
    %                          Default Catch                         %
    % -------------------------------------------------------------- %
        otherwise
            ThrowWarning('UnknownEnclosure');
            
    end
    
    
    % Get file pointer for output
    switch(Append)
        case true
            FileID = fopen(FileName,'a+');
            
        case false
            FileID = fopen(FileName,'w+');

            WriteInputHeader(FileID,Nsets,Buffer);

    end
    
    
    % Write the output
    WriteSetHeader   (FileID , SetID        , ParsedInput);
    WriteEmissivities(FileID , Emissivities , ParsedInput);
    WriteViewFactors (FileID , VFMatrix     , ParsedInput);
    
    % Release the file pointer
    fclose(FileID);
    
end



% ============================================================================ %
%                           Warning Throwing Function                          %
% ============================================================================ %
function [] = ThrowWarning(Key)
    switch(lower(Key))
        case('failedsummation')
            ID      = 'RadEncInpGenerator:FailedSummation';
            Message = ['Not all rows of the view factor matrix summed to 1 ',...
                       'within tolerance'];
            
            
        case('failedreciprocity')
            ID      = 'RadEncInpGenerator:FailedReicprocity';
            Message = ['The view factor matrix times the area matrix does not yield',...
                       'a symmetric matrix to within tolerance.'];
            
            
        case('reciprocitycheckskipped:emptysurfaceareas')
            ID      = 'RadEncInpGenerator:ReciprocityCheckSkipped:EmptySurfaceAreas'  ;
            Message = ['A reciprocity check was requested with an '                 ...
                       'empty surface area matrix; therefore, the '                 ...
                       'check will be skipped.']                                    ;
            
            
        case('enforcementskipped:emptysurfaceareas')
            ID      = 'RadEncInpGenerator:EnforcementSkipped:EmptySurfaceAreas'	;
            Message = ['An enforcement of summation and reciprocity was '       ...
                       'requested with an empty surface area matrix; '          ...
                       'therefore, the enforcement will be skipped.']           ;
            
            
        case('reciprocitycheckskipped:conductionenclosure')
            ID      = 'RadEncInpGenerator:ReciprocityCheckSkipped:ConductionEnclosure'  ;
            Message = ['A reciprocity check was requested for a conduction '            ...
                       'enclosure.  There is no such requirement for conduction '       ...
                       'enclosures and was, therefore, skipped.']                        ;
            
            
        case('enforcementskipped:conductionenclosure')
            ID      = 'RadEncInpGenerator:Enforcement:ConductionEnclosure'              ;
            Message = ['An enforcement of summation and reciprocity was requested '     ...
                       'for a conduction enclosure.  There is no such requirement '     ...
                       'for conduction enclosures and was, therefore, skipped.']        ;
            
            
        case('unknownenclosure')
            ID      = 'RadEncInpGenerator:UnknownEnclosure'                     ;
            Message = ['An unknown enclosure has been indicated.  The only '    ...
                       'options available are ''radiation'' and '               ...
                       '''conduction''.']                                       ;
            
        otherwise
            ID      = 'RadEncInpGenerator:UnknownWarning';
            Message = 'ThrowWarning received an unknown warning key.';
    end
    
    warning(ID,Message);
end



% ============================================================================ %
%                  Summation-Reciprocity Enforcement Function                  %
% ============================================================================ %
function VFcorrected = EnforceConsistency(VF,SA,Norm,RelTol)
    
    NotDone = true          ;
    Nvf     = length(VF)    ;
    Iter    = 0             ;
    
    while NotDone
        
        % Generate Symmetrix Matrix from upper-triangular portion
        RecipMatrix     = VF .* SA                  ;
        U               = triu(RecipMatrix,1)      	;
        L               = U'                       	;
        D               = diag(diag(RecipMatrix))   ;
        RecipMatrix     = U + L + D                 ;
        VF_U            = RecipMatrix ./ SA         ;

        
        for k = 1:Nvf
            VF_U(k,:) = VF_U(k,:) ./ sum(VF_U(k,:));
        end
        
        % Generate Symmetrix Matrix from lower-triangular portion of corrected matrix
        RecipMatrix     = VF .* SA                  ;
        L               = tril(RecipMatrix,-1)  	;
        U               = L'                       	;
        D               = diag(diag(RecipMatrix))	;
        RecipMatrix     = U + L + D                 ;
        VF_L            = RecipMatrix ./ SA         ;

        for k = 1:Nvf
            VF_L(k,:) = VF_L(k,:) ./ sum(VF_L(k,:));
        end
        
        % Average the lower and upper view factor matrices together
        VF = (VF_L + VF_U)/2;
        
        % Perform iteration tests
        FailSum     = CheckSummation(VF,RelTol)             ;
        FailRecip   = CheckReciprocity(VF,SA,Norm,RelTol)   ;
        NotDone   	= FailRecip | FailSum                   ;
        
        Iter        = Iter + 1                              ;
    end
    
    VFcorrected = VF;
end



% ============================================================================ %
%                               Input Parse                                    %
% ============================================================================ %
function ParsedInput = ParseInput(VFMatrix,FileName,OptAndParamValInputs)
%
%   Input parser for the main call.  All required and key-value
%   inputs are defined here and extracted from the parsed struct in the
%   main call.
%
    
    Input = inputParser;
    
    Input.addRequired  ('VFMatrix'                    ,@(x) isnumeric(x) && IsSquare(x)         );
    Input.addRequired  ('FileName'                    ,@(x) ischar(x)                           );
    Input.addOptional  ('Options'        ,[]          ,@(x) isstruct(x)                         );
    Input.addParamValue('SurfaceAreas'   ,[]          ,@(x) isnumeric(x) && IsSquare(x)         );
    Input.addParamValue('Emissivities'   ,[]          ,@(x) isvector(x)  && IsBounded(x,0,1)    );
    Input.addParamValue('CheckSumRecip'  ,false       ,@(x) islogical(x)                        );
    Input.addParamValue('EnforceSumRecip',false       ,@(x) islogical(x)                        );
    Input.addParamValue('SurfaceIDs'     ,0           ,@(x) isscalar(x)  && IsBoundedInt(x,0,99));
    Input.addParamValue('SetID'          ,0           ,@(x) isscalar(x)  && IsBoundedInt(x,0,99));
    Input.addParamValue('Nsets'          ,1           ,@(x) isscalar(x)  && IsBoundedInt(x,0,99));
    Input.addParamValue('Append'         ,false       ,@(x) islogical(x)                        );
    Input.addParamValue('Buffer'         ,72          ,@(x) isnumeric(x) && isscalar(x)         );
    Input.addParamValue('Format'         ,'%10.3E'    ,@(x) ischar(x)                           );
    Input.addParamValue('NormRecip'      ,'inf'       ,@(x) ischar(x)    || isscalar(x)         );
    Input.addParamValue('NormEnforce'    ,'inf'       ,@(x) ischar(x)    || isscalar(x)         );
    Input.addParamValue('RelTolSum'      ,1.0E-3      ,@(x) isnumeric(x) && isscalar(x)         );
    Input.addParamValue('RelTolRecip'    ,1.0E-3      ,@(x) isnumeric(x) && isscalar(x)         );
    Input.addParamValue('RelTolEnforce'  ,1.0E-5      ,@(x) isnumeric(x) && isscalar(x)         );
    Input.addParamValue('EnclosureModel' ,'Radiation' ,@(x) ischar(x)                           );
    Input.addParamValue('LeftRight'      ,'Right'     ,@(x) ischar(x)    || iscellstr(x)        );
    Input.addParamValue('StructureName'  ,'Surface'   ,@(x) ischar(x)    || iscellstr(x)        );
    Input.addParamValue('MinTemperature' , 900        ,@(x) isscalar(x)  || IsBounded(x,0,Inf)	);
    Input.addParamValue('MinVoid'        , 0.75       ,@(x) isscalar(x)  || IsBounded(x,0,1)	);
    
    
    Input.parse(VFMatrix,FileName,OptAndParamValInputs{:})  ;
    ParsedInput = Input.Results                             ;
    Options     = Input.Results.Options                     ;
    ParsedInput = rmfield(ParsedInput,'Options')            ;

    
    if (isstruct(Options))
        
	% This block makes an OptionsParse cell array from the Options struct that 
    % can be validated with the existing parser instance.
    %
    % Any options put into the Options struct *override* parameter-value pairs.
    %
    
        FieldNames              = cellstr(fieldnames(Options))  ;
        Values                  = struct2cell(Options)          ;
        OptionsParse            = cell(1,2*length(Values))      ;
        OptionsParse(1:2:end-1) = FieldNames                    ;
        OptionsParse(2:2:end)   = Values                        ;
        Input.parse(VFMatrix,FileName,OptionsParse{:})          ;
        
        for k = 1:length(FieldNames)
            FieldName = FieldNames{k};
            ParsedInput.(FieldName) = Options.(FieldName);
        end
    end

    
end








% ============================================================================ %
%                             Utility Programs                                 %
% ============================================================================ %

function TrueFalse = IsSquare(Matrix)
%
%   Simple logical function that checks if a matrix is square.
%
    Dimension = size(Matrix);
    TrueFalse = (Dimension(1) == Dimension(2));
end


function FailSum = CheckSummation(VF,RelTolSum)
%
%   Checks to see is the VF matrix sums to 1 within the passed, relative tolerance.
%
    FailSum = any(abs(1 - sum(VF,2))./sum(VF,2) > RelTolSum);
end


function FailRecip = CheckReciprocity(VF,SA,NormRecip,RelTolSum)
%
%   Checks to see is the VF matrix times is associated surface area matrix 
%   is symmetric in the passed norm within the passed, relative tolerance.
%
    SymmMat     = VF .* SA                          ;
    NormRez     = norm(SymmMat - SymmMat',NormRecip);
    NormSymm    = norm(SymmMat           ,NormRecip);
    FailRecip   = NormRez/NormSymm  > RelTolSum     ;
end

function TrueFalse = IsBounded(Number,LoBound,HiBound)
%
%   Checks if Number is between LoBound and HiBound (inclusive), returning
%   TRUE if it is in the range.
%   
%   If Number is an array, all entries are checked and returns TRUE 
%   is ALL are (inclusively) within the bounds.
%
    
    TrueFalse = all(Number >= LoBound & Number <= HiBound);
end

function TrueFalse = IsBoundedInt(Number,LoBound,HiBound)
%
%   Checks if Number is an integer between LoBound and HiBound (inclusive), returning
%   TRUE if it is in the range.
%   
%   If Number is an array, all entries are checked and returns TRUE 
%   is ALL are (inclusively) within the bounds and integers.
%
    AreIntegers = floor(Number) == Number               ;
    AreBounded  = Number >= LoBound & Number <= HiBound ;
    TrueFalse   = all(AreIntegers & AreBounded)         ;
end


function ZeroedString = Spaces2Zeros(String)
%
%   Replaces all whitespace in String with 0s.
%
    
    if not(ischar(String) || iscellstr(String))
        error('Non-string passed to Spaces2Zeros');
    end
    
    switch(ischar(String))
        case true
            ZeroedString = char(regexprep(cellstr(String),'\s*','0'));
            
        case false
            ZeroedString = regexprep(cellstr(String),'\s*','0');
    end
end
