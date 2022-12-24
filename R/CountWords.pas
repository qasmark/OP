PROGRAM CountWords(INPUT, OUTPUT);

USES
  TreeWorker, FileManager;

VAR
  Root: Tree;
  
BEGIN
  Root := NIL;
  
  ProcessText(Root);
  PrintStats;
  WRITELN('Complete successful!')
END.
