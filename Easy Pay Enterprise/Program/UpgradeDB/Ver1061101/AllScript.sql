Read UpgradeDB\Ver1061101\AllEntityStoredProc.sql;
Read UpgradeDB\Ver1061101\AllEntityStoredProc2.sql;

/*Allow to save Report Export record */
Delete From ReportExport Where ReportExportID NOT IN (Select ReportExportID From ReportAccess);

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewQueryFolder') then
  drop procedure InsertNewQueryFolder
end if;
CREATE PROCEDURE DBA.InsertNewQueryFolder(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(100),
in In_SourceTmplFolderID char(20))
begin
  if not exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    
    insert into QueryFolder(QueryFolderID,QueryFolderDesc,SourceTmplFolderID) values(In_QueryFolderID,In_QueryFolderDesc,In_SourceTmplFolderID);

    // Create Custom variable records for that Folder
    if (In_SourceTmplFolderID ='' or In_SourceTmplFolderID is null) then

        call InsertNewCustomVariables(In_QueryFolderID, 
            '','','','','', // Keyword
            '','','','','', // StrVar
            '','','','','', // NumVar
            '','', //DateVar
            '','','','','', // Keyword Desc
            '','','','','', // Keyword Def Value
            '','','','','', // String Def Value
            NULL,NULL,NULL,NULL,NULL, // Num Def Value
            '1899-12-31','1899-12-31'); //Date Def Value

    else
        // From Template
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

    end if;

    commit work;

  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewReportAccess') then
  drop procedure InsertNewReportAccess
end if;
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

/* Create Triggers on PesonalAddress Table (Update) */

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddAddress') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddAddress" after update of PersonalAddAddress
order 1 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddAddress', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddAddress,new_record.PersonalAddAddress,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddAddress2') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddAddress2" after update of PersonalAddAddress2
order 2 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddAddress2', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddAddress2,new_record.PersonalAddAddress2,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddAddress3') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddAddress3" after update of PersonalAddAddress3
order 3 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddAddress3', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddAddress3,new_record.PersonalAddAddress3,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddCity') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddCity" after update of PersonalAddCity
order 5 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddCity', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddCity,new_record.PersonalAddCity,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddCountry') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddCountry" after update of PersonalAddCountry
order 4 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddCountry', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddCountry,new_record.PersonalAddCountry,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddMailing') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddMailing" after update of PersonalAddMailing
order 8 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddMailing', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddMailing,new_record.PersonalAddMailing,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddPCode') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddPCode" after update of PersonalAddPCode
order 7 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddPCode', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddPCode,new_record.PersonalAddPCode,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddState') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddState" after update of PersonalAddState
order 6 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddState', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddState,new_record.PersonalAddState,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

/* Create Triggers on PesonalAddress Table (Insert) */

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailInsertPersonalAddress') then
CREATE TRIGGER "AuditTrailInsertPersonalAddress" after insert order 15 on
DBA.PersonalAddress
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddAddress',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddAddress,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddAddress2',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddAddress2,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddAddress3',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddAddress3,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddCountry',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddCountry,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddCity',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddCity,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddState',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddState,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddPCode',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddPCode,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddMailing',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddMailing,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString1',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString1,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString2',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString2,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString3',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString3,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString4',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString4,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString5',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString5,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString6',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString6,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);


end;
END IF;

/* Create Triggers on PesonalAddress Table (Delete) */

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailDeletePersonalAddress') then
CREATE TRIGGER "AuditTrailDeletePersonalAddress" after delete order 16 on
DBA.PersonalAddress
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddAddress',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddAddress,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddAddress2',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddAddress2,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddAddress3',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddAddress3,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddCountry',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddCountry,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddCity',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddCity,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddState',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddState,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddPCode',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddPCode,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddMailing',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddMailing,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString1',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString1,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString2',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString2,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString3',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString3,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString4',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString4,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString5',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString5,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString6',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString6,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

end;
END IF;

commit work;