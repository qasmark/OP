PROGRAM GroupWords(INPUT, OUTPUT);
{GroupWords: ����������� ������������ ���� � ����� ������� CountWords}
USES
  Statistics;

CONST
  StatisticsFilename = 'stats.txt';

VAR
  StatisticsFile: TEXT;

BEGIN {GroupWords}
  GroupWords(INPUT);
  ASSIGN(StatisticsFile, StatisticsFilename);
  REWRITE(StatisticsFile);
  PrintStatistics(StatisticsFile)
END. {GroupWords}
