UNIT ConvertLetterToDraw;
INTERFACE
CONST
  MinIndex = 1;
  MatrixSize = 5;
  MaxIndex = MatrixSize * MatrixSize;
  PrintedLetter = 'X';
TYPE
  PosSymbol = SET OF MinIndex .. MaxIndex;
FUNCTION GetSetByChar(Ch: CHAR): PosSymbol;
PROCEDURE PrintSet(Ch: CHAR);
IMPLEMENTATION
VAR
  Ch: CHAR;
  Index: INTEGER;
FUNCTION GetSetByChar(Ch: CHAR): PosSymbol; // convert char to set of int-s
VAR
  Letter: PosSymbol;
BEGIN
  CASE Ch OF
    'M': Letter := [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
    'F': Letter := [1, 2, 3, 4, 5, 6, 11, 12, 13, 16, 21];
    'H': Letter := [1, 5, 6, 10, 11, 12, 13, 14, 15, 16, 20, 21, 25];
    'I': Letter := [1, 2, 3, 4, 5, 8, 13, 18, 21, 22, 23, 24, 25];
    'L': Letter := [1, 6, 11, 16, 21, 22, 23, 24, 25];
  ELSE
    Letter := [1..25]
  END;
  GetSetByChar := Letter
END;

PROCEDURE PrintSet(Ch: CHAR);
VAR
  Letter: PosSymbol;
BEGIN
  Letter := GetSetByChar(Ch);
  FOR Index := MinIndex TO MaxIndex
  DO
    BEGIN
      IF Index IN Letter
      THEN
        WRITE(PrintedLetter)
      ELSE
        WRITE(' ');
      IF Index MOD MatrixSize = 0
      THEN
        WRITELN
    END
END;
END.
