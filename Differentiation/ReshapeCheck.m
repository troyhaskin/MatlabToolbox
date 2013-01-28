function Checked = ReshapeCheck(Vector1,Vector2)
if (size(Vector1,1) ~= size(Vector2,1))
	Checked = Vector2';
else
	Checked = Vector2;
end
end