if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUsageItemRecordCount') then
   drop procedure ASQLUsageItemRecordCount
end if
;

CREATE PROCEDURE DBA.ASQLUsageItemRecordCount(
in In_UsageItemID char(20),
in In_ItemRefKey1 char(50),
in In_ItemRefKey2 char(50),
in In_ItemRefKey3 char(50))
begin
  declare In_CurDateTime datetime; 
  declare In_IntegerValue integer;
  select NOW(*) into In_CurDateTime;  
  select IntegerValue into In_IntegerValue from UsageItemRecord where UsageItemRecord.UsageItemID = In_UsageItemID 
    and UsageItemRecord.ItemRefKey1 = In_ItemRefKey1 
    and UsageItemRecord.ItemRefKey2 = In_ItemRefKey2 
    and UsageItemRecord.ItemRefKey3= In_ItemRefKey3;

    
	if (In_IntegerValue is null) then
	// Create
    insert into UsageItemRecord(UsageItemID,
        ItemRefKey1,
        ItemRefKey2,
        ItemRefKey3,
        IntegerValue,      
        ModifyDateTime) values(
        In_UsageItemID,
        In_ItemRefKey1,
        In_ItemRefKey2,
        In_ItemRefKey3,
        1,
        In_CurDateTime);

	commit work;
	else
	// Update
    set In_IntegerValue = In_IntegerValue +1;
    update UsageItemRecord set
        IntegerValue = In_IntegerValue,
        ModifyDateTime = In_CurDateTime 
        where UsageItemRecord.UsageItemID = In_UsageItemID 
        and UsageItemRecord.ItemRefKey1 = In_ItemRefKey1 
        and UsageItemRecord.ItemRefKey2 = In_ItemRefKey2 
        and UsageItemRecord.ItemRefKey3= In_ItemRefKey3;
    commit work;
	end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUsageItemRecordCountReset') then
   drop procedure ASQLUsageItemRecordCountReset
end if
;

CREATE PROCEDURE DBA.ASQLUsageItemRecordCountReset()
begin
	// Update
    update UsageItemRecord set IntegerValue = 0 where IntegerValue > 0;
    commit work;
    
    //Update UsageDataSentDate
    update SubRegistry set
      SubRegistry.DateTimeAttr = NOW() where
      SubRegistry.SubRegistryId = 'UsageDataSentDate';
    commit work   
end;

commit work;

IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_ePortal') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_ePortal','Contact Number (ePortal)','Contact Number (ePortal)','EXPORT',0,0,0,'ePortalContact',243,5,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_ePortal') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_Home','Contact Number (Home)','Contact Number (Home)','EXPORT',0,0,0,'HomeContact',244,5,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_ePortal') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_Work','Contact Number (Work)','Contact Number (Work)','EXPORT',0,0,0,'WorkContact',245,5,0,'')
END IF;
IF NOT EXISTS (SELECT * FROM Keyword WHERE KeywordId = 'EX_Contact_ePortal') THEN
  INSERT INTO Keyword VALUES ('EX_Contact_Office','Contact Number (Office)','Contact Number (Office)','EXPORT',0,0,0,'OfficeContact',246,5,0,'')
END IF;

if not exists(select 1 from UsageGrp where UsageGrpID='System') then
  insert into UsageGrp values('BankDisk','Bank Disk Generation');
  insert into UsageGrp values('StatSubmit','Statuatory Submission');
  insert into UsageGrp values('License','License');
  insert into UsageGrp values('System','System');

  insert into UsageItem values('SerialNo','License','Serial No.','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, SubSerialNo AS RetValue FROM LicenseRecord;','');
  insert into UsageItem values('CompanyName','License','Company Name','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, SubCompanyName AS RetValue FROM LicenseRecord;','');
  insert into UsageItem values('ProductName','License','Product Name','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, (CASE WHEN CHARINDEX(''EP Standard'', Functionlist) > 0 then ''Easy Pay Standard'' ELSE ProductName END ) AS RetValue FROM LicenseRecord;','');
  insert into UsageItem values('ProductVersion','System','Product Version','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, IntegerAttr AS RetValue FROM Subregistry WHERE SubRegistryID=''DBVersion'';','');
  insert into UsageItem values('ProductCountry','System','Product Country','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, RegProperty1 AS RetValue FROM Subregistry WHERE SubRegistryID=''DBCountry'';','');
  insert into UsageItem values('HasCustomisedModule','License','Has Customised Module','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, (CASE WHEN CHARINDEX(''Customise'', Functionlist) > 0 then ''Yes'' ELSE ''No'' END) AS RetValue FROM LicenseRecord;','');
  insert into UsageItem values('LicenseExpiryDate','License','License Expiry Date','','','','DateValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, LicenseExpiringDate AS RetValue FROM LicenseRecord;','');
  insert into UsageItem values('PersonalCount','License','Personal Count','Cessation Cut-Off Year','Cessation Cut-Off Period','','IntegerValue','SELECT CAST(YEAR(TODAY(*)) AS CHAR(4)) AS Key1, CAST(MONTH(TODAY(*)) AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(DISTINCT Personal.PersonalSysId) AS RetValue FROM  Personal LEFT OUTER JOIN Employee ','WHERE YEAR(CessationDate) > YEAR(TODAY(*)) OR (YEAR(CessationDate) = YEAR(TODAY(*)) AND MONTH(CessationDate) >= MONTH(TODAY(*))) OR CessationDate=''18991230'' OR EmployeeSysID IS NULL;');
  insert into UsageItem values('EmployeeCount','License','Employee Count','Cessation Cut-Off Year','Cessation Cut-Off Period','','IntegerValue','SELECT CAST(YEAR(TODAY(*)) AS CHAR(4)) AS Key1, CAST(MONTH(TODAY(*)) AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(EmployeeSysId) AS RetValue FROM Employee ','WHERE YEAR(CessationDate) > YEAR(TODAY(*)) OR (YEAR(CessationDate) = YEAR(TODAY(*)) AND MONTH(CessationDate) >= MONTH(TODAY(*)) OR CessationDate = ''18991230'');');
  insert into UsageItem values('PayRecordCount','License','Pay Record Count','Year','Period','','IntegerValue','SELECT CAST(PayRecYear AS CHAR(4)) AS Key1, CAST(PayRecPeriod AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(EmployeeSysID) AS RetValue FROM PayPeriodRecord GROUP BY PayRecYear, PayRecPeriod ','HAVING PayRecYear=(SELECT FIRST PayGroupYear FROM PayGroupPeriod Order by SubPeriodEndDate DESC) AND PayRecPeriod=(SELECT FIRST PayGroupPeriod FROM PayGroupPeriod Order by SubPeriodEndDate DESC); ');
  insert into UsageItem values('ExeOSVersion','System','Executing OS Version','','','','StringValue','','');
  insert into UsageItem values('ExeIPAddress','System','Executing IP Address','','','','StringValue','','');
  insert into UsageItem values('UsageDataSentDate','System','Usage Data Sent Date','','','','DateValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, TODAY(*) AS RetValue;','');
  insert into UsageItem values('UsageLastSentDate','System','Usage Data Last Sent Date','','','','DateValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, DateTimeAttr AS RetValue FROM Subregistry WHERE SubRegistryID=''UsageDataSentDate'';','');
  insert into UsageItem values('BankDiskGenCount','BankDisk','Bank Disk Generation  Count','Submit For','Format','','IntegerValue','SELECT ItemRefKey1 AS Key1, ItemRefKey2 AS Key2, ItemRefKey3 AS Key3, ModifyDateTime AS ModDateTime, IntegerValue AS RetValue FROM UsageItemRecord ','WHERE UsageItemID=''BankDiskGenCount'' AND IntegerValue>0;');
end if;

if not exists(select 1 from subregistry where subregistryId = 'UsageDataSentDate') then
insert into SubRegistry values('System','UsageDataSentDate','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
end if;

if not exists(Select 1 From ModuleScreenGroup Where ModuleScreenId = 'CoreTmsOutputFile') then
insert into ModuleScreenGroup values('CoreTmsOutputFile','CoreTmsExport','TMS Output File','Core',0,0,0,'')
end if;

if not exists(Select 1 From subregistry Where SubRegistryId = 'TMSOutputFile') then
Insert into subregistry values('System','TMSOutputFile','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
end if;

Delete from subregistry Where SubRegistryId = 'LveActivityLogging';

commit work;