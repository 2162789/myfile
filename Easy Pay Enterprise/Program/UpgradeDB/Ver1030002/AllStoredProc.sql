if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLEPMarkCurrent') then
   drop procedure ASQLEPMarkCurrent
end if
;

CREATE PROCEDURE "DBA"."ASQLEPMarkCurrent"(
in In_EmployeeSysId integer,
In_PeriodEndDate date)
begin
  declare Out_EPEffectiveDate date;
  declare Out_EPCurrent smallint;
  select first EPEffectiveDate,EPCurrent into Out_EPEffectiveDate,
    Out_EPCurrent from EmployPassProgression where
    EmployeeSysId = In_EmployeeSysId and
    EPEffectiveDate <= In_PeriodEndDate order by
    EPEffectiveDate desc;
  if(Out_EPEffectiveDate is not null and Out_EPCurrent = 0) then
    update EmployPassProgression set
      EPCurrent = 0 where
      EmployeeSysId = In_EmployeeSysId;
    update EmployPassProgression set EPCurrent = 1 where
      EmployeeSysId = In_EmployeeSysId and
      EPEffectiveDate = Out_EPEffectiveDate;
    commit work
  end if
end
;