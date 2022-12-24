PROGRAM Stat(INPUT, OUTPUT);
VAR
  Number, Min, Max, Sum, Count: INTEGER;
  IntPart, FloatPart: INTEGER;
    
PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
{Считывает текущий символ из файла. Если он - цифра, возвращает его 
 преобразуя в значение типа INTEGER. Если считанный символ не цифра
 возвращает -1}
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
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
    END
END; {ReadDigit}

PROCEDURE CheckSafeToExpand(VAR N, D: INTEGER; VAR Flag: BOOLEAN);
{Проверяет,безопасно ли добавить к числу N разряд D}
BEGIN {CheckSafeToExpand}
  Flag := (N < MAXINT DIV 10) OR ((N = MAXINT DIV 10) AND (D <= MAXINT MOD 10))
END; {CheckSafeToExpand}

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
{Преобразует стпоку цифр из файла до первого нецифрового символа,  в соответствующее целое число N}
VAR
  Digit: INTEGER;
  IsSafeToExpand: BOOLEAN;
BEGIN {ReadNumber}
  N := 0;
  Digit := 0;
  WHILE (Digit <> -1) AND (N <> -1)
  DO
    BEGIN
      CheckSafeToExpand(N, Digit, IsSafeToExpand);
      IF IsSafeToExpand
      THEN
        N := N * 10 + Digit
      ELSE
        N := -1;
      ReadDigit(F, Digit)
    END
END; {ReadNumber}

PROCEDURE CalculateAverage(VAR Sum, Count, IntPart, FloatPart: INTEGER);
{Вычисление среднего с точностью до 2 цифр после запятой в FloatPart}
VAR
  IntResult: INTEGER;
BEGIN {CalculateAverage}
  IntResult := (Sum * 100) DIV Count;
  IntPart := IntResult DIV 100;      
  FloatPart := IntResult MOD 100
END; {CalculateAverage}

PROCEDURE BumpCount(VAR Count: INTEGER);
BEGIN {BumpCount}
  IF Count <= MAXINT - 1
  THEN
    Count := Count + 1
  ELSE
    Count := -1
END; {BumpCount}

PROCEDURE BumpSum(VAR Sum, Number: INTEGER);
BEGIN {BumpSum}
  IF Sum <= (MAXINT - Number) DIV 100
  THEN
    Sum := Sum + Number
  ELSE
    Sum := -1
END; {BumpSum}

BEGIN {Stat}
  Number := 0;
  Min := MAXINT;
  Max := 0;
  Sum := 0;
  Count := 0;
  WHILE (NOT EOLN) AND (Number <> -1) AND (Sum <> -1) AND (Count <> -1)
  DO
    BEGIN    
      ReadNumber(INPUT, Number);
      IF Number <> -1
      THEN
        BEGIN
          BumpCount(Count);
          BumpSum(Sum, Number);
          IF Number < Min
          THEN
            Min := Number;
          IF Number > Max
          THEN
            Max := Number
        END
    END;
  {Проверка невалидных данных}
  IF (Count <= 0) OR (Sum <= 0) OR (Sum > MAXINT DIV 100)
  THEN
    WRITELN('Invalid data')
  ELSE
    BEGIN
      WRITELN('Count: ', Count);
      WRITELN('Min: ', Min);
      WRITELN('Max: ', Max);
      CalculateAverage(Sum, Count, IntPart, FloatPart);
      WRITELN('Average: ', IntPart, '.', FloatPart)
    END
END. {Stat}
