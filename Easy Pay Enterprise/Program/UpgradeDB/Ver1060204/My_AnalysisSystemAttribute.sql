if not exists(Select * From SystemAttribute  Where SysAttributeId='Ana_ArrearEmpeeEPFWage') then
 Insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) Values('PolicyRecord','Ana_ArrearEmpeeEPFWage','Employee EPF Arrear Wage',1,'','','','','');
end if;
if not exists(Select * From SystemAttribute  Where SysAttributeId='Ana_ArrearEmperEPFWage') then
 Insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) Values('PolicyRecord','Ana_ArrearEmperEPFWage','Employer EPF Arrear Wage',1,'','','','','');
end if;
if not exists(Select * From SystemAttribute  Where SysAttributeId='Ana_ArrearEmpeeEPF') then
 Insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) Values('PolicyRecord','Ana_ArrearEmpeeEPF','Employee EPF Arrear Submission',1,'','','','','');
end if;
if not exists(Select * From SystemAttribute  Where SysAttributeId='Ana_ArrearEmperEPF') then
 Insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) Values('PolicyRecord','Ana_ArrearEmperEPF','Employer EPF Arrear Submission',1,'','','','','');
end if;
if not exists(Select * From SystemAttribute  Where SysAttributeId='Ana_ArrearTotalTaxWage') then
 Insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) Values('PolicyRecord','Ana_ArrearTotalTaxWage','Total Arrear Tax Gross Wage',1,'','','','','');
end if;
if not exists(Select * From SystemAttribute  Where SysAttributeId='Ana_ArrearTotalTaxAmt') then
 Insert into SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5 ) Values('PolicyRecord','Ana_ArrearTotalTaxAmt','Total Arrear Tax Amount',1,'','','','','');
end if;