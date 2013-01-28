function AlphabetizedList = Alphabetize(WordList)
	Convert = 0;
	
	if    (ischar(WordList))
		WordList = cellstr(WordList);
		Convert = 1;
	elseif(~iscellstr(WordList))
		error('Input must be a character array or a cell string array.')
	end
	
	AlphabetizedList = sort(WordList);
	
	if (Convert == 1)
		AlphabetizedList = char(AlphabetizedList);
	end
end