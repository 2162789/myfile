/*Begin of head for every patch*/

if exists(select * from "DBA"."subRegistry" WHERE registryid='System'and subregistryid='Patch')
then
	Delete from SubRegistry where registryid='System'and subregistryid='Patch'
end if;
/*End of head for every patch*/


Read upgradeDB\Audit\DelSingapore.sql;
Read upgradeDB\Audit\AddBasic.sql;

create trigger dba.AuditTrailDeletePeriodPolicySummary after delete order 1 on
DBA.PeriodPolicySummary
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CalFWL',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.CalFWL,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CalSDF',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.CalSDF,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriFWL',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriFWL,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriSDF',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriSDF,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
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
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PrevOrdinaryWage',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.PrevOrdinaryWage,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PrevAdditionalWage',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.PrevAdditionalWage,'',
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
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalCDAC',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalCDAC,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalSINDA',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalSINDA,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalEUCF',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalEUCF,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalMBMF',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalMBMF,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalComm',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalComm,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalYMF',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.CalFWL,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TotalMOSQ',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.TotalMOSQ,'',
    old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailInsertPeriodPolicySummary after insert order 2 on
DBA.PeriodPolicySummary
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CalFWL',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalFWL,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CalSDF',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalSDF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriFWL',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriFWL,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriSDF',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriSDF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
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
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PrevOrdinaryWage',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PrevOrdinaryWage,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PrevAdditionalWage',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PrevAdditionalWage,
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
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalCDAC',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalCDAC,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalSINDA',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalSINDA,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalEUCF',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalEUCF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalMBMF',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalMBMF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalComm',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalComm,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalYMF',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalFWL,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TotalMOSQ',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TotalMOSQ,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CalFWL after update of CalFWL
order 3 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CalFWL',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.CalFWL,new_record.CalFWL,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CalSDF after update of CalSDF
order 4 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CalSDF',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.CalSDF,new_record.CalSDF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF after update of ContriAddEECPF
order 11 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriAddERCPF after update of ContriAddERCPF
order 14 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriFWL after update of ContriFWL
order 5 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ContriFWL',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.ContriFWL,new_record.ContriFWL,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF after update of ContriOrdEECPF
order 12 on DBA.PeriodPolicySummary
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
order 13 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriSDF after update of ContriSDF
order 6 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ContriSDF',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.ContriSDF,new_record.ContriSDF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurAdditionalWage after update of CurAdditionalWage
order 8 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurOrdinaryWage after update of CurOrdinaryWage
order 7 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PrevAdditionalWage after update of PrevAdditionalWage
order 10 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PrevAdditionalWage',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.PrevAdditionalWage,new_record.PrevAdditionalWage,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage after update of PrevOrdinaryWage
order 9 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PrevOrdinaryWage',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.PrevOrdinaryWage,new_record.PrevOrdinaryWage,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalCDAC after update of TotalCDAC
order 15 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalCDAC',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalCDAC,new_record.TotalCDAC,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalComm after update of TotalComm
order 19 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalComm',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalComm,new_record.TotalComm,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalEUCF after update of TotalEUCF
order 17 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalEUCF',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalEUCF,new_record.TotalEUCF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalMBMF after update of TotalMBMF
order 18 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalMBMF',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalMBMF,new_record.TotalMBMF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalMOSQ after update of TotalMOSQ
order 21 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalMOSQ',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalMOSQ,new_record.TotalMOSQ,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalSINDA after update of TotalSINDA
order 16 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalSINDA',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalSINDA,new_record.TotalSINDA,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalYMF after update of TotalYMF
order 20 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TotalYMF',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.TotalYMF,new_record.TotalYMF,
    new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;


IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString1') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString1" after update of CustString1
order 9 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString1', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString1,new_record.CustString1,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString2') then
 CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString2" after update of CustString2
order 10 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString2', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString2,new_record.CustString2,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString3') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString3" after update of CustString3
order 11 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString3', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString3,new_record.CustString3,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString4') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString4" after update of CustString4
order 12 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString4', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString4,new_record.CustString4,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString5') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString5" after update of CustString5
order 13 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString5', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString5,new_record.CustString5,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString6') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString6" after update of CustString6
order 14 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString6', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString6,new_record.CustString6,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

commit work;
/*Begin of tailor for every patch*/
INSERT into "DBA"."subRegistry"(registryid,subregistryid,IntegerAttr) values('System','Patch',1);
commit work;
/*End of tailor for every patch*/
