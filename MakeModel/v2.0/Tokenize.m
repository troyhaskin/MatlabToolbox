% % % % % % % % % % % % % % % % % % % % % % % % % % %
% % %                                           % % %
% % %         Does nothing for now              % % %
% % %                                           % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % %
function Token = Tokenize(Buffer)
	
	GroupSep  = (Buffer == ';');
	Ngroups   =  sum(GroupSep) ;
	
	GroupLocs = find(GroupSep) ;
	Bottom    = 1              ;
	for k = 1:Ngroups
		LocBuff = Buffer(Bottom:GroupsLocs(k));
		
	end
	
	
	Token = cell(Ngroups,Ntokens);
end