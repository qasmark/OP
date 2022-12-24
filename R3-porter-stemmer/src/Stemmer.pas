UNIT Stemmer;
{Morphology: модуль, предоставляющий морфологический разбор слова с помощью алгоритма стемминга Портера
 https://web.archive.org/web/20210413174257/https://snowball.tartarus.org/algorithms/russian/stemmer.html}
INTERFACE
USES WordReader;

FUNCTION Stem(Word: WordType): WordType; {Возвращает корень слова}
FUNCTION GetEnding(Word, Base: WordType): WordType; {Возвращает окончание слова}


IMPLEMENTATION
CONST
  Vowels: SET OF CHAR = ['а', 'е', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я'];

  PerfectiveGerundAmount = 12;
  PerfectiveGerund: ARRAY [1 .. PerfectiveGerundAmount] OF WordType = ('ывшись', 'ившись', 'авшись', 'явшись', 'авши', 'явши', 'ивши', 'ывши', 'ав', 'яв', 'ив', 'ыв');

  AdjectiveAmount = 26;
  Adjective: ARRAY [1 .. AdjectiveAmount] OF WordType = ('ее', 'ие', 'ые', 'ое', 'ими', 'ыми', 'ей', 'ий', 'ый', 'ой', 'ем', 'им', 'ым', 'ом', 'его', 'ого', 'ему', 'ому', 'их', 'ых', 'ую', 'юю', 'ая', 'яя', 'ою', 'ею');

  ParticipleAmount = 13;
  Participle: ARRAY [1 .. ParticipleAmount] OF WordType = ('аем', 'анн', 'авш', 'ающ', 'яем', 'янн', 'явш', 'яющ', 'ивш', 'ывш', 'ующ', 'ящ', 'ащ');

  ReflexiveAmount = 2;
  Reflexive: ARRAY [1 .. ReflexiveAmount] OF WordType = ('ся', 'сь');

  Verb1Amount = 34;
  Verb1: ARRAY [1 .. Verb1Amount] OF WordType = ('янно', 'яешь', 'яйте', 'яете', 'анно', 'аешь', 'айте', 'аете', 'ять', 'яны', 'яют', 'яет', 'яно', 'яло', 'яем', 'яли', 'яна', 'яла', 'ать', 'аны', 'ают', 'ает', 'ано', 'ало', 'аем', 'али', 'ана', 'ала', 'ян', 'ял', 'яй', 'ан', 'ал', 'ай');
  Verb2Amount = 29;
  Verb2: ARRAY [1 .. Verb2Amount] OF WordType = ('уйте', 'ейте', 'ишь', 'ыть', 'ить', 'ены', 'уют', 'ует', 'ено', 'ыло', 'ило', 'ыли', 'или', 'ите', 'ена', 'ыла', 'ила', 'ую', 'ыт', 'ит', 'ят', 'ен', 'ым', 'им', 'ыл', 'ил', 'уй', 'ей', 'ю');

  NounAmount = 36;
  Noun: ARRAY [1 .. NounAmount] OF WordType = ('иями', 'иях', 'ием', 'иям', 'ией', 'ами', 'ями', 'ья', 'ия', 'ью', 'ию', 'ях', 'ах', 'ом', 'ам', 'ем', 'ям', 'ий', 'ой', 'ей', 'ии', 'еи', 'ье', 'ие', 'ов', 'ев', 'я', 'ю', 'ь', 'ы', 'у', 'о', 'й', 'и', 'е', 'а');

  SuperlativeAmount = 2;
  Superlative: ARRAY [1 .. SuperlativeAmount] OF WordType = ('ейше', 'ейш');

  DerivationalAmount = 2;
  Derivational: ARRAY [1 .. DerivationalAmount] OF WordType = ('ость', 'ост');

FUNCTION ReverseString(Str: WordType): WordType;
{ReverseString: возвращает реверсированную строку}
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
{ReversePos: возвращает индекс первого вхождения Pattern в строке}
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
{IsEnding: возвращает TRUE, если слово оканчивается на указанное окончание}
BEGIN {IsEnding}
  IsEnding := Ending = COPY(Word, ReversePos(Ending, Word), LENGTH(Word))
END; {IsEnding}

FUNCTION GetRVPart(Word: WordType): WordType;
{GetRVPart: получение части RV}
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
{GetR1Part: получение части R1 слова}
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
{GetR2Part: получение части R2 слова}
BEGIN {GetR2Part}
  GetR2Part := GetR1Part(GetR1Part(Word))
END; {GetR2Part}

FUNCTION Step1(Word: WordType): WordType;
{Step1: первый шаг}
VAR
  Index: INTEGER;
  Found: BOOLEAN;
BEGIN {Step1}
  Found := FALSE;
  {1a: удалить perfective gerund, выйти, если найдено}
  FOR Index := 1 TO PerfectiveGerundAmount
  DO
    IF IsEnding(GetRVPart(Word), PerfectiveGerund[Index])
    THEN
      BEGIN
        IF PerfectiveGerund[Index][1] IN ['а', 'я']
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
  {1b: удалить reflexive}
  FOR Index := 1 TO ReflexiveAmount
  DO
    IF IsEnding(GetRVPart(Word), Reflexive[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Reflexive[Index], Word) - 1);
        BREAK
      END;
  {1c: удалить adjectival, выйти, если найдено}
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
        IF Participle[Index][1] IN ['а', 'я']
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
  {1d: удалить verb, выйти, если найдено}
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
  {1e: удалить noun, выйти, если найдено}
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
{Step2: удаление 'и' с конца слова}
BEGIN {Step2}
  IF IsEnding(GetRVPart(Word), 'и')
  THEN
    Step2 := COPY(Word, 1, LENGTH(Word) - 1)
  ELSE
    Step2 := Word
END; {Step2}

FUNCTION Step3(Word: WordType): WordType;
{Step3: удаление derivational из R2}
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
{Step4: четвертый шаг}
VAR
  Index: INTEGER;
BEGIN {Step4}
  {4a: заменить 'нн' на 'н'}
  IF IsEnding(GetRVPart(Word), 'нн')
  THEN
    Word := COPY(Word, 1, LENGTH(Word) - 1);
  {4b: удалить superlative и заменить 'нн' на 'н'}
  FOR Index := 1 TO SuperlativeAmount
  DO
    IF IsEnding(GetRVPart(Word), Superlative[Index])
    THEN
      BEGIN
        Word := COPY(Word, 1, ReversePos(Superlative[Index], Word) - 1);
        BREAK
      END;
  IF IsEnding(GetRVPart(Word), 'нн')
  THEN
    Word := COPY(Word, 1, LENGTH(Word) - 1);
  {4c: удалить 'ь'}
  IF IsEnding(GetRVPart(Word), 'ь')
  THEN
    Word := COPY(Word, 1, LENGTH(Word) - 1);
  Step4 := Word
END; {Step4}

FUNCTION Stem(Word: WordType): WordType;
{Stem: отделение корня слова с помощью алгоритма стемминга Портера}
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
{GetEnding: получение окончания по слову и основе}
BEGIN {GetEnding}
  GetEnding := COPY(Word, LENGTH(Base) + 1, LENGTH(Word))
END; {GetEnding}

BEGIN {Morphology}
END. {Morphology}
