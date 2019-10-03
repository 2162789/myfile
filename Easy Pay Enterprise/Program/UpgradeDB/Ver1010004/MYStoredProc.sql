if exists(select 1 from sys.sysprocedure where proc_name = 'FGetEAFormRebateGranted') then
   drop procedure FGetEAFormRebateGranted
end if
;

CREATE FUNCTION "DBA"."FGetEAFormRebateGranted"(
in In_PersonalSysId integer,
in In_Year integer)
returns double
begin
  declare total double;
  select sum(FConvertNull(g.RebateAmt)-FConvertNull(g.LPAmt)) into total
    from RebateGranted as g where
    FGetMalTaxExemptFromEr(g.RebateID) = 1
    group by PersonalSysId,RebateDeclaredYear having
    g.RebateDeclaredYear = In_Year and
    g.PersonalSysId = In_PersonalSysId;
  return total
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalBIKItem') then
   drop procedure InsertNewMalBIKItem
end if
;

create procedure
dba.InsertNewMalBIKItem(
in In_MalBIKItemID char(20),
in In_MalBIKPropertyId char(20),
in In_MalBIKItemDesc char(100),
in In_MalBIKAddTax integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
    insert into MalBIKItem(MalBIKItemId,
      MalBIKPropertyId,
      MalBIKItemDesc,
      MalBIKAddTax) values(
      In_MalBIKItemID,
      In_MalBIKPropertyId,
      In_MalBIKItemDesc,
      In_MalBIKAddTax);
    commit work;
    if not exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalBIKItem') then
   drop procedure UpdateMalBIKItem
end if
;

create procedure
dba.UpdateMalBIKItem(
in In_MalBIKItemID char(20),
in In_MalBIKPropertyId char(20),
in In_MalBIKItemDesc char(100),
in In_MalBIKAddTax integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKItem where MalBIKItemId = In_MalBIKItemID) then
    update MalBIKItem set
      MalBIKPropertyId = In_MalBIKPropertyId,
      MalBIKItemDesc = In_MalBIKItemDesc,
      MalBIKAddTax = In_MalBIKAddTax where
      MalBIKItemId = In_MalBIKItemID;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

commit work;
