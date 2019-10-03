if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEmployeeKeyCostCentre') then
   drop FUNCTION FGetEmployeeKeyCostCentre
end if
;
Create FUNCTION DBA.FGetEmployeeKeyCostCentre(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_CostCentreId char(20);
  select EmployeeCostCentre.CostCentreId into Out_CostCentreId
    from EmployeeCostCentre join CostProgression on
    EmployeeCostCentre.CostProgSysId = CostProgression.CostProgSysId where
    CostProgression.EmployeeSysId = In_EmployeeSysId and KeyCostCentre = 1 and
    CostProgression.CostCentreCurrent = 1;
  return(Out_CostCentreId)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCopyBankAlloOtherInfo') then
   drop PROCEDURE ASQLCopyBankAlloOtherInfo
end if
;
Create PROCEDURE DBA.ASQLCopyBankAlloOtherInfo(
in In_EmployeeSysId integer,
in In_CopyBankAll bit,
in In_CopyOtherInfo bit)
BEGIN
   /*Get Personnel's Latest Employement record*/
   Declare Old_EmployeeSysId integer;
   Select FIRST emp.employeesysid into Old_EmployeeSysId 
   From employee as emp where emp.personalsysid = (Select personalsysid from employee where employeesysid = In_EmployeeSysId)
     And employeesysid != In_EmployeeSysId Order By hiredate desc;
   
   IF In_CopyBankAll = 1 THEN   
     /*Copy Data from Bank Allocation*/ 
     BankAlloLoop: For BankInfo AS Dynamic Scroll Cursor FOR
     Select BankId,BankBranchId,BankAccTypeId,BankAccountNo,PaymentValue,PaymentType,PaymentMode,BankRemarks,BeneficiaryName,BankAllocGpId
     From PaymentBankInfo Where EmployeeSysId = Old_EmployeeSysId
     DO 
       CALL InsertNewPaymentBankInfo(In_EmployeeSysId,BankId,BankBranchId,BankAccountNo,PaymentValue,PaymentType,BankAccTypeId,PaymentMode,BankRemarks,BeneficiaryName,BankAllocGpId);
     END FOR;
   END IF;
   
   IF In_CopyOtherInfo = 1 THEN   
     /*Copy Data from Employee Other Info*/   
     OtherInfoLoop: For OtherIno AS Scroll Cursor FOR
     Select EmpeeOtherInfoId,EmpeeOtherInfoCaption,EmpeeOtherInfoType,EmpeeOtherInfoDate,EmpeeOtherInfoString,EmpeeOtherInfoBoolean,EmpeeOtherInfoDouble 
     From EmpeeOtherInfo Where EmployeeSysId = Old_EmployeeSysId
     DO
       CALL UpdateEmpeeOtherInfo(In_EmployeeSysId,EmpeeOtherInfoId,EmpeeOtherInfoType,EmpeeOtherInfoCaption,EmpeeOtherInfoDate,EmpeeOtherInfoString,EmpeeOtherInfoBoolean,EmpeeOtherInfoDouble);
     END FOR;
   END IF;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetServiceYear') then
   drop FUNCTION FGetServiceYear
end if
;
CREATE FUNCTION DBA.FGetServiceYear( 
In In_FromDate date,
In In_ToDate date)
RETURNS double
BEGIN
    DECLARE Out_ServiceYear double;
    DECLARE Temp_FromDate integer;
    DECLARE Temp_ToDate integer;
    DECLARE Temp_DateDiff integer;
    DECLARE Temp_DateDiffRem integer;
    
    IF (In_FromDate < YMD(DATEPART(Year,In_FromDate),2,29)) THEN
      SET Temp_FromDate = YMD(DATEPART(Year,In_FromDate),1,1)
    ELSE 
      SET Temp_FromDate = YMD(DATEPART(Year,In_FromDate) +1,1,1)
    END IF;

    IF (In_ToDate < YMD(DATEPART(Year,In_ToDate),2,29)) THEN
      SET Temp_ToDate = YMD(DATEPART(Year,In_ToDate),1,1)
    ELSE 
      SET Temp_ToDate = YMD(DATEPART(Year,In_ToDate) +1,1,1)
    END IF;
    
    SET Temp_DateDiff = DATEDIFF(DAY,In_FromDate,In_ToDate);
    SET Temp_DateDiffRem = MOD(DATEDIFF(DAY,Temp_FromDate,Temp_ToDate),365);
    SET Out_ServiceYear = ROUND(CAST((Temp_DateDiff - Temp_DateDiffRem) AS DOUBLE)/365,10);
    RETURN Out_ServiceYear;
END
;

COMMIT WORK;

