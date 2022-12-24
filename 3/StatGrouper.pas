UNIT StatGrouper;
INTERFACE

PROCEDURE GroupWords(InpPath, OutPath: STRING);

IMPLEMENTATION
USES 
  StringHandler;                                

PROCEDURE GroupWords(InpPath, OutPath: STRING);
VAR 
  InpFile, OutFile: TEXT;
  TotalCount: INTEGER;
  Word, CountStr: STRING;
  WordBase, Base: STRING;
BEGIN {GroupWords}  
  ASSIGN(InpFile, InpPath);
  RESET(InpFile);
  ASSIGN(OutFile, OutPath);
  REWRITE(OutFile);

  Base := '';
  TotalCount := 0;

  WHILE NOT EOF(InpFile)
  DO
    BEGIN
      Word := ReadWord(InpFile);
      CountStr := ReadWord(InpFile);
      WordBase := GetBase(Word);

      IF WordBase = Base
      THEN 
        BEGIN   
          WRITE(OutFile, ', ', Word);
          TotalCount := TotalCount + ToInt(CountStr) 
        END
      ELSE 
        BEGIN   
          WRITELN(OutFile, ': ', TotalCount); 
          Base := WordBase;
          TotalCount := ToInt(CountStr);
          WRITE(OutFile, Word)
        END
    END;    

  CLOSE(InpFile)
END; {GroupWords}

BEGIN {StatGrouper}
END. {StatGrouper}
