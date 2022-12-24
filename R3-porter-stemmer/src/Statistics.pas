UNIT Statistics;
{Statistics: ����������� ���������� �� ������������ ������ � ����� � ������� ����������}
INTERFACE
USES
  WordReader, Stemmer, Container;

PROCEDURE GroupWords(VAR FIn: TEXT); {����������� ���������� �� �����}
PROCEDURE PrintStatistics(VAR FOut: TEXT); {����� ��������������� ���������� � ����}


IMPLEMENTATION
PROCEDURE GroupWords(VAR FIn: TEXT);
{GroupWords: ���������� ���������� ����������� �� �����}
VAR
  CurrentWord, CurrentBase, CurrentEnding: WordType;
  CurrentAmount: INTEGER;
  Item: ItemType;
BEGIN {GroupWords}
  ClearItem(Item);
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      ReadWord(FIn, CurrentWord);
      READLN(FIn, CurrentAmount);
      CurrentBase := Stem(CurrentWord);
      CurrentEnding := GetEnding(CurrentWord, CurrentBase);
      IF Item.Base <> ''
      THEN
        IF Item.Base = CurrentBase
        THEN
          BEGIN
            Item.Amount := Item.Amount + CurrentAmount;
            AddEnding(Item, CurrentEnding)
          END
        ELSE
          BEGIN
            AddItem(Item);
            ClearItem(Item);
            Item.Amount := CurrentAmount;
            Item.Base := CurrentBase;
            AddEnding(Item, CurrentEnding)
          END
      ELSE
        BEGIN
          Item.Base := CurrentBase;
          Item.Amount := CurrentAmount;
          AddEnding(Item, CurrentEnding)
        END
    END;
  AddItem(Item)
END; {GroupWords}

PROCEDURE PrintStatistics(VAR FOut: TEXT);
{PrintStatistics: ����� ���������� � ��������� ����}
BEGIN {PrintStatistics}
  PrintContainer(FOut)
END; {PrintStatistics}

BEGIN {Statistics}
END. {Statistics}
