if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPhExemptionStatusAlphalist') then
   drop procedure FGetPhExemptionStatusAlphalist
end if
;

CREATE FUNCTION "DBA"."FGetPhExemptionStatusAlphalist"(
in In_PersonalSysId integer,
in In_PhTaxYear integer)
returns char(10)
begin
  declare Out_ExemptionStatusFormatted char(10);
  declare PhExemption char(20);
  declare PhDependentNo integer;
  declare ExemptionStatusShortForm char(10);
  select PhExemption,PhDependentNo into PhExemption,
    PhDependentNo from PhTaxRecord where
    PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear;
  case PhExemption 
    when 'Single' then set ExemptionStatusShortForm='S' 
    when 'Married' then set ExemptionStatusShortForm='M'
    when 'Zero' then set ExemptionStatusShortForm='Z'
  else
    set ExemptionStatusShortForm=''
  end case
  ;
  if PhDependentNo > 0 and ExemptionStatusShortForm <> 'Z' then
    set Out_ExemptionStatusFormatted=ExemptionStatusShortForm || PhDependentNo
  else
    set Out_ExemptionStatusFormatted=ExemptionStatusShortForm
  end if;
  return Out_ExemptionStatusFormatted
end
;