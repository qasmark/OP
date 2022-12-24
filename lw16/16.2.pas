PROGRAM SarahRever(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 

BEGIN {SarahRever}
	{Инициализация}
	Looking := NOT EOLN;
	W1 := ' ';
	W2 := ' ';
	W3 := ' ';
	W4 := ' ';    
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN              
      {Движение окна}     
	  W1 := W2;         
	  W2 := W3;
  	  W3 := W4;
	  READ(W4);
      Looking := NOT EOLN;						
      {проверка окна на sea}
      Sea := (W2 = 's') AND (W3 = 'e') AND (W4 = 'a');
      {проверка окна на land}
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd')
    END;
  {Создание сообщения Sarah}
  IF Land
  THEN 
	WRITELN('The British are coming by land')
  ELSE 
    IF Sea
	THEN 
	  WRITELN('The British are coming by sea')
   ELSE 
     WRITELN('Sarah didn''t say')
END. {SarahRever}
