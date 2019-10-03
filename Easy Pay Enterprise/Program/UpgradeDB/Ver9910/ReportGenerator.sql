
create procedure DBA.ASQLProcessQueryFolder(
in In_TmplFolderID char(20),
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(20))
begin
  // Creates the Query Folder first
  call InsertNewQueryFolder(In_QueryFolderID,In_QueryFolderDesc,In_TmplFolderID);
  // Inserts the CustomQuery one by one
  CustomQueryLoop: for CustomQueryForLoop as Cur_CustomQuery dynamic scroll cursor for
    select TmplQuery.TmplQueryID as New_CustomQueryID,
      TmplQuery.QueryDesc as New_QueryDesc,
      TmplQuery.DistinctOption as New_DistinctOption,
      TmplQuery.TableString as New_TableString,
      TmplMember.MasterQueryID as New_MasterQueryID from
      TmplMember join TmplQuery where
      TmplMember.TmplFolderID = In_TmplFolderID do
    call InsertNewCustomQuery(In_QueryFolderID,
    New_CustomQueryID,
    New_QueryDesc,
    New_DistinctOption,
    New_TableString,
    0,New_MasterQueryID);
    // Inserts the  CustomTable one by one
    CustomTableLoop: for CustomTableForLoop as Cur_CustomTable dynamic scroll cursor for
      select TmplTable.TmplTableID as New_CustomTableID,
        TmplTable.TableDesc as New_TableDesc,
        TmplTable.PhysicalName as New_PhysicalName from
        TmplMember join TmplQuery join TmplTable where
        TmplMember.TmplFolderID = In_TmplFolderID and
        TmplMember.TmplQueryID = New_CustomQueryID do
      call
      InsertNewCustomTable(
      In_QueryFolderID,
      New_CustomQueryID,
      New_CustomTableID,
      New_TableDesc,
      New_PhysicalName);
      // Inserts the  CustomAttribute one by one
      CustomAttributeLoop: for CustomAttributeForLoop as Cur_CustomAttribute dynamic scroll cursor for
        select TmplAttribute.TmplAttributeID as New_CustomAttributeID,
          TmplAttribute.PhysicalName as New_AttributePhysicalName,
          TmplAttribute.AttributeDesc as New_AttributeDesc,
          TmplAttribute.AttributeFormula as New_AttributeFormula,
          TmplAttribute.AttributeType as New_AttributeType from
          TmplMember join TmplQuery join TmplTable join TmplAttribute where
          TmplMember.TmplFolderID = In_TmplFolderID and
          TmplMember.TmplQueryID = New_CustomQueryID and
          TmplTable.TmplTableID = New_CustomTableID do
        call
        InsertNewCustomAttribute(
        In_QueryFolderID,
        New_CustomQueryID,
        New_CustomTableID,
        New_CustomAttributeID,
        New_AttributePhysicalName,
        New_AttributeDesc,
        New_AttributeType,New_AttributeFormula,0,0,0) end for end for;
    // Inserts the   CustomSearch one by one
    CustomSearchLoop: for CustomSearchForLoop as Cur_CustomSearch dynamic scroll cursor for
      select TmplSearch.TmplSearchID as New_CustomSearchID,
        TmplSearch.SearchCondition as New_SearchCondition,
        TmplSearch.SearchDesc as New_SearchDesc,
        TmplSearch.SearchType as New_SearchType from
        TmplMember join TmplQuery join TmplSearch where
        TmplMember.TmplFolderID = In_TmplFolderID and
        TmplMember.TmplQueryID = New_CustomQueryID do
      call InsertNewCustomSearch(In_QueryFolderID,
      New_CustomQueryID,
      New_CustomSearchID,
      New_SearchCondition,
      New_SearchDesc,
      New_SearchType) end for;
    // Inserts the   CustomRelation one by one
    CustomRelationLoop: for CustomRelationForLoop as Cur_CustomRelation dynamic scroll cursor for
      select TmplRelation.DetailTableID as New_DetailTableID,
        TmplRelation.DetailAttributeID as New_DetailAttributeID,
        TmplRelation.MasterTableID as New_MasterTableID,
        TmplRelation.MasterAttributeID as New_MasterAttributeID from
        TmplMember join TmplQuery join TmplRelation where
        TmplMember.TmplFolderID = In_TmplFolderID and
        TmplMember.TmplQueryID = New_CustomQueryID do
      call InsertNewCustomRelation(
      In_QueryFolderID,
      New_CustomQueryID,
      New_DetailTableID,
      New_DetailAttributeID,
      New_MasterTableID,
      New_MasterAttributeID,
      0) end for end for
end
;


create procedure dba.DeleteCustomAttribute(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_CustomAttributeID char(20))
begin
  declare Out_CustomTableID char(20);
  declare Out_CustomAttributeID char(20);
  if exists(select* from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID and
      CustomAttribute.CustomAttributeID = In_CustomAttributeID) then
    delete from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID and
      CustomAttribute.CustomAttributeID = In_CustomAttributeID;
    commit work
  end if;
  select first CustomTableID,CustomAttributeID into Out_CustomTableID,Out_CustomAttributeID from CustomAttribute where QueryFolderID = In_QueryFolderID and CustomQueryID = In_CustomQueryID and
    SortByPosition <> 0 order by SortByPosition asc;
  call UpdateCustomAttributeSortPosition(In_QueryFolderID,In_CustomQueryID,Out_CustomTableID,Out_CustomAttributeID);
  select first CustomTableID,CustomAttributeID into Out_CustomTableID,Out_CustomAttributeID from CustomAttribute where QueryFolderID = In_QueryFolderID and CustomQueryID = In_CustomQueryID and
    GroupByPosition <> 0 order by GroupByPosition asc;
  call UpdateCustomAttributeGroupPosition(In_QueryFolderID,In_CustomQueryID,Out_CustomTableID,Out_CustomAttributeID)
end
;



create procedure dba.DeleteCustomAttributeByCustomQueryID(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20))
begin
  if exists(select* from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID) then
    delete from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID;
    commit work
  end if
end
;



create procedure dba.DeleteCustomAttributeByCustomTableID(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20))
begin
  if exists(select* from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID) then
    delete from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID;
    commit work
  end if
end
;


create procedure dba.DeleteCustomAttributeByQueryFolderID(
in In_QueryFolderID char(20))
begin
  if exists(select* from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID) then
    delete from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;


create procedure dba.DeleteCustomQuery(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20))
begin
  if exists(select* from CustomQuery where
      CustomQuery.QueryFolderID = In_QueryFolderID and CustomQuery.CustomQueryID = In_CustomQueryID) then
    call DeleteCustomSearchByCustomQueryID(In_QueryFolderID,In_CustomQueryID);
    call DeleteCustomTableByCustomQueryID(In_QueryFolderID,In_CustomQueryID);
    delete from CustomRelation where
      CustomRelation.QueryFolderID = In_QueryFolderID and CustomRelation.CustomQueryID = In_CustomQueryID;
    delete from CustomQuery where
      CustomQuery.QueryFolderID = In_QueryFolderID and CustomQuery.CustomQueryID = In_CustomQueryID;
    commit work
  end if
end
;


create procedure dba.DeleteCustomQueryByQueryFolderID(
in In_QueryFolderID char(20))
begin
  if exists(select* from CustomQuery where
      CustomQuery.QueryFolderID = In_QueryFolderID) then
    call DeleteCustomSearchByQueryFolderID(In_QueryFolderID);
    call DeleteCustomTableByQueryFolderID(In_QueryFolderID);
    delete from CustomRelation where
      CustomRelation.QueryFolderID = In_QueryFolderID;
    delete from CustomQuery where
      CustomQuery.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;



create procedure dba.DeleteCustomRelation(
in In_RelationSysID integer)
begin
  if exists(select* from CustomRelation where
      CustomRelation.RelationSysID = In_RelationSysID) then
    delete from CustomRelation where
      CustomRelation.RelationSysID = In_RelationSysID;
    commit work
  end if
end
;



create procedure dba.DeleteCustomSearch(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomSearchID char(20))
begin
  if exists(select* from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID and
      CustomSearch.CustomSearchID = In_CustomSearchID) then
    delete from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID and
      CustomSearch.CustomSearchID = In_CustomSearchID;
    commit work
  end if
end
;


create procedure dba.DeleteCustomSearchByCustomQueryID(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20))
begin
  if exists(select* from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID) then
    delete from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID;
    commit work
  end if
end
;



create procedure dba.DeleteCustomSearchByQueryFolderID(
in In_QueryFolderID char(20))
begin
  if exists(select* from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID) then
    delete from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;



create procedure dba.DeleteCustomTable(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20))
begin
  if exists(select* from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID and
      CustomTable.CustomTableID = In_CustomTableID) then
    call DeleteCustomAttributeByCustomTableID(In_QueryFolderID,In_CustomQueryID,In_CustomTableID);
    delete from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID and
      CustomTable.CustomTableID = In_CustomTableID;
    commit work
  end if
end
;



create procedure dba.DeleteCustomTableByCustomQueryID(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20))
begin
  if exists(select* from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID) then
    call DeleteCustomAttributeByCustomQueryID(In_QueryFolderID,In_CustomQueryID);
    delete from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID;
    commit work
  end if
end
;


create procedure dba.DeleteCustomTableByQueryFolderID(
in In_QueryFolderID char(20))
begin
  if exists(select* from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID) then
    call DeleteCustomAttributeByQueryFolderID(In_QueryFolderID);
    delete from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;


create procedure dba.DeleteCustomVariables(
in In_QueryFolderID char(20))
begin
  if exists(select* from CustomVariables where
      CustomVariables.QueryFolderID = In_QueryFolderID) then
    delete from CustomVariables where
      CustomVariables.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;


create procedure dba.DeleteQueryFolder(
in In_QueryFolderID char(20))
begin
  if exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    if not exists(select* from ReportExport where
        ReportExport.QueryFolderID = In_QueryFolderID) then
      call DeleteCustomVariables(In_QueryFolderID);
      call DeleteCustomQueryByQueryFolderID(In_QueryFolderID);
      delete from QueryFolder where
        QueryFolder.QueryFolderID = In_QueryFolderID;
      commit work
    end if
  end if
end
;



create procedure dba.DeleteReportAccess(
in In_ReportExportID char(20),
in In_UserGroupID char(20))
begin
  if exists(select* from ReportAccess where
      ReportAccess.ReportExportID = In_ReportExportID and
      ReportAccess.UserGroupID = In_UserGroupID) then
    delete from ReportAccess where
      ReportAccess.ReportExportID = In_ReportExportID and
      ReportAccess.UserGroupID = In_UserGroupID;
    commit work
  end if
end
;



create procedure dba.DeleteReportExport(
in In_ReportExportID char(20))
begin
  if exists(select* from ReportExport where
      ReportExport.ReportExportID = In_ReportExportID) then
    delete from ReportAccess where
      ReportAccess.ReportExportID = In_ReportExportID;
    delete from ReportExport where
      ReportExport.ReportExportID = In_ReportExportID;
    commit work
  end if
end
;



create procedure dba.InsertNewCustomAttribute(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_CustomAttributeID char(20),
in In_PhysicalName char(100),
in In_AttributeDesc char(100),
in In_AttributeType char(20),
in In_AttributeFormula char(255),
in In_GroupByPosition integer,
in In_SortByPosition integer,
in In_SortByType integer)
begin
  if not exists(select* from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID and
      CustomAttribute.CustomAttributeID = In_CustomAttributeID) then
    insert into CustomAttribute(QueryFolderID,
      CustomQueryID,
      CustomTableID,
      CustomAttributeID,
      PhysicalName,
      AttributeDesc,
      AttributeType,
      AttributeFormula,
      GroupByPosition,
      SortByPosition,
      SortByType) values(In_QueryFolderID,
      In_CustomQueryID,
      In_CustomTableID,
      In_CustomAttributeID,
      In_PhysicalName,
      In_AttributeDesc,
      In_AttributeType,
      In_AttributeFormula,
      In_GroupByPosition,
      In_SortByPosition,
      In_SortByType);
    commit work
  end if;
  if(In_SortByPosition <> 0) then
    call UpdateCustomAttributeSortPosition(In_QueryFolderID,In_CustomQueryID,In_CustomTableID,In_CustomAttributeID)
  end if;
  if(In_GroupByPosition <> 0) then
    call UpdateCustomAttributeGroupPosition(In_QueryFolderID,In_CustomQueryID,In_CustomTableID,In_CustomAttributeID)
  end if;
  if(In_SortByPosition = 0 or In_GroupByPosition = 0) then
    return
  end if
end
;


create procedure dba.InsertNewCustomQuery(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_QueryDesc char(100),
in In_DistinctOption integer,
in In_TableString char(500),
in In_GroupByOption integer,
in In_MasterQueryID char(20))
begin
  if not exists(select* from CustomQuery where
      CustomQuery.QueryFolderID = In_QueryFolderID and CustomQuery.CustomQueryID = In_CustomQueryID) then
    insert into CustomQuery(QueryFolderID,
      CustomQueryID,
      QueryDesc,
      DistinctOption,
      TableString,
      GroupByOption,
      MasterQueryID) values(
      In_QueryFolderID,
      In_CustomQueryID,
      In_QueryDesc,
      In_DistinctOption,
      In_TableString,
      In_GroupByOption,
      In_MasterQueryID);
    commit work
  end if
end
;



create procedure dba.InsertNewCustomRelation(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_DetailTableID char(20),
in In_DetailAttributeID char(20),
in In_MasterTableID char(20),
in In_MasterAttributeID char(20),
out Out_RelationSysID integer)
begin
  if not exists(select* from CustomRelation where
      CustomRelation.QueryFolderID = In_QueryFolderID and
      CustomRelation.CustomQueryID = In_CustomQueryID and
      CustomRelation.DetailTableID = In_DetailTableID and
      CustomRelation.DetailAttributeID = In_DetailAttributeID and
      CustomRelation.MasterTableID = In_MasterTableID and
      CustomRelation.MasterAttributeID = In_MasterAttributeID) then
    insert into CustomRelation(QueryFolderID,
      CustomQueryID,
      DetailTableID,
      DetailAttributeID,
      MasterTableID,
      MasterAttributeID) values(
      In_QueryFolderID,
      In_CustomQueryID,
      In_DetailTableID,
      In_DetailAttributeID,
      In_MasterTableID,
      In_MasterAttributeID);
    commit work;
    select CustomRelation.RelationSysID into Out_RelationSysID from CustomRelation where
      CustomRelation.QueryFolderID = In_QueryFolderID and
      CustomRelation.CustomQueryID = In_CustomQueryID and
      CustomRelation.DetailTableID = In_DetailTableID and
      CustomRelation.DetailAttributeID = In_DetailAttributeID and
      CustomRelation.MasterTableID = In_MasterTableID and
      CustomRelation.MasterAttributeID = In_MasterAttributeID
  end if
end
;


create procedure dba.InsertNewCustomSearch(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomSearchID char(20),
in In_SearchCondition char(500),
in In_SearchDesc char(100),
in In_SearchType char(1))
begin
  if not exists(select* from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID and
      CustomSearch.CustomSearchID = In_CustomSearchID) then
    insert into CustomSearch(QueryFolderID,
      CustomQueryID,
      CustomSearchID,
      SearchCondition,
      SearchDesc,
      SearchType) values(In_QueryFolderID,
      In_CustomQueryID,
      In_CustomSearchID,
      In_SearchCondition,
      In_SearchDesc,
      In_SearchType);
    commit work
  end if
end
;


create procedure dba.InsertNewCustomTable(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_TableDesc char(100),
in In_PhysicalName char(100))
begin
  if not exists(select* from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID and
      CustomTable.CustomTableID = In_CustomTableID) then
    insert into CustomTable(QueryFolderID,
      CustomQueryID,
      CustomTableID,
      TableDesc,
      PhysicalName) values(
      In_QueryFolderID,
      In_CustomQueryID,
      In_CustomTableID,
      In_TableDesc,
      In_PhysicalName);
    commit work
  end if
end
;


create procedure dba.InsertNewCustomVariables(
in In_QueryFolderID char(20),
in In_Keyword1ID char(20),
in In_Keyword2ID char(20),
in In_Keyword3ID char(20),
in In_Keyword4ID char(20),
in In_Keyword5ID char(20),
in In_StrVar1 char(50),
in In_StrVar2 char(50),
in In_StrVar3 char(50),
in In_StrVar4 char(50),
in In_StrVar5 char(50),
in In_NumVar1 char(50),
in In_NumVar2 char(50),
in In_NumVar3 char(50),
in In_NumVar4 char(50),
in In_NumVar5 char(50),
in In_DateVar1 char(50),
in In_DateVar2 char(50),
in In_Keyword1Desc char(50),
in In_Keyword2Desc char(50),
in In_Keyword3Desc char(50),
in In_Keyword4Desc char(50),
in In_Keyword5Desc char(50),
in In_Keyword1DefValue char(50),
in In_Keyword2DefValue char(50),
in In_Keyword3DefValue char(50),
in In_Keyword4DefValue char(50),
in In_Keyword5DefValue char(50),
in In_StrVar1DefValue char(50),
in In_StrVar2DefValue char(50),
in In_StrVar3DefValue char(50),
in In_StrVar4DefValue char(50),
in In_StrVar5DefValue char(50),
in In_NumVar1DefValue double,
in In_NumVar2DefValue double,
in In_NumVar3DefValue double,
in In_NumVar4DefValue double,
in In_NumVar5DefValue double,
in In_DateVar1DefValue date,
in In_DateVar2DefValue date)
begin
  if not exists(select* from CustomVariables where
      CustomVariables.QueryFolderID = In_QueryFolderID) then
    insert into CustomVariables(QueryFolderID,
      Keyword1ID,
      Keyword2ID,
      Keyword3ID,
      Keyword4ID,
      Keyword5ID,
      StrVar1,
      StrVar2,
      StrVar3,
      StrVar4,
      StrVar5,
      NumVar1,
      NumVar2,
      NumVar3,
      NumVar4,
      NumVar5,
      DateVar1,
      DateVar2,
      Keyword1Desc,
      Keyword2Desc,
      Keyword3Desc,
      Keyword4Desc,
      Keyword5Desc,
      Keyword1DefValue,
      Keyword2DefValue,
      Keyword3DefValue,
      Keyword4DefValue,
      Keyword5DefValue,
      StrVar1DefValue,
      StrVar2DefValue,
      StrVar3DefValue,
      StrVar4DefValue,
      StrVar5DefValue,
      NumVar1DefValue,
      NumVar2DefValue,
      NumVar3DefValue,
      NumVar4DefValue,
      NumVar5DefValue,
      DateVar1DefValue,
      DateVar2DefValue) values(
      In_QueryFolderID,
      In_Keyword1ID,
      In_Keyword2ID,
      In_Keyword3ID,
      In_Keyword4ID,
      In_Keyword5ID,
      In_StrVar1,
      In_StrVar2,
      In_StrVar3,
      In_StrVar4,
      In_StrVar5,
      In_NumVar1,
      In_NumVar2,
      In_NumVar3,
      In_NumVar4,
      In_NumVar5,
      In_DateVar1,
      In_DateVar2,
      In_Keyword1Desc,
      In_Keyword2Desc,
      In_Keyword3Desc,
      In_Keyword4Desc,
      In_Keyword5Desc,
      In_Keyword1DefValue,
      In_Keyword2DefValue,
      In_Keyword3DefValue,
      In_Keyword4DefValue,
      In_Keyword5DefValue,
      In_StrVar1DefValue,
      In_StrVar2DefValue,
      In_StrVar3DefValue,
      In_StrVar4DefValue,
      In_StrVar5DefValue,
      In_NumVar1DefValue,
      In_NumVar2DefValue,
      In_NumVar3DefValue,
      In_NumVar4DefValue,
      In_NumVar5DefValue,
      In_DateVar1DefValue,
      In_DateVar2DefValue);
    commit work
  end if
end
;


create procedure dba.InsertNewQueryFolder(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(20),
in In_SourceTmplFolderID char(20))
begin
  if not exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    insert into QueryFolder(QueryFolderID,QueryFolderDesc,SourceTmplFolderID) values(In_QueryFolderID,In_QueryFolderDesc,In_SourceTmplFolderID);
    // Then Create a Custom variable records for that Folder
    insert into CustomVariables(QueryFolderID) values(In_QueryFolderID);
    commit work
  end if
end
;


create procedure dba.InsertNewReportAccess(
in In_ReportExportID char(20),
in In_UserGroupID char(20))
begin
  if not exists(select* from ReportAccess where
      ReportAccess.ReportExportID = In_ReportExportID and
      ReportAccess.UserGroupID = In_UserGroupID) then
    insert into ReportAccess(ReportExportID,
      UserGroupID) values(
      In_ReportExportID,
      In_UserGroupID);
    commit work
  end if
end
;


create procedure dba.InsertNewReportExport(
in In_QueryFolderID char(20),
in In_ReportExportID char(20),
in In_UserGroupID char(20),
in In_ReportExportType char(20),
in In_ReportDesc char(100),
in In_LastModified date,
in In_AppearIn char(20))
begin
  if not exists(select* from ReportExport where
      ReportExport.ReportExportID = In_ReportExportID) then
    insert into ReportExport(QueryFolderID,
      ReportExportID,
      UserGroupID,
      ReportExportType,
      ReportDesc,
      LastModified,
      AppearIn) values(
      In_QueryFolderID,
      In_ReportExportID,
      In_UserGroupID,
      In_ReportExportType,
      In_ReportDesc,
      In_LastModified,
      In_AppearIn);
    commit work
  end if
end
;


create procedure dba.UpdateCustomAttribute(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_CustomAttributeID char(20),
in In_PhysicalName char(100),
in In_AttributeDesc char(100),
in In_AttributeType char(20),
in In_AttributeFormula char(255),
in In_GroupByPosition integer,
in In_SortByPosition integer,
in In_SortByType integer)
begin
  declare Out_CustomTableID char(20);
  declare Out_CustomAttributeID char(20);
  declare Old_SortByPosition integer;
  declare Old_GroupByPosition integer;
  if exists(select SortByPosition,GroupByPosition into Old_SortByPosition,Old_GroupByPosition from CustomAttribute where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID and
      CustomAttribute.CustomAttributeID = In_CustomAttributeID) then
    update CustomAttribute set
      PhysicalName = In_PhysicalName,
      AttributeDesc = In_AttributeDesc,
      AttributeType = In_AttributeType,
      AttributeFormula = In_AttributeFormula,
      GroupByPosition = In_GroupByPosition,
      SortByPosition = In_SortByPosition,
      SortByType = In_SortByType where
      CustomAttribute.QueryFolderID = In_QueryFolderID and CustomAttribute.CustomQueryID = In_CustomQueryID and
      CustomAttribute.CustomTableID = In_CustomTableID and
      CustomAttribute.CustomAttributeID = In_CustomAttributeID;
    commit work
  end if;
  if(In_SortByPosition <> 0) then
    call UpdateCustomAttributeSortPosition(In_QueryFolderID,In_CustomQueryID,In_CustomTableID,In_CustomAttributeID)
  else
    select first CustomTableID,CustomAttributeID into Out_CustomTableID,Out_CustomAttributeID from CustomAttribute where QueryFolderID = In_QueryFolderID and CustomQueryID = In_CustomQueryID and
      SortByPosition <> 0 order by SortByPosition asc;
    call UpdateCustomAttributeSortPosition(In_QueryFolderID,In_CustomQueryID,Out_CustomTableID,Out_CustomAttributeID)
  end if;
  if(In_GroupByPosition <> 0) then
    call UpdateCustomAttributeGroupPosition(In_QueryFolderID,In_CustomQueryID,In_CustomTableID,In_CustomAttributeID)
  else
    select first CustomTableID,CustomAttributeID into Out_CustomTableID,Out_CustomAttributeID from CustomAttribute where QueryFolderID = In_QueryFolderID and CustomQueryID = In_CustomQueryID and
      GroupByPosition <> 0 order by GroupByPosition asc;
    call UpdateCustomAttributeGroupPosition(In_QueryFolderID,In_CustomQueryID,Out_CustomTableID,Out_CustomAttributeID)
  end if
end
;

create procedure dba.UpdateCustomAttributeGroupPosition(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_CustomAttributeID char(20))
begin
  declare GroupPosition integer;
  declare Max_GroupPosition integer;
  declare In_GroupByPosition integer;
  declare Greater_GroupPosition integer;
  select GroupByPosition into In_GroupByPosition from CustomAttribute where
    QueryFolderID = In_QueryFolderID and
    CustomQueryID = In_CustomQueryID and
    CustomTableID = In_CustomTableID and
    CustomAttributeID = In_CustomAttributeID;
  /*
  if there is no record
  */
  if not exists(select* from CustomAttribute where QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      GroupByPosition <> 0) then return
  end if;
  /*
  Loop 1 : Sort the record below the pivot and set the position incrementing from 1  
  */
  set GroupPosition=0;
  LessThanPivotLoop: for SortLowerArrange as ProcessSortLowerArrangeCurs dynamic scroll cursor for
    select CustomAttributeID as CustomAttribute_ID,
      CustomTableID as CustomTable_ID from
      CustomAttribute where
      QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      GroupByPosition <> 0 and
      GroupByPosition < In_GroupByPosition order by GroupByPosition asc do
    set GroupPosition=GroupPosition+1;
    message 'Loop 1 '+CustomTable_ID+' '+CustomAttribute_ID+':  '+cast(GroupPosition as char(3)) type info to client;
    update CustomAttribute set
      GroupByPosition = GroupPosition where current of ProcessSortLowerArrangeCurs end for;
  commit work;
  /*
  set the pivot to max+1
  */
  set GroupPosition=GroupPosition+1;
  update CustomAttribute set
    GroupByPosition = GroupPosition where
    QueryFolderID = In_QueryFolderID and
    CustomQueryID = In_CustomQueryID and
    CustomTableID = In_CustomTableID and
    CustomAttributeID = In_CustomAttributeID;
  commit work;
  message 'Pivot : '+cast(GroupPosition as char(3)) type info to client;
  /*  
  if there is a record greater than or equal to the pivot 
  */
  if not exists(select* from CustomAttribute where
      QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      not(CustomAttributeId = In_CustomAttributeId and CustomTableId = In_CustomTableId) and
      GroupByPosition <> 0 and
      GroupByPosition >= GroupPosition) then return
  end if;
  set Greater_GroupPosition=GroupPosition;
  /*  
  Loop 2 : Sort and set the position incrementing from 1
  */
  GreaterThanOrEqualToPivotLoop: for SortUpperArrange as ProcessSortUpperArrangeCurs dynamic scroll cursor for
    select CustomAttributeID as CustomAttribute_ID,
      CustomTableID as CustomTable_ID from
      CustomAttribute where
      QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      not(CustomAttributeId = In_CustomAttributeId and CustomTableId = In_CustomTableId) and
      GroupByPosition <> 0 and
      GroupByPosition >= Greater_GroupPosition order by GroupByPosition asc do
    set GroupPosition=GroupPosition+1;
    message 'Loop 2 '+CustomTable_ID+' '+CustomAttribute_ID+':  '+cast(GroupPosition as char(3)) type info to client;
    update CustomAttribute set
      GroupByPosition = GroupPosition where current of ProcessSortUpperArrangeCurs end for;
  commit work
end
;


create procedure dba.UpdateCustomAttributeSortPosition(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_CustomAttributeID char(20))
begin
  declare SortPosition integer;
  declare Max_SortPosition integer;
  declare In_SortByPosition integer;
  declare Greater_SortPosition integer;
  select SortByPosition into In_SortByPosition from CustomAttribute where
    QueryFolderID = In_QueryFolderID and
    CustomQueryID = In_CustomQueryID and
    CustomTableID = In_CustomTableID and
    CustomAttributeID = In_CustomAttributeID;
  /*
  if there is no record
  */
  if not exists(select* from CustomAttribute where QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      SortByPosition <> 0) then return
  end if;
  /*
  Loop 1 : Sort the record below the pivot and set the position incrementing from 1  
  */
  set SortPosition=0;
  LessThanPivotLoop: for SortLowerArrange as ProcessSortLowerArrangeCurs dynamic scroll cursor for
    select CustomAttributeID as CustomAttribute_ID,
      CustomTableID as CustomTable_ID from
      CustomAttribute where
      QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      SortByPosition <> 0 and
      SortByPosition < In_SortByPosition order by SortByPosition asc do
    set SortPosition=SortPosition+1;
    message 'Loop 1 '+CustomTable_ID+' '+CustomAttribute_ID+':  '+cast(SortPosition as char(3)) type info to client;
    update CustomAttribute set
      SortByPosition = SortPosition where current of ProcessSortLowerArrangeCurs end for;
  commit work;
  /*
  set the pivot to max+1
  */
  set SortPosition=SortPosition+1;
  update CustomAttribute set
    SortByPosition = SortPosition where
    QueryFolderID = In_QueryFolderID and
    CustomQueryID = In_CustomQueryID and
    CustomTableID = In_CustomTableID and
    CustomAttributeID = In_CustomAttributeID;
  commit work;
  message 'Pivot : '+cast(SortPosition as char(3)) type info to client;
  /*  
  if there is a record greater than or equal to the pivot 
  */
  if not exists(select* from CustomAttribute where
      QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      not(CustomAttributeId = In_CustomAttributeId and CustomTableId = In_CustomTableId) and
      SortByPosition <> 0 and
      SortByPosition >= SortPosition) then return
  end if;
  set Greater_SortPosition=SortPosition;
  /*  
  Loop 2 : Sort and set the position incrementing from 1
  */
  GreaterThanOrEqualToPivotLoop: for SortUpperArrange as ProcessSortUpperArrangeCurs dynamic scroll cursor for
    select CustomAttributeID as CustomAttribute_ID,
      CustomTableID as CustomTable_ID from
      CustomAttribute where
      QueryFolderID = In_QueryFolderID and
      CustomQueryID = In_CustomQueryID and
      not(CustomAttributeId = In_CustomAttributeId and CustomTableId = In_CustomTableId) and
      SortByPosition <> 0 and
      SortByPosition >= Greater_SortPosition order by SortByPosition asc do
    set SortPosition=SortPosition+1;
    message 'Loop 2 '+CustomTable_ID+' '+CustomAttribute_ID+':  '+cast(SortPosition as char(3)) type info to client;
    update CustomAttribute set
      SortByPosition = SortPosition where current of ProcessSortUpperArrangeCurs end for;
  commit work
end
;


create procedure dba.UpdateCustomQuery(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_QueryDesc char(100),
in In_DistinctOption integer,
in In_TableString char(500),
in In_GroupByOption integer,
in In_MasterQueryID char(20))
begin
  if exists(select* from CustomQuery where
      CustomQuery.QueryFolderID = In_QueryFolderID and CustomQuery.CustomQueryID = In_CustomQueryID) then
    update CustomQuery set
      QueryDesc = In_QueryDesc,
      DistinctOption = In_DistinctOption,
      TableString = In_TableString,
      GroupByOption = In_GroupByOption,
      MasterQueryID = In_MasterQueryID where
      CustomQuery.QueryFolderID = In_QueryFolderID and CustomQuery.CustomQueryID = In_CustomQueryID;
    commit work
  end if
end
;


create procedure dba.UpdateCustomRelation(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_RelationSysID integer,
in In_DetailTableID char(20),
in In_DetailAttributeID char(20),
in In_MasterTableID char(20),
in In_MasterAttributeID char(20))
begin
  if exists(select* from CustomRelation where
      CustomRelation.RelationSysID = In_RelationSysID) then
    update CustomRelation set
      QueryFolderID = In_QueryFolderID,
      CustomQueryID = In_CustomQueryID,
      DetailTableID = In_DetailTableID,
      DetailAttributeID = In_DetailAttributeID,
      MasterTableID = In_MasterTableID,
      MasterAttributeID = In_MasterAttributeID where
      CustomRelation.RelationSysID = In_RelationSysID;
    commit work
  end if
end
;


create procedure dba.UpdateCustomSearch(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomSearchID char(20),
in In_SearchCondition char(500),
in In_SearchDesc char(100),
in In_SearchType char(1))
begin
  if exists(select* from CustomSearch where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID and
      CustomSearch.CustomSearchID = In_CustomSearchID) then
    update CustomSearch set
      SearchCondition = In_SearchCondition,
      SearchDesc = In_SearchDesc,
      SearchType = In_SearchType where
      CustomSearch.QueryFolderID = In_QueryFolderID and CustomSearch.CustomQueryID = In_CustomQueryID and
      CustomSearch.CustomSearchID = In_CustomSearchID;
    commit work
  end if
end
;


create procedure dba.UpdateCustomTable(
in In_QueryFolderID char(20),
in In_CustomQueryID char(20),
in In_CustomTableID char(20),
in In_TableDesc char(100),
in In_PhysicalName char(100))
begin
  if exists(select* from CustomTable where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID and
      CustomTable.CustomTableID = In_CustomTableID) then
    update CustomTable set
      TableDesc = In_TableDesc,
      PhysicalName = In_PhysicalName where
      CustomTable.QueryFolderID = In_QueryFolderID and CustomTable.CustomQueryID = In_CustomQueryID and
      CustomTable.CustomTableID = In_CustomTableID;
    commit work
  end if
end
;


create procedure dba.UpdateCustomVariables(
in In_QueryFolderID char(20),
in In_Keyword1ID char(20),
in In_Keyword2ID char(20),
in In_Keyword3ID char(20),
in In_Keyword4ID char(20),
in In_Keyword5ID char(20),
in In_StrVar1 char(50),
in In_StrVar2 char(50),
in In_StrVar3 char(50),
in In_StrVar4 char(50),
in In_StrVar5 char(50),
in In_NumVar1 char(50),
in In_NumVar2 char(50),
in In_NumVar3 char(50),
in In_NumVar4 char(50),
in In_NumVar5 char(50),
in In_DateVar1 char(50),
in In_DateVar2 char(50),
in In_Keyword1Desc char(50),
in In_Keyword2Desc char(50),
in In_Keyword3Desc char(50),
in In_Keyword4Desc char(50),
in In_Keyword5Desc char(50),
in In_Keyword1DefValue char(50),
in In_Keyword2DefValue char(50),
in In_Keyword3DefValue char(50),
in In_Keyword4DefValue char(50),
in In_Keyword5DefValue char(50),
in In_StrVar1DefValue char(50),
in In_StrVar2DefValue char(50),
in In_StrVar3DefValue char(50),
in In_StrVar4DefValue char(50),
in In_StrVar5DefValue char(50),
in In_NumVar1DefValue double,
in In_NumVar2DefValue double,
in In_NumVar3DefValue double,in 
In_NumVar4DefValue double,in In_NumVar5DefValue double,in In_DateVar1DefValue date,in In_DateVar2DefValue date)
begin
  if exists(select* from CustomVariables where
      CustomVariables.QueryFolderID = In_QueryFolderID) then
    update CustomVariables set
      Keyword1ID = In_Keyword1ID,
      Keyword2ID = In_Keyword2ID,
      Keyword3ID = In_Keyword3ID,
      Keyword4ID = In_Keyword4ID,
      Keyword5ID = In_Keyword5ID,
      StrVar1 = In_StrVar1,
      StrVar2 = In_StrVar2,
      StrVar3 = In_StrVar3,
      StrVar4 = In_StrVar4,
      StrVar5 = In_StrVar5,
      NumVar1 = In_NumVar1,
      NumVar2 = In_NumVar2,
      NumVar3 = In_NumVar3,
      NumVar4 = In_NumVar4,
      NumVar5 = In_NumVar5,
      DateVar1 = In_DateVar1,
      DateVar2 = In_DateVar2,
      Keyword1Desc = In_Keyword1Desc,
      Keyword2Desc = In_Keyword2Desc,
      Keyword3Desc = In_Keyword3Desc,
      Keyword4Desc = In_Keyword4Desc,
      Keyword5Desc = In_Keyword5Desc,
      Keyword1DefValue = In_Keyword1DefValue,
      Keyword2DefValue = In_Keyword2DefValue,
      Keyword3DefValue = In_Keyword3DefValue,
      Keyword4DefValue = In_Keyword4DefValue,
      Keyword5DefValue = In_Keyword5DefValue,
      StrVar1DefValue = In_StrVar1DefValue,
      StrVar2DefValue = In_StrVar2DefValue,
      StrVar3DefValue = In_StrVar3DefValue,
      StrVar4DefValue = In_StrVar4DefValue,
      StrVar5DefValue = In_StrVar5DefValue,
      NumVar1DefValue = In_NumVar1DefValue,
      NumVar2DefValue = In_NumVar2DefValue,
      NumVar3DefValue = In_NumVar3DefValue,
      NumVar4DefValue = In_NumVar4DefValue,
      NumVar5DefValue = In_NumVar5DefValue,
      DateVar1DefValue = In_DateVar1DefValue,
      DateVar2DefValue = In_DateVar2DefValue where
      CustomVariables.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;


create procedure dba.UpdateQueryFolder(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(20),
in In_SourceTmplFolderID char(20))
begin
  if exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    update QueryFolder set
      QueryFolder.QueryFolderDesc = In_QueryFolderDesc,
      SourceTmplFolderID = In_SourceTmplFolderID where
      QueryFolder.QueryFolderID = In_QueryFolderID;
    commit work
  end if
end
;


create procedure dba.UpdateReportExport(
in In_QueryFolderID char(20),
in In_ReportExportID char(20),
in In_UserGroupID char(20),
in In_ReportExportType char(20),
in In_ReportDesc char(100),
in In_LastModified date,
in In_AppearIn char(20))
begin
  if exists(select* from ReportExport where
      ReportExport.ReportExportID = In_ReportExportID) then
    update ReportExport set
      QueryFolderID = In_QueryFolderID,
      UserGroupID = In_UserGroupID,
      ReportExportType = In_ReportExportType,
      ReportDesc = In_ReportDesc,
      LastModified = In_LastModified,
      AppearIn = In_AppearIn where
      ReportExport.ReportExportID = In_ReportExportID;
    commit work
  end if
end
;

