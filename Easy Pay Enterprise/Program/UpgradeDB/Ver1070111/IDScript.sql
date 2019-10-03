if exists (select 1 from sys.sysprocedure where proc_name = 'FGetIndoTaxPercentage') then
  drop FUNCTION FGetIndoTaxPercentage;
end if;

CREATE FUNCTION "DBA"."FGetIndoTaxPercentage"(
in In_EmployeeSysID char(20),
in In_TaxPolicyID char(20),
in In_TaxYear integer)

RETURNS integer
BEGIN
    DECLARE Out_TaxPercentage integer;
    DECLARE Out_PayRecordPeriod int;
    DECLARE Out_SubPeriodEndDate date;
    DECLARE Out_TaxMonthlyID char(20);
    DECLARE Out_Taxableamount double;
    
    Select first PayRecPeriod,Sum(CurOrdinaryWage) into Out_PayRecordPeriod,Out_Taxableamount from POLICYRECORD where PayRecYear=In_TaxYear 
    and EmployeeSysID=In_EmployeeSysID group by PayRecPeriod  order by PayRecPeriod desc ; 

    Select First SubPeriodEndDate into Out_SubPeriodEndDate From PayGroupPeriod where PayGroupYear=In_TaxYear and PayGroupPeriod=Out_PayRecordPeriod
    and PaygroupID=FGetPayGroupID(In_EmployeeSysID) order by PayGroupSubPeriod Desc;    

    Select First IndoTaxMonthlyID into Out_TaxMonthlyID From IndoTaxPolicyProg where
    IndoTaxPolicyId =In_TaxPolicyID AND IndoTaxEffectiveDate <=Out_SubPeriodEndDate  Order By IndoTaxEffectiveDate Desc;

    SELECT MIN(IndoTaxRate) into Out_TaxPercentage  from IndoTaxMthFormula 
    WHERE IndoTaxMonthlyId=Out_TaxMonthlyID and Out_Taxableamount<=IndoTaxRangeUpTo;

   RETURN Out_TaxPercentage ;

END;


if exists (select 1 from sys.sysprocedure where proc_name = 'FGetIndoSeverancePay') then
  drop FUNCTION FGetIndoSeverancePay;
end if;

CREATE FUNCTION "DBA"."FGetIndoSeverancePay"(
in In_QueryType char(20),
in In_PersonalSysId integer,
in In_PayRecYear integer)
returns double
begin
   declare In_SeverancePay double;

   if(In_QueryType='SeverancePay') Then
      select Sum(AllowanceAmount) into In_SeverancePay from AllowanceRecord where
      EmployeeSysId in(Select EmployeeSysId from Employee Where PersonalSysId = In_PersonalSysId) and
      PayRecYear = In_PayRecYear and  
      AllowanceFormulaId in
      (Select FormulaId as AllowanceFormulaId From Formula Where 
      (FormulaSubCategory = 'Allowance') And 
      IsFormulaIdHasProperty(FormulaId,'SeverancePayCode') = 1 );
   end if;
 
   if(In_QueryType='SeverancePayTax') Then
     Select Sum(UserDef2Value) into In_SeverancePay From AllowanceHistoryRecord 
     where AllowanceSGSPGenId in
     (Select  AllowanceSGSPGENID from AllowanceRecord Where 
     EmployeeSysId in(Select EmployeeSysId from Employee Where PersonalSysId = In_PersonalSysId) and
     PayRecYear = In_PayRecYear and
     AllowanceFormulaId in
    (Select FormulaId as AllowanceFormulaId From Formula Where
    (FormulaSubCategory = 'Deduction') And
    IsFormulaIdHasProperty(FormulaId,'SeverancePayTaxCode') = 1 ) ) ;
   end if;

   if(In_QueryType='SeverancePayTaxPer') Then
     Select Top 1 UserDef1Value into In_SeverancePay From AllowanceHistoryRecord 
     where AllowanceSGSPGenId in
     (Select  AllowanceSGSPGENID from AllowanceRecord Where 
     EmployeeSysId in(Select EmployeeSysId from Employee Where PersonalSysId = In_PersonalSysId) and
     PayRecYear = In_PayRecYear and
     AllowanceFormulaId in
    (Select FormulaId as AllowanceFormulaId From Formula Where
    (FormulaSubCategory = 'Deduction') And
    IsFormulaIdHasProperty(FormulaId,'SeverancePayTaxCode') = 1 ) ) 
    Order by UserDef1Value desc ;
   end if;

 if In_SeverancePay >0 then return In_SeverancePay
 end if;

 return 0;

end;


commit work;
