{1) procedure AddElem(var stek1:List;znach1:TInf) - ��������� ���������� �������� � ����.
2) procedure Print(stek1:List) - ����� �����.
3) Procedure FreeStek(stek1:List) - ������������ ������ ��������������� ��� ����.
4) Function SearchElemZnach(stek1:List;znach1:TInf):List - ����� � ����� �� ��������, ������� ���������� ����� ���������� ��������.
5) Procedure DelElem(var stek1:List;tmp:List) - ��������� �������� �� ����� �������� � ������� tmp.
6) procedure DelElemZnach(var Stek1:List;znach1:TInf) - �������� �� ����� �������� �� ��������� znach1.
7) Procedure DelElemPos(var stek1:List;posi:integer) - �������� �� ����� �������� � ���������� ������� posi.
8) procedure SortBublInf(nach:list) - ���������� ����� "���������" (����� ������� �������), � ������� ������� ����� ����������.
9) procedure SortBublLink(nach:List)- ���������� ����� "���������" (����� ������� �������), � ���������� ���� ���������� �� ��������.
}
Program Spisok;
uses
  crt; {��� ������������� readkey � clrscr}
type
  Tinf=integer; {��� ������, ������� ����� ��������� � �������� ������}
  List=^TList;  {��������� �� ������� ���� TList}
  TList=record {� ��� ������������ ������ ���� "������" ������ ������������ ��������� ����������� ����� ������}
    data:TInf;  {������, �������� � ��������}
    next:List;   {��������� �� ��������� ������� ������}
  end;
 
{��������� ���������� ������ �������� � ����������� ������}
procedure AddElem(var spis1:List;znach1:TInf);
var
  tmp:List;
begin
  if spis1=nil then {��������� �� ���� �� ������, ���� ����, �� }
  begin
    GetMem(spis1,sizeof(TList));  {������ ��� ������ �������}
    tmp:=spis1;
  end
  else {� ������ ���� ������ �� ����}
  begin
    tmp:=spis1;
    while tmp^.next<>nil do
      tmp:=tmp^.next; {������ tmp �� ��������� ������� ������}
    GetMem(tmp^.next,sizeof(TList)); {������ ��������� �������}
    tmp:=tmp^.next;   {��������� tmp �� ����� �������}
  end;
  tmp^.next:=nil; {�������� ���������}
  tmp^.data:=znach1; {������� ��������}
end;
 
{��������� ������ ������
��������� ��������� ��� ������ �� ������}
procedure Print(spis1:List);
begin
  if spis1=nil then
  begin
    writeln('���᮪ ����.');
    exit;
  end;
  while spis1<>nil do
  begin
    Write(spis1^.data, ' ');
    spis1:=spis1^.next
  end;
end;
 
{��������� �������� ������
 ��������� ��������� ��� ������ �� ������}
Procedure FreeStek(spis1:List);
var
  tmp:List;
begin
  while spis1<>nil do
  begin
    tmp:=spis1;
    spis1:=spis1^.next;
    FreeMem(tmp,SizeOf(Tlist));
  end;
end;
 
{��������� ������ � ������
 ��������� ��������� ��� ������ �� ������}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
 
{��������� �������� ��������
 ��������� ��������� ��� ������ �� ������}
Procedure DelElem(var spis1:List;tmp:List);
var
  tmpi:List;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then
  begin
    spis1:=tmp^.next;
    FreeMem(tmp,SizeOf(TList));
  end
  else
  begin
    tmpi:=spis1;
    while tmpi^.next<>tmp do
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next;
    FreeMem(tmp,sizeof(TList));
  end;
end;
 
{��������� �������� �������� �� ��������
 ��������� ��������� ��� ������ �� ������}
procedure DelElemZnach(var Spis1:List;znach1:TInf);
var
  tmp:List;
begin
  if Spis1=nil then
  begin
    Writeln('���᮪ ����');
    exit;
  end;
  tmp:=SearchElemZnach(spis1,znach1);
  if tmp=nil then
  begin
    writeln('�����*� � �᪮�� �**�*��� ' ,znach1, ' ��������� � ᯨ᪥.');
    exit;
  end;
  DelElem(spis1,tmp);
  Writeln('�����*� �*��*.');
end;
 
{��������� �������� �������� �� �������
 ��������� ��������� ��� ������ �� ������}
Procedure DelElemPos(var spis1:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if posi<1 then
    exit;
  if spis1=nil then
  begin
    Write('���᮪ ����');
    exit
  end;
  i:=1;
  tmp:=spis1;
  while (tmp<>nil) and (i<>posi) do
  begin
    tmp:=tmp^.next;
    inc(i)
  end;
  if tmp=nil then
  begin
    Writeln('�����*�* � ���浪��� *���஬ ' ,posi, ' *�� � ᯨ᪥.');
    writeln('� ᯨ᪥ �ᥣ� ' ,i-1, ' ���*�*(��).');
    exit
  end;
  DelElem(spis1,tmp);
  Writeln('�����*� �*��*.');
end;
 
{��������� ���������� "���������" � ���������� ������ ������
 ��������� ��������� ��� ������ �� ������}
procedure SortBublInf(nach:list);
var
  tmp,rab:List;
  tmps:Tinf;
begin
  GetMem(tmp,SizeOf(Tlist));
  rab:=nach;
  while rab<>nil do
  begin
    tmp:=rab^.next;
    while tmp<>nil do
    begin
      if tmp^.data<rab^.data then
      begin
        tmps:=tmp^.data;
        tmp^.data:=rab^.data;
        rab^.data:=tmps
      end;
      tmp:=tmp^.next
    end;
    rab:=rab^.next
  end
end;
 
{��������� ���������� "���������" � ���������� ������ �������
 ��������� ��������� ��� ������ �� ������}
procedure SortBublLink(nach:List);
var
  tmp,pered,pered1,pocle,rab:List;
begin
  rab:=nach;
  while rab<>nil do
  begin
    tmp:=rab^.next;
    while tmp<>nil do
    begin
      if tmp^.data<rab^.data then
      begin
        pered:=nach;
        pered1:=nach;
        if rab<>nach then
          while pered^.next<>rab do pered:=pered^.next;
        while pered1^.next<>tmp do pered1:=pered1^.next;
        pocle:=tmp^.next;
        if rab^.next=tmp then
        begin
          tmp^.next:=rab;
          rab^.next:=pocle
        end
        else
        begin
          tmp^.next:=rab^.next;
          rab^.next:=pocle;
        end;
        if pered1<>rab then
          pered1^.next:=rab;
        if rab<>nach then
          pered^.next:=tmp
        else
          nach:=tmp;
        pered1:=tmp;
        tmp:=rab;
        rab:=pered1;
      end;
      tmp:=tmp^.next;
    end;
    rab:=rab^.next;
  end;
end;
 
var
  Spis,tmpl:List;
  znach:integer;
  ch:char;
begin
  Spis:=nil;
  repeat
    clrscr;
    Write('�ண�*��* ��� �*���� � ');
    TextColor(4);
    Writeln('ᯨ᪮�.');
    TextColor(7);
    Writeln('�롥�� ���*���� ����⢨�:');
    Writeln('1) ���*���� ���*�.');
    Writeln('2) �뢮� ᯨ�*.');
    Writeln('3) ��*��*�� ���*�* �� �**�*��.');
    Writeln('4) ��*��*�� ���*�* �� ���浪����� *�����.');
    Writeln('5) ���� ���*�* �� �**�*��.');
    Writeln('6) ����஢�* ᯨ�* ��⮤�� "�����*", ��*�� ⮫쪮 �***�.');
    Writeln('7) ����஢�* ᯨ�* � ����*�*��� *��ᮢ.');
    Writeln('8) ��室.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('������ �**�*�� ���*��塞��� ���*�* ');
            readln(znach);
            AddElem(Spis,znach);
          end;
      '2':begin
            clrscr;
            Print(Spis);
            readkey;
          end;
      '3':begin
            Write('������ �**�*�� �*�塞��� ���*�* ');
            readln(znach);
            DelElemZnach(Spis,znach);
            readkey;
          end;
      '4':begin
            Write('������ ���浪��� *���� �*�塞��� ���*�* ');
            readln(znach);
            DelElemPos(Spis,znach);
            readkey;
          end;
      '5':begin
            write('������ �**�*�� �᪮���� ���*�* ');
            readln(znach);
            tmpl:=SearchElemZnach(Spis,znach);
            if tmpl=nil then
              write('?᪮�� ���*� ��������� � ᯨ᪥')
            else
              write('�����*� ',tmpl^.data,' **���*');
            readkey;
          end;
      '6':begin
            if Spis=nil then
            begin
              Write('���᮪ ����.');
              readkey
            end
            else
            begin
              SortBublInf(Spis);
              Write('���᮪ �����஢**.');
              readkey;
            end
          end;
      '7':begin
            if Spis=nil then
            begin
              Write('���᮪ ����.');
              readkey
            end
            else
            begin
              SortBublLink(Spis);
              Write('���᮪ �����஢**.');
              readkey;
            end
          end;
    end;
  until ch='8';
  FreeStek(Spis);
end.