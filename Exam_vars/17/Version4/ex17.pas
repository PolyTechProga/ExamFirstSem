program ex17;
uses crt;

type
    a = ^elem;
    dan = record       
        num: integer;
        name: string;   
    end;
    elem = record
      tp: dan;
      sled: a;
    end;
    t = file of dan;

var
ukstr1,ukstr2,golova: a;
f0: text;
f: t;

procedure P1(var f1: t; var ff: text); {�⥭�� � ⨯���஢����}
var
buf: dan;
begin
while not eof(ff) do begin;
read(ff,buf.num); readln(ff,buf.name);   {��⠥� �� ����}
write(f1,buf);                           {������ 楫����}
end;
end;

procedure P2(var f1: t;var head: a);
var
buf: dan;
uksp: a;          {�������� ������ ᯨ᪠}
temp: a;
begin
new(uksp);                {������ ���� ���⮩ � ��᫥���� ���⮩}
head:=uksp;
new(uksp^.sled);
uksp^.sled^.sled:=nil;
while not eof(f) do begin
uksp:=head;
new(temp);        {������� ���� ����� � �⠥� � ���� ����}
read(f1,buf);     {�����뢠�� ����� ��� ������ 楫����}
temp^.tp:=buf;
while (uksp^.sled^.tp.name < temp^.tp.name) and (uksp^.sled^.sled<> nil) do
 uksp:=uksp^.sled;                  {����� ���� ���� ��� ������ �����}
 temp^.sled:=uksp^.sled;   {��� ��諨 - ��⠢�塞 ��� 㪠��⥫ﬨ}
 uksp^.sled:=temp;
end;
end;

procedure P4(var head1,head2,sim: a);  {���ﭨ� � ��騩 ᯨ᮪}
var                          {sim - ������ �� ��騩 ᯨ᮪}
uksp1,uksp2: a;
ukzv: a;
begin
new(ukzv);      {������� � ��饬 ���� ���⮩}
sim:=ukzv;
uksp1:=head1^.sled;   {�⠢�� � ᯨ᪠� �� ����}
uksp2:=head2^.sled;
while (uksp1^.sled<>nil) or (uksp2^.sled<>nil) do begin   {���� ��� ᯨ᪠ }
      new(ukzv^.sled);                                  {�� �������}
      ukzv:=ukzv^.sled;
      if (uksp1^.sled=nil) or (uksp2^.sled=nil) then begin
         if uksp1^.sled = nil then begin    {�᫨ ���� ���稫��, � }
            ukzv^.tp:=uksp2^.tp;
            uksp2:=uksp2^.sled; end         {������ ���� ⮫쪮 �� ��㣮��}
         else begin
            ukzv^.tp:=uksp1^.tp;
            uksp1:=uksp1^.sled; end;
      end
      else begin                  {�᫨ ��� �� �� ���稫���, �}
           if uksp1^.tp.name < uksp2^.tp.name then begin
              ukzv^.tp:=uksp1^.tp;
              uksp1:=uksp1^.sled; end       {�ࠢ������ ������ � �롨ࠥ�}
           else begin
                ukzv^.tp:=uksp2^.tp;
                uksp2:=uksp2^.sled; end;
      end;
end;
new(ukzv^.sled);             {��᫥���� ᮧ����� �����}
ukzv^.sled^.sled:=nil;
end;

procedure P5(var head: a;var ff: text);
var
uksp: a;                            {�뢮� ᯨ᪠ � 䠩�}
begin
uksp:=head^.sled;
while uksp^.sled<>nil do begin
writeln(ff,uksp^.tp.num,uksp^.tp.name);
uksp:=uksp^.sled;
end;
end;


begin
assign(f0,'rez.out');
rewrite(f0);
close(f0);
clrscr;
{---}
assign(f0,'v1.inp');
reset(f0);
assign(f,'o1.tip');
rewrite(f);
P1(f,f0);
close(f0);
close(f);
{---}
assign(f0,'v2.inp');
reset(f0);
assign(f,'o2.tip');
rewrite(f);
P1(f,f0);
close(f0);
close(f);
{---}
assign(f,'o1.tip');
reset(f);
P2(f,ukstr1);
close(f);
{---}
assign(f,'o2.tip');
reset(f);
P2(f,ukstr2);
close(f);
{---}
assign(f0,'rez.out');
append(f0);
writeln(f0,'  ���� ᯨ᮪:');
P5(ukstr1,f0);
writeln(f0);
close(f0);
{---}
assign(f0,'rez.out');
append(f0);
writeln(f0,'  ��ன ᯨ᮪:');
P5(ukstr2,f0);
writeln(f0);
close(f0);
{---}
P4(ukstr1,ukstr2,golova);
{---}
assign(f0,'rez.out');
append(f0);
writeln(f0,'  ��騩 ᯨ᮪:');
P5(golova,f0);
writeln(f0);
close(f0);
{---}
writeln('Done');
readkey;
end.