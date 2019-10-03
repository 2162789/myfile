// Citibank (Direct G3)
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Citibank (Direct G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Citibank (Direct G3)', 'RSingBankFormatCitibankDirectG3.dll', 'InvokeSalaryFormatter', 0);
end if;
commit work;

// Singapore Payslip CS1 Rpt config
/* SystemRptComp */
IF NOT EXISTS (SELECT * FROM SystemRptComp WHERE SysRptId='Payslip - CS 1' and SysRptCompName='CheckBox_Dept') THEN
INSERT INTO SystemRptComp (SysRptId, SysRptCompName, SysRptCompDesc, SysRptCompType, IsRptKey,RptkeyIndex)
VALUES ('Payslip - CS 1','CheckBox_Dept','Department','int',0,NULL)
END IF;

/* RptCompConfig */
IF NOT EXISTS (SELECT * FROM RptCompConfig WHERE RptCompSysId='Sys_205' ) THEN
INSERT INTO RptCompConfig (RptCompSysId, RptConfigID, SysRptId, SysRptCompName)
VALUES ('Sys_205','_Payslip - CS 1','Payslip - CS 1','CheckBox_Dept')
END IF;

/* RptCompItemConfig */

IF NOT EXISTS (SELECT * FROM RptCompItemConfig WHERE RptCompSysId='Sys_205' AND RptCompItemSysID = 1) THEN
INSERT INTO RptCompItemConfig (RptCompSysId, RptCompItemSysID, ItemValue)
VALUES ('Sys_205','1','1')
END IF;

COMMIT WORK;
