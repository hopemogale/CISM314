{---------------------------------------------------------------}
{ Parse and Translate an Expression }
procedure Expression;
begin
Term;
EmitLn('MOVE D0,D1');
case Look of
'+': Add;
'-': Subtract;
else Expected('Addop');
end;
end;
{--------------------------------------------------------------}
Next, just above Expression enter these two procedures:
{--------------------------------------------------------------}
{ Recognize and Translate an Add }
procedure Add;
begin
Match('+');
Term;
EmitLn('ADD D1,D0');
end;
{-------------------------------------------------------------}
{ Recognize and Translate a Subtract }
procedure Subtract;
begin
Match('-');
Term;
EmitLn('SUB D1,D0');
end;
{-------------------------------------------------------------}