READ UpgradeDB\Ver1050809\Entity.sql;
READ UpgradeDB\Ver1050809\StoredProc.sql;

IF EXISTS (SELECT * FROM BankSubmitFormat WHERE BankSubmitSubmitForId = 'Salary' AND FormatName = 'EON Bank (Online)')
THEN 
  UPDATE BankSubmitFormat
  SET FormatterInvoke = 'InvokeSalaryOnlineFormatter'
  WHERE BankSubmitSubmitForId = 'Salary' AND FormatName = 'EON Bank (Online)' 
END IF; 

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050809, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;