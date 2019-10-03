Update banksubmitformat set DateField1 = NULL 
where banksubmitsubmitforid = 'Salary' and formatname = 'Citibank (Paylink Payroll)' ;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='RBS' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'RBS', 'RSingBankFormatRBSAuto.dll', 'InvokeSalaryFormatter', '0');
END IF;


IF NOT EXISTS(SELECT 1 FROM WageProperty WHERE KeywordId='OTBackPay' AND WageId='AddWage') THEN
INSERT INTO WageProperty (KeywordId, WageId, WagePropertyUsed) VALUES ('OTBackPay','AddWage',1);
END IF;

IF NOT EXISTS(SELECT 1 FROM WageProperty WHERE KeywordId='OTBackPay' AND WageId='OrdWage') THEN
INSERT INTO WageProperty (KeywordId, WageId, WagePropertyUsed) VALUES ('OTBackPay','OrdWage',0);
END IF;

if exists(select * from syscolumn where table_id = (select table_id from systable where table_name='IR8A') and column_name='MalTaxGratuity') then
    alter table IR8A rename MalTaxGratuity to Gratuity;
end if;


commit work;