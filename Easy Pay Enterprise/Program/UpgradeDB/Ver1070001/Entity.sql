/*==============================================================*/
/* Table: CPFProgression                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='CPFProgression' and cname='CPFMAWIncRecPayElement') then
    alter table DBA.CPFProgression Add CPFMAWIncRecPayElement smallint default 0;
end if;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewCPFProgression') then
   drop procedure InsertNewCPFProgression
end if;
Create PROCEDURE "DBA"."InsertNewCPFProgression"(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFMedisaveSchemeId char(20),
in In_CPFProgRemarks char(255),
in In_CPFMAWIncRecPayElement smallint)
begin
  if not exists(select* from CPFProgression where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    insert into CPFProgression(EmployeeSysId,
      CPFEffectiveDate,
      CPFProgCurrent,
      CPFCareerId,
      CPFProgPolicyId,
      CPFProgAccountNo,
      CPFProgSchemeId,
      CPFMAWOption,
      CPFMAWLimit,
      CPFMAWPeriodOrdWage,
      CPFMedisavePaidByER,
      CPFMedisaveSchemeId,
      CPFProgRemarks,
	  CPFMAWIncRecPayElement) values(
      In_EmployeeSysId,
      In_CPFEffectiveDate,
      In_CPFProgCurrent,
      In_CPFCareerId,
      In_CPFProgPolicyId,
      In_CPFProgAccountNo,
      In_CPFProgSchemeId,
      In_CPFMAWOption,
      In_CPFMAWLimit,
      In_CPFMAWPeriodOrdWage,
      In_CPFMedisavePaidByER,
      In_CPFMedisaveSchemeId,
      In_CPFProgRemarks,
	  In_CPFMAWIncRecPayElement);
    commit work
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateCPFProgression') then
   drop procedure UpdateCPFProgression
end if;
Create PROCEDURE "DBA"."UpdateCPFProgression"(
in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFMedisaveSchemeId char(20),
in In_CPFProgRemarks char(255),
in In_CPFMAWIncRecPayElement smallint)
begin
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
    if(In_CPFProgCurrent = 1 and
      (FGetDBCountry(*) = 'Singapore' or
      FGetDBCountry(*) = 'Indonesia')) then
      update CPFProgression set
        CPFProgression.CPFProgCurrent = 0 where
        CPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    if(In_CPFProgCurrent = 1 and FGetDBCountry(*) = 'Brunei') then
      update CPFProgression set
        CPFProgression.CPFProgCurrent = 0 where
        CPFProgression.CPFProgSchemeId = In_CPFProgSchemeId and
        CPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update CPFProgression set
      CPFProgression.EmployeeSysId = In_EmployeeSysId,
      CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate,
      CPFProgression.CPFProgCurrent = In_CPFProgCurrent,
      CPFProgression.CPFCareerId = In_CPFCareerId,
      CPFProgression.CPFProgPolicyId = In_CPFProgPolicyId,
      CPFProgression.CPFProgAccountNo = In_CPFProgAccountNo,
      CPFProgression.CPFProgSchemeId = In_CPFProgSchemeId,
      CPFProgression.CPFMAWOption = In_CPFMAWOption,
      CPFProgression.CPFMAWLimit = In_CPFMAWLimit,
      CPFProgression.CPFMAWPeriodOrdWage = In_CPFMAWPeriodOrdWage,
      CPFProgression.CPFMedisavePaidByER = In_CPFMedisavePaidByER,
      CPFProgression.CPFMedisaveSchemeId = In_CPFMedisaveSchemeId,
      CPFProgression.CPFProgRemarks = In_CPFProgRemarks,
      CPFProgression.CPFMAWIncRecPayElement = In_CPFMAWIncRecPayElement	where
      CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLUpdateCPFProgression') then
   drop procedure ASQLUpdateCPFProgression
end if;
Create PROCEDURE "DBA"."ASQLUpdateCPFProgression"(in In_EmployeeSysId integer,
in In_CPFEffectiveDate date,
in In_NewCPFEffectiveDate date,
in In_CPFProgCurrent smallint,
in In_CPFCareerId char(20),
in In_CPFProgPolicyId char(20),
in In_CPFProgAccountNo char(30),
in In_CPFProgSchemeId char(20),
in In_CPFMAWOption smallint,
in In_CPFMAWLimit double,
in In_CPFMAWPeriodOrdWage double,
in In_CPFMedisavePaidByER smallint,
in In_CPFMedisaveSchemeId char(20),
in In_CPFProgRemarks char(255),
in In_CPFMAWIncRecPayElement smallint)

BEGIN
    if (In_NewCPFEffectiveDate = In_CPFEffectiveDate) then

       Call UpdateCPFProgression(In_EmployeeSysId, In_CPFEffectiveDate, 
        In_CPFProgCurrent, In_CPFCareerId, In_CPFProgPolicyId, In_CPFProgAccountNo, In_CPFProgSchemeId,
        In_CPFMAWOption, In_CPFMAWLimit , In_CPFMAWPeriodOrdWage, In_CPFMedisavePaidByER, In_CPFMedisaveSchemeId, In_CPFProgRemarks,In_CPFMAWIncRecPayElement);
    else
        // Remove CPFEddactiveDate record 
        if exists(select * from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_CPFEffectiveDate) then
            Call DeleteCPFProgressionRec(In_EmployeeSysId, In_CPFEffectiveDate);
        end if;
        // Remove NewCPFEddactiveDate record if already exists
        if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and CPFProgression.CPFEffectiveDate = In_NewCPFEffectiveDate) then
            Call DeleteCPFProgressionRec(In_EmployeeSysId, In_NewCPFEffectiveDate);
        end if;
        Call InsertNewCPFProgression(In_EmployeeSysId, In_NewCPFEffectiveDate, 
            In_CPFProgCurrent, In_CPFCareerId, In_CPFProgPolicyId, In_CPFProgAccountNo, In_CPFProgSchemeId,
            In_CPFMAWOption, In_CPFMAWLimit , In_CPFMAWPeriodOrdWage, In_CPFMedisavePaidByER, In_CPFMedisaveSchemeId, In_CPFProgRemarks,In_CPFMAWIncRecPayElement);
  end if
END
;


/*==============================================================*/
/* ASQLCalPayRecCurOrdWage                                  */
/*==============================================================*/

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecCurOrdWage') then
   drop function ASQLCalPayRecCurOrdWage;
end if;

CREATE  PROCEDURE "DBA"."ASQLCalPayRecCurOrdWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_CurOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_CurOrdWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
  
      select Sum(CurrentOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
      select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsWageElementInUsed('OTBackPay','OrdWage') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 0 and
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
    set Out_CurOrdWage=Out_CurOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','OrdWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurOrdWage=Out_CurOrdWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','OrdWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurOrdWage=Out_CurOrdWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','OrdWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurOrdWage=Out_CurOrdWage+Out_TotalWageAmt
  end if
end;

/*==============================================================*/
/*ASQLCalPayRecCurAddWage                                 */
/*==============================================================*/
if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecCurAddWage') then
   drop function ASQLCalPayRecCurAddWage;
end if;

CREATE PROCEDURE "DBA"."ASQLCalPayRecCurAddWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,in In_PayRecID char(20),out Out_CurAddWage double,out Out_AllowanceTotal double,out Out_OTTotal double,out Out_ShiftTotal double,out Out_LveDeductAmt double,out Out_BackPayAmt double,out Out_TotalWageAmt double,out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_CurAddWage=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */

      select Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsWageElementInUsed('LastOTPay','AddWage') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsWageElementInUsed('OTBackPay','AddWage') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 0 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 0 and
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
    set Out_CurAddWage=Out_CurAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','AddWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurAddWage=Out_CurAddWage+Out_LveDeductAmt
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','AddWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurAddWage=Out_CurAddWage+Out_BackPayAmt
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','AddWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_CurAddWage=Out_CurAddWage+Out_TotalWageAmt
  end if;
end;

/*==============================================================*/
/*ASQLCalPayRecPrevAddWage                                */
/*==============================================================*/
if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecPrevAddWage') then
   drop function ASQLCalPayRecPrevAddWage;
end if;

CREATE PROCEDURE "DBA"."ASQLCalPayRecPrevAddWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_PrevAddWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_PrevAddWage=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
      select Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsWageElementInUsed('LastOTPay','AddWage') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsWageElementInUsed('OTBackPay','AddWage') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 1 and
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
    set Out_PrevAddWage=Out_PrevAddWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if
end;

/*==============================================================*/
/*ASQLCalPayRecPrevOrdWage                             */
/*==============================================================*/

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecPrevOrdWage') then
   drop function ASQLCalPayRecPrevOrdWage;
end if;

CREATE PROCEDURE "DBA"."ASQLCalPayRecPrevOrdWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_PrevOrdWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_OTBackPayAmt double)
begin
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_PrevOrdWage=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
     select Sum(CurrentOTAmount)into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(OTFormulaId,'PreviousRateCPF') = 1 and
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
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(ShiftFormulaId,'PreviousRateCPF') = 1 and
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
    set Out_PrevOrdWage=Out_PrevOrdWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if
end
;

commit work;