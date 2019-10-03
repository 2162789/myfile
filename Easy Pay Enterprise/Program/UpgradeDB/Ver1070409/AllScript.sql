/*==============================================================*/
/* Import Worksheet for Pay Leave Record Viewer                 */
/*==============================================================*/
/* Validate Excel */
if not exists(Select * from Importspreadsheet where importspsheetId = 'System_PayLeave') then
	INSERT INTO ImportSpreadsheet (ImportspsheetId, Importspsheetremarks, importspsheettype, importspsheetpassword) VALUES ('System_PayLeave', NULL, 'Excel', NULL);
end if;

/* Validate Worksheet */
if not exists(select * from ImportWorksheet where WorksheetId = 'System_PayLeave') then
	INSERT INTO ImportWorksheet (worksheetid, worksheetname, worksheettype, physicaltablename, endingcolumn, endingrow, startingcolumn, startingrow, logfilename) VALUES ('System_PayLeave', 'Pay Leave Record', 'Vertical', 'iLeaveRecord', NULL, 99999, NULL, 3, 'ImportPayLeave.log');
end if;

/* Import feature for Pay Leave Deduction*/
if not exists(select * from Importproject where importprojectId = 'System_PayLeave') then
	INSERT INTO IMPORTPROJECT (ImportprojectId, interfaceconnectionId, importextConnection, importprojectremarks, importappearin) VALUES ('System_PayLeave', NULL, 0, NULL, 'System');
end if;

if not exists(select * from ImportSSMember where WorksheetId = 'System_PayLeave') then
	INSERT INTO ImportSSMember (WorksheetId, ImportSPSheetId, ProcessSequence) VALUES ('System_PayLeave','System_PayLeave', 1);
end if;

if not exists(select * from ImportProjectMember where ImportSPSheetId = 'System_PayLeave') then
	INSERT INTO ImportProjectMember (ImportSPSheetId, ImportProjectId, ProcessSequence) VALUES ('System_PayLeave','System_PayLeave', 1);
end if;

/* Map system import field with Excel row */
if not exists(select * from ImportField where WorksheetId = 'System_PayLeave') then
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'LveEmployeeID', 'A', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'LveID', 'B', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'LeaveDate', 'C', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'CurrentLveDays', 'D', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'CurrentLveHours', 'E', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'PreviousLveIncDays', 'F', '0', '1899-12-30', '', 0, 0.0);
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_PayLeave', 'PreviousLveIncHours', 'G', '0', '1899-12-30', '', 0, 0.0);
end if;

/* Process records using System_import for Leave Processing */
UPDATE Interfaceprocess SET INTPROCACTIVATE = 1 where INTERFACEPROJECTID = 'System_Import' AND INTERFACEPROCESSID = 'Leave Process';

/* Security Setup: Add Import Pay Leave Record in Module Screen Group */
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'ImportPayLeave') then
	INSERT INTO ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
	VALUES ('ImportPayLeave','CoreImport','Pay Leave Record','Core',0,0,0,'');
end if;

commit work;