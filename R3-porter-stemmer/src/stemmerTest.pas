PROGRAM StemmerTest(INPUT, OUTPUT);
{StemmerTest: тестирование алгоритма стемминга}
USES
  WordReader, Stemmer;

VAR
  Word: WordType;

BEGIN {GroupWords}
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      IF NOT EOLN(INPUT)
      THEN
        BEGIN
          ReadWord(INPUT, Word);
          WRITELN(OUTPUT, Stem(Word))
        END
      ELSE
        READLN(INPUT)
    END
END. {GroupWords}
