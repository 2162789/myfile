INPUT INTO "DBA"."Keyword"
FROM "UpgradeDB\Ver1010002\PhExemption.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."Keyword"
FROM "UpgradeDB\Ver1010002\PhKeyword.dat"
FORMAT ASCII
BY ORDER;

INPUT INTO "DBA"."SubRegistry"
FROM "UpgradeDB\Ver1010002\PhSubRegistry.dat"
FORMAT ASCII
BY ORDER;

commit work;