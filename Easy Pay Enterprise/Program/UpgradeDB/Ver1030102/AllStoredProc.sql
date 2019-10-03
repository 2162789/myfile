if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLoanEmployee') then
   drop procedure InsertNewLoanEmployee
end if
;

CREATE PROCEDURE "DBA"."InsertNewLoanEmployee"(
in In_LoanFromId char(20),
in In_LoanTypeId char(20),
in In_EmployeeSysId integer,
in In_LoanRefNo char(20),
in In_LoanApprovalDate date,
in In_LoanEffectiveDate date,
in In_LoanExpiryDate date,
in In_LoanMonths integer,
in In_LoanTotalAmt double,
in In_LoanMthPayment double,
in In_LoanPayElementId char(20),
in In_LoanDesc char(100),
in In_LoanOtherBoolean1 smallint,
in In_LoanOtherBoolean2 smallint,
in In_LoanOtherBoolean3 smallint,
in In_LoanOtherDate1 date,
in In_LoanOtherDate2 date,
in In_LoanOtherDate3 date,
in In_LoanOtherInteger1 integer,
in In_LoanOtherInteger2 integer,
in In_LoanOtherInteger3 integer,
in In_LoanOtherNumeric1 double,
in In_LoanOtherNumeric2 double,
in In_LoanOtherNumeric3 double,
in In_LoanOtherString1 char(50),
in In_LoanOtherString2 char(50),
in In_LoanOtherString3 char(50),
in In_LoanOtherString4 char(50),
in In_LoanOtherString5 char(50),
in In_LoanPrincipalAmt double,
out Out_ErrorCode integer)
begin
  declare iLoanSysId integer;
  insert into LoanEmployee(LoanFromId,
    LoanTypeId,
    EmployeeSysId,
    LoanRefNo,
    LoanApprovalDate,
    LoanEffectiveDate,
    LoanExpiryDate,
    LoanMonths,
    LoanTotalAmt,
    LoanMthPayment,
    LoanPayElementId,
    LoanDesc,
    LoanOtherBoolean1,
    LoanOtherBoolean2,
    LoanOtherBoolean3,
    LoanOtherDate1,
    LoanOtherDate2,
    LoanOtherDate3,
    LoanOtherInteger1,
    LoanOtherInteger2,
    LoanOtherInteger3,
    LoanOtherNumeric1,
    LoanOtherNumeric2,
    LoanOtherNumeric3,
    LoanOtherString1,
    LoanOtherString2,
    LoanOtherString3,
    LoanOtherString4,
    LoanOtherString5,
    LoanPrincipalAmt) values(
    In_LoanFromId,
    In_LoanTypeId,
    In_EmployeeSysId,
    In_LoanRefNo,
    In_LoanApprovalDate,
    In_LoanEffectiveDate,
    In_LoanExpiryDate,
    In_LoanMonths,
    In_LoanTotalAmt,
    In_LoanMthPayment,
    In_LoanPayElementId,
    In_LoanDesc,
    In_LoanOtherBoolean1,
    In_LoanOtherBoolean2,
    In_LoanOtherBoolean3,
    In_LoanOtherDate1,
    In_LoanOtherDate2,
    In_LoanOtherDate3,
    In_LoanOtherInteger1,
    In_LoanOtherInteger2,
    In_LoanOtherInteger3,
    In_LoanOtherNumeric1,
    In_LoanOtherNumeric2,
    In_LoanOtherNumeric3,
    In_LoanOtherString1,
    In_LoanOtherString2,
    In_LoanOtherString3,
    In_LoanOtherString4,
    In_LoanOtherString5,
    In_LoanPrincipalAmt);
  commit work;
  select LoanSysId into iLoanSysId from LoanEmployee where
    EmployeeSysId = In_EmployeeSysId and
    LoanFromId = In_LoanFromId and
    LoanTypeId = In_LoanTypeId and
    LoanRefNo = In_LoanRefNo and
    LoanApprovalDate = In_LoanApprovalDate and
    LoanEffectiveDate = In_LoanEffectiveDate and
    LoanExpiryDate = In_LoanExpiryDate and
    LoanMonths = In_LoanMonths and
    LoanTotalAmt = In_LoanTotalAmt and
    LoanMthPayment = In_LoanMthPayment and
    LoanPayElementId = In_LoanPayElementId and
    LoanDesc = In_LoanDesc;
  insert into LoanPayment(LoanSysId,LoanPaySubPeriod,LoanPayRecordId) values(iLoanSysId,1,'Normal');
  commit work;
  set Out_ErrorCode=iLoanSysId
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLoanEmployee') then
   drop procedure UpdateLoanEmployee
end if
;

CREATE PROCEDURE "DBA"."UpdateLoanEmployee"(
in In_LoanSysId integer,
in In_LoanTypeId char(20),
in In_LoanRefNo char(20),
in In_LoanApprovalDate date,
in In_LoanEffectiveDate date,
in In_LoanExpiryDate date,
in In_LoanMonths integer,
in In_LoanTotalAmt double,
in In_LoanMthPayment double,
in In_LoanPayElementId char(20),
in In_LoanDesc char(100),
in In_LoanOtherBoolean1 smallint,
in In_LoanOtherBoolean2 smallint,
in In_LoanOtherBoolean3 smallint,
in In_LoanOtherDate1 date,
in In_LoanOtherDate2 date,
in In_LoanOtherDate3 date,
in In_LoanOtherInteger1 integer,
in In_LoanOtherInteger2 integer,
in In_LoanOtherInteger3 integer,
in In_LoanOtherNumeric1 double,
in In_LoanOtherNumeric2 double,
in In_LoanOtherNumeric3 double,
in In_LoanOtherString1 char(50),
in In_LoanOtherString2 char(50),
in In_LoanOtherString3 char(50),
in In_LoanOtherString4 char(50),
in In_LoanOtherString5 char(50),
in In_LoanPrincipalAmt double,
out Out_ErrorCode integer)
begin
  if exists(select* from LoanEmployee where LoanSysId = In_LoanSysId) then
    update LoanEmployee set
      LoanTypeId = In_LoanTypeId,
      LoanRefNo = In_LoanRefNo,
      LoanApprovalDate = In_LoanApprovalDate,
      LoanEffectiveDate = In_LoanEffectiveDate,
      LoanExpiryDate = In_LoanExpiryDate,
      LoanMonths = In_LoanMonths,
      LoanTotalAmt = In_LoanTotalAmt,
      LoanMthPayment = In_LoanMthPayment,
      LoanPayElementId = In_LoanPayElementId,
      LoanDesc = In_LoanDesc,
      LoanOtherBoolean1 = In_LoanOtherBoolean1,
      LoanOtherBoolean2 = In_LoanOtherBoolean2,
      LoanOtherBoolean3 = In_LoanOtherBoolean3,
      LoanOtherDate1 = In_LoanOtherDate1,
      LoanOtherDate2 = In_LoanOtherDate2,
      LoanOtherDate3 = In_LoanOtherDate3,
      LoanOtherInteger1 = In_LoanOtherInteger1,
      LoanOtherInteger2 = In_LoanOtherInteger2,
      LoanOtherInteger3 = In_LoanOtherInteger3,
      LoanOtherNumeric1 = In_LoanOtherNumeric1,
      LoanOtherNumeric2 = In_LoanOtherNumeric2,
      LoanOtherNumeric3 = In_LoanOtherNumeric3,
      LoanOtherString1 = In_LoanOtherString1,
      LoanOtherString2 = In_LoanOtherString2,
      LoanOtherString3 = In_LoanOtherString3,
      LoanOtherString4 = In_LoanOtherString4,
      LoanOtherString5 = In_LoanOtherString5,
      LoanPrincipalAmt = In_LoanPrincipalAmt where
      LoanSysId = In_LoanSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

commit work;