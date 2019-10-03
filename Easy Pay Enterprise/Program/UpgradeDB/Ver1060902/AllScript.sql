READ UpgradeDB\Ver1060902\Entity.sql;
READ UpgradeDB\Ver1060902\StoredProc.sql;

/* Update Sub Registery */
IF NOT exists(select * FROM SubRegistry where SubRegistryId='AppSyncSetup') THEN
    INSERT INTO Subregistry(RegistryId,SubRegistryId, BooleanAttr, ShortStringAttr) VALUES ('System','AppSyncSetup',0,'EpeSync.exe');
END IF;

if not exists(select RegistryId from registry where registryid='SageProdIntegrate') then
Insert into Registry (RegistryId,RegistryDesc) values ('SageProdIntegrate','Sage Product Integration');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewPayRecID') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewPayRecID','View_TMS_PayRecID');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewOTRate') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewOTRate','View_TMS_OTRate');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewAllowanceID') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewAllowanceID','View_TMS_AllowanceID');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewLeaveType') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewLeaveType','View_TMS_LeaveType');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewHolidays') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewHolidays','View_TMS_Holidays');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewJobCode') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewJobCode','View_TMS_JobCode');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewSTEmployee') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewSTEmployee','View_TMS_SmartTouch_Employee');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewSTLveRec') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewSTLveRec','View_TMS_SmartTouch_LeaveRecord');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewSTBRProg') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewSTBRProg','View_TMS_SmartTouch_BasicRateProgression');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewQry') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewQry','View_TMS_Query');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewSGTimeSheet') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewSGTimeSheet','View_Acc_SG_TimeSheet');
end if;

if not exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewTsPayElement') then
Insert into subregistry (RegistryId,SubRegistryId,Regproperty1) values ('SageProdIntegrate','TMSViewTsPayElement','View_Acc_TimeSheetPayElement');
end if;

commit work;