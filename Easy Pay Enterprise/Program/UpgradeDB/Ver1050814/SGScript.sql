If not exists(select * from DBA.SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'CheckBox_IncludeLogo') then
  INSERT INTO DBA.SystemRptComp (SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey)
  VALUES ('Payslip - Laser','CheckBox_IncludeLogo','Include Company Letterhead','int',0 );
End If;

COMMIT WORK;