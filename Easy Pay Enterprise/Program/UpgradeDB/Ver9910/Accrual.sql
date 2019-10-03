create procedure dba.ASQLUpdateAccrualBasisKeyword()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare CustInteger1_Id char(20);
  declare CustInteger2_Id char(20);
  declare CustInteger3_Id char(20);
  declare CustNumeric1_Id char(20);
  declare CustNumeric2_Id char(20);
  declare CustNumeric3_Id char(20);
  declare CustDate1_Id char(20);
  declare CustDate2_Id char(20);
  declare CustDate3_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into CustInteger1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger1';
  select NewLName into CustInteger2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger2';
  select NewLName into CustInteger3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger3';
  select NewLName into CustNumeric1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric1';
  select NewLName into CustNumeric2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric2';
  select NewLName into CustNumeric3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric3';
  select NewLName into CustDate1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
  if exists(select* from CostKeyword where
      CostKeywordId = 'PayEmpCode1Id') then
    update CostKeyword set CostKeywordDesc = EmpCode1_Id,CostKeywordUserDefinedName = EmpCode1_Id where
      CostKeywordId = 'PayEmpCode1Id'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'PayEmpCode2Id') then
    update CostKeyword set CostKeywordDesc = EmpCode2_Id,CostKeywordUserDefinedName = EmpCode2_Id where
      CostKeywordId = 'PayEmpCode2Id'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'PayEmpCode3Id') then
    update CostKeyword set CostKeywordDesc = EmpCode3_Id,CostKeywordUserDefinedName = EmpCode3_Id where
      CostKeywordId = 'PayEmpCode3Id'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'PayEmpCode4Id') then
    update CostKeyword set CostKeywordDesc = EmpCode4_Id,CostKeywordUserDefinedName = EmpCode4_Id where
      CostKeywordId = 'PayEmpCode4Id'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'PayEmpCode5Id') then
    update CostKeyword set CostKeywordDesc = EmpCode5_Id,CostKeywordUserDefinedName = EmpCode5_Id where
      CostKeywordId = 'PayEmpCode5Id'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'CustInteger1') then
    update CostKeyword set CostKeywordDesc = CustInteger1_Id,CostKeywordUserDefinedName = CustInteger1_Id where
      CostKeywordId = 'CustInteger1'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'CustInteger2') then
    update CostKeyword set CostKeywordDesc = CustInteger2_Id,CostKeywordUserDefinedName = CustInteger2_Id where
      CostKeywordId = 'CustInteger2'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'CustInteger3') then
    update CostKeyword set CostKeywordDesc = CustInteger3_Id,CostKeywordUserDefinedName = CustInteger3_Id where
      CostKeywordId = 'CustInteger3'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'CustNumeric1') then
    update CostKeyword set CostKeywordDesc = CustNumeric1_Id,CostKeywordUserDefinedName = CustNumeric1_Id where
      CostKeywordId = 'CustNumeric1'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'CustNumeric2') then
    update CostKeyword set CostKeywordDesc = CustNumeric2_Id,CostKeywordUserDefinedName = CustNumeric2_Id where
      CostKeywordId = 'CustNumeric2'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'CustNumeric3') then
    update CostKeyword set CostKeywordDesc = CustNumeric3_Id,CostKeywordUserDefinedName = CustNumeric3_Id where
      CostKeywordId = 'CustNumeric3'
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'ExcludeCustDate1') then
    if CustDate1_Id <> '' then
      update CostKeyword set CostKeywordDesc = 'Exclude '+CustDate1_Id,CostKeywordUserDefinedName = 'Exclude '+CustDate1_Id where
        CostKeywordId = 'ExcludeCustDate1'
    else
      update CostKeyword set CostKeywordDesc = CustDate1_Id,CostKeywordUserDefinedName = CustDate1_Id where
        CostKeywordId = 'ExcludeCustDate1'
    end if
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'ExcludeCustDate2') then
    if CustDate2_Id <> '' then
      update CostKeyword set CostKeywordDesc = 'Exclude '+CustDate2_Id,CostKeywordUserDefinedName = 'Exclude '+CustDate2_Id where
        CostKeywordId = 'ExcludeCustDate2'
    else
      update CostKeyword set CostKeywordDesc = CustDate2_Id,CostKeywordUserDefinedName = CustDate2_Id where
        CostKeywordId = 'ExcludeCustDate2'
    end if
  end if;
  if exists(select* from CostKeyword where
      CostKeywordId = 'ExcludeCustDate3') then
    if CustDate3_Id <> '' then
      update CostKeyword set CostKeywordDesc = 'Exclude '+CustDate3_Id,CostKeywordUserDefinedName = 'Exclude '+CustDate3_Id where
        CostKeywordId = 'ExcludeCustDate3'
    else
      update CostKeyword set CostKeywordDesc = CustDate3_Id,CostKeywordUserDefinedName = CustDate3_Id where
        CostKeywordId = 'ExcludeCustDate3'
    end if
  end if;
  commit work
end
;

create procedure DBA.ASQLUpdateAccrualRecord(
in In_AccrItemId char(20),
in In_EmployeeSysId integer,
in In_CostPeriodSysId integer,
in In_CostSubPeriod integer,
in In_AccrAmount double,
in In_AccrRecKey1 integer,
in In_AccrRecKey2 integer,
in In_AccrRecKey3 integer,
in In_AccrRecKey4 integer,
in In_AccrRecKey5 integer,
in In_AccrRecKeyStr1 char(20),
in In_AccrRecKeyStr2 char(20),
in In_AccrFormulaDesc char(100),
in In_CreatedBy char(1),
in In_LastProcessed date,
out Out_Error integer)
begin
  declare Out_AccrRecSysId char(30);
  declare Out_AccrAmount double;
  set Out_Error=0;
  select FGetNewSGSPGeneratedIndex('AccrualRecord') into Out_AccrRecSysId;
  insert into AccrualRecord(AccrRecSysId,
    EmployeeSysId,
    CostPeriodSysId,
    CostSubPeriod,
    AccrItemId,
    AccrAmount,
    AccrRecKey1,
    AccrRecKey2,
    AccrRecKey3,
    AccrRecKey4,
    AccrRecKey5,
    AccrRecKeyStr1,
    AccrRecKeyStr2,
    AccrFormulaDesc,
    CreatedBy,
    LastProcessed) values(
    Out_AccrRecSysId,
    In_EmployeeSysId,
    In_CostPeriodSysId,
    In_CostSubPeriod,
    In_AccrItemId,
    In_AccrAmount,
    In_AccrRecKey1,
    In_AccrRecKey2,
    In_AccrRecKey3,
    In_AccrRecKey4,
    In_AccrRecKey5,
    In_AccrRecKeyStr1,
    In_AccrRecKeyStr2,
    In_AccrFormulaDesc,
    In_CreatedBy,
    In_LastProcessed);
  commit work
end
;

create procedure dba.DeleteAccrGWItem(
in In_AccrGWSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AccrGWItem where AccrGWSysId = In_AccrGWSysId) then
    delete from AccrGWItem where AccrGWSysId = In_AccrGWSysId;
    commit work;
    if exists(select* from AccrGWItem where AccrGWSysId = In_AccrGWSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrualEligible(
in In_AccrualEligibleId char(20),
out Out_ErrorCode integer)
begin
  if In_AccrualEligibleId <> 'ALL' then
    if not exists(select* from AccrualItem where AccrualEligibleId = In_AccrualEligibleId) then
      if exists(select* from AccrualEligible where AccrualEligibleId = In_AccrualEligibleId) then
        if exists(select* from AccrualEligibleBasis where AccrualEligibleId = In_AccrualEligibleId) then
          delete from AccrualEligibleBasis where AccrualEligibleId = In_AccrualEligibleId;
          commit work
        end if;
        delete from AccrualEligible where AccrualEligibleId = In_AccrualEligibleId;
        commit work;
        if exists(select* from AccrualEligible where AccrualEligibleId = In_AccrualEligibleId) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.DeleteAccrualField(
in In_AccrItemId char(20),
in In_AccrFieldOrder integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualField where AccrItemId = In_AccrItemId and
      AccrFieldOrder = In_AccrFieldOrder) then
    delete from AccrualField where AccrItemId = In_AccrItemId and AccrFieldOrder = In_AccrFieldOrder;
    commit work;
    if exists(select* from AccrualField where AccrItemId = In_AccrItemId and
        AccrFieldOrder = In_AccrFieldOrder) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrualGroup(
in In_AccrItemGroupId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualGroup where AccrualGroup.AccrItemGroupId = In_AccrItemGroupId) then
    if not exists(select* from AccrualItem where AccrualItem.AccrItemGroupId = In_AccrItemGroupId) then
      delete from AccrualGroup where
        AccrualGroup.AccrItemGroupId = In_AccrItemGroupId;
      commit work
    end if;
    if exists(select* from AccrualGroup where AccrualGroup.AccrItemGroupId = In_AccrItemGroupId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrualItem(
in In_AccrItemId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrualRecord where AccrItemId = In_AccrItemId) then
    if not exists(select* from AccrualField where AccrModule = 'AccrAccrual' and AccrType = 'AccrAccrualItem' and
        AccrFieldId = In_AccrItemId) then
      if exists(select* from AccrualItem where AccrItemId = In_AccrItemId) then
        if exists(select* from AccrualItemPeriod where AccrItemId = In_AccrItemId) then
          delete from AccrualItemPeriod where AccrItemId = In_AccrItemId;
          commit work
        end if;
        if exists(select* from AccrualField where AccrItemId = In_AccrItemId) then
          delete from AccrualField where AccrItemId = In_AccrItemId;
          commit work
        end if;
        if exists(select* from AccrualUserDefined where AccrItemId = In_AccrItemId) then
          delete from AccrualUserDefined where AccrItemId = In_AccrItemId;
          commit work
        end if;
        if exists(select* from AccrItemBasis where AccrItemId = In_AccrItemId) then
          delete from AccrItemBasis where AccrItemId = In_AccrItemId;
          commit work
        end if;
        if exists(select* from AccrualCondition where AccrItemId = In_AccrItemId) then
          delete from AccrualCondition where AccrItemId = In_AccrItemId;
          commit work
        end if;
        delete from AccrualItem where AccrItemId = In_AccrItemId;
        commit work;
        if exists(select* from AccrualItem where AccrItemId = In_AccrItemId) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrualMethod(
in In_AccrMethodId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrItemBasis where AccrMethodId = In_AccrMethodId) then
    if exists(select* from AccrualMethod where AccrMethodId = In_AccrMethodId) then
      delete from AccrualMethod where AccrMethodId = In_AccrMethodId;
      commit work;
      if exists(select* from AccrualMethod where AccrMethodId = In_AccrMethodId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrualPeriodSetup(
in In_CostGroupId char(20),
in In_AccrualYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualPeriodSetup where
      CostGroupId = In_CostGroupId and
      AccrualYear = In_AccrualYear) then
    delete from AccrualPeriodSetup where CostGroupId = In_CostGroupId and AccrualYear = In_AccrualYear;
    commit work;
    if exists(select* from AccrualPeriodSetup where
        CostGroupId = In_CostGroupId and
        AccrualYear = In_AccrualYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAccrGWItem(
in In_AccrGWId char(20),
in In_AccrGWItemType char(100),
in In_AccrGWItemId char(20),
out Out_AccrGWSysId integer,
out Out_ErrorCode integer)
begin
  declare AccrGWItemId integer;
  select MAX(AccrGWSysId) into AccrGWItemId from AccrGWItem where AccrGWId = In_AccrGWId;
  if AccrGWItemId is null then set AccrGWItemId=0
  end if;
  if not exists(select* from AccrGWItem where AccrGWId = In_AccrGWId and AccrGWItemType = In_AccrGWItemType and
      AccrGWItemId = In_AccrGWItemId) then
    insert into AccrGWItem(AccrGWId,
      AccrGWItemType,
      AccrGWItemId) values(
      In_AccrGWId,
      In_AccrGWItemType,
      In_AccrGWItemId);
    commit work;
    select MAX(AccrGWSysId) into Out_AccrGWSysId from AccrGWItem where AccrGWId = In_AccrGWId;
    if Out_AccrGWSysId is null then set Out_AccrGWSysId=0
    end if;
    if AccrGWItemId = Out_AccrGWSysId then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAccrualEligible(
in In_AccrualEligibleId char(20),
in In_AccrualEligibleDesc char(100),
in In_AccrualNoOfBasis integer,
in In_AccrualBasis1Type char(20),
in In_AccrualBasis2Type char(20),
in In_AccrualBasis3Type char(20),
out Out_ErrorCode integer)
begin
  if In_AccrualEligibleId is not null then
    if In_AccrualNoOfBasis <> 0 then
      if not exists(select* from AccrualEligible where AccrualEligibleId = In_AccrualEligibleId) then
        insert into AccrualEligible(AccrualEligibleId,
          AccrualEligibleDesc,
          AccrualNoOfBasis,
          AccrualBasis1Type,
          AccrualBasis2Type,
          AccrualBasis3Type) values(
          In_AccrualEligibleId,
          In_AccrualEligibleDesc,
          In_AccrualNoOfBasis,
          In_AccrualBasis1Type,
          In_AccrualBasis2Type,
          In_AccrualBasis3Type);
        commit work;
        if not exists(select* from AccrualEligible where AccrualEligibleId = In_AccrualEligibleId) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    else
      set Out_ErrorCode=-2
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewAccrualField(
in In_AccrItemId char(20),
in In_AccrModule char(20),
in In_AccrType char(20),
in In_AccrFieldId char(20),
in In_AccrBasisAmount char(20),
out Out_AccrFieldOrder integer,
out Out_ErrorCode integer)
begin
  declare FieldOrder integer;
  if In_AccrItemId is not null then
    select MAX(AccrFieldOrder) into FieldOrder from AccrualField where AccrItemId = In_AccrItemId;
    if FieldOrder is null then set FieldOrder=0
    end if;
    if(FieldOrder < 10) then
      if not exists(select* from AccrualField where AccrItemId = In_AccrItemId and
          AccrFieldOrder = FieldOrder+1) then
        insert into AccrualField(AccrItemId,
          AccrFieldOrder,
          AccrModule,
          AccrType,
          AccrFieldId,
          AccrBasisAmount) values(
          In_AccrItemId,
          FieldOrder+1,
          In_AccrModule,
          In_AccrType,
          In_AccrFieldId,
          In_AccrBasisAmount);
        commit work;
        if not exists(select* from AccrualField where AccrItemId = In_AccrItemId and
            AccrFieldOrder = FieldOrder+1) then
          set Out_ErrorCode=0
        else
          set Out_AccrFieldOrder=FieldOrder+1;
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    else
      set Out_ErrorCode=-2
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewAccrualGroup(
in In_AccrItemGroupId char(20),
in In_AccrItemGroupDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrualGroup where AccrualGroup.AccrItemGroupId = In_AccrItemGroupId) then
    insert into AccrualGroup(AccrItemGroupId,AccrItemGroupDesc) values(In_AccrItemGroupId,In_AccrItemGroupDesc);
    commit work;
    if not exists(select* from AccrualGroup where AccrualGroup.AccrItemGroupId = In_AccrItemGroupId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAccrualItem(
in In_AccrItemId char(20),
in In_AccrItemDesc char(100),
in In_IsPayoutItem integer,
in In_AccrItemGroupId char(20),
in In_AccrOption integer,
in In_AccrModule char(20),
in In_AccrType char(20),
in In_AccrFieldId char(20),
in In_AccrualEligibleId char(20),
in In_AccrDLLName char(100),
in In_AccrOnAccrLevel integer,
in In_CustBoolean integer,
out Out_ErrorCode integer)
begin
  if In_AccrItemId is not null then
    if not exists(select* from AccrualItem where AccrItemId = In_AccrItemId) then
      insert into AccrualItem(AccrItemId,
        AccrItemDesc,
        IsPayoutItem,
        AccrItemGroupId,
        AccrOption,
        AccrModule,
        AccrType,
        AccrFieldId,
        AccrualEligibleId,
        AccrDLLName,
        AccrOnAccrLevel,
        CustBoolean) values(
        In_AccrItemId,
        In_AccrItemDesc,
        In_IsPayoutItem,
        In_AccrItemGroupId,
        In_AccrOption,
        In_AccrModule,
        In_AccrType,
        In_AccrFieldId,
        In_AccrualEligibleId,
        In_AccrDLLName,
        In_AccrOnAccrLevel,
        In_CustBoolean);
      commit work;
      if not exists(select* from AccrualItem where AccrItemId = In_AccrItemId) then
        set Out_ErrorCode=0
      else
        if(In_AccrOption = 0 or In_AccrOption = 1) then
          InsertAccrItemBasis: for InsertAccrItemBasisFor as InsertAccrItemBasisCurs dynamic scroll cursor for
            select AccrualBasisSysId as Out_AccrualBasisSysId from
              AccrualEligibleBasis where
              AccrualEligibleId = In_AccrualEligibleId do
            insert into AccrItemBasis(AccrItemId,
              AccrualBasisSysId) values(
              In_AccrItemId,
              Out_AccrualBasisSysId);
            commit work end for
        end if;
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewAccrualMethod(
in In_AccrMethodId char(20),
in In_AccrMethodDesc char(100),
in In_Formula char(255),
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrualMethod where AccrMethodId = In_AccrMethodId) then
    insert into AccrualMethod(AccrMethodId,
      AccrMethodDesc,
      Formula,
      Keywords1,
      Keywords2,
      Keywords3,
      Keywords4,
      Keywords5,
      Keywords6,
      Keywords7,
      Keywords8,
      Keywords9,
      Keywords10) values(
      In_AccrMethodId,
      In_AccrMethodDesc,
      In_Formula,
      In_Keywords1,
      In_Keywords2,
      In_Keywords3,
      In_Keywords4,
      In_Keywords5,
      In_Keywords6,
      In_Keywords7,
      In_Keywords8,
      In_Keywords9,
      In_Keywords10);
    commit work;
    if not exists(select* from AccrualMethod where AccrMethodId = In_AccrMethodId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAccrualPeriodSetup(
in In_CostGroupId char(20),
in In_AccrualYear integer,
in In_AccrualPeriod integer,
in In_GLCutOffDate date,
in In_AccrualWeek integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrualPeriodSetup where
      CostGroupId = In_CostGroupId and
      AccrualYear = In_AccrualYear and
      AccrualPeriod = In_AccrualPeriod) then
    insert into AccrualPeriodSetup(CostGroupId,
      AccrualYear,
      AccrualPeriod,
      GLCutOffDate,
      AccrualWeek) values(
      In_CostGroupId,
      In_AccrualYear,
      In_AccrualPeriod,
      In_GLCutOffDate,
      In_AccrualWeek);
    commit work;
    if not exists(select* from AccrualPeriodSetup where
        CostGroupId = In_CostGroupId and
        AccrualYear = In_AccrualYear and
        AccrualPeriod = In_AccrualPeriod) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrGWItem(
in In_AccrGWSysId integer,
in In_AccrGWId char(20),
in In_AccrGWItemType char(100),
in In_AccrGWItemId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrGWItem where AccrGWSysId = In_AccrGWSysId) then
    update AccrGWItem set AccrGWId = In_AccrGWId,
      AccrGWItemType = In_AccrGWItemType,
      AccrGWItemId = In_AccrGWItemId where
      AccrGWSysId = In_AccrGWSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualEligible(
in In_AccrualEligibleId char(20),
in In_AccrualEligibleDesc char(100),
in In_AccrualNoOfBasis integer,
in In_AccrualBasis1Type char(20),
in In_AccrualBasis2Type char(20),
in In_AccrualBasis3Type char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualEligible where AccrualEligibleId = In_AccrualEligibleId) then
    update AccrualEligible set AccrualEligibleDesc = In_AccrualEligibleDesc,
      AccrualNoOfBasis = In_AccrualNoOfBasis,
      AccrualBasis1Type = In_AccrualBasis1Type,
      AccrualBasis2Type = In_AccrualBasis2Type,
      AccrualBasis3Type = In_AccrualBasis3Type where
      AccrualEligibleId = In_AccrualEligibleId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualField(
in In_AccrItemId char(20),
in In_AccrFieldOrder integer,
in In_AccrModule char(20),
in In_AccrType char(20),
in In_AccrFieldId char(20),
in In_AccrBasisAmount char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualField where AccrItemId = In_AccrItemId and
      AccrFieldOrder = In_AccrFieldOrder) then
    update AccrualField set AccrModule = In_AccrModule,
      AccrType = In_AccrType,
      AccrFieldId = In_AccrFieldId,
      AccrBasisAmount = In_AccrBasisAmount where
      AccrItemId = In_AccrItemId and
      AccrFieldOrder = In_AccrFieldOrder;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualGroup(
in In_AccrItemGroupId char(20),
in In_AccrItemGroupDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualGroup where AccrItemGroupId = In_AccrItemGroupId) then
    update AccrualGroup set
      AccrItemGroupDesc = In_AccrItemGroupDesc where
      AccrItemGroupId = In_AccrItemGroupId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualItem(
in In_AccrItemId char(20),
in In_AccrItemDesc char(100),
in In_IsPayoutItem integer,
in In_AccrItemGroupId char(20),
in In_AccrOption integer,
in In_AccrModule char(20),
in In_AccrType char(20),
in In_AccrFieldId char(20),
in In_AccrualEligibleId char(20),
in In_AccrDLLName char(100),
in In_AccrOnAccrLevel integer,
in In_CustBoolean integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualItem where AccrItemId = In_AccrItemId) then
    update AccrualItem set AccrItemDesc = In_AccrItemDesc,
      IsPayoutItem = In_IsPayoutItem,
      AccrItemGroupId = In_AccrItemGroupId,
      AccrOption = In_AccrOption,
      AccrModule = In_AccrModule,
      AccrType = In_AccrType,
      AccrFieldId = In_AccrFieldId,
      AccrualEligibleId = In_AccrualEligibleId,
      AccrDLLName = In_AccrDLLName,
      AccrOnAccrLevel = In_AccrOnAccrLevel,
      CustBoolean = In_CustBoolean where
      AccrItemId = In_AccrItemId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualMethod(
in In_AccrMethodId char(20),
in In_AccrMethodDesc char(100),
in In_Formula char(255),
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualMethod where AccrMethodId = In_AccrMethodId) then
    update AccrualMethod set AccrMethodDesc = In_AccrMethodDesc,
      Formula = In_Formula,
      Keywords1 = In_Keywords1,
      Keywords2 = In_Keywords2,
      Keywords3 = In_Keywords3,
      Keywords4 = In_Keywords4,
      Keywords5 = In_Keywords5,
      Keywords6 = In_Keywords6,
      Keywords7 = In_Keywords7,
      Keywords8 = In_Keywords8,
      Keywords9 = In_Keywords9,
      Keywords10 = In_Keywords10 where
      AccrMethodId = In_AccrMethodId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualPeriodSetup(
in In_CostGroupId char(20),
in In_AccrualYear integer,
in In_AccrualPeriod integer,
in In_GLCutOffDate date,
in In_AccrualWeek integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualPeriodSetup where
      CostGroupId = In_CostGroupId and
      AccrualYear = In_AccrualYear and
      AccrualPeriod = In_AccrualPeriod) then
    update AccrualPeriodSetup set
      GLCutOffDate = In_GLCutOffDate,
      AccrualWeek = In_AccrualWeek where
      CostGroupId = In_CostGroupId and
      AccrualYear = In_AccrualYear and
      AccrualPeriod = In_AccrualPeriod;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrItemBasis(
in In_AccrItemId char(20),
in In_AccrualBasisSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AccrItemBasis where AccrItemId = In_AccrItemId and
      AccrualBasisSysId = In_AccrualBasisSysId) then
    delete from AccrItemBasis where AccrItemId = In_AccrItemId and
      AccrualBasisSysId = In_AccrualBasisSysId;
    commit work;
    if exists(select* from AccrItemBasis where AccrItemId = In_AccrItemId and
        AccrualBasisSysId = In_AccrualBasisSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAccrualGrossWage(
in In_AccrGWId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrualField where AccrModule = 'AccrAccrual' and
      AccrType = 'AccrGrossWage' and AccrFieldId = In_AccrGWId) then
    if exists(select* from AccrualGrossWage where AccrualGrossWage.AccrGWId = In_AccrGWId) then
      if exists(select* from AccrGWItem where AccrGWItem.AccrGWId = In_AccrGWId) then
        delete from AccrGWItem where
          AccrGWItem.AccrGWId = In_AccrGWId;
        commit work
      end if;
      delete from AccrualGrossWage where
        AccrualGrossWage.AccrGWId = In_AccrGWId;
      commit work;
      if exists(select* from AccrualGrossWage where AccrualGrossWage.AccrGWId = In_AccrGWId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.InsertNewAccrItemBasis(
in In_AccrItemId char(20),
in In_AccrualBasisSysId integer,
in In_AccrMethodId char(20),
in In_Formula char(255),
in In_AccrUserDefinedValue1 double,
in In_AccrUserDefinedValue2 double,
in In_AccrUserDefinedValue3 double,
in In_AccrUserDefinedValue4 double,
in In_AccrUserDefinedValue5 double,
in In_AccrFormulaDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrItemBasis where AccrItemId = In_AccrItemId and
      AccrualBasisSysId = In_AccrualBasisSysId) then
    insert into AccrItemBasis(AccrItemId,
      AccrualBasisSysId,
      AccrMethodId,
      Formula,
      AccrUserDefinedValue1,
      AccrUserDefinedValue2,
      AccrUserDefinedValue3,
      AccrUserDefinedValue4,
      AccrUserDefinedValue5,
      AccrFormulaDesc) values(
      In_AccrItemId,
      In_AccrualBasisSysId,
      In_AccrMethodId,
      In_Formula,
      In_AccrUserDefinedValue1,
      In_AccrUserDefinedValue2,
      In_AccrUserDefinedValue3,
      In_AccrUserDefinedValue4,
      In_AccrUserDefinedValue5,
      In_AccrFormulaDesc);
    commit work;
    if not exists(select* from AccrItemBasis where AccrItemId = In_AccrItemId and
        AccrualBasisSysId = In_AccrualBasisSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAccrualGrossWage(
in In_AccrGWId char(20),
in In_AccrGWDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from AccrualGrossWage where AccrualGrossWage.AccrGWId = In_AccrGWId) then
    insert into AccrualGrossWage(AccrGWId,AccrGWDesc) values(In_AccrGWId,In_AccrGWDesc);
    commit work;
    if not exists(select* from AccrualGrossWage where AccrualGrossWage.AccrGWId = In_AccrGWId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrItemBasis(
in In_AccrItemId char(20),
in In_AccrualBasisSysId integer,
in In_AccrMethodId char(20),
in In_Formula char(255),
in In_AccrUserDefinedValue1 double,
in In_AccrUserDefinedValue2 double,
in In_AccrUserDefinedValue3 double,
in In_AccrUserDefinedValue4 double,
in In_AccrUserDefinedValue5 double,
in In_AccrFormulaDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrItemBasis where AccrItemId = In_AccrItemId and
      AccrualBasisSysId = In_AccrualBasisSysId) then
    update AccrItemBasis set AccrMethodId = In_AccrMethodId,
      Formula = In_Formula,
      AccrUserDefinedValue1 = In_AccrUserDefinedValue1,
      AccrUserDefinedValue2 = In_AccrUserDefinedValue2,
      AccrUserDefinedValue3 = In_AccrUserDefinedValue3,
      AccrUserDefinedValue4 = In_AccrUserDefinedValue4,
      AccrUserDefinedValue5 = In_AccrUserDefinedValue5,
      AccrFormulaDesc = In_AccrFormulaDesc where
      AccrItemId = In_AccrItemId and
      AccrualBasisSysId = In_AccrualBasisSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAccrualGrossWage(
in In_AccrGWId char(20),
in In_AccrGWDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AccrualGrossWage where AccrGWId = In_AccrGWId) then
    update AccrualGrossWage set
      AccrGWDesc = In_AccrGWDesc where
      AccrGWId = In_AccrGWId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create function DBA.FGetCostEmperCPFRate(
in In_EmployeeSysId integer,
in In_StartDate date,
in In_EndDate date)
returns double
begin
  declare Out_CPFPolicyId char(20);
  declare Out_CPFSchemeId char(20);
  declare Out_PersonalSysId integer;
  declare Out_ResidenceTypeId char(20);
  declare Out_CPFTableCodeId char(20);
  declare Out_CPFFormulaId char(20);
  declare Out_CPFAge double;
  declare Out_CPFRate double;
  declare fResult double;
  /* Get nearest CPF SchemeId and PolicyId */
  select first CPFProgPolicyId,CPFProgSchemeId into Out_CPFPolicyId,Out_CPFSchemeId from CPFProgression where EmployeeSysId = In_EmployeeSysId and
    CPFEffectiveDate <= In_EndDate order by CPFEffectiveDate desc;
  if((Out_CPFPolicyId is null or Out_CPFPolicyId = '') or(Out_CPFSchemeId is null or Out_CPFSchemeId = '')) then
    return(0)
  end if;
  select PersonalSysId into Out_PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId;
  /* Get nearest ResidenceTypeId */
  select first ResidenceTypeId into Out_ResidenceTypeId from ResidenceStatusRecord where PersonalSysId = Out_PersonalSysId and
    ResStatusEffectiveDate <= In_EndDate order by ResStatusEffectiveDate desc;
  if(Out_ResidenceTypeId is null) then
    return(0)
  end if;
  /* Get CPF TableCodeId */
  select first CPFTableCode.CPFTableCodeId into Out_CPFTableCodeId from CPFPolicyMember join CPFTableCode where
    CPFPolicyId = Out_CPFPolicyId and CPFSchemeId = Out_CPFSchemeId and CPFResidenceTypeId = Out_ResidenceTypeId order by CPFTableCode.CPFTableCodeId;
  if(Out_CPFTableCodeId is null) then
    return(0)
  end if;
  /* Get CPF Age */
  set Out_CPFAge=FGetEmpeeCPFAge(Out_PersonalSysId,In_StartDate);
  /* Get Employer CPF Formula */
  select first EROrdCPFFormula into Out_CPFFormulaId from CPFTableComponent where
    CPFTableCodeId = Out_CPFTableCodeId and Out_CPFAge > MinCPFAge and Out_CPFAge <= MaxCPFAge order by
    MaxSalary desc;
  if(Out_CPFFormulaId is null) then
    return(0)
  end if;
  /* Get Employer CPF Rate */
  select(case FormulaType when 'T4' then 0 else Constant1 end) into Out_CPFRate from Formula join FormulaRange where Formula.FormulaId = Out_CPFFormulaId;
  set fResult=Out_CPFRate/100;
  return(fResult)
end
;

create function DBA.FGetEmpeeCPFAge(
in In_PersonalSysId integer,
in In_RefDate date)
returns double
begin
  declare in_DateOfBirth date;
  declare iEmpeeCPFAge double;
  declare TempAge double;
  select DateOfBirth into in_DateOfBirth from Personal where PersonalSysId = in_PersonalSysId;
  set TempAge=Months(in_DateOfBirth,In_RefDate);
  set iEmpeeCPFAge=Round(TempAge/12,2);
  return(iEmpeeCPFAge)
end
;

create function DBA.GenAccrNoOfChild(
in In_EmployeeSysId integer,
in In_CostYear integer,
in In_CostPeriod integer,
in In_AgeFr integer,
in In_AgeTo integer)
returns double
begin
  declare RetValue double;
  declare Out_PersonalSysId integer;
  declare Out_RefDate date;
  select PersonalSysId into Out_PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId;
  select CostDateFrom into Out_RefDate from CostGroupPeriod where CostGroupId = any(select FGetEmployeeCostGroup(In_EmployeeSysId)) and
    CostGroupYear = In_CostYear and CostGroupPeriod = In_CostPeriod and CostGroupSubPeriod = 1;
  if(Out_RefDate is not null) then
    select COUNT(FamilySysId) into RetValue from Family where PersonalSysId = Out_PersonalSysId and
      RelationshipId in('Son','Daughter') and
      (Months(DOB,Out_RefDate)/12) between In_AgeFr and In_AgeTo
  end if;
  return(RetValue)
end
;

create function DBA.GenAccrYTD(
in In_EmployeeSysId integer,
in In_AccrItemId char(20),
in In_CostYearFr integer,
in In_CostPeriodFr integer,
in In_CostYearTo integer,
in In_CostPeriodTo integer)
returns double
begin
  declare RetValue double;
  declare FrVal integer;
  declare ToVal integer;
  set FrVal=In_CostYearFr*100+In_CostPeriodFr;
  set ToVal=In_CostYearTo*100+In_CostPeriodTo;
  select Sum(AccrAmount) into RetValue from AccrualRecord natural join CostPeriod where
    AccrualRecord.EmployeeSysId = In_EmployeeSysId and
    AccrItemId = In_AccrItemId and(CostYear*100+CostPeriod) between FrVal and ToVal;
  return(RetValue)
end
;

create function dba.FGetAccrFormulaDesc(
in In_EmployeeSysId integer,
in In_AccrItemId char(20),
in In_CostPeriodSysId integer)
returns char(100)
begin
  declare Out_AccrFormulaDesc char(100);
  select AccrFormulaDesc into Out_AccrFormulaDesc from AccrualRecord where
    EmployeeSysId = In_EmployeeSysId and
    AccrItemId = In_AccrItemId and
    CostPeriodSysId = In_CostPeriodSysId;
  return(Out_AccrFormulaDesc)
end
;