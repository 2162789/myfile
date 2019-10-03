if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalTaxExemptFromEr') then
   drop procedure FGetMalTaxExemptFromEr
end if
;

CREATE FUNCTION DBA.FGetMalTaxExemptFromEr(
in In_RebateID char(20))
returns integer
begin
  declare Out_result integer;
  select(if In_RebateID in('Petrol Non Official','Petrol Official','Parking','Meal','Childcare','Communication','Loan Interest','Innovation','Gift New Computer') then
    1 else 0 endif) into Out_result;

/* 
  select(if In_RebateID in('Petrol Non Official','Petrol Official','Parking','Meal','Childcare','Communication',
				'Employer Goods','Employer Service','Loan Interest','Other Medical','Innovation',
				'Gift New Computer','Lve Passage','Lve Passage Overseas','Foreign Insurance','Group Insurance') then
      1 else 0 endif) into Out_result;
*/
  return(Out_result)
end;

commit work;
