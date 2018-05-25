{---------------------------------------------------------------}
{ Parse and Translate a Math Factor }
procedure Factor;
begin
 EmitLn('MOVE #' + GetNum + ',D0')
end;
{--------------------------------------------------------------}
{ Recognize and Translate a Multiply }
procedure Multiply;
begin
 Match('*');
 Factor;
 EmitLn('MULS (SP)+,D0');
end;
{-------------------------------------------------------------}
{ Recognize and Translate a Divide }
procedure Divide;
begin
 Match('/');
 Factor;
 EmitLn('MOVE (SP)+,D1');
 EmitLn('DIVS D1,D0');
end;
{---------------------------------------------------------------}
{ Parse and Translate a Math Term }
procedure Term;
begin
 Factor;
 while Look in ['*', '/'] do begin
 EmitLn('MOVE D0,-(SP)');
 case Look of
 '*': Multiply;
 '/': Divide;
 else Expected('Mulop');
 end;
 end;
end;
{--------------------------------------------------------------}
{ Recognize and Translate an Add }
procedure Add;
begin
 Match('+');
 Term;
 EmitLn('ADD (SP)+,D0');
end;
{-------------------------------------------------------------}
{ Recognize and Translate a Subtract }
procedure Subtract;
begin
 Match('-');
 Term;
 EmitLn('SUB (SP)+,D0');
 EmitLn('NEG D0');
end;
{---------------------------------------------------------------}
{ Parse and Translate an Expression }
procedure Expression;
begin
 Term;
 while Look in ['+', '-'] do begin
 EmitLn('MOVE D0,-(SP)');
 case Look of
 '+': Add;
 '-': Subtract;
 else Expected('Addop');
 end;
 end;
end;
{--------------------------------------------------------------}

{The last part is for allowing parenthesis}

{---------------------------------------------------------------}
{ Parse and Translate a Math Factor }
procedure Expression; Forward;
procedure Factor;
begin
 if Look = '(' then begin
 Match('(');
 Expression;
 Match(')');
 end
 else
 EmitLn('MOVE #' + GetNum + ',D0');
end;
{--------------------------------------------------------------}
