if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMalDeleteArrear' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLMalDeleteArrear
end if;

create procedure DBA.ASQLMalDeleteArrear(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      AllowanceRecurSysId from AllowanceRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (AllowanceCreatedBy = 'Arrear') do
    delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
    delete from AllowanceRecord where AllowanceSGSPGenId = GenId end for;
  commit work
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxPolicyProg' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewMalTaxPolicyProg
end if;

create procedure DBA.InsertNewMalTaxPolicyProg(
in In_MalTaxPolicyId char(20),
in In_MalSTDPolicyId char(20),
in In_MalTaxPolicyEffDate date,
in In_MalChildOutside integer,
in In_MalChildInside integer,
in In_MalChildDisabled integer,
in In_MalCat1Relief double,
in In_MalCat2ChildRelief double,
in In_MalCat2Relief double,
in In_MalCat3ChildRelief double,
in In_MalCat3Relief double,
in In_EPFCappingOption smallint,
in In_EPFCappingYearly double,
in In_EPFCappingMonthly double,
in In_MalTaxCompenPerYr double,
in In_MalTaxMinTaxAmt double,
out Out_MalTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  select max(MalTaxPolicyProgSysId) into Out_MalTaxPolicyProgSysId from MalTaxPolicyProg;
  if(Out_MalTaxPolicyProgSysId is null) then
    set Out_MalTaxPolicyProgSysId=0
  end if;
  if not exists(select* from MalTaxPolicyProg where
      MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
    insert into MalTaxPolicyProg(MalTaxPolicyProgSysId,
      MalTaxPolicyId,
      MalSTDPolicyId,
      MalTaxPolicyEffDate,
      MalChildOutside,
      MalChildInside,
      MalChildDisabled,
      MalCat1Relief,
      MalCat2ChildRelief,
      MalCat2Relief,
      MalCat3ChildRelief,
      MalCat3Relief,
      EPFCappingOption,
      EPFCappingYearly,
      EPFCappingMonthly,
      MalTaxCompenPerYr,
      MalTaxMinTaxAmt) values(
      Out_MalTaxPolicyProgSysId+1,
      In_MalTaxPolicyId,
      In_MalSTDPolicyId,
      In_MalTaxPolicyEffDate,
      In_MalChildOutside,
      In_MalChildInside,
      In_MalChildDisabled,
      In_MalCat1Relief,
      In_MalCat2ChildRelief,
      In_MalCat2Relief,
      In_MalCat3ChildRelief,
      In_MalCat3Relief,
      In_EPFCappingOption,
      In_EPFCappingYearly,
      In_EPFCappingMonthly,
      In_MalTaxCompenPerYr,
      In_MalTaxMinTaxAmt);
    commit work;
    if not exists(select* from MalTaxPolicyProg where
        MalTaxPolicyProgSysId = Out_MalTaxPolicyProgSysId+1) then
      set Out_MalTaxPolicyProgSysId=null;
      set Out_ErrorCode=0
    else
      set Out_MalTaxPolicyProgSysId=Out_MalTaxPolicyProgSysId+1;
      set Out_ErrorCode=1;
      if Year(In_MalTaxPolicyEffDate) >= 2012 then
        Insert into MalTaxFormula (MalTaxPolicyProgSysId, PolicyProgTaxScheme, MalSTDPolicyId) 
            Select Out_MalTaxPolicyProgSysId, CoreKeywordId, NULL 
 	    From CoreKeyword Where CoreKeywordCategory='MalTaxScheme' and CoreKeywordId not in ('STD','Resident');
      end if  
    end if
  else
    set Out_MalTaxPolicyProgSysId=null;
    set Out_ErrorCode=0
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearTaxByYear' and user_name(creator) = 'DBA') then
   drop function DBA.FGetMalArrearTaxByYear
end if;

create function DBA.FGetMalArrearTaxByYear(
in In_EmployeeSysId int,
in In_PayRecYear int, 
in In_PayRecPeriod int, 
in In_ArrearYear char(20))
RETURNS double
BEGIN
	DECLARE Out_Tax double;
	   
    Select Sum(UserDef4Value) into Out_Tax From AllowanceRecord join AllowanceHistoryRecord Where
        EmployeeSysId = In_EmployeeSysId And
        PayRecYear = In_PayRecYear And
        PayRecPeriod = In_PayRecPeriod And
        Year(AllowanceDeclaredDate) = In_ArrearYear And
        AllowanceFormulaId in 
            (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');

    if Out_Tax is null then set Out_Tax = 0 end if;
	return Out_Tax;
END;

