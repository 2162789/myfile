Read UpgradeDB\Ver1070404\AllScript.sql;

Update Keyword Set KeywordUserDefinedName ='YTD Supplementary Difference', KeywordDefaultName ='YTD Supplementary Difference' Where KeywordId='TaxYTDCumulative';
Commit work;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070404, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;