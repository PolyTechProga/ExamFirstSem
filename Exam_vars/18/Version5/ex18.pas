program bilet18;
uses crt;

type
    a =^dan;
    dan=record
      num: integer;
      data: string;
      next: a;
      sort: a;
    end;

var
ukstr: a;
c1: integer;

procedure making(var head: a);
var
ukzv: a;
f: text;
work,pered,mu,posle,before: a;   {㪠��⥫� ��� ���஢��}
beg: a;                          {work - ࠡ�稩, mu - ���������}
begin                            {before - ��। mu, posle - �� mu}
assign(f,'vhod.inp');            {pered - ��। work, beg - ����騩}
reset(f);
new(ukzv);
head:=ukzv;
while not eof(f) do begin
new(ukzv^.next);
ukzv^.sort:=ukzv^.next;       {���� ᮧ����� ᯨ᪠ � ���� � ���. �����}
ukzv:=ukzv^.next;             {㪠��⥫� sort �⠢�� ���� �� ���浪�}
read(f,ukzv^.num);
readln(f,ukzv^.data);
end;
new(ukzv^.next);
ukzv^.sort:=ukzv^.next;
ukzv^.next^.next:=nil;
ukzv^.sort^.sort:=nil;

ukzv:=head;
while ukzv^.sort<>nil do begin   {��稭��� ���஢��}
      pered:=ukzv;
      ukzv:=ukzv^.sort;          {����⠢�塞 㪠��⥫� ��� ��砫� �஡���}
      work:=ukzv;
      mu:=ukzv;
      beg:=ukzv;
      while beg^.sort<>nil do begin
      if beg^.data < mu^.data then    {����� �� ���� � �饬 ���������}
      mu:=beg;
      beg:=beg^.sort;
      end;
      if mu<>work then begin      {�᫨ ��諨, � ������ ᬥ��}
      posle:=mu^.sort;            {�⠢�� posle}
      before:=head;
      while before^.sort<>mu do   {�饬 before}
      before:=before^.sort;
      pered^.sort:=before^.sort;  {����⠢�塞 3 㪠��⥫�!!}
      mu^.sort:=work;
      before^.sort:=posle;
      end;
pered:=pered^.sort;    {���室�� �� ���⠢����� ���������}
ukzv:=pered;           {� ⠪ �� ���� ���஢������ ᯨ᪠ sort}
end;
end;

procedure adding(var head: a);
var
ukzv: a;
buf: a;
begin
new(buf);
writeln('������� ������. ����� �஡���� � �������� ������ ���� _ :');
read(buf^.num);     {�⠥� ����� ������ � ���� �����}
read(buf^.data);
ukzv:=head^.next;
while ukzv^.next^.next<>nil do
ukzv:=ukzv^.next;          {�⠢�� ��� � ����� ���筮�� ᯨ᪠ }
buf^.next:=ukzv^.next;
ukzv^.next:=buf;

ukzv:=head;
while (ukzv^.sort^.data < buf^.data) and (ukzv^.sort^.sort<>nil) do
ukzv:=ukzv^.sort;           {�饬 ��� ���� � ���஢����� ����}
buf^.sort:=ukzv^.sort;
ukzv^.sort:=buf;
end;

procedure vivod(var head: a; c: integer);
var
uksp: a;
f: text;
begin
assign(f,'rez.out');               {���� �뢮� �� ���浪�, � ��⮬ ���.}
if c=0 then begin
rewrite(f);
writeln(f,'��室�� �����__:');
end
else begin
append(f);
writeln(f,'���� �����__:');
end;
writeln(f,'  �� ���浪�:');
uksp:=head^.next;
while uksp^.next<>nil do begin
write(f,uksp^.num:3);
writeln(f,uksp^.data);
uksp:=uksp^.next;
end;
writeln(f);
writeln(f,'  �� ��䠢���:');
uksp:=head^.sort;
while uksp^.sort<>nil do begin
write(f,uksp^.num:3);
writeln(f,uksp^.data);
uksp:=uksp^.sort;
end;
writeln(f);
close(f);
end;

begin
clrscr;
making(ukstr);
c1:=0;
writeln('���᮪ ᤥ���');
vivod(ukstr,c1);
writeln('���᮪ �뢥��� � 䠩�');
c1:=1;
adding(ukstr);
vivod(ukstr,c1);
writeln('���� 䠩�� �뢥����');
readkey;
end.
