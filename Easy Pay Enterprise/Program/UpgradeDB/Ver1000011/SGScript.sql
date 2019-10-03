if exists (select * from modulescreengroup where IsEPClassic = 1) then 
	Delete from ModuleScreenGroup Where IsEPClassic=1;
end if;

//1. 3DBSDisk
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='3DBSDisk') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', '3DBSDisk', 'RSingBankFormat3DBSDisk.dll', 'InvokeSalaryFormatter', '0');
END IF;

//2. ABN Amro
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='ABN Amro') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'ABN Amro', 'RSingBankFormatABNAmro.dll', 'InvokeSalaryFormatter', '0');
END IF;

//3. Bank Boston
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Bank Boston') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Bank Boston', 'RSingBankFormatBankBoston.dll', 'InvokeSalaryFormatter', '0');
END IF;

//4. BNP
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='BNP') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BNP', 'RSingBankFormatBNP.dll', 'InvokeSalaryFormatter', '0');
END IF;

//5. BNP (CONNEXIS)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='BNP (CONNEXIS)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BNP (CONNEXIS)', 'RSingBankFormatBNPCONNEXIS.dll', 'InvokeSalaryFormatter', '0');
END IF;

//6. BOA (Trans)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='BOA (Trans)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BOA (Trans)', 'RSingBankFormatBOATrans.dll', 'InvokeSalaryFormatter', '0');
END IF;

//7. BOA (Wanda)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='BOA (Wanda)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BOA (Wanda)', 'RSingBankFormatBOAWanda.dll', 'InvokeSalaryFormatter', '0');
END IF;

//8. Chase Manhattan
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Chase Manhattan') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Chase Manhattan', 'RSingBankFormatChaseManhattan.dll', 'InvokeSalaryFormatter', '0');
END IF;

//9. Chase Manhattan (New)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Chase Manhattan (New)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Chase Manhattan (New)', 'RSingBankFormatChaseManhattanNew.dll', 'InvokeSalaryFormatter', '0');
END IF;

//10. Citibank (BFT)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Citibank (BFT)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Citibank (BFT)', 'RSingBankFormatCitibankBFT.dll', 'InvokeSalaryFormatter', '0');
END IF;

//11. Citibank (CitiDirect 4.1)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Citibank (CitiDirect 4.1)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Citibank (CitiDirect 4.1)', 'RSingBankFormatCitibankCitiDirect41.dll', 'InvokeSalaryFormatter', '0');
END IF;

//12. Citibank (E-Giro)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Citibank (eGiro)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Citibank (eGiro)', 'RSingBankFormatCitibankEGiro.dll', 'InvokeSalaryFormatter', '0');
END IF;

//13. Citibank (Paylink Payroll)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Citibank (Paylink Payroll)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Citibank (Paylink Payroll)', 'RSingBankFormatCitibankPaylinkPayroll.dll', 'InvokeSalaryFormatter', '0');
END IF;

//14. Credit Agricole OPTIM
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Credit Agricole OPTIM') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Credit Agricole OPTIM', 'RSingBankFormatCreditAgricoleBankOPTIM.dll', 'InvokeSalaryFormatter', '0');
END IF;

//15. Deutsche (Giro)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Deutsche (Giro)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Deutsche (Giro)', 'RSingBankFormatDeutscheGiro.dll', 'InvokeSalaryFormatter', '0');
END IF;

//16. Deutsche Internet
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Deutsche Internet') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Deutsche Internet', 'RSingBankFormatDeutscheInternet.dll', 'InvokeSalaryFormatter', '0');
END IF;

//17. Fuji Bank
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Fuji Bank') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Fuji Bank', 'RSingBankFormatFujiBank.dll', 'InvokeSalaryFormatter', '0'); 
END IF;

//18. HSBC (AutoPay)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='HSBC (AutoPay)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'HSBC (AutoPay)', 'RSingBankFormatHSBCAutoPay.dll', 'InvokeSalaryFormatter', '0');
END IF;

//19. HSBC (Hexagon)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='HSBC (Hexagon)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'HSBC (Hexagon)', 'RSingBankFormatHSBCHexagon.dll', 'InvokeSalaryFormatter', '0');
END IF;

//20. IBS (Skip this first, waiting for spec)


//21. ICB
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='ICB') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'ICB', 'RSingBankFormatICB.dll', 'InvokeSalaryFormatter', '0');
END IF;

//22. JP Morgan (GMT)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='JPMorgan (GMT)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'JPMorgan (GMT)', 'RSingBankFormatJPMorganGMT.dll', 'InvokeSalaryFormatter', '0');
END IF;

//23. Keppel TatLee
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Keppel TatLee Bank') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Keppel TatLee Bank', 'RSingBankFormatKeppelTatLee.dll', 'InvokeSalaryFormatter', '0');
END IF;

//24. MayBank
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Maybank') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Maybank', 'RSingBankFormatMaybank.dll', 'InvokeSalaryFormatter', '0');
END IF;

//25. Mitsubishi Bank
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Mitsubishi Bank') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Mitsubishi Bank', 'RSingBankFormatMitsubishiBank.dll', 'InvokeSalaryFormatter', '0');
END IF;

//26. Mizuho (Giro)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Mizuho (Giro)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Mizuho (Giro)', 'RSingBankFormatMizuhoGiro.dll', 'InvokeSalaryFormatter', '0');
END IF;

//27. OCBC
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='OCBC') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'OCBC', 'RSingBankFormatOCBC.dll', 'InvokeSalaryFormatter', '0');
END IF;

//28. OCBC (Listing)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='OCBC (Listing)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'OCBC (Listing)', 'RSingBankFormatOCBCListing.dll', 'InvokeSalaryFormatter', '0');
END IF;

//29. OUB (Hash Total)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='OUB (Hash Total)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'OUB (Hash Total)', 'RSingBankFormatOUBHashTotal.dll', 'InvokeSalaryFormatter', '0');
END IF;

//30. POSB (DPAY1)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='POSB (DPAY1)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'POSB (DPAY1)', 'RSingBankFormatPOSBDPay1.dll', 'InvokeSalaryFormatter', '0');
END IF;

//31. POSB (DPAY2)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='POSB (DPAY2)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'POSB (DPAY2)', 'RSingBankFormatPOSBDPay2.dll', 'InvokeSalaryFormatter', '0');
END IF;

//32. Sakura Bank
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Sakura Bank') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Sakura Bank', 'RSingBankFormatSakuraBank.dll', 'InvokeSalaryFormatter', '0');
END IF;

//33. Sanwa Bank
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Sanwa Bank') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Sanwa Bank', 'RSingBankFormatSanwaBank.dll', 'InvokeSalaryFormatter', '0');
END IF;

//34. Sanwa Bank (UFJ)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Sanwa Bank (UFJ)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Sanwa Bank (UFJ)', 'RSingBankFormatSanwaBankUFJ.dll', 'InvokeSalaryFormatter', '0');
END IF;

//35. Standard Chartered (New)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Standard Chartered (New)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Standard Chartered (New)', 'RSingBankFormatStandardCharteredNew.dll', 'InvokeSalaryFormatter', '0');
END IF;

//36. Standard Chartered (NPS)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Standard Chartered (NPS)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Standard Chartered (NPS)', 'RSingBankFormatStandardCharteredNPS.dll', 'InvokeSalaryFormatter', '0');
END IF;

//37. Standard Chartered (STS)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Standard Chartered (STS)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Standard Chartered (STS)', 'RSingBankFormatStandardCharteredSTS.dll', 'InvokeSalaryFormatter', '0');
END IF;

//38. Sumitomo
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Sumitomo') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Sumitomo', 'RSingBankFormatSumitomoOld.dll', 'InvokeSalaryFormatter', '0');
END IF;

//39. Sumitomo (Giro)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Sumitomo (Giro)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Sumitomo (Giro)', 'RSingBankFormatSumitomoGiro.dll', 'InvokeSalaryFormatter', '0');
END IF;

//40. UOB
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='UOB') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'UOB', 'RSingBankFormatUOB.dll', 'InvokeSalaryFormatter', '0');
END IF;

//41. UOB (CMS) 
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='UOB (CMS)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'UOB (CMS)', 'RSingBankFormatUOBCMS.dll', 'InvokeSalaryFormatter', '0');
END IF;

//42. UOB (Listing)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='UOB (Listing)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'UOB (Listing)', 'RSingBankFormatUOBListing.dll', 'InvokeSalaryFormatter', '0');
END IF;

//43. UOB (Netsfedi)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='UOB (Netsfedi)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'UOB (Netsfedi)', 'RSingBankFormatUOBNetsfedi.dll', 'InvokeSalaryFormatter', '0');
END IF;

//44. UOB (YR2K - WEB)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='UOB (YR2K - WEB)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'UOB (YR2K - WEB)', 'RSingBankFormatUOBYR2KWEB.dll', 'InvokeSalaryFormatter', '0');
END IF;

//45. UOB (YR2K)
IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='UOB (YR2K)') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'UOB (YR2K)', 'RSingBankFormatUOBYR2K.dll', 'InvokeSalaryFormatter', '0');
END IF;

