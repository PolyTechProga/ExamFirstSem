Type 
   Tree=^s; 
   S=record 
   Inf: integer;//<��� �������� ����������>; 
    
      Left , right : tree ; 
End ;
//poisk
function find(root:tree; key:integer; var p, parent:tree):Boolean; 
begin 
   p:=root; 
   while p<>nil do begin 
      if key=p^.inf then begin{ ���� � ����� ������ ���� } 
         find:=true; 
         exit; 
      end; 
      parent:=p; {��������� ��������� �� ������} 
      if key<p^.inf then
         p := p ^. left {���������� �����} 
      else p := p ^. right ; {���������� ������} 
   end; 
find:=false; 
end;
//obxod
Procedure obhod(p:tree); 
Begin 
   if p<>nil then 
   begin 
      obhod(p^.left); 
      writeln(p^.inf); 
      obhod(p^.right); 
   end; 
end;
//udalenie
procedure del ( var root : tree ; key : integer ); 
var 
   p : tree ; {��������� ����} 
   parent : tree ; {������ ���������� ����} 
   y : tree ; {����, ���������� ���������} 
function spusk(p:tree):tree; 
var 
   y : tree ; {����, ���������� ���������} 
   pred:tree; { ������ ���� �y�} 
begin 
   y:=p^.right; 
   if y^.left=nil then y^.left:=p^.left {1} 
   else {2} 
   begin 
      repeat 
         pred:=y; y:=y^.left; 
      until y^.left=nil; 
      y^.left:=p^.left; {3} 
      pred^.left:=y^.right; {4} 
      y^.right:=p^.right; {5} 
   end; 
   spusk:=y; 
end;
procedure TreeLoad(var aPNode : TPNode; const aFileName : String); //������ �� �����
var
  F : TextFile;
begin
  TreeFree(aPNode);
  AssignFile(F, aFileName);
  Reset(F);
  try
    NodeLoad(aPNode, F);
  finally
    CloseFile(F);
  end;
end;
Procedure Create_Cicl( var head? PList; n? byte ); var p? PList; i? byte; begin new( head ); head^.link?=head;	{ head � ��������� �� ������ ������ } { n � ���������� ����� � ������ }     { �������� ������������� ������ }
for i?=1 to n do begin	{ c������� ������������ ������ �� n ����� }
new( p );	{ �������� ���� ������ }
readln(p^.info);	{ ���������� ��������������� ���� ���� }
p^.link?=head^.link;	{ ��������� ����� ����� ����������� ����� � c������}
head^.link?=p;	{ ���������� ���� ����� ��������� ���� }
end; end;
begin 
   if not find(root, key, p, parent) then {6} 
   begin writeln('������ �������� ���'); exit; end; 
   if p^.left=nil then y:=p^.right {7} 
   else 
      if p^.right=nil then y:=p^.left {8} 
      else y:=spusk(p); {9} 
   if p=root then root:=y {10} 
   else {11} 
      if key<parent^.inf then 
         parent^.left:=y 
      else parent^.right:=y; 
   dispose(p); {12} 
end;
