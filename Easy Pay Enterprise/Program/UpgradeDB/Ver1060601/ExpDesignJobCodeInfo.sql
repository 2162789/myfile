// Export Designer - add Job Code information (ProjectId, CostCentreId,JobRefNo and Desc) selection to Time sheet Detail.

// SystemAttribute
IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE SysAttributeId = 'Ana_TsProjectId') THEN
 INSERT INTO SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
 VALUES('TMSDetail','Ana_TsProjectId','Project ID',1,'','','','','');
END IF;

IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE SysAttributeId = 'Ana_TsCostCentreId') THEN
 INSERT INTO SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
 VALUES('TMSDetail','Ana_TsCostCentreId','Cost Centre ID',1,'','','','','');
END IF;

IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE SysAttributeId = 'Ana_TsJobCodeRefNo') THEN
 INSERT INTO SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
 VALUES('TMSDetail','Ana_TsJobCodeRefNo','Job Ref No',1,'','','','','');
END IF;

IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE SysAttributeId = 'Ana_TsJobCodeDesc') THEN
 INSERT INTO SystemAttribute (SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
 VALUES('TMSDetail','Ana_TsJobCodeDesc','Job Code Description',1,'','','','','');
END IF;



// AnItemLookup
IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE AnlysLookupId = 'TsProjectId') THEN
 INSERT INTO AnItemLookup (AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
 VALUES('TsProjectId','TMSDetail','Ana_TsProjectId','TsDetail','AnlysStringValue1','TMSDetail','(SELECT TMSProjectId FROM JobCode WHERE JobCode=TimeSheet.JobCode)','','','');
END IF;

IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE AnlysLookupId = 'TsCostCentreId') THEN
 INSERT INTO AnItemLookup (AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
 VALUES('TsCostCentreId','TMSDetail','Ana_TsCostCentreId','TsDetail','AnlysStringValue1','TMSDetail','(Select TMSCostCentreId FROM JobCode WHERE JobCode=TimeSheet.JobCode)','','','');
END IF;

IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE AnlysLookupId = 'TsJobCodeRefNo') THEN
 INSERT INTO AnItemLookup (AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
 VALUES('TsJobCodeRefNo','TMSDetail','Ana_TsJobCodeRefNo','TsDetail','AnlysStringValue1','TMSDetail','(Select JobCodeRefNo FROM JobCode WHERE JobCode=TimeSheet.JobCode)','','','');
END IF;

IF NOT EXISTS(SELECT * FROM AnItemLookup WHERE AnlysLookupId = 'TsJobCodeDesc') THEN
 INSERT INTO AnItemLookup (AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
 VALUES('TsJobCodeDesc','TMSDetail','Ana_TsJobCodeDesc','TsDetail','AnlysStringValue1','TMSDetail','(Select JobCodeDesc FROM JobCode WHERE JobCode=TimeSheet.JobCode)','','','');
END IF;

