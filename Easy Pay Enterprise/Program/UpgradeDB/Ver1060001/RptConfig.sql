Update RptConfig Set RptFileType='RptFilePDF' where RptFileType='RptFileTXT';


//----- Insert for Payslip - Laser ----- 

IF EXISTS(SELECT * FROM "DBA"."SubRegistry" where SubRegistryID='DBCountry' 
AND  RegProperty1 IN ('Indonesia','Philippines','Thailand','Hong Kong')) THEN

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - Laser','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL);

END IF;


//----- Insert for Payslip - CS 1 ----- 

IF EXISTS(SELECT * FROM "DBA"."SubRegistry" where SubRegistryID='DBCountry' 
AND  RegProperty1 IN ('Singapore')) THEN

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 1','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL);

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 1','Edit_Header','Header Message','AnsiString',0,NULL);

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 1','Edit_Footer','Footer Message','AnsiString',0,NULL);

END IF;


//----- Insert for Payslip - CS 2 ----- 

IF EXISTS(SELECT * FROM "DBA"."SubRegistry" where SubRegistryID='DBCountry' 
AND  RegProperty1 IN ('Singapore','Indonesia','Malaysia','Philippines','Thailand','Hong Kong')) THEN

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 2','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL);

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 2','Edit_Header','Header Message','AnsiString',0,NULL);

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 2','Edit_Footer','Footer Message','AnsiString',0,NULL);

END IF;

//----- Insert for Payslip - CS 3 ----- 

IF EXISTS(SELECT * FROM "DBA"."SubRegistry" where SubRegistryID='DBCountry' 
AND  RegProperty1 IN ('Philippines')) THEN

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 3','CheckBox_IncludeLogo','Include Company Letterhead','int',0,NULL);

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 3','Edit_Header','Header Message','AnsiString',0,NULL);

Insert INTO SystemRptComp
(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
VALUES('Payslip - CS 3','Edit_Footer','Footer Message','AnsiString',0,NULL);

END IF;
