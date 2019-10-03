if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalTaxDetails' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateMalTaxDetails
end if
;

create procedure DBA.UpdateMalTaxDetails(
in In_PersonalSysId integer,
in In_MalTaxPolicyId char(20),
in In_MalTaxEmployerId char(20),
in In_MalTaxEETaxRefNo char(20),
in In_MalTaxMethod char(20),
in In_MalTaxChildRelief double,
in In_MalTaxNoChildRelief integer,
in In_MalTaxNoChildBelow18 integer,
in In_MalTaxSpouseTaxRefNo char(100),
in In_MalTaxSpouseWorking smallint,
in In_MalTaxSpouseTaxBranchId char(20),
in In_MalTaxPriority smallint,
in In_MalTaxScheme char(20),
in In_IsHandicapped smallint,
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from MalTaxDetails where PersonalSysId = In_PersonalSysId) then
    update MalTaxDetails set
      MalTaxPolicyId = In_MalTaxPolicyId,
      MalTaxEmployerId = In_MalTaxEmployerId,
      MalTaxEETaxRefNo = In_MalTaxEETaxRefNo,
      MalTaxMethod = In_MalTaxMethod,
      MalTaxChildRelief = In_MalTaxChildRelief,
      MalTaxNoChildRelief = In_MalTaxNoChildRelief,
      MalTaxNoChildBelow18 = In_MalTaxNoChildBelow18,
      MalTaxSpouseTaxRefNo = In_MalTaxSpouseTaxRefNo,
      MalTaxSpouseWorking = In_MalTaxSpouseWorking,
      MalTaxSpouseTaxBranchId = In_MalTaxSpouseTaxBranchId,
      MalTaxPriority = In_MalTaxPriority,
      MalTaxScheme = In_MalTaxScheme,
      IsHandicapped = In_IsHandicapped where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxPolicyProg' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewMalTaxPolicyProg
end if
;

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
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalTaxDetails' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewMalTaxDetails
end if
;

create procedure DBA.InsertNewMalTaxDetails(
in In_PersonalSysId integer,
in In_MalTaxPolicyId char(20),
in In_MalTaxEmployerId char(20),
in In_MalTaxEETaxRefNo char(20),
in In_MalTaxMethod char(20),
in In_MalTaxChildRelief double,
in In_MalTaxNoChildRelief integer,
in In_MalTaxNoChildBelow18 integer,
in In_MalTaxSpouseTaxRefNo char(100),
in In_MalTaxSpouseWorking smallint,
in In_MalTaxSpouseTaxBranchId char(20),
in In_MalTaxPriority smallint,
in In_MalTaxScheme char(20),
in In_IsHandicapped smallint,
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from MalTaxDetails where PersonalSysId = In_PersonalSysId) then
    insert into MalTaxDetails(PersonalSysId,
      MalTaxPolicyId,
      MalTaxEmployerId,
      MalTaxEETaxRefNo,
      MalTaxMethod,
      MalTaxChildRelief,
      MalTaxNoChildRelief,
      MalTaxNoChildBelow18,
      MalTaxSpouseTaxRefNo,
      MalTaxSpouseWorking,
      MalTaxSpouseTaxBranchId,
      MalTaxPriority,
	  MalTaxScheme,
	  IsHandicapped) values(
      In_PersonalSysId,
      In_MalTaxPolicyId,
      In_MalTaxEmployerId,
      In_MalTaxEETaxRefNo,
      In_MalTaxMethod,
      In_MalTaxChildRelief,
      In_MalTaxNoChildRelief,
      In_MalTaxNoChildBelow18,
      In_MalTaxSpouseTaxRefNo,
      In_MalTaxSpouseWorking,
      In_MalTaxSpouseTaxBranchId,
      In_MalTaxPriority,
	  In_MalTaxScheme,
	  In_IsHandicapped);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-2
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalSTDPolicy' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewMalSTDPolicy
end if
;

create procedure DBA.InsertNewMalSTDPolicy(
in In_MalSTDPolicyId char(20),
in In_MalSTDPolicyDesc char(100),
in In_MalSTDFormula1Ratio double,
in In_MalTaxScheme char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
    insert into MalSTDPolicy(MalSTDPolicyId,
      MalSTDPolicyDesc,MalSTDFormula1Ratio,MalTaxScheme) values(In_MalSTDPolicyId,
      In_MalSTDPolicyDesc,In_MalSTDFormula1Ratio,In_MalTaxScheme);
    commit work;
    if not exists(select* from MalSTDPolicy where MalSTDPolicyId = In_MalSTDPolicyId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteMalTaxPolicyProg' and user_name(creator) = 'DBA') then
   drop procedure DBA.DeleteMalTaxPolicyProg
end if
;

create procedure DBA.DeleteMalTaxPolicyProg(
in In_MalTaxPolicyProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
    if exists(select* from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      delete from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
      commit work
    end if;
    delete from MalTaxFormula where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    delete from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId;
    commit work;
    if exists(select* from MalTaxPolicyProg where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

