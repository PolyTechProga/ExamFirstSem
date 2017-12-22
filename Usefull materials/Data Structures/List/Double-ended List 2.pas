Program Spisok_dn;
uses
  crt; {��� ������������� readkey � clrscr}
type
  Tinf=integer; {��� ������, ������� ����� ��������� � �������� ������}
  List=^TList;  {��������� �� ������� ���� TList}
  TList=record {� ��� ������������ ������ ���� "������" ������ ������������ ��������� ����������� ����� ������}
    data:TInf;  {������, �������� � ��������}
    next,    {��������� �� ��������� ������� ������}
    prev:List;   {��������� �� ���������� ������� ������}
  end;
 
{��������� ���������� ������ �������� � ��������������� ������}
procedure AddElem(var nach,ends:List;znach1:TInf);
begin
  if nach=nil then {�� ���� �� ������, ���� ����, ��}
  begin
    Getmem(nach,SizeOf(TList)); {������ �������, ��������� nach ��� ����� ����� �����}
    nach^.next:=nil; {������� �� �������� "��������" ���������}
    nach^.prev:=nil; {����������}
    ends:=nach; {�������� ��������� ����� ������}
  end
  else {���� ������ �� ����}
  begin
    GetMem(ends^.next,SizeOf(Tlist)); {������ ����� �������}
    ends^.next^.prev:=ends; {����� ������ �������� � ��������� ��������� ������}
    ends:=ends^.next;{����� ������ ��������� � �� ��������� "������������"}
    ends^.next:=nil; {�� �������� "��������" ���������}
  end;
  ends^.data:=znach1; {������� ������}
end;
 
procedure AddElemVst(var nach:List; var ends:List;znach1:TInf);
var
  tmp,tmpL:List;
  flag:boolean;
begin
  if nach=nil then {�� ���� �� ������, ���� ����, ��}
  begin
    Getmem(nach,SizeOf(TList)); {������ �������, ��������� nach ��� ����� ����� �����}
    nach^.next:=nil; {������� �� �������� "��������" ���������}
    nach^.prev:=nil; {����������}
    ends:=nach; {�������� ��������� ����� ������}
    tmp:=nach;
  end
  else {���� ������ �� ����}
  begin
    tmpl:=nach;
    flag:=true;
    while tmpl^.data<znach1 do
    begin
      tmpl:=tmpl^.next;
      if tmpl=nil then
        break;
    end;
    if tmpl<>nil then
    begin
      tmpl:=tmpl^.prev;
      if tmpl=nach then
        flag:=false;
      if tmpl=nil then
        tmpl:=nach;
    end
    else
    begin
      tmpl:=ends;
      flag:=false
    end;
    GetMem(tmp,SizeOf(TList));
    if ends=nach then
      if ends^.data<znach1 then
      begin
        ends^.next:=tmp;
        tmp^.prev:=ends;
        tmp^.next:=nil;
        ends:=tmp;
      end
      else
      begin
        nach^.prev:=tmp;
        tmp^.prev:=nil;
        tmp^.next:=nach;
        nach:=tmp;
      end
    else
    if (tmpl=nach) and (flag) then
    begin
      nach^.prev:=tmp;
      tmp^.prev:=nil;
      tmp^.next:=nach;
      nach:=tmp;
    end
    else
      if (tmpl=nach) and not(flag) then
      begin
        tmp^.next:=nach^.next;
        nach^.next^.prev:=tmp;
        tmp^.prev:=nach;
        nach^.next:=tmp;
      end
      else
      if (tmpL=ends) and not (flag) then
      begin
        ends^.next:=tmp;
        tmp^.prev:=ends;
        tmp^.next:=nil;
        ends:=tmp;
      end
      else
      begin
        tmp^.next:=tmpl^.next;
        tmpl^.next^.prev:=tmp;
        tmp^.prev:=tmpl;
        tmpl^.next:=tmp;
      end;
  end;
  tmp^.data:=znach1; {������� ������}
end;
 
{��������� ������ ������
��������� ��������� ��� ������ �� ������}
procedure Print(spis1:List);
begin
  if spis1=nil then
  begin
    writeln('������ ����.');
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
 
{������� ������ � ������
 ��������� ��������� ��� ������ �� ������}
Function SearchElemZnach(spis1:List;znach1:TInf):List;
begin
  if spis1<>nil then
    while (Spis1<>nil) and (znach1<>spis1^.data) do
      spis1:=spis1^.next;
  SearchElemZnach:=spis1;
end;
 
{��������� �������� �������� � ��������������� ������}
Procedure DelElem(var spis1,spis2:List;tmp:List);
var
  tmpi:List;
begin
  if (spis1=nil) or (tmp=nil) then
    exit;
  if tmp=spis1 then {���� ��������� ������� ������ � ������, ��}
  begin
    spis1:=tmp^.next; {��������� �� ������ ������� ������������ �� ��������� ������� ������}
    if spis1<>nil then {���� ������ �������� �� �� ������ ��������, ��}
      spis1^.prev:=nil {"��������" ���������}
    else {� ������, ���� ������� ��� ����, ��}
      spis2:=nil; {"��������" ��������� ����� ������, � ��������� ������ ��� "������"}
    FreeMem(tmp,SizeOf(TList));
  end
  else
    if tmp=spis2 then {���� ��������� ������� �������� ��������� ��������� ������}
    begin
      spis2:=spis2^.prev; {��������� ����� ������ ������������ �� ���������� �������}
      if spis2<>nil then {���� ���������� ������� ����������,��}
        spis2^.next:=nil {"��������" ���������}
      else {� ������, ���� ������� ��� ���� � ������, ��}
        spis1:=nil; {"��������" ��������� �� ������ ������}
      FreeMem(tmp,SizeOf(TList));
    end
    else {���� �� ��������� ������ �� �� ������ � �� �� �����, ��}
    begin
      tmpi:=spis1;
      while tmpi^.next<>tmp do {������ ��������� tmpi �� ������� ����� ���������}
        tmpi:=tmpi^.next;
      tmpi^.next:=tmp^.next; {������ �����}
      if tmp^.next<>nil then
        tmp^.next^.prev:=tmpi; {� �������� �� ���������� � ����� ����}
      FreeMem(tmp,sizeof(TList));
    end;
end;
 
{��������� �������� �������� �� ��������
 ��������� ��������� ��� ������ �� ������}
procedure DelElemZnach(var Spis1,spis2:List;znach1:TInf);
var
  tmp:List;
begin
  if Spis1=nil then
  begin
    Writeln('������ ����');
    exit;
  end;
  tmp:=SearchElemZnach(spis1,znach1);
  if tmp=nil then
  begin
    writeln('������� � ������� ��������� ' ,znach1, ' ����������� � ������.');
    exit;
  end;
  DelElem(spis1,spis2,tmp);
  Writeln('������� �����.');
end;
 
{��������� �������� �������� �� �������
 ��������� ��������� ��� ������ �� ������}
Procedure DelElemPos(var spis1,spis2:List;posi:integer);
var
  i:integer;
  tmp:List;
begin
  if posi<1 then
    exit;
  if spis1=nil then
  begin
    Write('������ ����');
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
    Writeln('�������� � ���������� ������� ' ,posi, ' ��� � ������.');
    writeln('� ������ ����� ' ,i-1, ' ���������.');
    exit
  end;
  DelElem(spis1,spis2,tmp);
  Writeln('������� �����.');
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
 
{��������� ���������� "���������" � ���������� ������ �������}
{����� ����������� ��� ��� �������� ��� ����� ����������� ������
 � �������� ������ � ������� ����� ����������. ����������� �������
 �� ���, ��� ���������� � ���������, ��������� �� � �� ���� ������}
procedure SortBublLink(var nach,ends:List);
var
  tmp,pocle1,rab:List;
begin
  rab:=nach;
  while rab<>nil do
  begin
    tmp:=rab^.next;
    while tmp<>nil do
    begin
      if tmp^.data<rab^.data then
      begin
        pocle1:=tmp^.next;
        if rab^.next=tmp then
        begin
          if tmp^.next<>nil then
            tmp^.next^.prev:=rab;
          tmp^.next:=rab;
          tmp^.prev:=rab^.prev;
          if tmp^.prev<>nil then
            tmp^.prev^.next:=tmp;
          rab^.prev:=tmp;
          rab^.next:=pocle1;
        end
        else
        begin
          if rab^.prev<>nil then
            rab^.prev^.next:=tmp;
          tmp^.prev^.next:=rab;
          if tmp^.next<>nil then
            tmp^.next^.prev:=rab;
          rab^.next^.prev:=tmp;
          tmp^.next:=rab^.next;
          rab^.next:=pocle1;
          pocle1:=rab^.prev;
          rab^.prev:=tmp^.prev;
          tmp^.prev:=pocle1;
        end;
        if rab=nach then
        begin
          nach:=tmp;
          nach^.prev:=nil;
        end;
        if tmp=ends then
        begin
          ends:=rab;
          ends^.next:=nil
        end;
        pocle1:=rab;
        rab:=tmp;
        tmp:=pocle1;
      end;
      tmp:=tmp^.next;
    end;
    rab:=rab^.next;
  end;
end;
 
{��������� ���� ����� ������ � ��������� � ������ ������� ������}
Procedure Swap(var nach,ends:List;a,b,c:integer); {�-������ �����, b-����� �����, �-�������}
var
  i:integer;
  yk,yk1,yk2,rab:List;
begin
  rab:=nach;
  i:=0;
  while rab<>nil do {���� ���������� ���������� ���������}
  begin
    inc(i);
    rab:=rab^.next
  end;
 {�������� �� "������������" �������� ������}
  if (i+1<a) or (i+1<b) or (i+1<c) or ((c>=a) and (c<=b)) then
    exit;
  if a>b then {���� "��������" ������� ������ � ����� �����, ��}
  begin
    a:=a xor b; {��������� ������ ����������, �.�.}
    b:=b xor a; {�������� �� a �������� � b}
    a:=b xor a; {�� b �������� � a}
  end;
  yk:=nach;
  for i:=1 to a-1 do
    yk:=yk^.next; {������ ��������� �� ������ ��� �������}
  yk1:=nach;
  for i:=1 to b-1 do
    yk1:=yk1^.next;{������ ��������� �� ������ ��� �������}
  yk2:=nach;
  for i:=1 to c-1 do
    yk2:=yk2^.next;{������ ��������� �� ������ ��� �������}
  if yk=nach then {��������� ������� �� ��� �������� ������ ������}
  begin
   nach:=yk1^.next; {�������� ������}
   nach^.prev:=nil; {"��������" ���������}
  end
  else {����� � ������� �������� �� ��������}
  begin
    if yk1^.next<>nil then
      yk1^.next^.prev:=yk^.prev
    else
    begin
      ends:=yk^.prev;
      yk^.prev^.next:=nil;
    end;
    yk^.prev^.next:=yk1^.next;
  end;
  if yk2^.next=nil then
  begin
    yk1^.next:=nil;
    ends:=yk1;
  end
  else
  begin
    yk2^.next^.prev:=yk1;
    yk1^.next:=yk2^.next;;
  end;
  yk2^.next:=yk;
  yk^.prev:=yk2;
end;
 
var
  SpisNach, {��������� �� ������ ������ �}
  SpisEnd,   {��������� �� ����� ������. ��� ��� ��������� }
  tmpl:List; {������������ ����� � ��������������� ������}
  znach,a,b:integer;
  ch:char;
begin
  SpisNach:=nil;
  SpisEnd:=nil;
  repeat
    clrscr;
    Write('��������� ��� ������ � ');
    TextColor(4);
    Writeln('��������������� �������.');
    TextColor(7);
    Writeln('�������� �������� ��������:');
    Writeln('1) �������� �������.');
    Writeln('2) ����� ������.');
    Writeln('3) �������� ��������� �� ��������.');
    Writeln('4) �������� ��������� �� ����������� ������.');
    Writeln('5) ����� ��������� �� ��������.');
    Writeln('6) ���������� ������ ������� "��������", ����� ������ ������.');
    Writeln('7) ���������� ������ � ���������� �������.');
    Writeln('8) Swap ������.');
    Writeln('9) �����.');
    writeln;
    ch:=readkey;
    case ch of
      '1':begin
            write('������� �������� ������������ ��������: ');
            readln(znach);
            AddElemVst(SpisNach,SpisEnd,znach);
            {AddElem(SpisNach,SpisEnd,znach);}
          end;
      '2':begin
            clrscr;
            Print(SpisNach);
            readkey;
          end;
      '3':begin
            Write('������� �������� ���������� ��������: ');
            readln(znach);
            DelElemZnach(SpisNach,SpisEnd,znach);
            readkey;
          end;
      '4':begin
            Write('������� ���������� ����� ���������� ��������: ');
            readln(znach);
            DelElemPos(SpisNach,SpisEnd,znach);
            readkey;
          end;
      '5':begin
            write('������� �������� �������� ��������: ');
            readln(znach);
            tmpl:=SearchElemZnach(SpisNach,znach);
            if tmpl=nil then
              write('������� ������� ����������� � ������.')
            else
            begin
              write('������� ');
              TextColor(4);
              Write(tmpl^.data);
              TextColor(7);
              Write(' ������');
            end;
            readkey;
          end;
      '6':begin
            if SpisNach=nil then
            begin
              Write('������ ����.');
              readkey
            end
            else
            begin
              SortBublInf(SpisNach);
              Write('������ ������������.');
              readkey;
            end
          end;
      '7':begin
            if SpisNach=nil then
            begin
              Write('������ ����.');
              readkey
            end
            else
            begin
              SortBublLink(SpisNach,SpisEnd);
              Write('������ ������������.');
              readkey;
            end
          end;
      '8':begin
            Writeln('������ �� ���������:');
            print(SpisNach);
            writeln;
            write('������� ��������� �������: ');
            readln(a);
            Write('������� �������� �������: ');
            readln(b);
            write('������� ����� ���� ���������: ');
            readln(znach);
            Writeln;
            swap(SpisNach,SpisEnd,a,b,znach);
            writeln;
            Writeln('������ ����� ���������:');
            print(SpisNach);
            readkey;
          end;
    end;
  until ch='9';
  FreeStek(SpisNach);
end.