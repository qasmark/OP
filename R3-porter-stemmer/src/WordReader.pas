UNIT WordReader;
{WordReader: модуль для чтения слов}
INTERFACE
CONST
  MaxWordLength = 50; {Максимальная длина слова}

TYPE
  WordType = STRING[MaxWordLength];

PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType); {Чтение слова из файла в строку}


IMPLEMENTATION
CONST
  CaseOffset = 32;

FUNCTION IsAlphabetic(VAR Ch: CHAR): BOOLEAN;
{IsAlphabetic: возвращает TRUE, если символ является алфавитным}
BEGIN {IsAlphabetic}
  IsAlphabetic := Ch IN ['A' .. 'Z', 'a' .. 'z', 'А' .. 'Я', 'а' .. 'я', 'Ё', 'ё']
END; {IsAlphabetic}

FUNCTION IsUpperCase(Ch: CHAR): BOOLEAN;
{IsUpperCase: возвращает TRUE, если символ в верхнем регистре}
BEGIN {IsUpperCase}
  IsUpperCase := Ch IN ['A' .. 'Z', 'А' .. 'Я', 'Ё']
END; {IsUpperCase}

FUNCTION ToLowerCase(Ch: CHAR): CHAR;
{ToLowerCase: возвращает символ в нижнем регистре}
BEGIN {ToLowerCase}
  ToLowerCase := Ch;
  IF IsUpperCase(Ch)
  THEN
    {"ё" не входит в основной диапазон алфавита в кодировке Windows 1251}
    IF Ch = 'Ё'
    THEN
      ToLowerCase := 'ё'
    ELSE
      ToLowerCase := CHR(ORD(Ch) + CaseOffset)
END; {ToLowerCase}

PROCEDURE AppendChar(VAR Word: WordType; Ch: CHAR);
{AppendChar: обработка символа и добавление к строке}
BEGIN {AppendChar}
  Ch := ToLowerCase(Ch);
  Word := Word + Ch
END; {AppendChar}

PROCEDURE TrimWhitespaces(VAR FIn: TEXT; VAR Ch: CHAR);
{TrimWhitespaces: чтение неалфавитных символов до первого алфавитного}
BEGIN {TrimWhitespaces}
  IF NOT EOLN(FIn)
  THEN
    REPEAT
      READ(FIn, Ch)
    UNTIL (IsAlphabetic(Ch)) OR (EOLN(FIn))
END; {TrimWhitespaces}

PROCEDURE ReadWord(VAR FIn: TEXT; VAR Word: WordType);
{ReadWord: пропуск всех неалфавитных символов до первого алфавитного,
 чтение слова до первого неалфавитного символа}
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
