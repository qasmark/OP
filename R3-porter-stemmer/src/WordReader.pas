UNIT WordReader;
{WordReader: ������ ��� ������ ����}
INTERFACE
CONST
  MaxWordLength = 50; {������������ ����� �����}

TYPE
  WordType = STRING[MaxWordLength];

PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType); {������ ����� �� ����� � ������}


IMPLEMENTATION
CONST
  CaseOffset = 32;

FUNCTION IsAlphabetic(VAR Ch: CHAR): BOOLEAN;
{IsAlphabetic: ���������� TRUE, ���� ������ �������� ����������}
BEGIN {IsAlphabetic}
  IsAlphabetic := Ch IN ['A' .. 'Z', 'a' .. 'z', '�' .. '�', '�' .. '�', '�', '�']
END; {IsAlphabetic}

FUNCTION IsUpperCase(Ch: CHAR): BOOLEAN;
{IsUpperCase: ���������� TRUE, ���� ������ � ������� ��������}
BEGIN {IsUpperCase}
  IsUpperCase := Ch IN ['A' .. 'Z', '�' .. '�', '�']
END; {IsUpperCase}

FUNCTION ToLowerCase(Ch: CHAR): CHAR;
{ToLowerCase: ���������� ������ � ������ ��������}
BEGIN {ToLowerCase}
  ToLowerCase := Ch;
  IF IsUpperCase(Ch)
  THEN
    {"�" �� ������ � �������� �������� �������� � ��������� Windows 1251}
    IF Ch = '�'
    THEN
      ToLowerCase := '�'
    ELSE
      ToLowerCase := CHR(ORD(Ch) + CaseOffset)
END; {ToLowerCase}

PROCEDURE AppendChar(VAR Word: WordType; Ch: CHAR);
{AppendChar: ��������� ������� � ���������� � ������}
BEGIN {AppendChar}
  Ch := ToLowerCase(Ch);
  Word := Word + Ch
END; {AppendChar}

PROCEDURE TrimWhitespaces(VAR FIn: TEXT; VAR Ch: CHAR);
{TrimWhitespaces: ������ ������������ �������� �� ������� �����������}
BEGIN {TrimWhitespaces}
  IF NOT EOLN(FIn)
  THEN
    REPEAT
      READ(FIn, Ch)
    UNTIL (IsAlphabetic(Ch)) OR (EOLN(FIn))
END; {TrimWhitespaces}

PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType);
{ReadWord: ������� ���� ������������ �������� �� ������� �����������,
 ������ ����� �� ������� ������������� �������}
VAR
  Ch: CHAR;
  Index: INTEGER;
BEGIN {ReadWord}
  Word := '';
  Index := 0;
  TrimWhitespaces(FIn, Ch);
  WHILE (NOT EOLN(FIn)) AND (IsAlphabetic(Ch)) AND (Index < MaxWordLength)
  DO
    BEGIN
      AppendChar(Word, Ch);
      READ(FIn, Ch);
      Index := Index + 1
    END;
  IF (EOLN(FIn)) AND (IsAlphabetic(Ch)) AND (Index < MaxWordLength)
  THEN
    AppendChar(Word, Ch)
END; {ReadWord}

BEGIN {WordReader}
END. {WordReader}
