if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIndoTaxEmployer') then
   drop procedure InsertNewIndoTaxEmployer;
end if;
create procedure DBA.InsertNewIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(20),
in In_IndoTaxAuthoriseTaxRefNo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(20),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
in In_IndoBPJSKSOption smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    insert into IndoTaxEmployer(IndoTaxEmployerId,
      IndoTaxEmployerDesc,
      IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo,
      Address1,Address2,Address3,
      State,City,PostalCode,
      TelephoneNo,
      TypeOfBusiness,
      RegistrationNo,
      IndoOldAgeOption,
      Signature,
      IndoBPJSKSOption) values(
      In_IndoTaxEmployerId,
      In_IndoTaxEmployerDesc,
      In_IndoTaxAuthoriseName,
      In_IndoTaxERTaxRefNo,
      In_IndoTaxAuthoriseTaxRefNo,
      In_Address1,In_Address2,In_Address3,
      In_State,In_City,In_PostalCode,
      In_TelephoneNo,
      In_TypeOfBusiness,
      In_RegistrationNo,
      In_IndoOldAgeOption,
      In_Signature,
      In_IndoBPJSKSOption);
    commit work;
    if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIndoTaxEmployer') then
   drop procedure UpdateIndoTaxEmployer;
end if;
create procedure DBA.UpdateIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(20),
in In_IndoTaxAuthoriseTaxRefNo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(20),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
in In_IndoBPJSKSOption smallint,
out Out_ErrorCode 
integer)
begin
  if exists(select* from IndoTaxEmployer where IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    update IndoTaxEmployer set
      IndoTaxEmployerDesc = In_IndoTaxEmployerDesc,
      IndoTaxAuthoriseName = In_IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo = In_IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo = In_IndoTaxAuthoriseTaxRefNo,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      State = In_State,
      City = In_City,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      TypeOfBusiness = In_TypeOfBusiness,
      RegistrationNo = In_RegistrationNo,
      IndoOldAgeOption = In_IndoOldAgeOption,
      Signature = In_Signature, 
      IndoBPJSKSOption = In_IndoBPJSKSOption where
      IndoTaxEmployerId = In_IndoTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIndoTaxRecord') then
   drop procedure InsertNewIndoTaxRecord;
end if;
create procedure dba.InsertNewIndoTaxRecord(
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoTaxSerialNo integer,
in In_IndoTaxYear integer,
in In_IndoTaxFromPeriod integer,
in In_IndoTaxToPeriod integer,
in In_IndoTaxPermanent integer,
in In_IndoTaxBelowGovtBorne integer,
in In_IndoTaxSalary double,
in In_IndoTaxBenefit double,
in In_IndoTaxOtherAllowance double,
in In_IndoTaxOT double,
in In_IndoTaxHonoraria double,
in In_IndoTaxInsurance double,
in In_IndoTaxOtherBenefit double,
in In_IndoTaxBonus double,
in In_IndoTaxOccu double,
in In_IndoTaxOccuBonus double,
in In_IndoTaxPension double,
in In_IndoTaxCurrentTaxable double,
in In_IndoTaxAnnualTaxable double,
in In_IndoTaxPersonal double,
in In_IndoTaxMarriage double,
in In_IndoTaxNoDependent integer,
in In_IndoTaxDependent double,
in In_IndoTaxTotalTaxable double,
in In_IndoTaxPrevTaxable double,
in In_IndoTaxPrevTaxAmt double,
in In_IndoTaxBorneGovt double,
in In_IndoTaxBalPayableTax double,
in In_IndoTaxAnnualAmt double,
in In_IndoTaxActualTaxAmt double,
in In_IndoTaxPaidTaxAmt double,
in In_IndoTaxBalance double,
in In_IndoTaxExcess double,
in In_IndoTaxBPJSKSAmt double,
out Out_Code integer)
begin
  declare MaxSysId integer;
  if In_IndoTaxPolicyId is null then
    set Out_Code=-1;
    return
  end if;
  if In_IndoTaxEmployerId is null then
    set Out_Code=-2;
    return
  end if;
  if In_IndoTaxFromPeriod > In_IndoTaxToPeriod then
    set Out_Code=-3;
    return
  end if;
  if exists(select* from IndoTaxRecord) then
    select Max(IndoTaxRecSysId) into MaxSysId from IndoTaxRecord;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  insert into IndoTaxRecord(IndoTaxRecSysId,
    PersonalSysId,
    IndoTaxPolicyId,
    IndoTaxEmployerId,
    IndoTaxSerialNo,
    IndoTaxYear,
    IndoTaxFromPeriod,
    IndoTaxToPeriod,
    IndoTaxPermanent,
    IndoTaxBelowGovtBorne,
    IndoTaxSalary,
    IndoTaxBenefit,
    IndoTaxOtherAllowance,
    IndoTaxOT,
    IndoTaxHonoraria,
    IndoTaxInsurance,
    IndoTaxOtherBenefit,
    IndoTaxBonus,
    IndoTaxOccu,
    IndoTaxOccuBonus,
    IndoTaxPension,
    IndoTaxCurrentTaxable,
    IndoTaxAnnualTaxable,
    IndoTaxPersonal,
    IndoTaxMarriage,
    IndoTaxNoDependent,
    IndoTaxDependent,
    IndoTaxTotalTaxable,
    IndoTaxPrevTaxable,
    IndoTaxPrevTaxAmt,
    IndoTaxBorneGovt,
    IndoTaxBalPayableTax,
    IndoTaxAnnualAmt,
    IndoTaxActualTaxAmt,
    IndoTaxPaidTaxAmt,
    IndoTaxBalance,
    IndoTaxExcess,
    IndoTaxBPJSKSAmt) values(
    Out_Code,
    In_PersonalSysId,
    In_IndoTaxPolicyId,
    In_IndoTaxEmployerId,
    In_IndoTaxSerialNo,
    In_IndoTaxYear,
    In_IndoTaxFromPeriod,
    In_IndoTaxToPeriod,
    In_IndoTaxPermanent,
    In_IndoTaxBelowGovtBorne,
    In_IndoTaxSalary,
    In_IndoTaxBenefit,
    In_IndoTaxOtherAllowance,
    In_IndoTaxOT,
    In_IndoTaxHonoraria,
    In_IndoTaxInsurance,
    In_IndoTaxOtherBenefit,
    In_IndoTaxBonus,
    In_IndoTaxOccu,
    In_IndoTaxOccuBonus,
    In_IndoTaxPension,
    In_IndoTaxCurrentTaxable,
    In_IndoTaxAnnualTaxable,
    In_IndoTaxPersonal,
    In_IndoTaxMarriage,
    In_IndoTaxNoDependent,
    In_IndoTaxDependent,
    In_IndoTaxTotalTaxable,
    In_IndoTaxPrevTaxable,
    In_IndoTaxPrevTaxAmt,
    In_IndoTaxBorneGovt,
    In_IndoTaxBalPayableTax,
    In_IndoTaxAnnualAmt,
    In_IndoTaxActualTaxAmt,
    In_IndoTaxPaidTaxAmt,
    In_IndoTaxBalance,
    In_IndoTaxExcess,
    In_IndoTaxBPJSKSAmt);
  commit work
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIndoTaxRecord') then
   drop procedure UpdateIndoTaxRecord;
end if;
create procedure dba.UpdateIndoTaxRecord(
in In_IndoTaxRecSysId integer,
in In_PersonalSysId integer,
in In_IndoTaxPolicyId char(20),
in In_IndoTaxEmployerId char(20),
in In_IndoTaxSerialNo integer,
in In_IndoTaxYear integer,
in In_IndoTaxFromPeriod integer,
in In_IndoTaxToPeriod integer,
in In_IndoTaxPermanent integer,
in In_IndoTaxBelowGovtBorne integer,
in In_IndoTaxSalary double,
in In_IndoTaxBenefit double,
in In_IndoTaxOtherAllowance double,
in In_IndoTaxOT double,
in In_IndoTaxHonoraria double,
in In_IndoTaxInsurance double,
in In_IndoTaxOtherBenefit double,
in In_IndoTaxBonus double,
in In_IndoTaxOccu double,
in In_IndoTaxOccuBonus double,
in In_IndoTaxPension double,
in In_IndoTaxCurrentTaxable double,
in In_IndoTaxAnnualTaxable double,
in In_IndoTaxPersonal double,
in In_IndoTaxMarriage double,
in In_IndoTaxNoDependent integer,
in In_IndoTaxDependent double,
in In_IndoTaxTotalTaxable double,
in In_IndoTaxPrevTaxable double,
in In_IndoTaxPrevTaxAmt double,
in In_IndoTaxBorneGovt double,
in In_IndoTaxBalPayableTax double,
in In_IndoTaxAnnualAmt double,
in In_IndoTaxActualTaxAmt double,
in In_IndoTaxPaidTaxAmt double,
in In_IndoTaxBalance double,
in In_IndoTaxExcess double,
in In_IndoTaxBPJSKSAmt double,
out Out_ErrorCode integer)
begin
  if In_IndoTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if In_IndoTaxEmployerId is null then
    set Out_ErrorCode=-2;
    return
  end if;
  if In_IndoTaxFromPeriod > In_IndoTaxToPeriod then
    set Out_ErrorCode=-3;
    return
  end if;
  if exists(select* from IndoTaxRecord where
      IndoTaxRecSysId = In_IndoTaxRecSysId) then
    update IndoTaxRecord set
      PersonalSysId = In_PersonalSysId,
      IndoTaxPolicyId = In_IndoTaxPolicyId,
      IndoTaxEmployerId = In_IndoTaxEmployerId,
      IndoTaxSerialNo = In_IndoTaxSerialNo,
      IndoTaxYear = In_IndoTaxYear,
      IndoTaxFromPeriod = In_IndoTaxFromPeriod,
      IndoTaxToPeriod = In_IndoTaxToPeriod,
      IndoTaxPermanent = In_IndoTaxPermanent,
      IndoTaxBelowGovtBorne = In_IndoTaxBelowGovtBorne,
      IndoTaxSalary = In_IndoTaxSalary,
      IndoTaxBenefit = In_IndoTaxBenefit,
      IndoTaxOtherAllowance = In_IndoTaxOtherAllowance,
      IndoTaxOT = In_IndoTaxOT,
      IndoTaxHonoraria = In_IndoTaxHonoraria,
      IndoTaxInsurance = In_IndoTaxInsurance,
      IndoTaxOtherBenefit = In_IndoTaxOtherBenefit,
      IndoTaxBonus = In_IndoTaxBonus,
      IndoTaxOccu = In_IndoTaxOccu,
      IndoTaxOccuBonus = In_IndoTaxOccuBonus,
      IndoTaxPension = In_IndoTaxPension,
      IndoTaxCurrentTaxable = In_IndoTaxCurrentTaxable,
      IndoTaxAnnualTaxable = In_IndoTaxAnnualTaxable,
      IndoTaxPersonal = In_IndoTaxPersonal,
      IndoTaxMarriage = In_IndoTaxMarriage,
      IndoTaxNoDependent = In_IndoTaxNoDependent,
      IndoTaxDependent = In_IndoTaxDependent,
      IndoTaxTotalTaxable = In_IndoTaxTotalTaxable,
      IndoTaxPrevTaxable = In_IndoTaxPrevTaxable,
      IndoTaxPrevTaxAmt = In_IndoTaxPrevTaxAmt,
      IndoTaxBorneGovt = In_IndoTaxBorneGovt,
      IndoTaxBalPayableTax = In_IndoTaxBalPayableTax,
      IndoTaxAnnualAmt = In_IndoTaxAnnualAmt,
      IndoTaxActualTaxAmt = In_IndoTaxActualTaxAmt,
      IndoTaxPaidTaxAmt = In_IndoTaxPaidTaxAmt,
      IndoTaxBalance = In_IndoTaxBalance,
      IndoTaxExcess = In_IndoTaxExcess, 
      IndoTaxBPJSKSAmt = In_IndoTaxBPJSKSAmt where
      IndoTaxRecSysId = In_IndoTaxRecSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-4
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBPJSKSWage') then
   drop procedure ASQLCalPayPeriodBPJSKSWage;
end if;
Create PROCEDURE "DBA"."ASQLCalPayPeriodBPJSKSWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_BPJSKeseWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_BPJSKeseWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_TotalWageAmt
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecBPJSKSWage') then
   drop procedure ASQLCalPayRecBPJSKSWage;
end if;
CREATE PROCEDURE "DBA"."ASQLCalPayRecBPJSKSWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_BPJSKeseWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_BPJSKeseWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_TotalWageAmt
  end if
end
;

commit work;