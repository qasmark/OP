PROGRAM Deencryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
  и печатает новые символы в OUTPUT}
CONST
  Len = 20;
  EncryptionOfSpace = '~';
TYPE
  Letter = 'A' .. 'Z';
  Str = ARRAY [1 .. Len] OF Letter;
  Chiper = ARRAY [Letter] OF CHAR;
  Length = 0 .. Len;
VAR
  Msg: Str;
  Code: Chiper;
  MsgLen: Length;
  UnivercalEncrSymbol: CHAR; 
PROCEDURE Initialize(VAR Code: Chiper);
{Присвоить Code шифр замены}
VAR
  F: TEXT;
  EncrpSymbol, NotEncrpSymbol: CHAR;
BEGIN {Initialize}
  ASSIGN(F, 'denencryption.txt');
  RESET(F);
  WHILE NOT EOF(F)
  DO
    BEGIN
       READ(F, NotEncrpSymbol);
       READ(F, EncrpSymbol);
       READLN(F);
       IF NotEncrpSymbol IN ['A' .. 'Z', '~']
       THEN
         Code[NotEncrpSymbol] := EncrpSymbol
    END;      
END;  {Initialize}
 
PROCEDURE Encode(VAR S: Str; MsgLen: Length);
{Выводит символы из Code, соответсвующие символам из S}
VAR
  Index: 1 .. Len;
BEGIN {Encode}
  FOR Index := 1 TO MsgLen
  DO
    IF S[Index] IN  ['A' .. 'Z', '~']
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END;  {Encode}
 
BEGIN {Encryption}
  {Инициализировать Code}
  Initialize(Code);
  {Читать строку в Msg и распечатать ее}
  MsgLen := 0;
  WHILE (NOT EOLN) AND (MsgLen < Len)
  DO
    BEGIN
      MsgLen := MsgLen + 1;
      READ(Msg[MsgLen]);
      WRITE(Msg[MsgLen])
    END;
  READLN;
  WRITELN;
  {Распечатать кодированное сообщение}
  Encode(Msg, MsgLen)
END.  {Encryption}

