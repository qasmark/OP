PROGRAM XPrint(INPUT, OUTPUT);
USES 
  ConvertLetterToDraw;
VAR
  Ch: CHAR;
BEGIN
  WRITE('Enter one of next letters M, F, H, I, L: ');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      PrintSet(Ch);
      WRITELN
    END
END.
