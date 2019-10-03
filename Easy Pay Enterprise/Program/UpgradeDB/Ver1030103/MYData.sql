INPUT INTO "DBA"."SystemAttribute"
FROM UpgradeDB\Ver1030103\AnalysisSystemAttribute_MY.dat
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."AnItemLookup"
FROM UpgradeDB\Ver1030103\AnItemLookup_MY.dat
FORMAT ASCII
BY ORDER;


