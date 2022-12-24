PROGRAM RunBubbleSort(INPUT, OUTPUT);
  { Сортируем первую строку INPUT в OUTPUT }
VAR
  Sorted, Ch, Ch1, Ch2: CHAR;
  F1, F2:TEXT;

PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch);
    END;
  READLN(InFile);
  WRITELN(OutFile)
END;

PROCEDURE CopySwap(VAR F1, F2: TEXT; VAR Sorted: CHAR);
VAR
  Ch1, Ch2: CHAR;
BEGIN
  Sorted := 'Y';
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch2);
          IF Ch1 <= Ch2
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END
        END;
      WRITE(F2, Ch1)
    END;
  READLN(F1);
  WRITELN(F2)
END;

BEGIN { BubbleSort }
  { Копируем INPUT в F1 }
  REWRITE(F1);
  CopyFile(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted ='N'
  DO
    BEGIN
      { Копируем F1 в F2 проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      RESET(F1);
      REWRITE(F2);
      CopySwap(F1, F2, Sorted);
      { Копируем F2 в F1}
      REWRITE(F1);
      RESET(F2);
      CopyFile(F2, F1)
    END; 
  { Копируем F1 в OUTPUT }    
  RESET(F1);
  CopyFile(F1, OUTPUT)
END.{ BubbleSort }
