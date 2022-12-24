PROGRAM GroupWords(INPUT, OUTPUT);
USES 
  Stemming;
VAR
  InpPath, OutPath: STRING;  

BEGIN {GroupWords}               

  InpPath := 'Output.txt';
  OutPath := 'GroupedOutput.txt';
  WRITELN('Grouping was started');
  GroupWords(InpPath, OutPath) 

END. {GroupWords}
