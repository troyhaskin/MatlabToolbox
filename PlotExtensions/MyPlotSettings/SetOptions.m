function [] = SetOptions(Selector,Style)
	if (iscell(Selector))
		LoopMax = size(Selector,2);
		for k = 1:LoopMax
			ASelector = char(Selector(k));
			SetIndividualSelector(ASelector,Style);
		end
	else
		SetIndividualSelector(Selector,Style);
	end
end