program ex7;

type

t=^el;
el=record
fam:string[10];    {䠬����}
num:integer;       {����� (���祢�� ����) }
lf,rt:t;
end;

procedure putree(var ukt:t;c:integer;st:string;var g:text);  {�⠭���⭠� ����������� ��楤�� ᮧ����� ��ॢ�}
var
uk:t;
begin
if ukt= nil then {ᮧ����� ������ 㧫�}
 begin
 new(uk);
 uk^.num:=c;
 uk^.fam:=st;
 uk^.lf:=nil;
 uk^.rt:=nil;
 ukt:=uk;
 end
else                  {�᫨ 㧥� ����, � ���� ����室����� ���� ��ᮥ������� ����������}
 begin
 if c>ukt^.num then                             {������砥� �ࠢ�}
  begin
  writeln(g,'right ',ukt^.num,' ',c);
  putree(ukt^.rt,c,st,g);
  end
 else                                            {������砥� ᫥��}
  begin
  writeln(g,'left ',ukt^.num,' ',c);
  putree(ukt^.lf,c,st,g);
  end;
end;
end;

procedure getree_lr(var ukt:t;var g:text);  {����������� ��楤�� �뢮�� ��ॢ� ᫥�� ���ࠢ� (�� �����⠭��)}
begin
 if ukt^.lf<>nil then getree_lr(ukt^.lf,g);
 if ukt<>nil then writeln(g,ukt^.num,' ',ukt^.fam);
 if ukt^.rt<>nil then getree_lr(ukt^.rt,g);
end;

procedure getree_rl(var ukt:t;var g:text); {����������� ��楤�� �뢮�� ��ॢ� �ࠢ� ������ (�� �뢠���)}
begin
 if ukt^.rt<>nil then getree_rl(ukt^.rt,g);
 if ukt<>nil then writeln(g,ukt^.num,' ',ukt^.fam);
 if ukt^.lf<>nil then getree_rl(ukt^.lf,g);
end;

var
uktree:t;
c:integer;
st:string[10];
f,g:text;

begin
assign(f,'ex7.inp');
assign(g,'ex7.out');
reset(f);
rewrite(g);
uktree:=nil;     {��易⥫쭮 ���� � ��砫� ��ᢠ����� NIL}
while not EOF(f) do begin   {横� ���뢠��� �� 䠩�� ���ଠ樨}
readln(f,st,c);
putree(uktree,c,st,g); {�ନ஢����}
end;
close(f);
writeln(g);
getree_lr(uktree,g);    {᫥�� ���ࠢ�}
writeln(g);
getree_rl(uktree,g);    {�ࠢ� ������}
close(g);
end.