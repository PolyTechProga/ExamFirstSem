{1) procedure AddElem(var stek1:List;znach1:TInf) - ��������� ���������� �������� � ����.
2) procedure Print(stek1:List) - ����� �����.
3) Procedure FreeStek(stek1:List) - ������������ ������ ��������������� ��� ����.
4) Function SearchElemZnach(stek1:List;znach1:TInf):List - ����� � ����� �� ��������, ������� ���������� ����� ���������� ��������.
5) Procedure DelElem(var stek1:List;tmp:List) - ��������� �������� �� ����� �������� � ������� tmp.
6) procedure DelElemZnach(var Stek1:List;znach1:TInf) - �������� �� ����� �������� �� ��������� znach1.
7) Procedure DelElemPos(var stek1:List;posi:integer) - �������� �� ����� �������� � ���������� ������� posi.
8) procedure SortBublInf(nach:list) - ���������� ����� "���������" (����� ������� �������), � ������� ������� ����� ����������.
}
Program Spisok_kolco;
uses
  crt; {��� ������������� readkey � clrscr}
type
  Tinf=integer; {��� ������, ������� ����� ��������� � �������� ������}
  List=^TList;  {��������� �� ������� ���� TList}
  TList=record  {� ��� ������������ ������ ���� "������" ������ ������������ ��������� ����������� ����� ������}
    data:TInf;  {������, �������� � ��������}
    next:List;  {��������� �� ��������� ������� ������}
  end;
 
{��������� ���������� ������ �������� � ��������������� ������}
procedure AddElem(var nach:List;znach1:TInf);
var
  tmp,tmp1:List;
begin
  if nach=nil then {�� ���� �� ������, ���� ����, ��}
  begin
    Getmem(nach,SizeOf(TList)); {������ �������, ��������� nach ��� ����� ����� �����}
    nach^.next:=nach; {������� �� �������� "��������" ���������}
    tmp:=nach;
  end
  else {���� ������ �� ����}
  begin
    tmp:=nach;
    while tmp^.next<>nach do
      tmp:=tmp^.next;
    GetMem(tmp1,SizeOf(Tlist));
    tmp1^.next:=nach;
    tmp^.next:=tmp1;
    tmp:=tmp1;
  end;
  tmp^.data:=znach1; {������� ������}
end;
 
{��������� ������ ������
��������� ��������� ��� ������ �� ������}
procedure Print(spis1:List);
var
  nach:List;
begin
  if spis1=nil then
  begin
    writeln('���᮪ ����.');
    exit;
  end;
  nach:=spis1;
  Write(spis1^.data, ' ');
  spis1:=spis1^.next;
  while spis1<>nach do
  begin
    Write(spis1^.data, ' ');
    spis1:=spis1^.next;
  end;
end;
 
{��������� �������� ������
 ��������� ��������� ��� ������ �� ������}
Procedure FreeStek(spis1:List);
var
  tmp,nach:List;
begin
  if spis1=nil then
    exit;
  nach:=spis1;
  tmp:=spis1;
  spis1:=spis1^.next;
  dispose(tmp);
  while spis1<>nach do
  begin
    tmp:=spis1;
    spis1:=spis1^.next;
    FreeMem(tmp,SizeOf(Tlist));
  end;
end;
 
{������� ������ � ������
 ��������� ��������� ��� ������ �� ������}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
var
  tmp:List;
begin
  tmp:=spis1;
  if spis1<>nil then
    if spis1^.data=znach1 then
      SearchElemZnach:=spis1
    else
    begin
      spis1:=spis1^.next;
      while (Spis1<>tmp) and (znach1<>spis1^.data) do
        spis1:=spis1^.next;
      if spis1=tmp then
        spis1:=nil;
    end;
  SearchElemZnach:=spis1;
end;
 
{��������� �������� �������� � ��������������� ������}
Procedure DelElem(var spis1:List;tmp:List);
var
  tmpi:List;
begin
  if tmp=spis1 then
  begin
    tmpi:=tmp;
    while tmpi^.next<>spis1 do
      tmpi:=tmpi^.next;
    if tmpi=spis1 then
    begin
      spis1^.next:=nil;
      dispose(spis1);
      spis1:=nil
    end
    else
    begin
      tmpi^.next:=tmp^.next;
      spis1:=spis1^.next;
      dispose(tmp)
    end;
  end
  else
  begin
    tmpi:=spis1;
    while tmpi^.next<>tmp do
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next;
    dispose(tmp);
  end;
end;
 
{��������� �������� �������� �� ��������
 ��������� ��������� ��� ������ �� ������}
procedure DelElemZnach(var Spis1:List;znach1:TInf);
var
  tmp:List;
begin
  tmp:=spis1;
  if znach1=tmp^.data then
  begin
    DelElem(spis1,tmp);
    exit;
  end;
  tmp:=tmp^.next;
  while tmp<>Spis1 do
  begin
    if tmp^.data=znach1 then
    begin
      DelElem(spis1,tmp);
      exit
    end;
    tmp:=tmp^.next;
  end;
end;
 
{��������� �������� �������� �� �������
 ��������� ��������� ��� ������ �� ������}
Procedure DelElemPos(var spis1:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if spis1=nil then
  begin
    writeln('Spisok /7ycT');
    readkey;
    exit
  end;
  tmp:=spis1^.next;
  i:=1;
  while tmp<>spis1 do
  begin
    tmp:=tmp^.next;
    inc(i)
  end;
  if (posi<1) or (posi>i) then
  begin
    writeln('� ᯨ᪥ ',i, ' ���*�*(��).');
    writeln('�����*� ',posi,' ��������� � ᯨ᪥.');
    readkey;
    exit
  end
  else
  begin
    i:=1;
    tmp:=spis1;
    while i<posi do
    begin
      tmp:=tmp^.next;
      inc(i)
    end;
    DelElem(spis1,tmp);
  end;
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
  while rab^.next<>nach do
  begin
    tmp:=rab^.next;
    while tmp<>nach do
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
 
 
{procedure SortBublLink(var nach:List);
var
  tmp,pocle1,rab:List;
begin
  if nach=nil then
    exit;
  rab:=nach;
  while rab^.next<>nach do
  begin
    tmp:=rab^.next;
    while tmp<>nach do
    begin
      if tmp^.data<rab^.data then
      begin
 
      end;
      tmp:=tmp^.next;
    end;
    rab:=rab^.next;
  end;
end;}
 
 
 
var
  SpisNach, {��������� �� ������ ������ �}
  tmpl:List; {������������ ����� � ��������������� ������}
  znach,a,b:integer;
  ch:char;
begin
  SpisNach:=nil;
  repeat
    clrscr;
    Write('�ண�*��* ��� �*���� � ');
    TextColor(4);
    Writeln('����楢� ᯨ᪮�.');
    TextColor(7);
    Writeln('�롥�� ���*���� ����⢨�:');
    Writeln('1) ���*���� ���*�.');
    Writeln('2) �뢮� ᯨ�*.');
    Writeln('3) ��*��*�� ���*�* �� �**�*��.');
    Writeln('4) ��*��*�� ���*�* �� ���浪����� *�����.');
    Writeln('5) ���� ���*�* �� �**�*��.');
    Writeln('6) ����஢�* ᯨ�* ��⮤�� "�����*", ��*�� ⮫쪮 �***�.');
    Writeln('7) ��室.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('������ �**�*�� ���*��塞��� ���*�* ');
            readln(znach);
            AddElem(SpisNach,znach);
          end;
      '2':begin
            clrscr;
            Print(SpisNach);
            readkey;
          end;
      '3':begin
            Write('������ �**�*�� �*�塞��� ���*�* ');
            readln(znach);
            DelElemZnach(SpisNach,znach);
          end;
      '4':begin
            Write('������ ���浪��� *���� �*�塞��� ���*�* ');
            readln(znach);
            DelElemPos(SpisNach,znach);
            readkey;
          end;
      '5':begin
            write('������ �**�*�� �᪮���� ���*�* ');
            readln(znach);
            tmpl:=SearchElemZnach(SpisNach,znach);
            if tmpl=nil then
              write('?᪮�� ���*� ��������� � ᯨ᪥')
            else
              write('�����*� ',tmpl^.data,' **���*');
            readkey;
          end;
      '6':begin
            if SpisNach=nil then
            begin
              Write('���᮪ ����.');
              readkey
            end
            else
            begin
              SortBublInf(SpisNach);
              Write('���᮪ �����஢**.');
              readkey;
            end
          end;
    end;
  until ch='7';
  FreeStek(SpisNach);
end.