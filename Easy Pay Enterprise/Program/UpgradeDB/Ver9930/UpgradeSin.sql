READ UpgradeDB\Ver9930\Entity.sql;
READ UpgradeDB\Ver9930\SingStoredProc.sql;
READ UpgradeDB\Ver9930\SpecialRequest.sql;

if not exists(select * from YEKeyword where YEKeywordId = 'UENO') then 
	insert into YEKeyword  (YEKeyWordId, YEKeyWordUserDefinedName, YEProperty1, YEKeyWordCategory) values ('UENO', 'Business Registration number issued by ACRA', 'U', 'PayerID'); 
end if;

Update YEKeyword set YEKeyWordUserDefinedName = 'UEN' where YEKeyWordId = 'ROB';

update YEKeyword set YEKeyWordUserDefinedName = 'UEN-Local' where YEKeyWordId = 'ROC';

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Citibank Direct 4.5.1') THEN
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, BooleanField1) values
	('Salary', 'Citibank Direct 4.5.1', 'RSingBankFormatCitibankDirect451.dll', 'InvokeSalaryFormatter', 0); 
END IF;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9930, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;