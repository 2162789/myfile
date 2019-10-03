if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormDifference') then
   drop procedure FGetEAFormDifference
end if
;

CREATE FUNCTION "DBA"."FGetEAFormDifference"(
in In_EmployeeSysId integer,
in In_Year integer,
in In_Month integer)
returns double
begin
  declare total double;
  // obtain the total of EA Form's editable values
  // the value will be used in CP159 form, appended into December's gross wage.
  if(In_Month <> 12) then
    return 0
  end if;
  select Sum(MalTaxMotorCarFuel+MalTaxDriver+
    MalTaxUtility+MalTaxFurniture+MalTaxFullKitchenEquip+
    MalTaxFittings+MalTaxKitchenEquip+MalTaxHandphone+
    MalTaxServant+MalTaxHolidays+MalTaxOtherFoodCloth+
    MalTaxAccomdation+MalTaxRefundPension+MalTaxAnnuity) into total
    from MalTaxRecord join MalTaxEmployee where
    FGetMalTaxRecordEmployeeSysId(MalTaxRecord.PersonalsysId,MalTaxRecord.MalTaxYear) = In_EmployeeSysId and FGetMalTaxRecordYear(MalTaxRecord.MalTaxYear) = In_Year;   
  return total
end
;

commit work;