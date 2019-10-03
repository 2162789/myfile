if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecEPFNonAddWage') then
   drop procedure ASQLCalPayRecEPFNonAddWage
end if
;

CREATE PROCEDURE "DBA"."ASQLCalPayRecEPFNonAddWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_EPFWageType char(20),
out Out_EPFWage double)
begin
  declare In_SubjectString char(20);
  declare In_DeclaredYear integer;
  declare Out_AllowanceTotal double;
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  declare Out_OTBackPayAmt double;
  declare Out_LveDeductAmt double;
  declare Out_TotalWageAmt double;
  declare Out_BackPayAmt double;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_LveDeductAmt=0;
  set Out_TotalWageAmt=0;
  set Out_BackPayAmt=0;
  set Out_EPFWage=0;
  /*
  Setting Declared Date and Property
  */
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear-1
  else
    return
  end case
  ;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select CalTotalWage into Out_TotalWageAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  /*
  Property Based Items
  */
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Allowance
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjectString) = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      Year(AllowanceDeclaredDate) = In_DeclaredYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage') then
      /*
      OT Amount
      */
      select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID;
      /*
      Shift Amount
      */
      select Sum(ShiftAmount) into Out_ShiftTotal from
        ShiftRecord where
        IsFormulaIdHasProperty(ShiftFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(ShiftFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if;
    /*
    OT Back Pay Amount Only applicable to Period 1 if Previous 
    */
    if(((In_PayRecPeriod > 1 or In_PayRecYear = 2009) and
      (In_EPFWageType = 'CurrEEManEPFWage' or In_EPFWageType = 'CurrEEVolEPFWage')) or
      (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
      (In_EPFWageType = 'PrevEEManEPFWage' or In_EPFWageType = 'PrevEEVolEPFWage'))) then
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  end if;
  if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
  end if;
  if Out_OTTotal is null then set Out_OTTotal=0
  end if;
  if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
  end if;
  if Out_ShiftTotal is null then set Out_ShiftTotal=0
  end if;
  set Out_EPFWage=Out_TotalWageAmt+
    Out_LveDeductAmt+
    Out_BackPayAmt+
    Out_AllowanceTotal+
    Out_OTTotal+
    Out_OTBackPayAmt+
    Out_ShiftTotal
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodEPFNonAddWage') then
   drop procedure ASQLCalPayPeriodEPFNonAddWage
end if
;

CREATE PROCEDURE "DBA"."ASQLCalPayPeriodEPFNonAddWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_EPFWageType char(20),
out Out_EPFWage double)
begin
  declare In_SubjectString char(20);
  declare In_DeclaredYear integer;
  declare Out_AllowanceTotal double;
  declare Out_OTTotal double;
  declare Out_ShiftTotal double;
  declare Out_OTBackPayAmt double;
  declare Out_LveDeductAmt double;
  declare Out_TotalWageAmt double;
  declare Out_BackPayAmt double;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_ShiftTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_LveDeductAmt=0;
  set Out_TotalWageAmt=0;
  set Out_BackPayAmt=0;
  set Out_EPFWage=0;
  /*
  Setting Declared Date and Property
  */
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_DeclaredYear=In_PayRecYear-1 when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF';
    set In_DeclaredYear=In_PayRecYear-1
  else
    return
  end case
  ;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from DetailRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  /*
  Property Based Items
  */
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Allowance
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,In_SubjectString) = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjTaxAddWage') = 0 and
      Year(AllowanceDeclaredDate) = In_DeclaredYear and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage') then
      /*
      OT Amount
      */
      select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod;
      /*
      Shift Amount
      */
      select Sum(ShiftAmount) into Out_ShiftTotal from
        ShiftRecord where
        IsFormulaIdHasProperty(ShiftFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(ShiftFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if;
    /*
    OT Back Pay Amount Only applicable to Period 1 if Previous 
    */
    if(((In_PayRecPeriod > 1 or In_PayRecYear = 2009) and
      (In_EPFWageType = 'CurrEEManEPFWage' or In_EPFWageType = 'CurrEEVolEPFWage')) or
      (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
      (In_EPFWageType = 'PrevEEManEPFWage' or In_EPFWageType = 'PrevEEVolEPFWage'))) then
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
        OTRecord where
        IsFormulaIdHasProperty(OTFormulaId,In_SubjectString) = 1 and
        IsFormulaIdHasProperty(OTFormulaId,'SubjTaxAddWage') = 0 and
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod
    end if
  end if;
  if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
  end if;
  if Out_OTTotal is null then set Out_OTTotal=0
  end if;
  if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
  end if;
  if Out_ShiftTotal is null then set Out_ShiftTotal=0
  end if;
  set Out_EPFWage=Out_TotalWageAmt+
    Out_LveDeductAmt+
    Out_BackPayAmt+
    Out_AllowanceTotal+
    Out_OTTotal+
    Out_OTBackPayAmt+
    Out_ShiftTotal
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxEmployer') then
   drop procedure InsertNewMalTaxEmployer
end if
;

CREATE PROCEDURE "DBA"."InsertNewMalTaxEmployer"(
in In_MalTaxEmployerId char(20),
in In_MalTaxBranchId char(20),
in In_MalTaxEmployerDesc char(100),
in In_MalTaxAuthoriseName char(100),
in In_MalTaxAuthoriseId char(30),
in In_Designation char(20),
in In_MalTaxFileNoE char(20),
in In_MalTaxERTaxRefNo char(20),
in In_MalTaxBranchENo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_FaxNo char(20),
in In_TypeOfBusiness char(20),
in In_FinancialEndYear integer,
in In_PublicSector smallint,
out Out_Code integer)
begin
  if In_MalTaxEmployerId is null then set Out_Code=-1;
    return
  end if;
  if not exists(select* from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId) then
    insert into MalTaxEmployer(MalTaxEmployerId,
      MalTaxBranchId,
      MalTaxEmployerDesc,
      MalTaxAuthoriseName,
      MalTaxAuthoriseId,
      Designation,
      MalTaxFileNoE,
      MalTaxERTaxRefNo,
      MalTaxBranchENo,
      Address1,
      Address2,
      Address3,
      State,
      City,
      PostalCode,
      TelephoneNo,
      FaxNo,
      TypeOfBusiness,
      FinancialEndYear,
      PublicSector) values(
      In_MalTaxEmployerId,
      In_MalTaxBranchId,
      In_MalTaxEmployerDesc,
      In_MalTaxAuthoriseName,
      In_MalTaxAuthoriseId,
      In_Designation,
      In_MalTaxFileNoE,
      In_MalTaxERTaxRefNo,
      In_MalTaxBranchENo,
      In_Address1,
      In_Address2,
      In_Address3,
      In_State,
      In_City,
      In_PostalCode,
      In_TelephoneNo,
      In_FaxNo,
      In_TypeOfBusiness,
      In_FinancialEndYear,
      In_PublicSector);
    commit work;
    set Out_Code=1
  else
    set Out_Code=-2;
    return
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalTaxEmployer') then
   drop procedure UpdateMalTaxEmployer
end if
;

CREATE PROCEDURE "DBA"."UpdateMalTaxEmployer"(
in In_MalTaxEmployerId char(20),
in In_MalTaxBranchId char(20),
in In_MalTaxEmployerDesc char(100),
in In_MalTaxAuthoriseName char(100),
in In_MalTaxAuthoriseId char(30),
in In_Designation char(20),
in In_MalTaxFileNoE char(20),
in In_MalTaxERTaxRefNo char(20),
in In_MalTaxBranchENo char(20),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_FaxNo char(20),
in In_TypeOfBusiness char(20),
in In_FinancialEndYear integer,
in In_PublicSector smallint,
out Out_Code integer)
begin
  if In_MalTaxEmployerId is null then set Out_Code=-1;
    return
  end if;
  if exists(select* from MalTaxEmployer where MalTaxEmployerId = In_MalTaxEmployerId) then
    update MalTaxEmployer set
      MalTaxBranchId = In_MalTaxBranchId,
      MalTaxEmployerDesc = In_MalTaxEmployerDesc,
      MalTaxAuthoriseName = In_MalTaxAuthoriseName,
      MalTaxAuthoriseId = In_MalTaxAuthoriseId,
      Designation = In_Designation,
      MalTaxFileNoE = In_MalTaxFileNoE,
      MalTaxERTaxRefNo = In_MalTaxERTaxRefNo,
      MalTaxBranchENo = In_MalTaxBranchENo,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      State = In_State,
      City = In_City,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      FaxNo = In_FaxNo,
      TypeOfBusiness = In_TypeOfBusiness,
      FinancialEndYear = In_FinancialEndYear, 
      PublicSector = In_PublicSector   
      where MalTaxEmployerId = In_MalTaxEmployerId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-2;
    return
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxRecord') then
   drop procedure DeleteMalTaxRecord
end if
;

CREATE PROCEDURE "DBA"."DeleteMalTaxRecord"(
in In_PersonalSysId integer,
in In_EmployeeSysId integer,
in In_MalTaxYear integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and
      FGetMalTaxRecordEmployeeSysId(PersonalSysId,In_MalTaxYear) = In_EmployeeSysId and
      MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from MalTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear;
    delete from MalTaxRecord_EC where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear;
    delete from MalTaxRecord where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  end if;
  if exists(select* from MalTaxRecord where PersonalSysId = In_PersonalSysId and
      FGetMalTaxRecordEmployeeSysId(PersonalSysId,In_MalTaxYear) = In_EmployeeSysId and
      MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxRecord_EC') then
   drop procedure DeleteMalTaxRecord_EC
end if
;

CREATE PROCEDURE "DBA"."DeleteMalTaxRecord_EC"(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from MalTaxRecord_EC where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear
  end if;
  if exists(select* from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxRecord_EC') then
   drop procedure InsertNewMalTaxRecord_EC
end if
;

CREATE PROCEDURE "DBA"."InsertNewMalTaxRecord_EC"(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxGratuity double,
in In_MalTaxBenefitsDetails char(100),
in In_MalTaxRebate1 char(50),
in In_MalTaxRebate1Amt double,
in In_MalTaxRebate2 char(50),
in In_MalTaxRebate2Amt double,
in In_MalTaxRebate3 char(50),
in In_MalTaxRebate3Amt double,
in In_MalTaxRebate4 char(50),
in In_MalTaxRebate4Amt double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId and MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
    return
  else
    insert into MalTaxRecord_EC(PersonalSysId,
        MalTaxYear,
        MalTaxGratuity,
        MalTaxBenefitsDetails,
        MalTaxRebate1,
        MalTaxRebate1Amt,
        MalTaxRebate2,
        MalTaxRebate2Amt,
        MalTaxRebate3,
        MalTaxRebate3Amt,
        MalTaxRebate4,
        MalTaxRebate4Amt
        ) values(
        In_PersonalSysId,
        In_MalTaxYear,
        In_MalTaxGratuity,
        In_MalTaxBenefitsDetails,
        In_MalTaxRebate1,
        In_MalTaxRebate1Amt,
        In_MalTaxRebate2,
        In_MalTaxRebate2Amt,
        In_MalTaxRebate3,
        In_MalTaxRebate3Amt,
        In_MalTaxRebate4,
        In_MalTaxRebate4Amt
        );
    commit work
  end if;
  if not exists(select* from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId and MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalTaxRecord_EC') then
   drop procedure UpdateMalTaxRecord_EC
end if
;

CREATE PROCEDURE "DBA"."UpdateMalTaxRecord_EC"(
in In_PersonalSysId integer,
in In_MalTaxYear integer,
in In_MalTaxGratuity double,
in In_MalTaxBenefitsDetails char(100),
in In_MalTaxRebate1 char(50),
in In_MalTaxRebate1Amt double,
in In_MalTaxRebate2 char(50),
in In_MalTaxRebate2Amt double,
in In_MalTaxRebate3 char(50),
in In_MalTaxRebate3Amt double,
in In_MalTaxRebate4 char(50),
in In_MalTaxRebate4Amt double,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalTaxRecord_EC where PersonalSysId = In_PersonalSysId and MalTaxYear = In_MalTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update MalTaxRecord_EC set
      MalTaxGratuity = In_MalTaxGratuity,
      MalTaxBenefitsDetails = In_MalTaxBenefitsDetails,
      MalTaxRebate1 = In_MalTaxRebate1,
      MalTaxRebate1Amt = In_MalTaxRebate1Amt,
      MalTaxRebate2 =In_MalTaxRebate2,
      MalTaxRebate2Amt = In_MalTaxRebate2Amt,
      MalTaxRebate3 = In_MalTaxRebate3,
      MalTaxRebate3Amt = In_MalTaxRebate3Amt,
      MalTaxRebate4 = In_MalTaxRebate4,
      MalTaxRebate4Amt = In_MalTaxRebate4Amt
      where
      PersonalSysId = In_PersonalSysId and
      MalTaxYear = In_MalTaxYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;


commit work;