READ UpgradeDB\Ver1060903\SGStoredProc.sql;
READ UpgradeDB\Ver1060903\StoredProc.sql;
READ UpgradeDB\Ver1060903\2015SG_PH.sql;


if not exists(select * from Formula where formulaid = 'CDAC2015') then
   Insert into Formula Values('CDAC2015',1,0,0,'PayElement','Deduction','Tabulated','CPFContriWage','Chinese Development Assistance Fund 2015','',30,1);
   Insert into FormulaRange Values('CDAC2015',1,2000.01,0.1,'C1;',-0.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('CDAC2015',2,3500.01,2000.01,'C1;',-1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('CDAC2015',3,5000.01,3500.01,'C1;',-1.5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('CDAC2015',4,7500.01,5000.01,'C1;',-2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('CDAC2015',5,99999999,7500.01,'C1;',-3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where formulaid = 'EUCF2015') then
   Insert into Formula Values('EUCF2015',1,0,0,'PayElement','Deduction','Tabulated','CPFContriWage','Eurasian Community Fund 2015','',30,1);
   Insert into FormulaRange Values('EUCF2015',1,1000.01,0.1,'C1;',-2,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('EUCF2015',2,1500.01,1000.01,'C1;',-4,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('EUCF2015',3,2500.01,1500.01,'C1;',-6,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('EUCF2015',4,4000.01,2500.01,'C1;',-9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('EUCF2015',5,7000.01,4000.01,'C1;',-12,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('EUCF2015',6,10000.01,7000.01,'C1;',-16,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('EUCF2015',7,99999999,10000.01,'C1;',-20,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;

if not exists(select * from Formula where formulaid = 'SIND2015') then
   Insert into Formula Values('SIND2015',1,0,0,'PayElement','Deduction','Tabulated','CPFContriWage','SINDA Contribution 2015','',30,1);
   Insert into FormulaRange Values('SIND2015',1,1000.01,0.1,'C1;',-1,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',2,1500.01,1000.01,'C1;',-3,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',3,2500.01,1500.01,'C1;',-5,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',4,4500.01,2500.01,'C1;',-7,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',5,7500.01,4500.01,'C1;',-9,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',6,10000.01,7500.01,'C1;',-12,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',7,15000.01,10000.01,'C1;',-18,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
   Insert into FormulaRange Values('SIND2015',8,99999999,15000.01,'C1;',-30,0,0,0,0,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'CDAC2015' and KeyWordId = 'CDACCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('CDACCode','CDAC2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'CDAC2015' and KeyWordId = 'DonationCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DonationCode','CDAC2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'CDAC2015' and KeyWordId = 'DeductCap') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DeductCap','CDAC2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'EUCF2015' and KeyWordId = 'DonationCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DonationCode','EUCF2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'EUCF2015' and KeyWordId = 'EUCFCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('EUCFCode','EUCF2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'EUCF2015' and KeyWordId = 'DeductCap') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DeductCap','EUCF2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'SIND2015' and KeyWordId = 'DonationCode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DonationCode','SIND2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'SIND2015' and KeyWordId = 'SINDACode') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('SINDACode','SIND2015');
end if;

if not exists(select * from FormulaProperty where FormulaId = 'SIND2015' and KeyWordId = 'DeductCap') then
   insert into FormulaProperty(KeyWordId,FormulaId) Values('DeductCap','SIND2015');
end if;




//-------------------------------
// Create 'View_Acc_SG_TimeSheet'
//-------------------------------

If NOT exists(select table_name FROM systable where table_type='view' and table_name = 'View_Acc_SG_TimeSheet')
then
CREATE VIEW "DBA"."View_Acc_SG_TimeSheet"
AS
  SELECT
   TimeSheet.TMSSGSPGenID, 

   TMSYear, 
   TMSPeriod,
   TMSSubPeriod, 
   TMSPayRecId, 
   TMSType,
   TMSDate,

   TMSProjectId,
   TimeSheet.JobCode,
   TMSCostCentreId,
   JobCodeRefNo,
   JobCodeDesc,

   EmployeeID,
   EmployeeName,
   HireDate,
   CessationDate,
   BranchId,
   CategoryId,
   DepartmentId,

   TMSPaymentType,
   (SELECT CurrentBasicRateType FROM PayEmployee WHERE EmployeeSysId=TimeSheet.EmployeeSysId) AS CurrentSalaryType,
   TMSBRDayHourRate,
   TMSWorkingDayHour,
   Description AS TMSDescription,
   BasicRateCostingAmt,
   BackPayCostingAmt,

   (CASE WHEN _LeaveDeductionAmt IS NULL THEN 0 ELSE _LeaveDeductionAmt END) AS LeaveDeductionAmt,
   (CASE WHEN _OTAmt IS NULL THEN 0 ELSE _OTAmt END) AS OTAmt,
   (CASE WHEN _ShiftAmt IS NULL THEN 0 ELSE _ShiftAmt END) AS ShiftAmt,

   (CASE WHEN _TsCurOrdCPFWage IS NULL THEN 0 ELSE _TsCurOrdCPFWage END) AS TsCurOrdCPFWage,
   (CASE WHEN _TsEECurOrdCPF IS NULL THEN 0 ELSE _TsEECurOrdCPF END) AS TsEECurOrdCPF,
   (CASE WHEN _TsERCurOrdCPF IS NULL THEN 0 ELSE _TsERCurOrdCPF END) AS TsERCurOrdCPF,
   (CASE WHEN _TsSDF IS NULL THEN 0 ELSE _TsSDF END) AS TsSDF,
   (CASE WHEN _TsFWL IS NULL THEN 0 ELSE _TsFWL END) AS TsFWL,

   (CASE WHEN _TotalAllowance IS NULL THEN 0 ELSE _TotalAllowance END) AS TotalAllowance,
   (CASE WHEN _TotalDeduction IS NULL THEN 0 ELSE _TotalDeduction END) AS TotalDeduction,
   (CASE WHEN _TotalReimbursement IS NULL THEN 0 ELSE _TotalReimbursement END) AS TotalReimbursement,

   (SELECT sum(CurrentCostingAmt+PreviousCostingAmt) FROM TMSLeaveDeduction WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _LeaveDeductionAmt,
   (SELECT sum(CurrentCostingAmt+LastOTCostingAmt+BackPayOTCostingAmt) FROM TMSOvertime WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _OTAmt,
   (SELECT sum(CostingAmount) FROM TMSShift WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _ShiftAmt,

   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurOrdCPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurOrdCPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEECurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERCurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsSDF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsSDF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsFWL' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsFWL,

   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Allowance' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalAllowance,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Deduction' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalDeduction,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Reimbursement' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalReimbursement
 
   FROM (TimeSheet LEFT OUTER JOIN TMSDetail) JOIN Employee ON TimeSheet.EmployeeSysID=Employee.EmployeeSysID JOIN JobCode ON JobCode.JobCode=TimeSheet.JobCode
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);
 else

ALTER VIEW "DBA"."View_Acc_SG_TimeSheet"
AS
  SELECT
   TimeSheet.TMSSGSPGenID, 

   TMSYear, 
   TMSPeriod,
   TMSSubPeriod, 
   TMSPayRecId, 
   TMSType,
   TMSDate,

   TMSProjectId,
   TimeSheet.JobCode,
   TMSCostCentreId,
   JobCodeRefNo,
   JobCodeDesc,

   EmployeeID,
   EmployeeName,
   HireDate,
   CessationDate,
   BranchId,
   CategoryId,
   DepartmentId,

   TMSPaymentType,
   (SELECT CurrentBasicRateType FROM PayEmployee WHERE EmployeeSysId=TimeSheet.EmployeeSysId) AS CurrentSalaryType,
   TMSBRDayHourRate,
   TMSWorkingDayHour,
   Description AS TMSDescription,
   BasicRateCostingAmt,
   BackPayCostingAmt,

   (CASE WHEN _LeaveDeductionAmt IS NULL THEN 0 ELSE _LeaveDeductionAmt END) AS LeaveDeductionAmt,
   (CASE WHEN _OTAmt IS NULL THEN 0 ELSE _OTAmt END) AS OTAmt,
   (CASE WHEN _ShiftAmt IS NULL THEN 0 ELSE _ShiftAmt END) AS ShiftAmt,

   (CASE WHEN _TsCurOrdCPFWage IS NULL THEN 0 ELSE _TsCurOrdCPFWage END) AS TsCurOrdCPFWage,
   (CASE WHEN _TsEECurOrdCPF IS NULL THEN 0 ELSE _TsEECurOrdCPF END) AS TsEECurOrdCPF,
   (CASE WHEN _TsERCurOrdCPF IS NULL THEN 0 ELSE _TsERCurOrdCPF END) AS TsERCurOrdCPF,
   (CASE WHEN _TsSDF IS NULL THEN 0 ELSE _TsSDF END) AS TsSDF,
   (CASE WHEN _TsFWL IS NULL THEN 0 ELSE _TsFWL END) AS TsFWL,

   (CASE WHEN _TotalAllowance IS NULL THEN 0 ELSE _TotalAllowance END) AS TotalAllowance,
   (CASE WHEN _TotalDeduction IS NULL THEN 0 ELSE _TotalDeduction END) AS TotalDeduction,
   (CASE WHEN _TotalReimbursement IS NULL THEN 0 ELSE _TotalReimbursement END) AS TotalReimbursement,

   (SELECT sum(CurrentCostingAmt+PreviousCostingAmt) FROM TMSLeaveDeduction WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _LeaveDeductionAmt,
   (SELECT sum(CurrentCostingAmt+LastOTCostingAmt+BackPayOTCostingAmt) FROM TMSOvertime WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _OTAmt,
   (SELECT sum(CostingAmount) FROM TMSShift WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _ShiftAmt,

   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurOrdCPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurOrdCPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEECurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERCurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsSDF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsSDF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsFWL' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsFWL,

   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Allowance' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalAllowance,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Deduction' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalDeduction,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Reimbursement' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalReimbursement
 
   FROM (TimeSheet LEFT OUTER JOIN TMSDetail) JOIN Employee ON TimeSheet.EmployeeSysID=Employee.EmployeeSysID JOIN JobCode ON JobCode.JobCode=TimeSheet.JobCode
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);

end if;


Update ModuleScreenGroup
set IsEPClassic = 1
Where ModuleScreenId in ('EC_PayCPFProgRpt','EC_PayFWLProgRpt','EC_PayEPProgRpt');




commit work;