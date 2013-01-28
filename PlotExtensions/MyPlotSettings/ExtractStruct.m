function OutStruct = ExtractStruct(InCell,Element)
	TempStruct = cell2struct(InCell(Element),'Bridge',1);
	OutStruct  = TempStruct.Bridge;
end