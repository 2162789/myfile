create procedure dba.ASQLDeleteEngRPayElement(
in In_EmployeeSysId integer,
in In_ForProcess char(1),
in In_RecurAlloSuspense integer)
begin
  if In_ForProcess = 'C' then
    delete from EmployeeRecurAllowance where
      EmployeeRecurAllowance.EmployeeSysId = In_EmployeeSysId and RecurCreated = 'C';
    commit work
  else
    if exists(select* from EmployeeRecurAllowance where
        EmployeeRecurAllowance.EmployeeSysId = In_EmployeeSysId and RecurCreated in('E','C','M')) then
      if In_RecurAlloSuspense = 1 then
        update EmployeeRecurAllowance set EmployeeRecurAllowance.RecurAlloSuspense = In_RecurAlloSuspense where
          EmployeeRecurAllowance.EmployeeSysId = In_EmployeeSysId and RecurCreated in('E','C','M')
      else
        delete from EmployeeRecurAllowance where
          EmployeeRecurAllowance.EmployeeSysId = In_EmployeeSysId and RecurCreated in('E','C','M')
      end if;
      commit work
    end if
  end if
end
;


create procedure dba.ASQLDeleteMClaimPolicyFolder(
in In_PersonalSysId integer)
begin
  if exists(select* from MClaimPolicyFolder where
      MClaimPolicyFolder.PersonalSysId = In_PersonalSysId) then
    delete from MClaimPolicyFolder where
      MClaimPolicyFolder.PersonalSysId = In_PersonalSysId
  end if;
  commit work
end
;


create procedure DBA.ASQLProcessEmployeeItemBatch(
in In_EmployeeSysId integer,
in In_MapItemBatchSysId integer,
out Out_ErrorCode integer)
begin
  declare In_PersonalSysId integer;
  select PersonalSysId into In_PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId;
  /* Inserts the ItemAssignItem one by one */
  MapItemBatchLoop: for MapItemBatchForLoop as Cur_MapItemBatch dynamic scroll cursor for
    select MapItemBatch_mm.ItemBatchId as New_ItemBatchId from
      MapItemBatch_mm where
      MapItemBatch_mm.MapItemBatchSysId = In_MapItemBatchSysId do
    call ASQLItemBatchAssign(In_PersonalSysId,New_ItemBatchId,Out_ErrorCode) end for
end
;


create procedure DBA.ASQLProcessEmployeeMClaimPolicy(
in In_EmployeeSysId integer,
in In_MapMClaimPolicySysId integer,
in In_ForProcess char(1))
begin
  declare In_PersonalSysId integer;
  select PersonalSysId into In_PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId;
  /* Inserts the MClaimPolicyFolder one by one */
  //
  // In_ForProcess = E:Employment, C:Confirmation, M:Career Movement */
  //
  if In_ForProcess = 'E' or In_ForProcess = 'M' then
    MapMClaimPolicyLoop: for MapMClaimPolicyForLoop as Cur_MapMClaimPolicy dynamic scroll cursor for
      select MapMClaimPolicy_mm.MedClaimPolicyId as New_MedClaimPolicyId from
        MapMClaimPolicy_mm where
        MapMClaimPolicy_mm.MapMClaimPolicySysId = In_MapMClaimPolicySysId and MapMClaimPolicy_mm.ForProcess = 'E' do
      if not exists(select* from MClaimPolicyFolder where MClaimPolicyFolder.MedClaimPolicyId = New_MedClaimPolicyId and MClaimPolicyFolder.PersonalSysId = In_PersonalSysId) then
        insert into MClaimPolicyFolder(MedClaimPolicyId,PersonalSysId) values(
          New_MedClaimPolicyId,In_PersonalSysId);
        commit work
      end if end for
  end if;
  if In_ForProcess = 'C' or In_ForProcess = 'M' then
    //
    // Check confirmation for career movement.
    //
    if In_ForProcess = 'M' then
      if(IsConfirmAfterMarkCareerProg(In_EmployeeSysId) = 1) then
        return
      end if
    end if;
    MMapMClaimPolicyLoop: for MMapMClaimPolicyForLoop as Cur_MMapMClaimPolicy dynamic scroll cursor for
      select MapMClaimPolicy_mm.MedClaimPolicyId as New_MedClaimPolicyId from
        MapMClaimPolicy_mm where
        MapMClaimPolicy_mm.MapMClaimPolicySysId = In_MapMClaimPolicySysId and MapMClaimPolicy_mm.ForProcess = 'C' do
      if not exists(select* from MClaimPolicyFolder where MClaimPolicyFolder.MedClaimPolicyId = New_MedClaimPolicyId and MClaimPolicyFolder.PersonalSysId = In_PersonalSysId) then
        insert into MClaimPolicyFolder(MedClaimPolicyId,PersonalSysId) values(
          New_MedClaimPolicyId,In_PersonalSysId);
        commit work
      end if end for
  end if
end
;


create procedure DBA.ASQLProcessEmployeeRPayElement(
in In_EmployeeSysId integer,
in In_MapRPayElementSysId integer,
in In_ForProcess char(1))
begin
  declare StartYear integer;
  declare Out_RecurAlloSGSPGenId char(30);
  select max(PayGroupYear) into StartYear from PayGroupPeriod;
  /* Inserts the EmployeeRecurAllowance one by one */
  //
  // In_ForProcess = E:Employment, C:Confirmation, M:Career Movement */
  //
  if In_ForProcess = 'E' or In_ForProcess = 'M' then
    MapRPayElementLoop: for MapRPayElementForLoop as Cur_MapRPayElement dynamic scroll cursor for
      select MapRPayElement_mm.FormulaId as New_FormulaId,
        MapRPayElement_mm.RecurAlloSubPeriod as New_RecurAlloSubPeriod,
        MapRPayElement_mm.RecurAlloAmount as New_RecurAlloAmount,
        MapRPayElement_mm.RecurAlloPayRecId as New_RecurAlloPayRecId from
        MapRPayElement_mm where
        MapRPayElement_mm.MapRPayElementSysId = In_MapRPayElementSysId and MapRPayElement_mm.ForProcess = 'E' do
      call InsertNewEmpRecurAllow('Processed on '+FGetDateFormat(today(*)),New_FormulaId,0,New_RecurAlloAmount,0,0,New_RecurAlloSubPeriod,1,StartYear,0,0,In_EmployeeSysId,In_ForProcess,New_RecurAlloPayRecId,0,0,0,0,0,Out_RecurAlloSGSPGenId) end for
  end if;
  if In_ForProcess = 'C' or In_ForProcess = 'M' then
    //
    // Check confirmation for career movement.
    //
    if In_ForProcess = 'M' then
      if(IsConfirmAfterMarkCareerProg(In_EmployeeSysId) = 1) then
        return
      end if
    end if;
    MMapRPayElementLoop: for MMapRPayElementForLoop as Cur_MMapRPayElement dynamic scroll cursor for
      select MapRPayElement_mm.FormulaId as New_FormulaId,
        MapRPayElement_mm.RecurAlloSubPeriod as New_RecurAlloSubPeriod,
        MapRPayElement_mm.RecurAlloAmount as New_RecurAlloAmount,
        MapRPayElement_mm.RecurAlloPayRecId as New_RecurAlloPayRecId from
        MapRPayElement_mm where
        MapRPayElement_mm.MapRPayElementSysId = In_MapRPayElementSysId and MapRPayElement_mm.ForProcess = 'C' do
      call InsertNewEmpRecurAllow('Processed on '+FGetDateFormat(today(*)),New_FormulaId,0,New_RecurAlloAmount,0,0,New_RecurAlloSubPeriod,1,StartYear,0,0,In_EmployeeSysId,In_ForProcess,New_RecurAlloPayRecId,0,0,0,0,0,Out_RecurAlloSGSPGenId) end for
  end if
end
;


create procedure dba.DeleteMapItemBatch(
in In_MapItemBatchSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapItemBatch where MapItemBatch.MapItemBatchSysId = In_MapItemBatchSysId) then
    if exists(select* from MapItemBatch_mm where MapItemBatch_mm.MapItemBatchSysId = In_MapItemBatchSysId) then
      delete from MapItemBatch_mm where MapItemBatch_mm.MapItemBatchSysId = In_MapItemBatchSysId;
      commit work
    end if;
    delete from MapItemBatch where MapItemBatch.MapItemBatchSysId = In_MapItemBatchSysId;
    commit work;
    if exists(select* from MapItemBatch where MapItemBatch.MapItemBatchSysId = In_MapItemBatchSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteMapMClaimPolicy(
in In_MapMClaimPolicySysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapMClaimPolicy where MapMClaimPolicy.MapMClaimPolicySysId = In_MapMClaimPolicySysId) then
    if exists(select* from MapMClaimPolicy_mm where MapMClaimPolicy_mm.MapMClaimPolicySysId = In_MapMClaimPolicySysId) then
      delete from MapMClaimPolicy_mm where MapMClaimPolicy_mm.MapMClaimPolicySysId = In_MapMClaimPolicySysId;
      commit work
    end if;
    delete from MapMClaimPolicy where MapMClaimPolicy.MapMClaimPolicySysId = In_MapMClaimPolicySysId;
    commit work;
    if exists(select* from MapMClaimPolicy where MapMClaimPolicy.MapMClaimPolicySysId = In_MapMClaimPolicySysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteMapOT(
in In_MapOTSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapOT where MapOT.MapOTSysId = In_MapOTSysId) then
    delete from MapOT where MapOT.MapOTSysId = In_MapOTSysId;
    commit work;
    if exists(select* from MapOT where MapOT.MapOTSysId = In_MapOTSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMapRPayElement(
in In_MapRPayElementSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapRPayElement where MapRPayElement.MapRPayElementSysId = In_MapRPayElementSysId) then
    if exists(select* from MapRPayElement_mm where MapRPayElement_mm.MapRPayElementSysId = In_MapRPayElementSysId) then
      delete from MapRPayElement_mm where MapRPayElement_mm.MapRPayElementSysId = In_MapRPayElementSysId;
      commit work
    end if;
    delete from MapRPayElement where MapRPayElement.MapRPayElementSysId = In_MapRPayElementSysId;
    commit work;
    if exists(select* from MapRPayElement where MapRPayElement.MapRPayElementSysId = In_MapRPayElementSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.DeleteMapShift(
in In_MapShiftSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapShift where MapShift.MapShiftSysId = In_MapShiftSysId) then
    delete from MapShift where MapShift.MapShiftSysId = In_MapShiftSysId;
    commit work;
    if exists(select* from MapShift where MapShift.MapShiftSysId = In_MapShiftSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.InsertNewMapItemBatch(
in In_ItemBatchBasis1 char(20),
in In_ItemBatchBasis2 char(20),
in In_ItemBatchBasis3 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MapItemBatch where ItemBatchBasis1 = In_ItemBatchBasis1 and
      ItemBatchBasis2 = In_ItemBatchBasis2 and
      ItemBatchBasis3 = In_ItemBatchBasis3) then
    insert into MapItemBatch(ItemBatchBasis1,
      ItemBatchBasis2,
      ItemBatchBasis3) values(
      In_ItemBatchBasis1,
      In_ItemBatchBasis2,
      In_ItemBatchBasis3);
    commit work;
    if not exists(select* from MapItemBatch where ItemBatchBasis1 = In_ItemBatchBasis1 and
        ItemBatchBasis2 = In_ItemBatchBasis2 and
        ItemBatchBasis3 = In_ItemBatchBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMapMClaimPolicy(
in In_MClaimPolicyBasis1 char(20),
in In_MClaimPolicyBasis2 char(20),
in In_MClaimPolicyBasis3 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MapMClaimPolicy where MClaimPolicyBasis1 = In_MClaimPolicyBasis1 and
      MClaimPolicyBasis2 = In_MClaimPolicyBasis2 and
      MClaimPolicyBasis3 = In_MClaimPolicyBasis3) then
    insert into MapMClaimPolicy(MClaimPolicyBasis1,
      MClaimPolicyBasis2,
      MClaimPolicyBasis3) values(
      In_MClaimPolicyBasis1,
      In_MClaimPolicyBasis2,
      In_MClaimPolicyBasis3);
    commit work;
    if not exists(select* from MapMClaimPolicy where MClaimPolicyBasis1 = In_MClaimPolicyBasis1 and
        MClaimPolicyBasis2 = In_MClaimPolicyBasis2 and
        MClaimPolicyBasis3 = In_MClaimPolicyBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewMapOT(
in In_OTBasis1 char(20),
in In_OTBasis2 char(20),
in In_OTBasis3 char(20),
in In_OTTableId char(20),
out Out_ErrorCode integer)
begin
  if In_OTTableId = '' then
    set In_OTTableId=null
  end if;
  if not exists(select* from MapOT where OTBasis1 = In_OTBasis1 and
      OTBasis2 = In_OTBasis2 and
      OTBasis3 = In_OTBasis3) then
    insert into MapOT(OTBasis1,
      OTBasis2,
      OTBasis3,
      OTTableId) values(
      In_OTBasis1,
      In_OTBasis2,
      In_OTBasis3,
      In_OTTableId);
    commit work;
    if not exists(select* from MapOT where OTBasis1 = In_OTBasis1 and
        OTBasis2 = In_OTBasis2 and
        OTBasis3 = In_OTBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewMapRPayElement(
in In_RPayElementBasis1 char(20),
in In_RPayElementBasis2 char(20),
in In_RPayElementBasis3 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MapRPayElement where RPayElementBasis1 = In_RPayElementBasis1 and
      RPayElementBasis2 = In_RPayElementBasis2 and
      RPayElementBasis3 = In_RPayElementBasis3) then
    insert into MapRPayElement(RPayElementBasis1,
      RPayElementBasis2,
      RPayElementBasis3) values(
      In_RPayElementBasis1,
      In_RPayElementBasis2,
      In_RPayElementBasis3);
    commit work;
    if not exists(select* from MapRPayElement where RPayElementBasis1 = In_RPayElementBasis1 and
        RPayElementBasis2 = In_RPayElementBasis2 and
        RPayElementBasis3 = In_RPayElementBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.InsertNewMapShift(
in In_ShiftBasis1 char(20),
in In_ShiftBasis2 char(20),
in In_ShiftBasis3 char(20),
in In_ShiftTableId char(20),
out Out_ErrorCode integer)
begin
  if In_ShiftTableId = '' then
    set In_ShiftTableId=null
  end if;
  if not exists(select* from MapShift where ShiftBasis1 = In_ShiftBasis1 and
      ShiftBasis2 = In_ShiftBasis2 and
      ShiftBasis3 = In_ShiftBasis3) then
    insert into MapShift(ShiftBasis1,
      ShiftBasis2,
      ShiftBasis3,
      ShiftTableId) values(
      In_ShiftBasis1,
      In_ShiftBasis2,
      In_ShiftBasis3,
      In_ShiftTableId);
    commit work;
    if not exists(select* from MapShift where ShiftBasis1 = In_ShiftBasis1 and
        ShiftBasis2 = In_ShiftBasis2 and
        ShiftBasis3 = In_ShiftBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateMapItemBatch(
in In_MapItemBatchSysId integer,
in In_ItemBatchBasis1 char(20),
in In_ItemBatchBasis2 char(20),
in In_ItemBatchBasis3 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MapItemBatch where MapItemBatchSysId = In_MapItemBatchSysId) then
    update MapItemBatch set
      ItemBatchBasis1 = In_ItemBatchBasis1,
      ItemBatchBasis2 = In_ItemBatchBasis2,
      ItemBatchBasis3 = In_ItemBatchBasis3 where
      MapItemBatchSysId = In_MapItemBatchSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateMapMClaimPolicy(
in In_MapMClaimPolicySysId integer,
in In_MClaimPolicyBasis1 char(20),
in In_MClaimPolicyBasis2 char(20),
in In_MClaimPolicyBasis3 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MapMClaimPolicy where MapMClaimPolicySysId = In_MapMClaimPolicySysId) then
    update MapMClaimPolicy set
      MClaimPolicyBasis1 = In_MClaimPolicyBasis1,
      MClaimPolicyBasis2 = In_MClaimPolicyBasis2,
      MClaimPolicyBasis3 = In_MClaimPolicyBasis3 where
      MapMClaimPolicySysId = In_MapMClaimPolicySysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMapOT(
in In_MapOTSysId integer,
in In_OTBasis1 char(20),
in In_OTBasis2 char(20),
in In_OTBasis3 char(20),
in In_OTTableId char(20),
out Out_ErrorCode integer)
begin
  if In_OTTableId = '' then
    set In_OTTableId=null
  end if;
  if exists(select* from MapOT where MapOTSysId = In_MapOTSysId) then
    update MapOT set
      OTBasis1 = In_OTBasis1,
      OTBasis2 = In_OTBasis2,
      OTBasis3 = In_OTBasis3,
      OTTableId = In_OTTableId where
      MapOTSysId = In_MapOTSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateMapRPayElement(
in In_MapRPayElementSysId integer,
in In_RPayElementBasis1 char(20),
in In_RPayElementBasis2 char(20),
in In_RPayElementBasis3 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MapRPayElement where MapRPayElementSysId = In_MapRPayElementSysId) then
    update MapRPayElement set
      RPayElementBasis1 = In_RPayElementBasis1,
      RPayElementBasis2 = In_RPayElementBasis2,
      RPayElementBasis3 = In_RPayElementBasis3 where
      MapRPayElementSysId = In_MapRPayElementSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateMapShift(
in In_MapShiftSysId integer,
in In_ShiftBasis1 char(20),
in In_ShiftBasis2 char(20),
in In_ShiftBasis3 char(20),
in In_ShiftTableId char(20),
out Out_ErrorCode integer)
begin
  if In_ShiftTableId = '' then
    set In_ShiftTableId=null
  end if;
  if exists(select* from MapShift where MapShiftSysId = In_MapShiftSysId) then
    update MapShift set
      ShiftBasis1 = In_ShiftBasis1,
      ShiftBasis2 = In_ShiftBasis2,
      ShiftBasis3 = In_ShiftBasis3,
      ShiftTableId = In_ShiftTableId where
      MapShiftSysId = In_MapShiftSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;



create procedure dba.UpdatePayEmployeeOTTable(
in In_EmployeeSysId integer,
in In_OTTableId char(20))
begin
  if exists(select* from PayEmployee where PayEmployee.EmployeeSysId = In_EmployeeSysId) then
    update PayEmployee set
      OTTableId = In_OTTableId where
      PayEmployee.EmployeeSysid = In_EmployeeSysId;
    commit work
  end if
end
;


create procedure dba.UpdatePayEmployeeShiftTable(
in In_EmployeeSysId integer,
in In_ShiftTableId char(20))
begin
  if exists(select* from PayEmployee where PayEmployee.EmployeeSysId = In_EmployeeSysId) then
    update PayEmployee set
      ShiftTableId = In_ShiftTableId where
      PayEmployee.EmployeeSysid = In_EmployeeSysId;
    commit work
  end if
end
;


create procedure dba.ASQLUpdateItemBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'ItemBasis' and SubRegistryId = 'ItemEmpLoc1Id'
  end if;
  commit work
end
;


create procedure dba.ASQLUpdateMClaimBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'MClaimBasis' and SubRegistryId = 'MClaimEmpLoc1Id'
  end if;
  commit work
end
;


create procedure dba.ASQLUpdateOTBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'OTBasis' and SubRegistryId = 'OTEmpLoc1Id'
  end if;
  commit work
end
;


create procedure dba.ASQLUpdateRPayElementBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'RPayElementBasis' and SubRegistryId = 'RPayEleEmpLoc1Id'
  end if;
  commit work
end
;

create procedure dba.ASQLUpdateShiftBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'ShiftBasis' and SubRegistryId = 'ShiftEmpLoc1Id'
  end if;
  commit work
end
;


create function DBA.IsConfirmAfterMarkCareerProg(
in In_EmployeeSysId char(20))
returns integer
begin
  if exists(select Employee.EmployeeSysId,EmployeeName,ConfirmationDate,CareerEffectiveDate from Employee join CareerProgression where
      (ConfirmationDate = '1899-12-30' or ConfirmationDate > CareerEffectiveDate) and Employee.EmployeeSysId = In_EmployeeSysId and
      CareerCurrent = 1) then
    return(1)
  end if;
  return(0)
end
;

create procedure dba.DeleteMapDonation(
in In_MapDonationSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MapDonation where MapDonation.MapDonationSysId = In_MapDonationSysId) then
    if exists(select* from MapDonation_mm where MapDonation_mm.MapDonationSysId = In_MapDonationSysId) then
      delete from MapDonation_mm where MapDonation_mm.MapDonationSysId = In_MapDonationSysId;
      commit work
    end if;
    delete from MapDonation where MapDonation.MapDonationSysId = In_MapDonationSysId;
    commit work;
    if exists(select* from MapDonation where MapDonation.MapDonationSysId = In_MapDonationSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMapDonation(
in In_DonationBasis1 char(20),
in In_DonationBasis2 char(20),
in In_DonationBasis3 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from MapDonation where DonationBasis1 = In_DonationBasis1 and
      DonationBasis2 = In_DonationBasis2 and
      DonationBasis3 = In_DonationBasis3) then
    insert into MapDonation(DonationBasis1,
      DonationBasis2,
      DonationBasis3) values(
      In_DonationBasis1,
      In_DonationBasis2,
      In_DonationBasis3);
    commit work;
    if not exists(select* from MapDonation where DonationBasis1 = In_DonationBasis1 and
        DonationBasis2 = In_DonationBasis2 and
        DonationBasis3 = In_DonationBasis3) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateMapDonation(
in In_MapDonationSysId integer,
in In_DonationBasis1 char(20),
in In_DonationBasis2 char(20),
in In_DonationBasis3 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MapDonation where MapDonationSysId = In_MapDonationSysId) then
    update MapDonation set
      DonationBasis1 = In_DonationBasis1,
      DonationBasis2 = In_DonationBasis2,
      DonationBasis3 = In_DonationBasis3 where
      MapDonationSysId = In_MapDonationSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;






