if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodEPFNonAddWage') then
   drop procedure ASQLCalPayPeriodEPFNonAddWage
end if;

create procedure DBA.ASQLCalPayPeriodEPFNonAddWage( 
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
  case In_EPFWageType 
    when 'CurrEEManEPFWage' then
        set In_SubjectString='SubjEEManEPF';
        set In_DeclaredYear=In_PayRecYear 
    when 'CurrEEVolEPFWage' then
        set In_SubjectString='SubjEEVolEPF';
        set In_DeclaredYear=In_PayRecYear 
    
    when 'CurrERManEPFWage' then
        set In_SubjectString='SubjERManEPF';
        set In_DeclaredYear=In_PayRecYear 
    when 'CurrERVolEPFWage' then
        set In_SubjectString='SubjERVolEPF';
        set In_DeclaredYear=In_PayRecYear 

    when 'PrevEEManEPFWage' then
        set In_SubjectString='SubjEEManEPF';
        set In_DeclaredYear=In_PayRecYear-1 
    when 'PrevEEVolEPFWage' then
        set In_SubjectString='SubjEEVolEPF';
        set In_DeclaredYear=In_PayRecYear-1

    when 'PrevERManEPFWage' then
        set In_SubjectString='SubjERManEPF';
        set In_DeclaredYear=In_PayRecYear-1 
    when 'PrevERVolEPFWage' then
        set In_SubjectString='SubjERVolEPF';
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
       In_EPFWageType = 'CurrEEVolEPFWage' or       
       In_EPFWageType = 'CurrERManEPFWage' or       
       In_EPFWageType = 'CurrERVolEPFWage') then
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
      (In_EPFWageType = 'CurrEEManEPFWage' or 
       In_EPFWageType = 'CurrEEVolEPFWage' or
       In_EPFWageType = 'CurrERManEPFWage' or 
       In_EPFWageType = 'CurrERVolEPFWage')) or
      
      (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
      (In_EPFWageType = 'PrevEEManEPFWage' or 
       In_EPFWageType = 'PrevEEVolEPFWage' or
       In_EPFWageType = 'PrevERManEPFWage' or 
       In_EPFWageType = 'PrevERVolEPFWage'))) then

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

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLCalPayRecEPFNonAddWage') then
   drop procedure ASQLCalPayRecEPFNonAddWage
end if;

create procedure dba.ASQLCalPayRecEPFNonAddWage(
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
  case In_EPFWageType 
    when 'CurrEEManEPFWage' then
        set In_SubjectString='SubjEEManEPF';
        set In_DeclaredYear=In_PayRecYear 
    when 'CurrEEVolEPFWage' then
        set In_SubjectString='SubjEEVolEPF';
        set In_DeclaredYear=In_PayRecYear 
    
    when 'CurrERManEPFWage' then
        set In_SubjectString='SubjERManEPF';
        set In_DeclaredYear=In_PayRecYear 
    when 'CurrERVolEPFWage' then
        set In_SubjectString='SubjERVolEPF';
        set In_DeclaredYear=In_PayRecYear 

    when 'PrevEEManEPFWage' then
        set In_SubjectString='SubjEEManEPF';
        set In_DeclaredYear=In_PayRecYear-1 
    when 'PrevEEVolEPFWage' then
        set In_SubjectString='SubjEEVolEPF';
        set In_DeclaredYear=In_PayRecYear-1

    when 'PrevERManEPFWage' then
        set In_SubjectString='SubjERManEPF';
        set In_DeclaredYear=In_PayRecYear-1 
    when 'PrevERVolEPFWage' then
        set In_SubjectString='SubjERVolEPF';
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
       In_EPFWageType = 'CurrEEVolEPFWage' or
       In_EPFWageType = 'CurrERManEPFWage' or
       In_EPFWageType = 'CurrERVolEPFWage'   ) then
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
      (In_EPFWageType = 'CurrEEManEPFWage' or 
       In_EPFWageType = 'CurrEEVolEPFWage' or
       In_EPFWageType = 'CurrERManEPFWage' or 
       In_EPFWageType = 'CurrERVolEPFWage'     )) or

      (In_PayRecPeriod = 1 and In_PayRecYear > 2009 and
      (In_EPFWageType = 'PrevEEManEPFWage' or 
       In_EPFWageType = 'PrevEEVolEPFWage' or
       In_EPFWageType = 'PrevERManEPFWage' or 
       In_EPFWageType = 'PrevERVolEPFWage'))) then

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

commit work;