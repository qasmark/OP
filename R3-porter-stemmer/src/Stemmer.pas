UNIT Stemmer;
{Morphology: ������, ��������������� ��������������� ������ ����� � ������� ��������� ��������� �������
 https://web.archive.org/web/20210413174257/https://snowball.tartarus.org/algorithms/russian/stemmer.html}
INTERFACE
USES WordReader;

FUNCTION Stem(Word: WordType): WordType; {���������� ������ �����}
FUNCTION GetEnding(Word, Base: WordType): WordType; {���������� ��������� �����}


IMPLEMENTATION
CONST
  Vowels: SET OF CHAR = ['�', '�', '�', '�', '�', '�', '�', '�', '�'];

  PerfectiveGerundAmount = 12;
  PerfectiveGerund: ARRAY [1 .. PerfectiveGerundAmount] OF WordType = ('������', '������', '������', '������', '����', '����', '����', '����', '��', '��', '��', '��');

  AdjectiveAmount = 26;
  Adjective: ARRAY [1 .. AdjectiveAmount] OF WordType = ('��', '��', '��', '��', '���', '���', '��', '��', '��', '��', '��', '��', '��', '��', '���', '���', '���', '���', '��', '��', '��', '��', '��', '��', '��', '��');

  ParticipleAmount = 13;
  Participle: ARRAY [1 .. ParticipleAmount] OF WordType = ('���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '��', '��');

  ReflexiveAmount = 2;
  Reflexive: ARRAY [1 .. ReflexiveAmount] OF WordType = ('��', '��');

  Verb1Amount = 34;
  Verb1: ARRAY [1 .. Verb1Amount] OF WordType = ('����', '����', '����', '����', '����', '����', '����', '����', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '��', '��', '��', '��', '��', '��');
  Verb2Amount = 29;
  Verb2: ARRAY [1 .. Verb2Amount] OF WordType = ('����', '����', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '���', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '�');

  NounAmount = 36;
  Noun: ARRAY [1 .. NounAmount] OF WordType = ('����', '���', '���', '���', '���', '���', '���', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '�', '�', '�', '�', '�', '�', '�', '�', '�', '�');

  SuperlativeAmount = 2;
  Superlative: ARRAY [1 .. SuperlativeAmount] OF WordType = ('����', '���');

  DerivationalAmount = 2;
  Derivational: ARRAY [1 .. DerivationalAmount] OF WordType = ('����', '���');

FUNCTION ReverseString(Str: WordType): WordType;
{ReverseString: ���������� ��������������� ������}
VAR
  Reversed: WordType;
  Index: INTEGER;
BEGIN {ReverseString}
  Reversed := '';
  FOR Index := LENGTH(Str) DOWNTO 1
  DO
    Reversed := Reversed + Str[Index];
  ReverseString := Reversed
END; {ReverseString}

FUNCTION ReversePos(Pattern, Word: WordType): INTEGER;
{ReversePos: ���������� ������ ������� ��������� Pattern � ������}
VAR
  WordLen, PatternLen: INTEGER;
  ReversedWord, ReversedPattern: WordType;
BEGIN {ReversePos}
  ReversedWord := ReverseString(Word);
  ReversedPattern := ReverseString(Pattern);
  WordLen := LENGTH(Word);
  PatternLen := LENGTH(Pattern);
  ReversePos := 0;
  IF POS(ReversedPattern, ReversedWord) = 1
  THEN
    ReversePos := WordLen - PatternLen + 1
  ELSE
    IF POS(Pattern, Word) <> 0
    THEN
      ReversePos := WordLen - POS(ReversedPattern, ReversedWord) - 1
END; {ReversePos}

FUNCTION IsEnding(Word: WordType; Ending: WordType): BOOLEAN;
{IsEnding: ���������� TRUE, ���� ����� ������������ �� ��������� ���������}
BEGIN {IsEnding}
  IsEnding := Ending = COPY(Word, ReversePos(Ending, Word), LENGTH(Word))
END; {IsEnding}

FUNCTION GetRVPart(Word: WordType): WordType;
{GetRVPart: ��������� ����� RV}
VAR
  Index: INTEGER;
BEGIN {GetRVPart}
  FOR Index := 1 TO LENGTH(Word)
  DO
    IF Word[Index] IN Vowels
    THEN
      BREAK;
  IF Index = LENGTH(Word)
  THEN
    GetRVPart := ''
  ELSE
    GetRVPart := COPY(Word, Index + 1, LENGTH(Word))
END; {GetRVPart}

FUNCTION GetR1Part(Word: WordType): WordType;
{GetR1Part: ��������� ����� R1 �����}
VAR
  Index, PrevIndex: INTEGER;
BEGIN {GetR1Part}
  FOR Index := 2 TO LENGTH(Word)
  DO
    BEGIN
      PrevIndex := Index - 1;
      IF (Word[PrevIndex] IN Vowels) AND (NOT (Word[Index] IN Vowels))
      THEN
        BREAK
    END;
  IF Index = LENGTH(Word)
  THEN
    GetR1Part := ''
  ELSE
    GetR1Part := COPY(Word, Index + 1, LENGTH(Word))
END; {GetR1Part}

FUNCTION GetR2Part(Word: WordType): WordType;
{GetR2Part: ��������� ����� R2 �����}
BEGIN {GetR2Part}
  GetR2Part := GetR1Part(GetR1Part(Word))
END; {GetR2Part}

FUNCTION Step1(Word: WordType): WordType;
{Step1: ������ ���}
VAR
  Index: INTEGER;
  Found: BOOLEAN;
BEGIN {Step1}
  Found := FALSE;
  {1a: ������� perfective gerund, �����, ���� �������}
  FOR Index := 1 TO PerfectiveGerundAmount
  DO
    IF IsEnding(GetRVPart(Word), PerfectiveGerund[Index])
    THEN
      BEGIN
        IF PerfectiveGerund[Index][1] IN ['�', '�']
        THEN
          Word := COPY(Word, 1, ReversePos(PerfectiveGerund[Index], Word))
        ELSE
          Word := COPY(Word, 1, ReversePos(PerfectiveGerund[Index], Word) - 1);
        Found := TRUE;
        BREAK
      END;
  Step1 := Word;
  IF Found
  THEN
    EXIT;
  {1b: ������� reflexive}
  FOR Index := 1 TO ReflexiveAmount
  DO
    IF IsEnding(GetRVPart(Word), Reflexive[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Reflexive[Index], Word) - 1);
        BREAK
      END;
  {1c: ������� adjectival, �����, ���� �������}
  FOR Index := 1 TO AdjectiveAmount
  DO
    IF IsEnding(GetRVPart(Word), Adjective[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Adjective[Index], Word) - 1);
        Found := TRUE;
        BREAK
      END;
  FOR Index := 1 TO ParticipleAmount
  DO
    IF IsEnding(GetRVPart(Word), Participle[Index])
    THEN
      BEGIN
        IF Participle[Index][1] IN ['�', '�']
        THEN
          Word := COPY(Word, 1, ReversePos(Participle[Index], Word))
        ELSE
          Word := COPY(Word, 1, ReversePos(Participle[Index], Word) - 1);
        BREAK
      END;
  Step1 := Word;
  IF Found
  THEN
    EXIT;
  {1d: ������� verb, �����, ���� �������}
  FOR Index := 1 TO Verb1Amount
  DO
    IF IsEnding(GetRVPart(Word), Verb1[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Verb1[Index], Word));
        Found := TRUE;
        BREAK
      END;
  FOR Index := 1 TO Verb2Amount
  DO
    IF IsEnding(GetRVPart(Word), Verb2[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Verb2[Index], Word) - 1);
        Found := TRUE;
        BREAK
      END;
  Step1 := Word;
  IF Found
  THEN
    EXIT;
  {1e: ������� noun, �����, ���� �������}
  FOR Index := 1 TO NounAmount
  DO
    IF IsEnding(GetRVPart(Word), Noun[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Noun[Index], Word) - 1);
        Found := TRUE;
        BREAK
      END;
  Step1 := Word
END; {Step1}

FUNCTION Step2(Word: WordType): WordType;
{Step2: �������� '�' � ����� �����}
BEGIN {Step2}
  IF IsEnding(GetRVPart(Word), '�')
  THEN
    Step2 := COPY(Word, 1, LENGTH(Word) - 1)
  ELSE
    Step2 := Word
END; {Step2}

FUNCTION Step3(Word: WordType): WordType;
{Step3: �������� derivational �� R2}
VAR
  Index: INTEGER;
BEGIN {Step3}
  FOR Index := 1 TO DerivationalAmount
  DO
    IF IsEnding(GetR2Part(Word), Derivational[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Derivational[Index], Word) - 1);
        BREAK
      END;
  Step3 := Word
END; {Step3}

FUNCTION Step4(Word: WordType): WordType;
{Step4: ��������� ���}
VAR
  Index: INTEGER;
BEGIN {Step4}
  {4a: �������� '��' �� '�'}
  IF IsEnding(GetRVPart(Word), '��')
  THEN
    Word := COPY(Word, 1, LENGTH(Word) - 1);
  {4b: ������� superlative � �������� '��' �� '�'}
  FOR Index := 1 TO SuperlativeAmount
  DO
    IF IsEnding(GetRVPart(Word), Superlative[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Superlative[Index], Word) - 1);
        BREAK
      END;
  IF IsEnding(GetRVPart(Word), '��')
  THEN
    Word := COPY(Word, 1, LENGTH(Word) - 1);
  {4c: ������� '�'}
  IF IsEnding(GetRVPart(Word), '�')
  THEN
    Word := COPY(Word, 1, LENGTH(Word) - 1);
  Step4 := Word
END; {Step4}

FUNCTION Stem(Word: WordType): WordType;
{Stem: ��������� ����� ����� � ������� ��������� ��������� �������}
BEGIN {Stem}
  IF LENGTH(Word) > 2
  THEN
    BEGIN
      Word := Step1(Word);
      Word := Step2(Word);
      Word := Step3(Word);
      Word := Step4(Word)
    END;
  Stem := Word
END; {Stem}

FUNCTION GetEnding(Word, Base: WordType): WordType;
{GetEnding: ��������� ��������� �� ����� � ������}
BEGIN {GetEnding}
  GetEnding := COPY(Word, LENGTH(Base) + 1, LENGTH(Word))
END; {GetEnding}

BEGIN {Morphology}
END. {Morphology}
