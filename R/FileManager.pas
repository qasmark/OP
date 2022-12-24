UNIT FileManager;
{Модуль для работы с файлами}
INTERFACE
USES
  WordReader, TreeWorker;

PROCEDURE WriteWord(VAR Root: Tree; Word: STRING);
PROCEDURE PrintTreeFile(VAR FOut: TEXT);
PROCEDURE ClearTree(VAR Root: Tree);
PROCEDURE ProcessText(VAR Root: Tree);
PROCEDURE PrintStats;

IMPLEMENTATION
CONST
  Separator = ' ';
  MaxNodes = 60000;
  TestFilename = 'wap.txt';
  StatsFilename = 'stats.txt';

TYPE
  TreeFile = FILE OF Node;

VAR
  NodeCnt: INTEGER;
  IsFirstTree: BOOLEAN;
  TempFile1, TempFile2: TreeFile;
  StatsFile, TestFile: TEXT;

PROCEDURE CopyTreeToFile(VAR Root: Tree; VAR FOut: TreeFile);
{Переносит дерево во временный файл в отсортированном виде}
BEGIN
  IF Root <> NIL
  THEN
    BEGIN
      CopyTreeToFile(Root^.LLink, FOut);
      WRITE(FOut, Root^);
      CopyTreeToFile(Root^.RLink, FOut)
    END
END;

PROCEDURE MergeRoutine(VAR Ptr: Tree; VAR FileNode: Node; VAR FileNodeReaded: BOOLEAN);
{Процесс объединения дерева с данными из файла в отсортированном виде}
VAR
  PtrPositionFound, PtrNodeInserted: BOOLEAN;
BEGIN
  IF Ptr <> NIL
  THEN
    BEGIN
      MergeRoutine(Ptr^.LLink, FileNode, FileNodeReaded);
      PtrPositionFound := FALSE;
      PtrNodeInserted := FALSE;
      WHILE (NOT PtrPositionFound) AND (NOT PtrNodeInserted) AND (NOT EOF(TempFile1))
      DO
        BEGIN
          IF NOT FileNodeReaded
          THEN
            READ(TempFile1, FileNode);

          IF FileNode.Word < Ptr^.Word
          THEN
            BEGIN
              WRITE(TempFile2, FileNode);
              FileNodeReaded := FALSE
            END
          ELSE
            IF FileNode.Word = Ptr^.Word
            THEN
              BEGIN
                FileNode.Amount := FileNode.Amount + Ptr^.Amount;
                WRITE(TempFile2, FileNode);
                PtrNodeInserted := TRUE;
                FileNodeReaded := FALSE
              END
            ELSE
              BEGIN
                PtrPositionFound := TRUE;
                FileNodeReaded := TRUE
              END
        END;
      IF NOT PtrNodeInserted
      THEN
        WRITE(TempFile2, Ptr^);
      MergeRoutine(Ptr^.RLink, FileNode, FileNodeReaded)
    END
END;
  
PROCEDURE MergeTreeWithFile(VAR Root: Tree);
{Объединение дерева с файлом}
VAR
  FileNode: Node;
  FileNodeReaded: BOOLEAN;
BEGIN
  RESET(TempFile1);
  REWRITE(TempFile2);
  FileNodeReaded := FALSE;
  MergeRoutine(Root, FileNode, FileNodeReaded);
  // Перенос остатка из первого файла во второй
  IF FileNodeReaded
  THEN
    WRITE(TempFile2, FileNode);
  WHILE NOT EOF(TempFile1)
  DO
    BEGIN
      READ(TempFile1, FileNode);
      WRITE(TempFile2, FileNode)
    END;
  // Перенос данных из второго файла в первый
  RESET(TempFile2);
  REWRITE(TempFile1);
  WHILE NOT EOF(TempFile2)
  DO
    BEGIN
      READ(TempFile2, FileNode);
      WRITE(TempFile1, FileNode)
    END
END;
  
PROCEDURE ClearTree(VAR Root: Tree);
{Очистка дерева с переносом данных во временный файл}
BEGIN
  IF NodeCnt <> 0
  THEN
    IF IsFirstTree
    THEN
      BEGIN
        REWRITE(TempFile1);
        CopyTreeToFile(Root, TempFile1);
        IsFirstTree := FALSE
      END
    ELSE
      MergeTreeWithFile(Root);
  DisposeTree(Root)
END;
  
PROCEDURE WriteWord(VAR Root: Tree; Word: STRING);
{Запись слова с проверкой на максимальное количество записей в дереве}
BEGIN
  IF InsertWord(Root, Word)
  THEN
    NodeCnt := NodeCnt + 1;
  IF NodeCnt = MaxNodes
  THEN
    BEGIN
      ClearTree(Root);
      NodeCnt := 0
    END
END;

PROCEDURE PrintTreeFile(VAR FOut: TEXT);
{Вывод отсортированных данных в файл}
VAR
  FileNode: Node;
BEGIN
  RESET(TempFile1);
  WHILE NOT EOF(TempFile1)
  DO
    BEGIN
      READ(TempFile1, FileNode);
      WRITELN(FOut, FileNode.Word, Separator, FileNode.Amount)
    END
END;

PROCEDURE ProcessText(VAR Root: Tree);
{Обработка входного текста}
VAR
  Word: STRING;
BEGIN
  Word := EmptyWord;
  ASSIGN(TestFile, TestFilename);
  RESET(TestFile);

  WHILE NOT EOF(TestFile)
  DO
    BEGIN
      ReadWord(Word, TestFile);
      IF Word <> EmptyWord
      THEN
        BEGIN
          WriteWord(Root, Word);
          Word := EmptyWord
        END
    END;
  ClearTree(Root)
END;

PROCEDURE PrintStats;
{Вывод обработанной статистики}
BEGIN
  ASSIGN(StatsFile, StatsFilename);
  REWRITE(StatsFile);
  PrintTreeFile(StatsFile)
END;

BEGIN
  IsFirstTree := TRUE;
  NodeCnt := 0
END.
