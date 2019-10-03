if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewCustomizedBankInfo') then
   drop procedure InsertNewCustomizedBankInfo
end if;

create procedure DBA.InsertNewCustomizedBankInfo( 
In In_TTEntryGenSysID char(30),
in In_EmployeeSysId integer,
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
BEGIN
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateCustomizedBankInfo') then
   drop procedure UpdateCustomizedBankInfo
end if;

create procedure DBA.UpdateCustomizedBankInfo( 
In In_TTEntryGenSysID char(30),
in In_EmployeeSysId integer,
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
BEGIN
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPaymentBankInfo') then
   drop procedure InsertNewPaymentBankInfo
end if;

create procedure dba.InsertNewPaymentBankInfo(
in In_EmployeeSysId integer,
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
begin
  declare New_PayBankSGSPGenId char(30);
  set New_PayBankSGSPGenId = FGetNewSGSPGeneratedIndex('PaymentBankInfo');
  insert into PaymentBankInfo(PayBankSGSPGenId,
    EmployeeSysId,
    BankId,
    BankBranchId,
    BankAccountNo,
    PaymentValue,
    PaymentType,BankAccTypeId,PaymentMode,BankRemarks,
    BeneficiaryName,
    BankAllocGpId) values(
    New_PayBankSGSPGenId,
    In_EmployeeSysId,
    In_BankId,
    In_BankBranchId,
    In_BankAccountNo,
    In_PaymentValue,
    In_PaymentType,In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
    In_BeneficiaryName,
    In_BankAllocGpId);

    call InsertNewCustomizedBankInfo(New_PayBankSGSPGenId,In_EmployeeSysId,In_BankId,In_BankBranchId,
         In_BankAccountNo,In_PaymentValue,In_PaymentType, In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
         In_BeneficiaryName,In_BankAllocGpId);
  commit work
end
; 

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePaymentBankInfo') then
   drop procedure UpdatePaymentBankInfo
end if;

create procedure dba.UpdatePaymentBankInfo(
in In_PayBankSGSPGenId char(30),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
begin
  if exists(select* from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId) then
    update PaymentBankInfo set
      PaymentBankInfo.BankId = In_BankId,
      PaymentBankInfo.BankBranchId = In_BankBranchId,
      PaymentBankInfo.BankAccountNo = In_BankAccountNo,
      PaymentBankInfo.PaymentValue = In_PaymentValue,
      PaymentBankInfo.PaymentType = In_PaymentType,
      PaymentBankInfo.BankAccTypeId = In_BankAccTypeId,
      PaymentBankInfo.PaymentMode = In_PaymentMode,
      PaymentBankInfo.BankRemarks = In_BankRemarks,
      PaymentBankInfo.BeneficiaryName = In_BeneficiaryName,
      PaymentBankInfo.BankAllocGpId = In_BankAllocGpId where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId;

   call UpdateCustomizedBankInfo(In_PayBankSGSPGenId,In_EmployeeSysId,In_BankId,In_BankBranchId,
         In_BankAccountNo,In_PaymentValue,In_PaymentType, In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
         In_BeneficiaryName,In_BankAllocGpId);
    commit work
  end if
end
;

commit work;