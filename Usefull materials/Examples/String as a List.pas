�������� ������

������ �������� ������
Type ukazat= ^ S;
   S= record
      Inf: integer;
      Next: ukazat;
   End;
� ������� ���������� �������� �������: ����� �������������� ������-���� ������� �� ������ ���� ������. ���������� ������� ���� ��� ����������, ������� ����� ��������� �� ��� �� ����������� ���.

������������ ������
����� ������ �����������, ���� ���������� ��������� �� ��� ������.
������ �������� ������

Type ukazat= ^S; 
   S= record 
      Inf: integer; 
      Next: ukazat; 
   End;

�������� ������ ������� ������:
New (u); {�������� ����� � ������}
u^. Next:= nil; {��������� ����}
u^. Inf:=3;
��������� ������������ ������. ��� ����� ����� �������� ������� ���� � ����� ������, ���� � ������.

�) ������� ������� � ������ ������. ��� ����� ���������� ��������� ������������������ ��������:
�������� ������ ��� ������ ��������; ��������� ���� ����������; ������������ ������� � ������ ������.
New(x); 
Readln(x^.Inf); 
x^. Next:= u; 
u:= x;

�)���������� �������� � ����� ������. ��� ����� ������ ��������������� ����������, ������� ����� ������� ����� ���������� ��������. ����� ��� ����� ��������� � ������ hv (�����).
x := hv;
New(x^. next); { �������� ������ ��� ���������� �������� }
x := x^.next; 
x^.next := nil; 
x^.inf := 5; 
hv := x;

�������� ������
While u <> nil do
Begin
Writeln (u^.inf);
u:= u^.next;>
end;


�������� �������� �� ������
�)�������� ������� ��������. ��� ����� �� ��������������� ��������� �������� ������ �������, ��������� �� ������ ������ ���������� �� ��������� ������� ������ � ��������� ������� ������������ ������, �� ������� ��������� ��������������� ���������.
x:= u; 
u:= u^.next; 
dispose(x);

�) �������� �������� �� �������� ������. ��� ����� ����� ����� ������ ���������� �������� � ��������, �������� ����� ���. ��������, ��� digit � ��� �������� ���������� ��������.
x:= u; 
while ( x <> nil) and ( x^.inf <> digit) do 
begin 
dx := x; 
x  := x^.next; 
end; 
dx^.next := x^.next: 
dispose(x);

�)�������� �� ����� ������. ��� ����� ����� ����� ������������� �������.
x:= u; dx:= u; 
while x^.next <> nil do 
begin 
dx := x;
x  := x^.next; 
end; 
dx^.next:= nil; 
dispose(x);


����������� ������. ����� ����� ���������� �������� ������, �������� ��� ���� �����-���� ��������. ����� ���������� ����� ����� ��������� ������.

summa:= 0; 
x:= u; 
while x <> nil do 
begin 
summa := summa + x^.inf; 
x := x^.next; 
end;

������������ ������� ������� ���������

������������� ���������������� ������� ��� ������� ���� ����� ����� ������� ������������ ���������. ���� � ���, ��� �� ����������������� ������ ����� ��������� ������ � ����� �����������, �� ������ ������ � ���������� �����. ����� ��� ������� ��������� ������������� ���������� �����-���� �������� � ���������, �������������� �������� � �������� ���������. ������ ����� ���������� �������� � ������ ��������� � ���������������� ������ � ��� ��� ����������� �������� ������� � ������� ������ ������� � ����������� ��������.

��� ���������� ����� ���������� ������� � ������ ����� ������ ��� ���� ����, ��������� �������� ����� ������ �� ���������� �����.

Type ukazat= ^S; 
S= record 
Inf: integer; 
Next: ukazat; 
Pred: ukazat; 
End;
������������ ���������, ��������� �� ������� ������ ����, ���������� ��������������� �������, ������� ���������� ����� ���������� ���:

������� � ������ ����� ���������������� ������ ������ ��� �� ���������, ��� � �� ���������� ����� ��������� �� ������� ����� ��������� �� ������ � ����� �����������. �� �������� � ���������������� ������� ����� ���� ��������� �����. � ���� Pred ����� ����� ���������� ������ ������ nil, �����������������, ��� � ���������� ����� ��� ����������� (��� ��, ��� � ���������� ��� ����������).

� ���������������� ��������������� ������ ����� �������� ��������� �������: � �������� �������� ���� Next ���������� ����� ��������� ������ �� ��������� �����, � � �������� �������� ���� Pred ���������� ����� � ������ �� ��������� �����:

��� �����, ����� ������ ���������� � ������������ �������: �������� �� �������, ����� �� ���������� ����� ���������� � ���������� �����, � ��� �������� � �������� ����������� � �� ���������� ����� ���������� � ����������. ������ ��������� ���� �������� ���������� ��������.