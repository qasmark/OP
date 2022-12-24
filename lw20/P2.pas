PROGRAM PrintX(INPUT, OUTPUT);
USES 
  PseudoGraphics;
VAR
  AlphabetFile: TEXT;
BEGIN
  Assign(AlphabetFile, 'alph.txt');
  Reset(AlphabetFile);
  LoadAlphabet(AlphabetFile);
  IF NOT PrintInline(INPUT, OUTPUT)
  THEN
    WRITELN  
END.
