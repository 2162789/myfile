if exists(select * from sys.sysprocedure where proc_name = 'FGetHiredMonthForResigned') then
  DROP FUNCTION FGetHiredMonthForResigned;
end if;
Create FUNCTION "DBA"."FGetHiredMonthForResigned"(
in In_PersonalSysId integer,
in In_Month integer,
in In_Year integer)
returns integer
begin

  Declare Out_FromMonth integer ;
  Declare Out_HireDate date;

  Select Top 1 HireDate into Out_HireDate From Employee 
  where (Year(CessationDate)= In_Year and Month(CessationDate)=In_Month and PersonalSysID=In_PersonalSysId ) order by CessationDate Desc ;
  if Year(Out_HireDate)<>In_Year Then 
    set Out_FromMonth=1;
  else
    set Out_FromMonth=Month(Out_HireDate);
  end if;

  return Out_FromMonth
end
;

commit work;