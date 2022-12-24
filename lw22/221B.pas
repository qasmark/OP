PROGRAM InsertionSort(INPUT, OUTPUT);
{Сортирует символы из INPUT}
CONST
  Max = 16;
  ListEnd = 0;
TYPE
  RecArray = ARRAY [1 .. Max] OF 
               RECORD
                 Key: CHAR;
                 Next: 0 .. Max;
               END;
VAR
  Arr: RecArray;
  First, Index: 0 .. Max;
  Prev, Curr: 0 .. Max;  
  Extra: CHAR;
  Found: BOOLEAN;
  I: INTEGER;
BEGIN {InsertionSort}
  First := 0;
  Index := 0;
  WHILE NOT EOLN      
  DO
    BEGIN
      {Помещать запись в список, если позволяет пространство, 
      иначе игнорировать и сообщаться об ошибке}
      Index := Index + 1;
      IF Index > Max
      THEN
        BEGIN
          READ(Extra);
          WRITELN('Cообщение содержит: ', Extra, '. Игнорируем.');
        END
      ELSE
        BEGIN
          READ(Arr[Index].Key);
          {Включение Arr[Index] в связанный список, DP 1.1 }
          Prev := 0;
          Curr := First;
          {Найти значения Prev и Curr, если существуют такие что
          Arr[Prev].Key  <= Arr[Index].Key <= Arr[Curr].Key, DP 1.1.1}
          Found := FALSE;
          WHILE (Curr <> 0) AND NOT Found
          DO
            BEGIN
              WRITELN('------------------------------');
              WRITELN('Логика');
              WRITELN(Arr[Curr].Key, ' is Arr[Curr].Key, ', Arr[Index].Key, ' is Arr[Index].Key');
              WRITELN(Arr[Curr].Next, ' is Arr[Curr].Next ');
              WRITELN('Физика');
              WRITELN(Curr, ' is Curr, ', Prev, ' is Prev, ', Index, ' is Index');
              IF Arr[Index].Key > Arr[Curr].Key
              THEN
                BEGIN
                  Prev := Curr;
                  Curr := Arr[Curr].Next
                END
              ELSE
                Found := True
            END;
          Arr[Index].Next := Curr;
          IF Prev = 0  {Первый элемент в списке}
          THEN
            First := Index
          ELSE
            Arr[Prev].Next := Index;
          END
    END; {WHILE}
    {Печать списка начиеая с Arr[First] DP 1.2}
    Index := First;
    WHILE Index <> ListEnd
    DO
      BEGIN
        WRITE(Arr[Index].Key);  
        Index := Arr[Index].Next;
      END;
   WRITELN
END.  {InsertionSort}
 

