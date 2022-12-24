PROGRAM Prime(INPUT, OUTPUT);
CONST
  MaxNumber = 100;
VAR
  Sieve: SET OF 2 .. MaxNumber;
  StartNumber, i: INTEGER;
BEGIN {SieveOfEratosthenes}
  Sieve := [2 .. MaxNumber];
  StartNumber := 2;
  WRITE('Prime numbers from 2 to ', MaxNumber, ' are next: ');
  WHILE StartNumber <= MaxNumber
  DO
    BEGIN
    IF StartNumber IN Sieve
    THEN 
	  BEGIN 
        i := StartNumber;                  
		WHILE i <= MaxNumber          
		DO                                     
		  BEGIN
		    Sieve := Sieve - [i]; 
            i := i + StartNumber    
		  END;
		WRITE(StartNumber , ' ')
      END;
	S
  END;
  WRITELN          tartNumber := StartNumber + 1
END. {SieveOfEratosthenes}
