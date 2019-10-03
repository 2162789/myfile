/*Begin of head for every patch*/

if exists(select * from "DBA"."subRegistry" WHERE registryid='System'and subregistryid='Patch')
then
	Delete from SubRegistry where registryid='System'and subregistryid='Patch'
end if;
/*End of head for every patch*/

Read upgradeDB\Audit\DelBrunei.sql;

Read upgradeDB\Audit\AddBasic.sql;

create trigger dba.AuditTrailDeletePeriodPolicySummary after delete order 1 on
DBA.PeriodPolicySummary
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurOrdinaryWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurOrdinaryWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurAdditionalWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurAdditionalWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriAddEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriAddEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriOrdEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriOrdEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriOrdERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriOrdERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriAddERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriAddERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalContriEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalContriEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalContriERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalContriERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CPFWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CPFWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CPFStatus',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CPFStatus,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CPFClass',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CPFClass,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
end
;
create trigger dba.AuditTrailInsertPeriodPolicySummary after insert order 2 on
DBA.PeriodPolicySummary
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurOrdinaryWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurOrdinaryWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurAdditionalWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurAdditionalWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalContriEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalContriEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalContriERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalContriERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CPFWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CPFWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CPFStatus',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CPFStatus,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CPFClass',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CPFClass,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurOrdinaryWage after update of CurOrdinaryWage
order 3 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CurOrdinaryWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurOrdinaryWage,new_record.CurOrdinaryWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurAdditionalWage after update of CurAdditionalWage
order 4 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CurAdditionalWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurAdditionalWage,new_record.CurAdditionalWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF after update of ContriAddEECPF
order 5 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ContriAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ContriAddEECPF,new_record.ContriAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF after update of ContriOrdEECPF
order 6 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ContriOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ContriOrdEECPF,new_record.ContriOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF after update of ContriOrdERCPF
order 7 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ContriOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ContriOrdERCPF,new_record.ContriOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriAddERCPF after update of ContriAddERCPF
order 8 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ContriAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ContriAddERCPF,new_record.ContriAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalContriEECPF after update of TotalContriEECPF
order 9 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalContriEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalContriEECPF,new_record.TotalContriEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalContriERCPF after update of TotalContriERCPF
order 10 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalContriERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalContriERCPF,new_record.TotalContriERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CPFWage after update of CPFWage
order 11 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CPFWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CPFWage,new_record.CPFWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CPFStatus after update of CPFStatus
order 12 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CPFStatus',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CPFStatus,new_record.CPFStatus,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CPFClass after update of CPFClass
order 13 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CPFClass',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CPFClass,new_record.CPFClass,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
commit work;
/*Begin of tailor for every patch*/
INSERT into "DBA"."subRegistry"(registryid,subregistryid,IntegerAttr) values('System','Patch',1);
commit work;
/*End of tailor for every patch*/
