UNIT Container;
{Container: модуль для хранения статистики и работы с её элементами}
INTERFACE
USES WordReader;

CONST
  MaxEndings = 50;
  PrintSeparator = ': ';

TYPE
  ItemType = RECORD
               Base: WordType;
               Endings: ARRAY [1 .. MaxEndings] OF WordType;
               EndingsAmount: 0 .. MaxEndings;
               Amount: INTEGER
             END;

PROCEDURE AddItem(VAR Item: ItemType); {добавление элемента}
PROCEDURE AddEnding(VAR Item: ItemType; VAR Ending: WordType); {добавление окончания к элементу}
PROCEDURE ClearItem(VAR Item: ItemType); {очистка одного элемента}
PROCEDURE PrintContainer(VAR FOut: TEXT); {вывод статистики в текстовом формате}

IMPLEMENTATION
VAR
  ItemFile: FILE OF ItemType;

PROCEDURE AddItem(VAR Item: ItemType);
BEGIN {AddItem}
  WRITE(ItemFile, Item)
END; {AddItem}

PROCEDURE AddEnding(VAR Item: ItemType; VAR Ending: WordType);
BEGIN {AddEnding}
  Item.EndingsAmount := Item.EndingsAmount + 1;
  Item.Endings[Item.EndingsAmount] := Ending
END; {AddEnding}

PROCEDURE ClearItem(VAR Item: ItemType);
BEGIN {ClearItem}
  Item.Base := '';
  Item.Amount := 0;
  Item.EndingsAmount := 0
END; {ClearItem}

PROCEDURE PrintItem(VAR FOut: TEXT; VAR Item: ItemType);
VAR
  Index: INTEGER;
BEGIN {PrintItem}
  FOR Index := 1 TO Item.EndingsAmount
  DO
    BEGIN
      WRITE(FOut, Item.Base, Item.Endings[Index]);
      IF Index <> Item.EndingsAmount
      THEN
        WRITE(FOut, ',')
    END;
  WRITE(FOut, PrintSeparator, Item.Amount)
END; {PrintItem}

PROCEDURE PrintContainer(VAR FOut: TEXT);
{PrintContainer: вывод бинарного файла статистики в текстовом
 представлении}
VAR
  Item: ItemType;
BEGIN {PrintContainer}
  RESET(ItemFile);
  WHILE NOT EOF(ItemFile)
  DO
    BEGIN
      READ(ItemFile, Item);
      PrintItem(FOut, Item);
      WRITELN(FOut)
    END
END; {PrintContainer}

BEGIN {Container}
  REWRITE(ItemFile)
END. {Container}
