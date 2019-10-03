if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateQueryFolder' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateQueryFolder
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewQueryFolder' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewQueryFolder
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCourseEndDate' and user_name(creator) = 'DBA') then
   drop function DBA.FGetCourseEndDate
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCityStateId' and user_name(creator) = 'DBA') then
   drop function DBA.FGetCityStateId
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCityCountryId' and user_name(creator) = 'DBA') then
   drop function DBA.FGetCityCountryId
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAllowanceUserDefInfo' and user_name(creator) = 'DBA') then
   drop function DBA.FGetAllowanceUserDefInfo
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLProcessQueryFolder' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLProcessQueryFolder
end if;

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
      0) end for end for;       
end
;


create function DBA.FGetAllowanceUserDefInfo(
in In_AllowanceSGSPGenId char(30),
in In_AllowanceCategory char(20))
RETURNS CHAR(255)
BEGIN
    DECLARE Out_UserDefInfo CHAR(255);
    DECLARE In_AllowanceFormulaId CHAR(20);
    DECLARE In_UserDef1 CHAR(20);
    DECLARE In_UserDef2 CHAR(20);
    DECLARE In_UserDef3 CHAR(20);
    DECLARE In_UserDef4 CHAR(20);
    DECLARE In_UserDef5 CHAR(20);
    DECLARE In_UserDef1Value CHAR(20);
    DECLARE In_UserDef2Value CHAR(20);
    DECLARE In_UserDef3Value CHAR(20);
    DECLARE In_UserDef4Value CHAR(20);
    DECLARE In_UserDef5Value CHAR(20);

    IF EXISTS(SELECT * FROM AllowanceHistoryRecord WHERE AllowanceSGSPGenId = In_AllowanceSGSPGenId) THEN
        SELECT AllowanceFormulaId INTO In_AllowanceFormulaId FROM AllowanceRecord WHERE AllowanceSGSPGenId = In_AllowanceSGSPGenId;
        IF EXISTS(SELECT * FROM Formula WHERE FormulaId = In_AllowanceFormulaId AND FormulaCategory = 'PayElement' AND 
                  FormulaSubCategory = In_AllowanceCategory AND FormulaType = 'Formula') THEN
            SELECT UserDef1, UserDef2, UserDef3, UserDef4, UserDef5, CAST(UserDef1Value AS CHAR(20)), CAST(UserDef2Value AS CHAR(20)), 
            CAST(UserDef3Value AS CHAR(20)), CAST(UserDef4Value AS CHAR(20)), CAST(UserDef5Value AS CHAR(20)) INTO In_UserDef1, In_UserDef2, 
            In_UserDef3, In_UserDef4, In_UserDef5, In_UserDef1Value, In_UserDef2Value, In_UserDef3Value, In_UserDef4Value, In_UserDef5Value 
            FROM AllowanceHistoryRecord WHERE AllowanceSGSPGenId = In_AllowanceSGSPGenId;

            IF In_UserDef1 <> '' THEN
                SET Out_UserDefInfo = In_UserDef1 || ' = ' || In_UserDef1Value;
            END IF;

            IF In_UserDef2 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef2 || ' = ' || In_UserDef2Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef2 || ' = ' || In_UserDef2Value;
                END IF;
            END IF;

            IF In_UserDef3 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef3 || ' = ' || In_UserDef3Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef3 || ' = ' || In_UserDef3Value;
                END IF;
            END IF;
            
            IF In_UserDef4 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef4 || ' = ' || In_UserDef4Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef4 || ' = ' || In_UserDef4Value;
                END IF;
            END IF;

            IF In_UserDef5 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef5 || ' = ' || In_UserDef5Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef5 || ' = ' || In_UserDef5Value;
                END IF;
            END IF;
        ELSE
            SET Out_UserDefInfo = ''
        END IF
    ELSE
        SET Out_UserDefInfo = ''
    END IF;
    
	RETURN Out_UserDefInfo;
END
;


create function DBA.FGetCityCountryId(
in In_CityId char(20))
RETURNS char(20)
BEGIN
	DECLARE Out_CountryId char(20);
	SELECT FIRST CountryId into Out_CountryId FROM City WHERE CityId = In_CityId;
	RETURN Out_CountryId;
END
;


create function DBA.FGetCityStateId(
in In_CityId char(20))
RETURNS char(20)
BEGIN
	DECLARE Out_StateId char(20);
	SELECT FIRST StateId into Out_StateId FROM City WHERE CityId = In_CityId;
	RETURN Out_StateId;
END
;


create function DBA.FGetCourseEndDate(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
returns date
begin
  declare Out_CourseEndDate date;
  select CourseEndDate into Out_CourseEndDate from CourseSchedule where
    CourseSchedule.CourseCode = In_CourseCode and
    CourseSchedule.CourseScheduleSysId = In_CourseScheduleSysId;
  return Out_CourseEndDate
end
;


create procedure DBA.InsertNewQueryFolder(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(100),
in In_SourceTmplFolderID char(20))
begin
  if not exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    insert into QueryFolder(QueryFolderID,QueryFolderDesc,SourceTmplFolderID) values(In_QueryFolderID,In_QueryFolderDesc,In_SourceTmplFolderID);

    // Inserts the CustomVariables
    CustomVariablesLoop: for CustomVariablesForLoop as Cur_CustomVariables dynamic scroll cursor for
    select TmplVariables.Keyword1ID as New_Keyword1ID, 
     TmplVariables.Keyword2ID as New_Keyword2ID,
     TmplVariables.Keyword3ID as New_Keyword3ID, 
     TmplVariables.Keyword4ID as New_Keyword4ID,
     TmplVariables.Keyword5ID as New_Keyword5ID,
     TmplVariables.StrVar1 as New_StrVar1,
     TmplVariables.StrVar2 as New_StrVar2, 
     TmplVariables.StrVar3 as New_StrVar3, 
     TmplVariables.StrVar4 as New_StrVar4, 
     TmplVariables.StrVar5 as New_StrVar5, 
     TmplVariables.NumVar1 as New_NumVar1, 
     TmplVariables.NumVar2 as New_NumVar2,
     TmplVariables.NumVar3 as New_NumVar3, 
     TmplVariables.NumVar4 as New_NumVar4, 
     TmplVariables.NumVar5 as New_NumVar5,
     TmplVariables.DateVar1 as New_DateVar1, 
     TmplVariables.DateVar2 as New_DateVar2, 
     TmplVariables.Keyword1Desc as New_Keyword1Desc, 
     TmplVariables.Keyword2Desc as New_Keyword2Desc, 
     TmplVariables.Keyword3Desc as New_Keyword3Desc, 
     TmplVariables.Keyword4Desc as New_Keyword4Desc, 
     TmplVariables.Keyword5Desc as New_Keyword5Desc,
     TmplVariables.Keyword1DefValue as New_Keyword1DefValue, 
     TmplVariables.Keyword2DefValue as New_Keyword2DefValue, 
     TmplVariables.Keyword3DefValue as New_Keyword3DefValue, 
     TmplVariables.Keyword4DefValue as New_Keyword4DefValue, 
     TmplVariables.Keyword5DefValue as New_Keyword5DefValue,
     TmplVariables.StrVar1DefValue as New_StrVar1DefValue, 
     TmplVariables.StrVar2DefValue as New_StrVar2DefValue, 
     TmplVariables.StrVar3DefValue as New_StrVar3DefValue, 
     TmplVariables.StrVar4DefValue as New_StrVar4DefValue, 
     TmplVariables.StrVar5DefValue as New_StrVar5DefValue, 
     TmplVariables.NumVar1DefValue as New_NumVar1DefValue, 
     TmplVariables.NumVar2DefValue as New_NumVar2DefValue, 
     TmplVariables.NumVar3DefValue as New_NumVar3DefValue, 
     TmplVariables.NumVar4DefValue as New_NumVar4DefValue, 
     TmplVariables.NumVar5DefValue as New_NumVar5DefValue, 
     TmplVariables.DateVar1DefValue as New_DateVar1DefValue, 
     TmplVariables.DateVar2DefValue as New_DateVar2DefValue from TmplVariables where TmplVariables.TmplFolderID = In_SourceTmplFolderID do
    call InsertNewCustomVariables(In_QueryFolderID, New_Keyword1ID, New_Keyword2ID, New_Keyword3ID, New_Keyword4ID, New_Keyword5ID,
     New_StrVar1, New_StrVar2, New_StrVar3, New_StrVar4, New_StrVar5, New_NumVar1, New_NumVar2, New_NumVar3, New_NumVar4, New_NumVar5,
     New_DateVar1, New_DateVar2, New_Keyword1Desc, New_Keyword2Desc, New_Keyword3Desc, New_Keyword4Desc, New_Keyword5Desc,
     New_Keyword1DefValue, New_Keyword2DefValue, New_Keyword3DefValue, New_Keyword4DefValue, New_Keyword5DefValue,
     New_StrVar1DefValue, New_StrVar2DefValue, New_StrVar3DefValue, New_StrVar4DefValue, New_StrVar5DefValue,
     New_NumVar1DefValue, New_NumVar2DefValue, New_NumVar3DefValue, New_NumVar4DefValue, New_NumVar5DefValue,
     New_DateVar1DefValue, New_DateVar2DefValue);  
  end for;
     
  commit work
  end if
end
;


create procedure DBA.UpdateQueryFolder(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(100),
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

COMMIT WORK;