/*Begin of head for every patch*/

if exists(select * from "DBA"."subRegistry" WHERE registryid='System'and subregistryid='Patch')
then
	Delete from SubRegistry where registryid='System'and subregistryid='Patch'
end if;
/*End of head for every patch*/

Read upgradeDB\Audit\DelMalaysia.sql;
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CPFStatus',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CPFStatus,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CPFClass',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CPFClass,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8ACurOrdWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8ACurOrdWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8ACurAddWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8ACurAddWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8APrevOrdWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8APrevOrdWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','SupIR8APrevAddWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.SupIR8APrevAddWage,'',
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TaxMaritalStatus',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TaxMaritalStatus,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TaxChildRelief',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TaxChildRelief,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurrentTaxWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentTaxWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PreviousTaxWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PreviousTaxWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurrentAddTaxWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentAddTaxWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PreviousAddTaxWage',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PreviousAddTaxWage,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','CurrentTaxAmount',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentTaxAmount,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PreviousTaxAmount',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PreviousTaxAmount,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TaxEPFRelief',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TaxEPFRelief,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TaxZakatRelief',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TaxZakatRelief,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PaidCurrentTaxAmt',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PaidCurrentTaxAmt,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','PaidPreviousTaxAmt',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PaidPreviousTaxAmt,'',
	 old_record.EmployeeSysId,old_record.PayPeriodSGSPGenId,old_record.PayRecYear,old_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PeriodPolicySummary','TaxBenefit',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.TaxBenefit,'',
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurOrdinaryWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurOrdinaryWage,
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CPFStatus',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CPFStatus,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CPFClass',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CPFClass,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8ACurOrdWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8ACurOrdWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8ACurAddWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8ACurAddWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8APrevOrdWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8APrevOrdWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','SupIR8APrevAddWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.SupIR8APrevAddWage,
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
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TaxMaritalStatus',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TaxMaritalStatus,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TaxChildRelief',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TaxChildRelief,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurrentTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PreviousTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PreviousTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurrentAddTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentAddTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PreviousAddTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PreviousAddTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','CurrentTaxAmount',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentTaxAmount,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PreviousTaxAmount',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PreviousTaxAmount,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TaxEPFRelief',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TaxEPFRelief,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TaxZakatRelief',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TaxZakatRelief,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PaidCurrentTaxAmt',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaidCurrentTaxAmt,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','PaidPreviousTaxAmt',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaidPreviousTaxAmt,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PeriodPolicySummary','TaxBenefit',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.TaxBenefit,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF after update of ContriOrdEECPF
order 4 on DBA.PeriodPolicySummary
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
order 5 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_ActualAddEECPF after update of ActualAddEECPF
order 6 on DBA.PeriodPolicySummary
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
order 7 on DBA.PeriodPolicySummary
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
order 8 on DBA.PeriodPolicySummary
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
order 9 on DBA.PeriodPolicySummary
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
order 10 on DBA.PeriodPolicySummary
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
order 11 on DBA.PeriodPolicySummary
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
order 12 on DBA.PeriodPolicySummary
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
order 13 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalCDAC after update of TotalCDAC
order 14 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalSINDA after update of TotalSINDA
order 15 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TotalEUCF after update of TotalEUCF
order 16 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CPFStatus after update of CPFStatus
order 17 on DBA.PeriodPolicySummary
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
order 18 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8ACurOrdWage after update of SupIR8ACurOrdWage
order 19 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8ACurOrdWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8ACurOrdWage,new_record.SupIR8ACurOrdWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8ACurAddWage after update of SupIR8ACurAddWage
order 20 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8ACurAddWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8ACurAddWage,new_record.SupIR8ACurAddWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8APrevOrdWage after update of SupIR8APrevOrdWage
order 21 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8APrevOrdWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8APrevOrdWage,new_record.SupIR8APrevOrdWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8APrevAddWage after update of SupIR8APrevAddWage
order 22 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','SupIR8APrevAddWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.SupIR8APrevAddWage,new_record.SupIR8APrevAddWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddEECPF after update of SupIR8AActAddEECPF
order 23 on DBA.PeriodPolicySummary
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
order 24 on DBA.PeriodPolicySummary
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
order 25 on DBA.PeriodPolicySummary
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
order 26 on DBA.PeriodPolicySummary
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
order 27 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TaxMaritalStatus after update of TaxMaritalStatus
order 28 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TaxMaritalStatus',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TaxMaritalStatus,new_record.TaxMaritalStatus,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TaxChildRelief after update of TaxChildRelief
order 29 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TaxChildRelief',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TaxChildRelief,new_record.TaxChildRelief,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurrentTaxWage after update of CurrentTaxWage
order 30 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PreviousTaxWage after update of PreviousTaxWage
order 31 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PreviousTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PreviousTaxWage,new_record.PreviousTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurrentAddTaxWage after update of CurrentAddTaxWage
order 32 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','CurrentAddTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentAddTaxWage,new_record.CurrentAddTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PreviousAddTaxWage after update of PreviousAddTaxWage
order 33 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PreviousAddTaxWage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PreviousAddTaxWage,new_record.PreviousAddTaxWage,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_CurrentTaxAmount after update of CurrentTaxAmount
order 34 on DBA.PeriodPolicySummary
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
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PreviousTaxAmount after update of PreviousTaxAmount
order 35 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PreviousTaxAmount',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PreviousTaxAmount,new_record.PreviousTaxAmount,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TaxEPFRelief after update of TaxEPFRelief
order 36 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TaxEPFRelief',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TaxEPFRelief,new_record.TaxEPFRelief,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TaxZakatRelief after update of TaxZakatRelief
order 37 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TaxZakatRelief',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TaxZakatRelief,new_record.TaxZakatRelief,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PaidCurrentTaxAmt after update of PaidCurrentTaxAmt
order 38 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PaidCurrentTaxAmt',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PaidCurrentTaxAmt,new_record.PaidCurrentTaxAmt,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_PaidPreviousTaxAmt after update of PaidPreviousTaxAmt
order 39 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','PaidPreviousTaxAmt',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PaidPreviousTaxAmt,new_record.PaidPreviousTaxAmt,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
create trigger dba.AuditTrailUpdatePeriodPolicySummary_TaxBenefit after update of TaxBenefit
order 40 on DBA.PeriodPolicySummary
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PeriodPolicySummary','TaxBenefit',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.TaxBenefit,new_record.TaxBenefit,
	 new_record.EmployeeSysId,new_record.PayPeriodSGSPGenId,new_record.PayRecYear,new_record.PayRecPeriod)
end
;
commit work;
/*Begin of tailor for every patch*/
INSERT into "DBA"."subRegistry"(registryid,subregistryid,IntegerAttr) values('System','Patch',1);
commit work;
/*End of tailor for every patch*/
