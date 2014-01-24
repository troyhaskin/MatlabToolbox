function TrueFalse = None(Array,varargin)
    TrueFalse = all(not(Array),varargin{:});
end