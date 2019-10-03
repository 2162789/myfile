/*==============================================================*/
/* Import for Leave Deduction (Pay Leave Record Viewer)         */
/*==============================================================*/
/* Revert all change from V10.7.4.09 - Change of ID*/
if exists(select * from ImportSSMember where WorksheetId = 'System_PayLeave') then
	DELETE FROM ImportSSMember where WorksheetId = 'System_PayLeave';
end if;
if exists(select * from ImportProjectMember where ImportSPSheetId = 'System_PayLeave') then
	DELETE FROM ImportProjectMember where ImportSPSheetId = 'System_PayLeave';
end if;
if exists(select * from ImportField where WorksheetId = 'System_PayLeave') then
	DELETE FROM IMPORTFIELD where WorksheetId = 'System_PayLeave';
end if;
if exists(Select * from Importspreadsheet where importspsheetId = 'System_PayLeave') then
	DELETE FROM ImportSpreadsheet where importspsheetId = 'System_PayLeave';
end if;
if exists(select * from Importproject where importprojectId = 'System_PayLeave') then
	DELETE FROM IMPORTPROJECT where importprojectId = 'System_PayLeave';
end if;
if exists(select * from ImportWorksheet where WorksheetId = 'System_PayLeave') then
	DELETE FROM ImportWorksheet where WorksheetId = 'System_PayLeave';
end if;


/* Validate Excel */
if not exists(Select * from Importspreadsheet where importspsheetId = 'System_LveDeduction') then
	INSERT INTO ImportSpreadsheet (ImportspsheetId, Importspsheetremarks, importspsheettype, importspsheetpassword) VALUES ('System_LveDeduction', NULL, 'Excel', NULL);
end if;

/* Validate Worksheet */
if not exists(select * from ImportWorksheet where WorksheetId = 'System_LveDeduction') then
	INSERT INTO ImportWorksheet (worksheetid, worksheetname, worksheettype, physicaltablename, endingcolumn, endingrow, startingcolumn, startingrow, logfilename) VALUES ('System_LveDeduction', 'Leave Deduction', 'Vertical', 'iLeaveRecord', NULL, 99999, NULL, 3, 'ImportLveDeduction.log');
end if;

/* Import feature for Pay Leave Deduction*/
if not exists(select * from Importproject where importprojectId = 'System_LveDeduction') then
	INSERT INTO IMPORTPROJECT (ImportprojectId, interfaceconnectionId, importextConnection, importprojectremarks, importappearin) VALUES ('System_LveDeduction', NULL, 0, NULL, 'System');
end if;

/* Import SS Member */
if not exists(select * from ImportSSMember where WorksheetId = 'System_LveDeduction') then
	INSERT INTO ImportSSMember (WorksheetId, ImportSPSheetId, ProcessSequence) VALUES ('System_LveDeduction','System_LveDeduction', 1);
end if;

/* Import Project Member */
if not exists(select * from ImportProjectMember where ImportSPSheetId = 'System_LveDeduction') then
	INSERT INTO ImportProjectMember (ImportSPSheetId, ImportProjectId, ProcessSequence) VALUES ('System_LveDeduction','System_LveDeduction', 1);
end if;

/* Map system import field with Excel row */
if not exists(select * from ImportField where WorksheetId = 'System_LveDeduction') then
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'LveEmployeeID', 'A', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'LveID', 'B', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'LeaveDate', 'C', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'CurrentLveDays', 'D', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'CurrentLveHours', 'E', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'PreviousLveIncDays', 'F', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_LveDeduction', 'PreviousLveIncHours', 'G', '0', '1899-12-30', '', 0, 0.0);
end if;

/* Security Setup: Add Import Pay Leave Record in Module Screen Group */
if exists(select * from ModuleScreenGroup where ModuleScreenId = 'ImportPayLeave') then
	DELETE FROM ModuleScreenGroup where ModuleScreenId = 'ImportPayLeave';
end if;
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'ImportLveDeduction') then
	INSERT INTO ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
	VALUES ('ImportLveDeduction','CoreImport','Leave Deduction','Core',0,0,0,'');
end if;

commit work;