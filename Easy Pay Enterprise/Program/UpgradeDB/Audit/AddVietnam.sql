/*Begin of head for every patch*/
if exists(select * from "DBA"."subRegistry" WHERE registryid='System'and subregistryid='Patch')
then
	Delete from SubRegistry where registryid='System'and subregistryid='Patch'
end if;
/*End of head for every patch*/


Read upgradeDB\Audit\DelVietnam.sql;
Read upgradeDB\Audit\AddBasic.sql;

Create trigger dba.AuditTrailDeletePeriodPolicySummary after delete order 1 on
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PrevOrdinaryWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PrevOrdinaryWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriOrdEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriOrdEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ContriAddEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ContriAddEECPF,'',
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ActualAddEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ActualAddEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ActualAddERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ActualAddERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ActualOrdEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ActualOrdEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','ActualOrdERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.ActualOrdERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','VolOrdEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.VolOrdEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','VolOrdERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.VolOrdERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','VolAddEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.VolAddEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','VolAddERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.VolAddERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AOrdEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AOrdEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AAddEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AAddEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AAddERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AAddERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AOrdERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AOrdERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AActAddEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AActAddEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AActAddERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AActAddERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AActOrdEECPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AActOrdEECPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8AActOrdERCPF',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8AActOrdERCPF,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TaxCategory',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TaxCategory,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurrentTaxWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentTaxWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurrentTaxAmount',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentTaxAmount,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
 
end
;

Create trigger dba.AuditTrailInsertPeriodPolicySummary after insert order 2 on
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PrevOrdinaryWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PrevOrdinaryWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ContriAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ContriAddEECPF,
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ActualAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ActualAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ActualAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ActualAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ActualOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ActualOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','ActualOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.ActualOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','VolOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.VolOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','VolOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.VolOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','VolAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.VolAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','VolAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.VolAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AActAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AActAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AActAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AActAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AActOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AActOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8AActOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8AActOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TaxCategory',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TaxCategory,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurrentTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurrentTaxAmount',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentTaxAmount,
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage after update of PrevOrdinaryWage
order 4 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF after update of ContriOrdEECPF
order 5 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF after update of ContriAddEECPF
order 6 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ActualAddEECPF after update of ActualAddEECPF
order 9 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ActualAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ActualAddEECPF,new_record.ActualAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ActualAddERCPF after update of ActualAddERCPF
order 10 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ActualAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ActualAddERCPF,new_record.ActualAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ActualOrdEECPF after update of ActualOrdEECPF
order 11 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ActualOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ActualOrdEECPF,new_record.ActualOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ActualOrdERCPF after update of ActualOrdERCPF
order 12 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','ActualOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.ActualOrdERCPF,new_record.ActualOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_VolOrdEECPF after update of VolOrdEECPF
order 13 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','VolOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.VolOrdEECPF,new_record.VolOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_VolOrdERCPF after update of VolOrdERCPF
order 14 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','VolOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.VolOrdERCPF,new_record.VolOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_VolAddEECPF after update of VolAddEECPF
order 15 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','VolAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.VolAddEECPF,new_record.VolAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_VolAddERCPF after update of VolAddERCPF
order 16 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','VolAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.VolAddERCPF,new_record.VolAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AOrdEECPF after update of SupIR8AOrdEECPF
order 17 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AOrdEECPF,new_record.SupIR8AOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AAddEECPF after update of SupIR8AAddEECPF
order 18 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AAddEECPF,new_record.SupIR8AAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AAddERCPF after update of SupIR8AAddERCPF
order 19 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AAddERCPF,new_record.SupIR8AAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AOrdERCPF after update of SupIR8AOrdERCPF
order 20 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AOrdERCPF,new_record.SupIR8AOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddEECPF after update of SupIR8AActAddEECPF
order 21 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AActAddEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AActAddEECPF,new_record.SupIR8AActAddEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddERCPF after update of SupIR8AActAddERCPF
order 22 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AActAddERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AActAddERCPF,new_record.SupIR8AActAddERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AActOrdEECPF after update of SupIR8AActOrdEECPF
order 23 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AActOrdEECPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AActOrdEECPF,new_record.SupIR8AActOrdEECPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AActOrdERCPF after update of SupIR8AActOrdERCPF
order 24 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8AActOrdERCPF',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8AActOrdERCPF,new_record.SupIR8AActOrdERCPF,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TaxCategory after update of TaxCategory
order 25 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TaxCategory',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TaxCategory,new_record.TaxCategory,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurrentTaxWage after update of CurrentTaxWage
order 26 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CurrentTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentTaxWage,new_record.CurrentTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurrentTaxAmount after update of CurrentTaxAmount
order 27 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CurrentTaxAmount',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentTaxAmount,new_record.CurrentTaxAmount,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;

commit work;

/*Begin of tailor for every patch*/
INSERT into "DBA"."subRegistry"(registryid,subregistryid,IntegerAttr) values('System','Patch',1);
commit work;
/*End of tailor for every patch*/