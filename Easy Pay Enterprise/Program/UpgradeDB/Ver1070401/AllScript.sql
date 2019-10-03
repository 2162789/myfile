/*
* Include PayrollDate to ImportFieldName for user self-mapping 
*/
if not exists(select * from importfieldname where TABLENAMEPHYSICAL = 'iMedClaim' and FIELDNAMEPHYSICAL = 'PayrollDate') then
	INSERT INTO IMPORTFIELDNAME (tablenamephysical, fieldnamephysical, fieldnameuserdefined, fieldtype, iskey) VALUES('iMedClaim', 'PayrollDate', 'Payroll Date', 'Date', 0);
end if;

/* 
* Add in PayrollDate Column in Medical Claim Interface Table if it does not exists 
*/
IF COL_LENGTH('dba.IMEDCLAIM', 'PayrollDate') IS NULL then
	ALTER TABLE iMedClaim ADD PAYROLLDATE date;
end if;

/*
*  Append PayrollDate to ImportField Table for default mapping
*/	
if not exists(select * from IMPORTFIELD where WORKSHEETID = 'System_MedicalClaim' and IMPORTFIELDPHYSICAL = 'PayrollDate') then
	INSERT INTO IMPORTFIELD (worksheetid, importfieldphysical, column, row, datevalue, stringvalue, integervalue, numericvalue) VALUES ('System_MedicalClaim', 'PayrollDate', 'Y', '0', '1899-12-30', '', 0, 0.0);
end if;

commit work;