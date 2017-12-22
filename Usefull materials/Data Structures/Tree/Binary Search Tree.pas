program tree;
uses crt;
 
type {�������� ���� ������}
  PNode = ^TNode;
  TNode = record
    value: integer;
    left: PNode;
    right: PNode;
  end;
 
var {������ �������� ����������}
  BiTree1, BiTree2: PNode;
  Node1, Node2: PNode;
  n: integer;
 
function CreateRandomBinaryTree(count_node: integer): PNode;
{���������� ������ ����������� ������}
var
  nleft, nright: integer;
  node: pnode;
  x: integer;
Begin
  if count_node = 0 then
    node:=nil
  else begin
    nleft:= count_node div 2; {���������� ������ ���������}
    nright:= count_node - nleft - 1; {���������� ������� ���������}
    write('vvedite element dereva: ');
    read(x); {����  ��������� ������}
    new(node);
    node^.value:= x;
    node^.left:= CreateRandomBinaryTree(nleft);
    node^.right:= CreateRandomBinaryTree(nright);
  end;
  CreateRandomBinaryTree:= node;
End;
 
procedure DestroyBinaryTree(root: PNode);
Begin
  if root <> nil then begin
    DestroyBinaryTree(root^.left);
    DestroyBinaryTree(root^.right);
    Dispose(root);
  end;
End;
 
function FindNodeByValue(root: PNode; value: integer): PNode;
{����� �������� �������� ������}
var
  temp: PNode;
Begin
  if root = nil then
    FindNodeByValue:= nil
  else
    if root^.value = value then
      FindNodeByValue:= root
    else begin
      temp:= FindNodeByValue(root^.left, value);
      if temp = nil then
        temp:= FindNodeByValue(root^.right, value);
      FindNodeByValue:= temp;  
    end;
End;
 
function FindNodeWithLeftNil(root: PNode): PNode;
{�������� �� ��, ����� �� ����� ���������}
Begin
  if root^.left = nil then
    FindNodeWithLeftNil:= root
  else
    FindNodeWithLeftNil:= FindNodeWithLeftNil(root^.left);
End;
 
procedure PrintTree(root: PNode; h: integer); {������ ������ � ��������}
begin
 if root <> nil then begin
  Printtree(root^.right,h+2);
  writeln(' ':h, root^.value);
  PrintTree(root^.left, h+2);
 end;
end;
 
BEGIN {������ ���������}
  clrscr; {������� ������}
  Write ('Kolichestvo uzlov 1 dereva: ');
  Readln(n); {���� ���������� ����� ������� ������}
  writeln('Binarnoe derevo 1 minimalnoy visoti:');
  BiTree1:= CreateRandomBinaryTree(n);
 {���������� ������� ������ ����������� ������}
  PrintTree(BiTree1, 0);
  readln; {������� �� ����� ������}
  Write ('Kolichestvo uzlov 2 dereva: ');
  Readln(n); {���� ���������� ����� ������� ������}
  writeln('Binarnoe derevo 2 minimalnoy visoti:');
  BiTree2:= CreateRandomBinaryTree(n);
 {���������� ������� ������ ����������� ������}
  PrintTree(BiTree2, 0);
  readln; {������� �� ����� ������}
  Write ('Iskomoe znachenie: ');
  Readln(n); {���� �������� �������� ������� ������}
  Node1:= FindNodeByValue(BiTree1, n);
  if Node1 <> nil then begin
    Node2:= FindNodeWithLeftNil(Node1);
    Node2^.left:= BiTree2;
    PrintTree(BiTree1, 0);
  end
  else
    Write('Znachenie ne naideno');
  Readln;
  DestroyBinaryTree(BiTree1);
END. {����� ���������}