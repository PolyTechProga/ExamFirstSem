��������� ��� �������� ����� � ����� ������ ����� ���:
type
	T = Integer;	{ �������� ����������� �� ����������� ���� ������ }

	TTree = ^TNode;
	TNode = record
		value: T;
		Left, Right: TTree;
	end;
����� ���� Left � Right - ��� ��������� �� �������� ������� ����, � ���� value ������������� ��� �������� ����������. 

��� �������� ������ ���������� ����������� ��������� ���������� ����:
procedure Insert(var Root: TTree; X: T);

	{ �������������� ���������, ��������� � ���������������� ����� ���� }
	procedure CreateNode(var p: TTree; n: T);
	begin
		New(p);
		p^.value := n;
		p^.Left := nil;
		p^.Right := nil
	end;
	
begin
	if Root = nil Then CreateNode(Root, X) { ������� ����� ���� ������ }
	else 
		with Root^ do begin
			if value < X then Insert(Right, X)
			else
				if value > X Then Insert(Left, X)
				else 
				{ ��������, ������������ � ������ ����������
				�������� ��������� � ������}
		end;
end;
��� ��������� ��������� ������� X � ������, �������� �������� X. ��� ���� ��������� ����� ���� ������.

�������� �������� �������� �������� ����� ���:
function GetNode(Root: TTree): T;
begin
	if Root = nil then WriteLn('������ - �����!')
	else
		GetNode:=Root^.value
end;
����� ��������� �������� (������� ���������� ����� ���� � ��������� ���������; ���� ������� � ������ �� ������, ������������ nil):
function Find(Root: TTree; X: T): TTree;
begin
	if Root = nil then Find := nil
	else
		if X = Root^.value then Find := Root
		else
			if X < Root^.value then Find := Find(Root^.Left, X)
			else Find := Find(Root^.Right, X);
end;
�������� ���� ��������� ������.

��� ������� ����� ������� ��������, ��� ����� ��������� ��������. ������� ���������� ����� �������, ���������� ��������. ���� ���� ������� - ����, �� ����� ���� ������ ������. ���� �� �� �������� ���������� ����� (����� ��������), �� ������ ��� ������� ��� �� ��������� - ����� ��������� ���������� ����� � ������.

��������� ���:
���� ��������� ���� ����� ������ ������ "����", �� ��� �������� ����� �������� ��������� ����� "����"
���� � ���������� �������� 2 "����", �������� ��� ��������� � ���������� ��������� ����� �������� ������� "����" (��� ��������� � ���������� ��������� ����� �������� ������ "����")


��� ���������� ��������� Remove ���������� ����� ������� DeleteMin, ������� ����� ������� ���������� ������� ��������� ������ Root, � ���������� �������� ���������� ��������:
function DeleteMin(var Root: TTree): T;
var WasRoot: TTree;
begin

	if Root^.Left = nil then begin
		DeleteMin := Root^.value;	{ ��������� ������� }
		WasRoot := Root;		{ ���������� ���� ��� ������������ �������� }
		Root := Root^.Right;		{ ������������ ������ }
		Dispose(WasRoot);		{ ������� ������ ������ }
	end
	else { ���� Root ����� ������ "����" }
		DeleteMin := DeleteMin(Root^.Left);
	
end;
������ ��������� Remove ����� ���� ����������� ���:
procedure Remove(var Root: TTree; X: T);
var WasNext: TTree;
begin
	if Root <> nil then
		if X < Root^.value then Remove(Root^.Left, X)
		else 
			if X > Root^.value then Remove(Root^.Right, X)
			else 
				if (Root^.Left = nil) and (Root^.Right = nil) then begin
					{ ��� "�������", ������� ����, �� ������� ��������� Root }
					Dispose(Root); 
					Root := nil
				end
				else 
					if Root^.Left = nil then begin
						WasNext := Root^.Right;
						Dispose(Root);
						Root := WasNext;
					end
					else
						if Root^.Right = nil then begin
							WasNext := Root^.Left;
							Dispose(Root);
							Root := WasNext;
						end
						else { � ���������� �������� ���� ��� "����" }
							Root^.value := DeleteMin(Root^.Right);
end;
����������� ��������� ������.
Procedure Delete(T: TTree);
Begin
  If T = nil Then Exit;

  Delete(T^.Right);
  Delete(T^.Left);
  Dispose(T)
End;