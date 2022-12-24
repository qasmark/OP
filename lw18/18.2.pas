PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 3;
  ClassSize = 2;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
  LastNameHolder: TEXT;
  Flag: CHAR;
  

PROCEDURE SaveLastName(VAR Temp: TEXT);
VAR Ch: CHAR;
BEGIN {SaveLastName}
  WHILE NOT EOLN
  DO 
	BEGIN
	  READ(Ch);
	  WRITE(Temp, Ch)			
	END;
  WRITELN(Temp)
END; {SaveLastName}

PROCEDURE PrintSavedLastName(VAR Temp: TEXT);
VAR Ch: CHAR;
BEGIN {PrintSavedLastName}
  WHILE NOT EOLN(Temp)
  DO	
    BEGIN
      READ(Temp, Ch);	
      WRITE(Ch)
    END
END; {PrintSavedLastName}

BEGIN {AverageScore}
  Flag := '1';
  ClassTotal := 0;
  Student := 1;
  WHILE Student <= ClassSize
  DO 
    BEGIN
      TotalScore := 0;
      WhichScore := 1; 
      {Вводится имя студента}
	  WRITELN('Enter student''s name:');
	  REWRITE(LastNameHolder);
	  SaveLastName(LastNameHolder);
	  {Вводятся оценки студента}
	  WRITELN('Enter student''s averages:');
      WHILE (WhichScore <= NumberOfScores)
      DO
        BEGIN
          WhichScore := WhichScore + 1;
          WRITELN(WhichScore);
          READ(NextScore);					                  
          TotalScore := TotalScore + NextScore
        END; 
      READLN; 	
	  {Подсчёт средней оценки студента}
      TotalScore := TotalScore * 10;
      Ave := TotalScore DIV NumberOfScores;
      {Печать имени студента}          
	  RESET(LastNameHolder);  
      PrintSavedLastName(LastNameHolder);
	  WRITE(': ');
      {Округление средней оценки студента}
      IF Ave MOD 10 >= 5
      THEN
        WRITE(Ave DIV 10 + 1)
      ELSE 
	    WRITE(Ave DIV 10);
  	    WRITELN;
      {Добавить оценки студента в общие оценки}
      ClassTotal := ClassTotal + TotalScore;
	  Student := Student + 1
    END;  
  {Вывод средней оценки всех студентов}
  WRITELN;            
  WRITELN('Class average:');
  ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
  WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
END.  {AverageScore}
