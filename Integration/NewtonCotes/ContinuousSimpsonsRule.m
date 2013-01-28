function Integral = ContinuousSimpsonsRule(Function,Start,End,Intervals)

	error(nargchk(3,4,nargin));
	
	if(nargin == 3)
		Intervals = 1;
	end
	
	IntervalSpacing    = (End - Start) / (Intervals)      ;
	SubIntervalSpacing = 0.5 * IntervalSpacing            ;
	Values             = Start : SubIntervalSpacing : End ;
	Phi                = Function(Values)                 ;
	
	Integral = DiscreteSimpsonsRuleQ(Values',Phi');
	
end