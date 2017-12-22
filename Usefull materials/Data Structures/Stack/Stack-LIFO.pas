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
Program Stek;
uses
  crt; {��� ������������� readkey � clrscr}
type
  Tinf=integer; {��� ������, ������� ����� ��������� � �������� �����}
  List=^TList;  {��������� �� ������� ���� TList}
  TList=record {� ��� ������������ ������ ���� "������" ������ ������������ ��������� ����������� ����� ������}
    data:TInf;  {������, �������� � ��������}
    next:List;   {��������� �� ��������� �������}
  end;
 
{��������� ����������� ������� � ����}
procedure AddElem(var stek1:List;znach1:TInf);
var
  tmp:List;
begin
  GetMem(tmp,sizeof(TList)); {�������� � ������ ����� ��� ������ ��������}
  tmp^.next:=stek1;  {��������� �� ��������� ������� "����������" �� ������� �����}
  tmp^.data:=znach1; {��������� � �������� ������}
  stek1:=tmp; {������� ����� ����������, ���� ��������� � ��������� �� ��}
end;
 
{��������� ������ �����}
procedure Print(stek1:List);
begin
  if stek1=nil then {�������� �� ������� �����}
  begin
    writeln('�⥪ ����.');
    exit;
  end;
  while stek1<>nil do {���� ��������� stek1 �� ������ ��������� � �������}
  begin   {� ��� ��������� ��� ������ �� ������� �� ������ ���������� ��������}
    Write(stek1^.data, ' '); {�������� �����}
    stek1:=stek1^.next  {� ���������� ��������� ������ �� �����}
  end;
end;
 
{��������� ������������ ������ ������� ������}
Procedure FreeStek(stek1:List);
var
  tmp:List;
begin
  while stek1<>nil do {���� stek1 �� ������ ��������� � "�������" ������}
  begin
    tmp:=stek1; {��������� tmp �������� �� ������� �����}
    stek1:=stek1^.next; {������� ����� �������� �� ��������� �� ������ �������� �������}
    FreeMem(tmp,SizeOf(Tlist)); {��������� ������ ������� ��� ������ �������}
  end;
end;
 
{����� �������� � ����� �� ��������}
Function SearchElemZnach(stek1:List;znach1:TInf):List;
begin
  if stek1<>nil then {���� ���� �� ����, ��}
    while (Stek1<>nil) and (znach1<>stek1^.data) do {���� stek1 �� ������ � "�������" ��� ���� �� �� ����� ������ ��� �������}
      stek1:=stek1^.next; {���������� ���������}
  SearchElemZnach:=stek1;{������� ���������� ��������� �� ��������� �������}
end;         {� ������ ���� ������� �� ������, ��� ����� nil}
 
{��������� �������� �������� �� ���������}
Procedure DelElem(var stek1:List;tmp:List);
var
  tmpi:List;
begin
  if (stek1=nil) or (tmp=nil) then {���� ���� ���� ��� ��������� ������ �� ���������, �� �������}
    exit;
  if tmp=stek1 then {���� �� ������� ������� ������� �������� �������� �����, ��}
  begin
    stek1:=tmp^.next;{������� ��������� ������� �}
    FreeMem(tmp,SizeOf(TList)); {����������� ������ �� ��� ��������}
  end
  else {� ������, ���� ��������� ������� �� ������� �����, ��}
  begin
    tmpi:=stek1; {������ ��������� �� ������� �����}
    while tmpi^.next<>tmp do {������� �� �������� �������� "�����" ���, ������� ��� ������� �������}
      tmpi:=tmpi^.next;
    tmpi^.next:=tmp^.next; {��������� �������� ��������� �� ��������� ������� �� ���������}
    FreeMem(tmp,sizeof(TList)); {������� �������}
  end;
end;
 
{��������� �������� �������� �� ��������}
procedure DelElemZnach(var Stek1:List;znach1:TInf);
var
  tmp:List;
begin
  if Stek1=nil then {���� ���� ����, �� ������� ��������� � �������}
  begin
    Writeln('�⥪ ����');
    exit;
  end;
  tmp:=SearchElemZnach(stek1,znach1); {tmp ��������� �� ��������� �������}
  if tmp=nil then {���� ������� �� ��� ������, �� ������� ��������� � �������}
  begin
    writeln('�����*� � �᪮�� �**�*��� ' ,znach1, ' ��������� � �⥪�.');
    exit;
  end;
  DelElem(stek1,tmp); {������� ������� �� ����� }
  Writeln('�����*� �*��*.'); {�������� � ���������� ��������}
end;
 
{�������� �������� �� ����������� ������ (������� ����� ����� 1)}
Procedure DelElemPos(var stek1:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if posi<1 then {�������� �� ���� ����������}
    exit;
  if stek1=nil then {���� ���� ����}
  begin
    Write('�⥪ ����');
    exit
  end;
  i:=1; {����� ������� �������}
  tmp:=stek1;
  while (tmp<>nil) and (i<>posi) do {���� tmp �� ������ � "�������" ��� �� �� ����� ������� �������}
  begin
    tmp:=tmp^.next; {��������� �� ��������� �������}
    inc(i)   {����������� �������� ��������}
  end;
  if tmp=nil then {���� �������� ��� ������� ��������������� ��������� � �������}
  begin
    Writeln('�����*�* � ���浪��� *���஬ ' ,posi, ' *�� � �⥪�.');
    writeln('� �⥪� ' ,i-1, ' ���*�*(��).');
    exit
  end;
  DelElem(stek1,tmp); {���� �� �� �����, �� ������� ���� � ��� ������� �������}
  Writeln('�����*� �*��*.'); {�������� � ���������� ��������}
end;
 
{��������� ���������� "���������" � ���������� ������ ������}
procedure SortBublInf(nach:list);
var
  tmp,rab:List;
  tmps:Tinf;
begin
  GetMem(tmp,SizeOf(Tlist)); {�������� ������ ��� �������� "������" ������}
  rab:=nach; {������� ������, ���������� �� ������� �����}
  while rab<>nil do {���� �� �� ����� �� ����� ����� ������}
  begin
    tmp:=rab^.next; {������� �� ��������� �������}
    while tmp<>nil do {���� �� ����� ����� ������}
    begin
      if tmp^.data<rab^.data then {��������� ������� �� ������ ��������}
      begin
        tmps:=tmp^.data; {����������� ������ � 3 ��������}
        tmp^.data:=rab^.data;
        rab^.data:=tmps
      end;
      tmp:=tmp^.next {������� � ���������� ��������}
    end;
    rab:=rab^.next {������� � ���������� ��������}
  end
end;
 
{��������� ���������� "���������" � ���������� ������ �������}
procedure SortBublLink(nach:List);
var
  tmp,pered,pered1,pocle,rab:List; {��� ������� ������}
begin
  rab:=nach; {���������� �� ������� �����}
  while rab<>nil do{���� �� ����� ����� ������}
  begin
    tmp:=rab^.next; {��������� � ���������� �� ����������� ��������}
    while tmp<>nil do {���� �� ����� ����� ������}
    begin
      if tmp^.data<rab^.data then {���� ������� ���������� ������, ��}
      begin
        pered:=nach; {���������� � ������� �����}
        pered1:=nach; {���������� � ������� �����}
        if rab<>nach then {���� �� �� ����� �� ���������� ��������, ��}
          while pered^.next<>rab do pered:=pered^.next; {������ �� �������� ����� ����������}
        while pered1^.next<>tmp do pered1:=pered1^.next; {������ �� �������� ����� ����������, ������� ��������� ��
        ������ ����������}
        pocle:=tmp^.next; {���������� ����� �������� ����� ������� �����������}
        if rab^.next=tmp then {���� �������� "������", ��}
        begin
          tmp^.next:=rab; {������ ������, ��� ���� �� ������� ������� �� ��������}
          rab^.next:=pocle
        end
        else {� ������ ���� �������� �� ������, ��}
        begin
          tmp^.next:=rab^.next;{������ ������, ��� ���� �� ������� ������� �� ��������}
          rab^.next:=pocle;
        end;
        if pered1<>rab then{������� ����������� �� ��������}
          pered1^.next:=rab;
        if rab<>nach then{������� ����������� �� ��������}
          pered^.next:=tmp
        else{�� ������� ����������� �� ��������}
          nach:=tmp;
        pered1:=tmp;{������� ����������� �� ��������}
        tmp:=rab;{������� ����������� �� ��������}
        rab:=pered1;{������� ����������� �� ��������}
      end;
      tmp:=tmp^.next; {��������� �� ��������� �������}
    end;
    rab:=rab^.next;{��������� �� ��������� �������}
  end;
end;
 
var
  Stk, {����������, ������� ������ ����� ��������� �� "�������" �����}
  tmpl:List; {������� ����������}
  znach:Tinf; {������ �������� �������������}
  ch:char; {��� ������ �������}
begin
  Stk:=nil;
  repeat {���� ��� ������ ����}
    clrscr; {������� ������, ����� ��� ����� ������ ����}
    Write('�ண�*��* ��� �*���� � ');
    Textcolor(4);
    Writeln('�⥪��.');
    Textcolor(7);
    Writeln('�롥�� ���*���� ����⢨�:');
    Writeln('1) ���*���� ���*�.');
    Writeln('2) �뢮� �⥪*.');
    Writeln('3) ��*��*�� ���*�* �� �**�*��.');
    Writeln('4) ��*��*�� ���*�* �� ���浪����� *�����.');
    Writeln('5) ���� ���*�* �� �**�*��');
    Writeln('6) ����஢�* �⥪* ��⮤�� "�����*", ��*�� ⮫쪮 �***�.');
    Writeln('7) ����஢�* �⥪* � ����*�*��� *��ᮢ.');
    Writeln('8) ��室.');
    writeln;
    ch:=readkey; {������� ������� �������}
    case ch of {�������� �������}
      '1':begin
            write('������ �**�*�� ���*��塞��� ���*�* ');
            readln(znach); {��������� �������� ������������ ������ �������}
            AddElem(Stk,znach);
          end;
      '2':begin
            clrscr; {������� ������}
            Print(Stk); {����� ��������� ������}
            readkey; {������� ������� �������}
          end;
      '3':begin
            Write('������ �**�*�� �*�塞��� ���*�* ');
            readln(znach); {���� �������� ���������� ��������}
            DelElemZnach(Stk,znach); {����� ��������� �������� �������� �� ��������}
            readkey;{������� ������� �������}
          end;
      '4':begin
            Write('������ ���浪��� *���� �*�塞��� ���*�* ');
            readln(znach); {���� ������� ���������� �����}
            DelElemPos(Stk,znach);{����� ��������� �������� �������� �� ��������}
            readkey;{������� ������� �������}
          end;
      '5':begin
            write('������ �**�*�� �᪮���� ���*�* ');
            readln(znach); {���� �������� ��������}
            tmpl:=SearchElemZnach(Stk,znach); {�������� ��������� ������ �������� �� ��������}
            if tmpl=nil then {��������� ������ �� ������� � ������� ��������������� ���������}
              write('?᪮�� ���*� ��������� � �⥪�')
            else
              write('�����*� ',tmpl^.data,' **���*');
            readkey;{������� ������� �������}
          end;
      '6':begin
            if Stk=nil then {��������� �� ������ �� ����}
            begin
              Write('�⥪ ����.');
              readkey{������� ������� �������}
            end
            else
            begin
              SortBublInf(Stk);{����� ��������� ���������� ����� � ���������� ������}
              Write('�⥪ �����஢**.');
              readkey;{������� ������� �������}
            end
          end;
      '7':begin
            if Stk=nil then{��������� �� ������ �� ����}
            begin
              Write('�⥪ ����.');
              readkey{������� ������� �������}
            end
            else
            begin
              SortBublLink(Stk);{����� ��������� ���������� ����� � ���������� �������}
              Write('�⥪ �����஢**.');
              readkey;{������� ������� �������}
            end
          end;
    end;
  until ch='8';
  FreeStek(Stk); {����������� ������ ������� ������}
end.