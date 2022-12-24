PROGRAM ReadIntNumber(INPUT, OUTPUT);
VAR
  Number: INTEGER;
PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  IF NOT EOLN(F)
  THEN
    READ(F, Ch);
  IF Ch = '0' THEN D := 0 ELSE
  IF Ch = '1' THEN D := 1 ELSE    
  IF Ch = '2' THEN D := 2 ELSE
  IF Ch = '3' THEN D := 3 ELSE
  IF Ch = '4' THEN D := 4 ELSE
  IF Ch = '5' THEN D := 5 ELSE
  IF Ch = '6' THEN D := 6 ELSE
  IF Ch = '7' THEN D := 7 ELSE
  IF Ch = '8' THEN D := 8 ELSE
  IF Ch = '9' THEN D := 9 
  ELSE  
    D := -1  
END; {ReadDigit}
PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
VAR
  Digit: INTEGER;
  Check: BOOLEAN;
BEGIN {ReadNumber}
  Digit := 0;
  N := 0;
  Check := TRUE;
  WHILE Check
  DO
    BEGIN
      ReadDigit(F, Digit);              
      IF (Digit <> -1) 
      THEN
        BEGIN
          IF ((MAXINT DIV 10 < N) OR (((MAXINT DIV 10 = N) AND ((MAXINT MOD 10) < Digit))))
          THEN
            BEGIN
              Check := FALSE;
              N := -2;
            END
          ELSE
            N := N * 10 + Digit
        END
      ELSE
        Check := FALSE
    END;
    IF N = 0
    THEN
      N := -1
END; {ReadNumber}
BEGIN {ReadIntNumber}
  ReadNumber(INPUT, Number);
  WRITELN(Number)
END.  {ReadIntNumber}
