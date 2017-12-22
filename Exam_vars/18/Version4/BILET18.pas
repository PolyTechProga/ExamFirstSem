program bilet18;
uses crt;

type

pbook=^tbook;
tbook=record
  number:string[3];
  author:string[10];
  name:string[10];
  god:string[4];
  cena:real;
  next1,next2:pbook;
    end;

var
inp,out:text;
head,tail:pbook;
symb:char;

procedure sort_list(var head,first:pbook);
var
sorted,tmp:pbook;


begin
sorted:=first;
                      while (sorted^.next2<>nil)
                      and (head^.number>sorted^.next2^.number)
                      do begin
                         sorted:=sorted^.next2;
                         {writeln('head = ',head^.number,' sorted = ',sorted^.number);}
                         end;
                      tmp:= sorted^.next2;
                      sorted^.next2:=head;
                      head^.next2:=tmp;

end;



procedure read_from_file(var inp:text; var head,tail:pbook);
var
tmp,next,first,sorted:pbook;
space:char;

begin
first:=head;
reset(inp);
while not eof(inp) do begin
                      new(head^.next1);
                      head:=head^.next1;
                      with head^ do readln(inp,number,space,author,space,name,space,god,space,cena);
                      sort_list(head,first);
                       end;
head^.next1:=nil;
tail:=head;
head:=first;

end;


procedure write_head_1(var out:text; head:pbook);


begin
append(out);
writeln(out);
writeln(out,'�뢮� ᯨ᪠ � ���浪�, ��� � 䠩��');
while head<>nil do begin
                   with head^ do
                   {writeln(number,' ',author,' ',name,' ',god,' ',cena:5:2);}
                   writeln(out,number,' ',author,' ',name,' ',god,' ',cena:5:2);
                   head:=head^.next1;
                   end;
close(out);
end;

procedure write_head_2(var out:text; head:pbook);


begin
append(out);
writeln(out);
writeln(out,'�뢮� ᯨ᪠ � ���浪� �����⠭�� ����஢');
while head<>nil do begin
                   with head^ do
                   {writeln(number,' ',author,' ',name,' ',god,' ',cena:5:2);}
                   writeln(out,number,' ',author,' ',name,' ',god,' ',cena:5:2);
                   head:=head^.next2;
                   end;
close(out);
end;


procedure add_rec(var head:pbook);
var first:pbook;

begin
first:=head;
while head^.next1<>nil do head:=head^.next1;
new(head^.next1);
head:=head^.next1;
head^.next1:=nil;
writeln('������ ����� �����');
readln (head^.number);
writeln('������ 䠬���� ����');
readln (head^.author);
writeln('������ �������� �����');
readln (head^.name);
writeln('������ ��� �������');
readln (head^.god);
writeln('������ 業� �����');
readln (head^.cena);
sort_list(head,first);
head:=first;
end;

procedure find_book(head:pbook);
var
author:string[10];
success:boolean;

begin
append(out);

write('������ 䠬���� ����, ����� ���ண� ��� ����.');
writeln('������� ������ ᮤ�ঠ�� 10 ᨬ�����. �᫨ 䠬���� ����, �������騥 ᨬ���� �������� �஡�����');
readln(author);
writeln(out);
writeln(out,'�� �᪠�� ����� ����: ',author);
success:=false;
while head<>nil do begin
                   if head^.author=author then begin
                                               success:=true;
                   writeln(out,head^.number,' ',head^.author,' ', head^.name,' ',head^.god,' ',head^.cena:5:2);
                                               end;
                   head:=head^.next1;
                   end;
if success=false then writeln(out,'� ��� ��� ���� �⮣� ����');
close(out);
end;

procedure choose_write(var out:text; head:pbook);

var
symb:char;

begin
write('������ F, �᫨ ��� �뢥�� ᯨ᮪ � ���浪� ��� � 䠩��, ��� ');
writeln('������ A, �᫨ ��� �뢥�� ᯨ᮪ � ���浪� �����⠭�� ����஢');
readln(symb);
if (symb='A') or (symb = 'a') then write_head_2(out,head^.next2)
else if (symb='F') or (symb = 'f') then write_head_1(out,head^.next1)
else writeln('�� �� ��ࠫ� � ����� ���浪� �뢮��� ᯨ᮪. ᯨ᮪ �� �㤥� �뢥���');
end;



begin
clrscr;
assign(inp,'in.inp');
assign(out,'ou.out');
rewrite(out);
close(out);
new(head);
head^.next1:=nil;
head^.next2:=nil;
head^.number:='000';
head^.author:='';
head^.name:='';
head^.god:='';
head^.cena:=0;
read_from_file(inp,head,tail);
choose_write(out,head);
add_rec(head);
choose_write(out,head);
find_book(head^.next1);
end.