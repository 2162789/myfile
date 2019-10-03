update RptCompItemConfig set ItemValue = 1 
where RptCompSysId in('sys_7','sys_14','sys_22','sys_26','sys_30');

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060207, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;