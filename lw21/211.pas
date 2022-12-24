PROGRAM Encryption(INPUT, OUTPUT);
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
   
PROCEDURE Initialize(VAR Code: Chiper);
{Присвоить Code шифр замены}
BEGIN {Initialize}
  Code['A'] := 'Z';
  Code['B'] := 'Y';
  Code['C'] := 'X';
  Code['D'] := '#';
  Code['E'] := 'V';
  Code['F'] := 'U';
  Code['G'] := 'T';
  Code['H'] := 'S';
  Code['I'] := 'I';
  Code['J'] := 'Q';
  Code['K'] := 'P';
  Code['L'] := '!';
  Code['M'] := 'N';
  Code['N'] := 'M';
  Code['O'] := '2';
  Code['P'] := 'K';
  Code['Q'] := '$';
  Code['R'] := 'D';
  Code['S'] := 'H';
  Code['T'] := '*';
  Code['U'] := 'F';
  Code['V'] := 'E';
  Code['W'] := 'T';
  Code['X'] := 'C';
  Code['Y'] := 'B';
  Code['Z'] := 'A'
END;  {Initialize}
 
PROCEDURE Encode(VAR S: Str; MsgLen: Length);
{Выводит символы из Code, соответсвующие символам из S}
VAR
  Index: 1 .. Len;
BEGIN {Encode}
  FOR Index := 1 TO MsgLen
  DO
    IF S[Index] IN ['A' .. 'Z', ' ']
    THEN
      IF S[Index] = ' '
      THEN
        WRITE(EncryptionOfSpace)
      ELSE
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

