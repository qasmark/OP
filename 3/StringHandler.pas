UNIT StringHandler;
INTERFACE 
                                      
FUNCTION IsWordChar(Ch: CHAR) : BOOLEAN;
FUNCTION ToLower(Str: STRING) : STRING;
FUNCTION StringComparer(VAR A, B: STRING) : INTEGER;
FUNCTION ReadWord(VAR Inp: TEXT) : STRING;
FUNCTION ToInt(Str: STRING) : INTEGER;
FUNCTION GetBase(Word: STRING) : STRING;
                                       
IMPLEMENTATION          

FUNCTION IsWordChar(Ch: CHAR) : BOOLEAN;
BEGIN {WordChar}
  IsWordChar := 
    ((Ch >= 'à') AND (Ch <= 'ÿ')) OR
    ((Ch >= 'a') AND (Ch <= 'z')) OR
    ((Ch >= 'À') AND (Ch <= 'ß')) OR 
    ((Ch >= 'A') AND (Ch <= 'Z')) OR 
    ((Ch >= '0') AND (Ch <= '9'));
END; {WordChar}   

FUNCTION ToLower(Str: STRING) : STRING;
VAR 
  I, Len, Holder, LetterDiff: INTEGER;
BEGIN 
  Len := LENGTH(Str);  
  LetterDiff := ORD('A') - ORD('a');

  FOR I := 1 TO Len
  DO 
    BEGIN
      IF ((Str[I] >= 'À') AND (Str[I] <= 'ß')) OR 
         ((Str[I] >= 'A') AND (Str[I] <= 'Z'))
      THEN
        BEGIN
          Holder := ORD(Str[I]) - LetterDiff;
          Str[I] := CHR(Holder)
        END
    END;  
  
  ToLower := Str;
END;

FUNCTION StringComparer(VAR A, B: STRING) : INTEGER;
{Returns:
-1 if A is less than B,
0 if A is equal to B, 
1 if A is greater than B}
VAR 
  LengthA, LengthB: INTEGER;
  Index, MaxLength: INTEGER;
BEGIN {Comparer}
  LengthA := LENGTH(A);
  LengthB := LENGTH(B); 

  IF LengthA > LengthB
  THEN
    MaxLength := LengthA
  ELSE
    MaxLength := LengthB;
  
  FOR Index := 1 TO MaxLength
  DO
    BEGIN
      IF Index > LengthA
      THEN 
        BEGIN
          StringComparer := -1;
          EXIT
        END; 

      IF Index > LengthB
      THEN 
        BEGIN
          StringComparer := 1;
          EXIT
        END;
 
      IF A[Index] > B[Index]
      THEN
        BEGIN
          StringComparer := 1;
          EXIT
        END;
     
      IF A[Index] < B[Index]
      THEN
        BEGIN
          StringComparer := -1;
          EXIT
        END     
    END;
  
  StringComparer := 0;  
END; {Comparer} 

FUNCTION ReadWord(VAR Inp: TEXT) : STRING;
VAR
  Ch, PrevCh: CHAR;
  Word: STRING;  
  IsWord: BOOLEAN;
BEGIN {ReadWord}  
  Ch := ' ';      
  PrevCh := ' ';    
  Word := '';
  IsWord := TRUE;

  WHILE NOT IsWordChar(Ch)
  DO
    BEGIN
      READ(Inp, Ch);
      IF EOF(Inp) THEN EXIT
    END;

  WHILE IsWord
  DO 
    BEGIN                   
      PrevCh := Ch;

      IF EOF(Inp) 
      THEN 
        BEGIN
          ReadWord := Word;
          EXIT
        END;
      READ(Inp, Ch);
         
      IsWord := IsWordChar(Ch);
      {This willn't save words like this 
      'some-' with '-' at the end}
      IF IsWord OR (PrevCh <> '-')
      THEN          
        Word := Word + PrevCh;

      IsWord := IsWord OR (Ch = '-')
    END;
  
  ReadWord := Word
END; {ReadWord}

FUNCTION ToInt(Str: STRING) : INTEGER;
VAR                       
  I, Len: INTEGER;        
  MaxNumber: INTEGER; 
  Digit, Res: INTEGER; 
  MinDigitCode: INTEGER;
BEGIN {ToInt}
  Res := 0;
  ToInt := 0;
  Len := LENGTH(Str); 
  MaxNumber := 32767;
  MinDigitCode := ORD('0');

  FOR I := 1 TO Len
  DO 
    BEGIN   
      Digit := ORD(Str[I]) - MinDigitCode;

      IF (Digit < 0) OR
         (Digit > 9)
      THEN 
        BEGIN
          WRITELN('Failed ToInt convertion: Invalid string: ', Str);
          EXIT
        END;
  
      IF ( Res > ((MaxNumber - Digit) DIV 10) )
      THEN 
        BEGIN  
          WRITELN('Failed ToInt convertion: Integer overflow');   
          EXIT
        END;

      Res := Res * 10 + Digit
    END;

  ToInt := Res
END; {ToInt}

FUNCTION GetBase(Word: STRING) : STRING;
BEGIN {GetBase}
  GetBase := '';
END; {GetBase}

BEGIN {StringHandler}
END. {StringHandler}
