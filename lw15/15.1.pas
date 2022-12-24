PROGRAM CountThree(INPUT, OUTPUT);    
USES 
	Count3;
VAR 
  X100, X10, X1: CHAR;
  Prev, Ch, Next: CHAR;

BEGIN {CountThem} 
  {Initialization}
  Start;
  IF NOT EOLN THEN READ(Prev);
  IF NOT EOLN THEN READ(Ch);
  IF NOT EOLN THEN READ(Next);
  {Process first 3 symbols}
  IF((Ch > Prev) AND (Ch > Next)) OR ((Ch < Prev) AND (Ch < Next))
	THEN 
      Bump;
  {Process other data}
  WHILE NOT EOLN              
  DO
    BEGIN   
      Prev := Ch;
      Ch := Next;
      READ(Next);
      IF((Ch > Prev) AND (Ch > Next)) OR ((Ch < Prev) AND (Ch < Next))
      THEN 
        Bump
    END;
  {Print result}
  Value(X100, X10, X1);
  WRITELN('Result: ', X100, X10, X1)		
END. {CountThem}
