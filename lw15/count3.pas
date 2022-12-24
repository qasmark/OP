UNIT Count3;
INTERFACE  
        
PROCEDURE Start; {Sets counter's value to 0}
PROCEDURE Bump; {Increases counter's value by 1}
PROCEDURE Value(VAR V100, V10, V1: CHAR); {Returns counter's value}

IMPLEMENTATION
VAR 
  Ones, Tens, Hundreds: CHAR;

PROCEDURE Start;
{Ones = '0', Tens = '0', Hundreds = '0'}
BEGIN {Start}
  Ones:='0';
  Tens:='0';
  Hundreds:='0'
END; {Start}

PROCEDURE NextDigit(VAR Digit: CHAR);
{Digit = a -> 
 Digit = a + 1, if a < 9; or
 Digit = '0', if a = '9'}
BEGIN {NextDigit} 
  IF Digit = '0' THEN Digit := '1'
  ELSE IF Digit = '1' THEN Digit := '2'
  ELSE IF Digit = '2' THEN Digit := '3'
  ELSE IF Digit = '3' THEN Digit := '4'
  ELSE IF Digit = '4' THEN Digit := '5'
  ELSE IF Digit = '5' THEN Digit := '6'
  ELSE IF Digit = '6' THEN Digit := '7'
  ELSE IF Digit = '7' THEN Digit := '8'
  ELSE IF Digit = '8' THEN Digit := '9'
  ELSE 
    Digit := '0'
END; {NextDigit}

PROCEDURE Bump;
{Ones = a, Tens = b, Hundreds = c ->
 Ones = a + 1, if a < 9; 
 else Onse = 0, Tens = b + 1, if b < 9; 
 else Onse = 0, Tens = 0, Hundreds = c + 1, if c < 9; 
 else Onse = 0, Tens = 0, Hundreds = 0}
VAR Increased: CHAR;
BEGIN {Bump}
  NextDigit(Ones);
  IF Ones = '0'
  THEN 
    BEGIN
      NextDigit(Tens);
      IF Tens = '0'
      THEN 
      BEGIN 
        NextDigit(Hundreds);
        Start
      END
    END 		
END; {Bump}

PROCEDURE Value(VAR V100, V10, V1: CHAR);
{V100 = Hundreds, V10 = Tens, V1 = Ones}
BEGIN {Value}
  V100 := Hundreds;
  V10 := Tens;
  V1 := Ones
END; {Value}

BEGIN {Count3}
	Start
END. {Count3}
