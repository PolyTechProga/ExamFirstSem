{
� readData ����������� ����������� ������� ������ �� ��������:

Pos(subS, s) -���������� ������ ������� ��������� ���������(subS) � ������(s).
���������� ������ ���������, ��� -1, ���� ��� ���������.

Copy(s, start, len) - ���������� ��������� ������ len, ������ � ������� strat � ������ s

Length(s) - ����� ������
}


uses
Crt;

type

elPtr = ^element_t; {��� ��������� �� ������� ������}

{������� ����������� ������}
element_t = record
  number : integer; {����� �����}
  autor : string; {�����}
  name : string; {�������� �����}
  
  next, prev : elPtr;
end;


var

{������ ������������� input/output, ����� ����� ����������� ������ �� �����}
op : text; {��� ������ � ��������� ����}
inp : text; {��� ����� �� ���������� �����}

pHead : elPtr; {��������� �� �������� ������� ������}
{������ ����� 2 ���������� ��������: � ������ � ������}


{������� �������� � ������ �� ������}
procedure insertElement(head : elPtr; number : integer; name, autor : string);
var
  newEl : elPtr; {����������� �������}
begin
{������ �� ������, ����� ����� �������}
  while head^.next^.next <> nil do
  begin
  {���� ����� ����� ������� - �������� ���� (head ��������� �� ������ �����)}
    if head^.next^.number > number then break;
    
    head := head^.next;
  end;
      
  {����� ���������� ���������� �������� head ��������� �� ����� �������}
  new(newEl); {������� �������}
  
  newEl^.next := head^.next; {������ � ��������� ���������}
  head^.next^.prev := newEl;
  
  newEl^.prev := head; {� � �������}
  head^.next := newEl;
  
  newEl^.number := number; {���������� ����� (������� �����������!)}
  newEl^.name := name;
  newEl^.autor := autor;
end;


{P1}
{������ ������ �� �����, ����������� ������ � �����������}
procedure readData(head : elPtr);
var
  num : integer;
  str : string;
  chr : char;
  name, autor : string;
  commaIndex : integer; {������ ������� � ������ str}
begin

  while not eof(inp) do
  begin
    readLn(inp, num, chr, chr, str); {��������� ������ � ������}
    {� �������� 2 ������ ������� -��� ������ � �������}
    {�.�. � num - �����, � � str - ������ � ��������� � ������� (������������ ����� �������)}
    
    commaIndex := Pos(',' , str); {�������� ������ ������� ����� ������ � ���������}
    
    autor := Copy(str, 1, commaIndex - 1); {������ ��������� � �������}
    name := Copy(str, commaIndex + 1, Length(str) - commaIndex); {������ ��������� � ������ �����}

    insertElement(head, num, name, autor); {�������� ������� � ������}
  end;
end;


{P2}
{������ �������� � ����� ������� ��� ������}
procedure readRecord(head : elPtr);
var
  num : integer;
  str : string;
  chr : char;
  name, autor : string;
  commaIndex : integer; {������ ������� � ������ str}
begin
  readLn(num, chr, chr, str); {��������� ������� � ����������}
  
  {������ ������:}
  commaIndex := Pos(',' , str); {�������� ������ ������� ����� ������ � ���������}
    
  autor := Copy(str, 1, commaIndex - 1); {������ ��������� � �������}
  name := Copy(str, commaIndex + 1, Length(str) - commaIndex); {������ ��������� � ������ �����}

  insertElement(head, num, name, autor); {�������� ������� � ������}
end;


{P3}
{����� ������ � ��������� ����}
procedure list_print(head : elPtr; direction : boolean); {direction - ������ �����������}
begin
  head := head^.next;
  
  {���� ������� ������ � ����� - ������ � �����}
  if not (direction) then
    while head^.next^.next <> nil do
      head := head^.next;
  
  while true do
  begin
  {�������� ������� ������ �� ����� � ����������� �� ����������� �������}
    if direction and (head^.next = nil) then break;
    if not (direction) and (head^.prev = nil) then break;
  
    writeLn(op, head^.number, ' ,', head^.autor, ' ,', head^.name);
    
    {����� ����������� �������}
    if direction then
    begin
      head := head^.next;
    end
    else begin 
      head := head^.prev;
    end;
  end;
  
  writeLn(op);
end;


{P4}
{����� ���� ���� ��������� ������}
procedure list_printAutor(head : elPtr; autor : string);
begin
  head := head^.next;
  
  while(head^.next <> nil) do
  begin
  {���� � ��������� ����� ����� ������ � ��������� - �������}
    if head^.autor = autor then
      writeLn(op, head^.number, ' ,', head^.autor, ' ,' , head^.name);
  
    head := head^.next;
  end;
end;



begin
  ClrScr; {�������� ����� ������ (��� �� Crt)}

  assign(inp, 'dan1.inp');
  assign(op, 'res1.out');
  
  reset(inp);
  rewrite(op);
  
  {������� �������� � ��������� �������� (�� ��������� ��������. ������ ����� ����)}
  new(pHead);
  new(pHead^.next);
  pHead^.prev := nil;
  pHead^.next^.next := nil;
  pHead^.next^.prev := pHead;
  
  
  readData(pHead); {��������� ������ ������ ���� �� �����}
  
  readRecord(pHead); {���� � ���������� ������}
  
  list_print(pHead, true); {������� ������ ������ ��������}
  list_print(pHead, false); {� ��������}
  
  list_printAutor(pHead, ' aaaa '); {������� ����� ������ aaaa (��� ��� =)}
  
  close(inp);
  close(op);

end.