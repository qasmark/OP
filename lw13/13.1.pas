PROGRAM RunBubbleSort(INPUT, OUTPUT);
  { Сортируем первую строку INPUT в OUTPUT }
VAR
  Sorted, Ch, Ch1, Ch2:CHAR;
  F1, F2: TEXT;

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
      { Копируем F2 в F1}
      Sorted := 'Y'
    END;
  { Копируем F1 в OUTPUT }
  Reset(F1);
  CopyFile(F1, OUTPUT)
END.{ BubbleSort }
