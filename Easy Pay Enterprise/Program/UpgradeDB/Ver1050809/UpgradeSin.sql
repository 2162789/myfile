READ UpgradeDB\Ver1050809\Entity.sql;
READ UpgradeDB\Ver1050809\StoredProc.sql;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'Salary' AND FormatName = 'Deutsche Internet (Direct-DB)' )
THEN 
  INSERT INTO BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke)
  VALUES ('Salary','Deutsche Internet (Direct-DB)','RSingBankFormatDeutscheDirectDBInternet.dll','InvokeSalaryFormatter')
END IF; 

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050809, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;