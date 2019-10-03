if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewEPFProgression') then
   drop procedure InsertNewEPFProgression
end if
;

CREATE PROCEDURE "DBA"."InsertNewEPFProgression"(
in In_EmployeeSysId integer,
in In_EPFEffectiveDate date,
in In_EPFCareerId char(20),
in In_EPFProgPolicyId char(20),
in In_EPFProgSchemeId char(20),
in In_EPFEEVolPercent double,
in In_EPFERVolPercent double,
in In_EPFEEVolAmt double,
in In_EPFERVolAmt double,
in In_EPFProgRemarks char(255),
in In_EPFProgCurrent smallint)
begin
  if not exists(select* from EPFProgression where
      EPFProgression.EmployeeSysId = In_EmployeeSysId and
      EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate) then
    insert into EPFProgression(EmployeeSysId,
      EPFEffectiveDate,
      EPFCareerId,
      EPFProgPolicyId,
      EPFProgSchemeId,
      EPFEEVolPercent,
      EPFERVolPercent,
      EPFEEVolAmt,
      EPFERVolAmt,
      EPFProgRemarks,
      EPFProgCurrent) values(
      In_EmployeeSysId,
      In_EPFEffectiveDate,
      In_EPFCareerId,
      In_EPFProgPolicyId,
      In_EPFProgSchemeId,
      In_EPFEEVolPercent,
      In_EPFERVolPercent,
      In_EPFEEVolAmt,
      In_EPFERVolAmt,
      In_EPFProgRemarks,
      In_EPFProgCurrent);
    commit work
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateEPFProgression') then
   drop procedure UpdateEPFProgression
end if
;

CREATE PROCEDURE "DBA"."UpdateEPFProgression"(
in In_EmployeeSysId integer,
in In_EPFEffectiveDate date,
in In_EPFCareerId char(20),
in In_EPFProgPolicyId char(20),
in In_EPFProgSchemeId char(20),
in In_EPFEEVolPercent double,
in In_EPFERVolPercent double,
in In_EPFEEVolAmt double, 
in In_EPFERVolAmt double,
in In_EPFProgRemarks char(255),
in In_EPFProgCurrent smallint)
begin
  if exists(select* from EPFProgression where EPFProgression.EmployeeSysId = In_EmployeeSysId and EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate) then
    if(In_EPFProgCurrent = 1) then
      update EPFProgression set
        EPFProgression.EPFProgCurrent = 0 where
        EPFProgression.EmployeeSysId = In_EmployeeSysId
    end if;
    update EPFProgression set
      EPFProgression.EmployeeSysId = In_EmployeeSysId,
      EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate,
      EPFProgression.EPFCareerId = In_EPFCareerId,
      EPFProgression.EPFProgPolicyId = In_EPFProgPolicyId,
      EPFProgression.EPFProgSchemeId = In_EPFProgSchemeId,
      EPFProgression.EPFEEVolPercent = In_EPFEEVolPercent,
      EPFProgression.EPFERVolPercent = In_EPFERVolPercent,
      EPFProgression.EPFEEVolAmt = In_EPFEEVolAmt,
      EPFProgression.EPFERVolAmt = In_EPFERVolAmt,
      EPFProgression.EPFProgRemarks = In_EPFProgRemarks,
      EPFProgression.EPFProgCurrent = In_EPFProgCurrent where
      EPFProgression.EmployeeSysId = In_EmployeeSysId and EPFProgression.EPFEffectiveDate = In_EPFEffectiveDate;
    commit work
  end if
end
;


