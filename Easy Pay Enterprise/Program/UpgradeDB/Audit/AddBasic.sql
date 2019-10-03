Read upgradeDB\Audit\DelBasic.sql;
if  not exists(select * from Systable join Syscolumn where table_name='AuditTrailTable' and column_name='AuditKey5') 
 then
	alter table "DBA"."AuditTrailTable" add  AuditKey5 char(50) DEFAULT '';
 end if;
if  not exists(select * from Systable join Syscolumn where table_name='AuditTrailTable' and column_name='AuditKey6') 
 then
	alter table "DBA"."AuditTrailTable" add  AuditKey6 char(50) DEFAULT '';
 end if;

create trigger dba.AuditTrailDeleteEmployee after delete order 6 on
DBA.Employee
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','Employee','CessationDate',
    old_record.EmployeeId,old_record.CessationDate,'',old_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','Employee','HireDate',
    old_record.EmployeeId,old_record.HireDate,'',old_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailInsertEmployee after insert order 5 on
DBA.Employee
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','Employee','CessationDate',
    new_record.EmployeeId,'',new_record.CessationDate,new_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','Employee','HireDate',
    new_record.EmployeeId,'',new_record.HireDate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdateEmployee_CessationDate after update of CessationDate
order 3 on DBA.Employee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','Employee','CessationDate',
    new_record.EmployeeId,old_record.CessationDate,new_record.CessationDate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdateEmployee_HireDate after update of HireDate
order 4 on DBA.Employee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','Employee','HireDate',
    new_record.EmployeeId,old_record.HireDate,new_record.HireDate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailDeletePayEmployee after delete order 2 on
DBA.PayEmployee
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PayEmployee','CurrentBasicRate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentBasicRate,'',old_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PayEmployee','PreviousBasicRate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.PreviousBasicRate,'',old_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PayEmployee','CurrentBasicRateType',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentBasicRateType,'',old_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PayEmployee','PreviousBasicRateType',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.PreviousBasicRateType,'',old_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PayEmployee','BonusFactor',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BonusFactor,'',old_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PayEmployee','LastPayDate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.LastPayDate,'',old_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailInsertPayEmployee after insert order 1 on
DBA.PayEmployee
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PayEmployee','CurrentBasicRate',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentBasicRate,new_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PayEmployee','PreviousBasicRate',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PreviousBasicRate,new_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PayEmployee','CurrentBasicRateType',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentBasicRateType,new_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PayEmployee','PreviousBasicRateType',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PreviousBasicRateType,new_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PayEmployee','BonusFactor',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BonusFactor,new_record.EmployeeSysId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PayEmployee','LastPayDate',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.LastPayDate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdatePayEmployee_BonusFactor after update of BonusFactor
order 7 on DBA.PayEmployee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PayEmployee','BonusFactor',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.BonusFactor,new_record.BonusFactor,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdatePayEmployee_CurrentBasicRate after update of CurrentBasicRate
order 3 on DBA.PayEmployee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PayEmployee','CurrentBasicRate',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentBasicRate,new_record.CurrentBasicRate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdatePayEmployee_CurrentBasicRateType after update of CurrentBasicRateType
order 5 on DBA.PayEmployee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PayEmployee','CurrentBasicRateType',
    
FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentBasicRateType,new_record.CurrentBasicRateType,
new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdatePayEmployee_LastPayDate after update of LastPayDate
order 8 on DBA.PayEmployee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PayEmployee','LastPayDate',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.LastPayDate,new_record.LastPayDate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdatePayEmployee_PreviousBasicRate after update of PreviousBasicRate
order 4 on DBA.PayEmployee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PayEmployee','PreviousBasicRate',
    
FGetEmployeeId(new_record.EmployeeSysId),old_record.PreviousBasicRate,new_record.PreviousBasicRate,new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailUpdatePayEmployee_PreviousBasicRateType after update of PreviousBasicRateType
order 6 on DBA.PayEmployee
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PayEmployee','PreviousBasicRateType',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.PreviousBasicRateType,new_record.PreviousBasicRateType,
new_record.EmployeeSysId)
end
;
create trigger dba.AuditTrailDeletePaymentBankInfo after delete order 1 on
DBA.PaymentBankInfo
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PaymentBankInfo','BankId',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BankId,'',old_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PaymentBankInfo','BankBranchId',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BankBranchId,'',old_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PaymentBankInfo','BankAccountNo',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BankAccountNo,'',old_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PaymentBankInfo','PaymentValue',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentValue,'',old_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PaymentBankInfo','PaymentType',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentType,'',old_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PaymentBankInfo','BeneficiaryName',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BeneficiaryName,'',old_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailInsertPaymentBankInfo after insert order 2 on
DBA.PaymentBankInfo
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PaymentBankInfo','BankId',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BankId,new_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PaymentBankInfo','BankBranchId',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BankBranchId,new_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PaymentBankInfo','BankAccountNo',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BankAccountNo,new_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PaymentBankInfo','PaymentValue',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentValue,new_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PaymentBankInfo','PaymentType',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentType,new_record.PayBankSGSPGenId);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PaymentBankInfo','BeneficiaryName',
    FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BeneficiaryName,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailUpdatePaymentBankInfo_BankAccountNo after update of BankAccountNo
order 5 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','BankAccountNo',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.BankAccountNo,new_record.BankAccountNo,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailUpdatePaymentBankInfo_BankBranchId after update of BankBranchId
order 4 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','BankBranchId',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.BankBranchId,new_record.BankBranchId,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailUpdatePaymentBankInfo_BankId after update of BankId
order 3 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','BankId',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.BankId,new_record.BankId,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailUpdatePaymentBankInfo_PaymentType after update of PaymentType
order 7 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','PaymentType',
    FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentType,new_record.PaymentType,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailUpdatePaymentBankInfo_PaymentValue after update of PaymentValue
order 6 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','PaymentValue',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentValue,new_record.PaymentValue,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailUpdatePaymentBankInfo_BeneficiaryName after update of BeneficiaryName
order 12 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','BeneficiaryName',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BeneficiaryName,new_record.BeneficiaryName,new_record.PayBankSGSPGenId)
end
;
create trigger dba.AuditTrailDeleteBasicRateProgression after delete order 1 on
DBA.BasicRateProgression
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgressionCode',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgressionCode,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgEffectiveDate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgEffectiveDate,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgNextIncDate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgNextIncDate,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgCareerId',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgCareerId,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgPrevBasicRate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgPrevBasicRate,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgIncrementAmt',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgIncrementAmt,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgPercentage',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgPercentage,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgNewBasicRate',
    FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgNewBasicRate,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgBasicRateType',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgBasicRateType,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgPayGroup',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgPayGroup,'',old_record.EmployeeSysId,old_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BasicRateProgression','BRProgCurrent',
	 FGetEmployeeId(old_record.EmployeeSysId),old_record.BRProgCurrent,'',old_record.EmployeeSysId,old_record.BRProgDate)
end
;
create trigger dba.AuditTrailInsertBasicRateProgression after insert order 2 on
DBA.BasicRateProgression
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgressionCode',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgressionCode,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgEffectiveDate',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgEffectiveDate,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgNextIncDate',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgNextIncDate,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgCareerId',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgCareerId,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgPrevBasicRate',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgPrevBasicRate,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgIncrementAmt',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgIncrementAmt,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgPercentage',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgPercentage,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgNewBasicRate',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgNewBasicRate,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgBasicRateType',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgBasicRateType,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgPayGroup',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgPayGroup,new_record.EmployeeSysId,new_record.BRProgDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BasicRateProgression','BRProgCurrent',
	 FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BRProgCurrent,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgressionCode after update of BRProgressionCode
order 3 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgressionCode',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgressionCode,new_record.BRProgressionCode,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgEffectiveDate after update of BRProgEffectiveDate
order 4 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgEffectiveDate',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgEffectiveDate,new_record.BRProgEffectiveDate,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgNextIncDate after update of BRProgNextIncDate
order 5 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgNextIncDate',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgNextIncDate,new_record.BRProgNextIncDate,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgCareerId after update of BRProgCareerId
order 6 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgCareerId',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgCareerId,new_record.BRProgCareerId,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgPrevBasicRate after update of BRProgPrevBasicRate
order 7 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgPrevBasicRate',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgPrevBasicRate,new_record.BRProgPrevBasicRate,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgIncrementAmt after update of BRProgIncrementAmt
order 8 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgIncrementAmt',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgIncrementAmt,new_record.BRProgIncrementAmt,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgPercentage after update of BRProgPercentage
order 9 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgPercentage',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgPercentage,new_record.BRProgPercentage,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgNewBasicRate after update of BRProgNewBasicRate
order 10 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgNewBasicRate',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgNewBasicRate,new_record.BRProgNewBasicRate,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgBasicRateType after update of BRProgBasicRateType
order 11 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgBasicRateType',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgBasicRateType,new_record.BRProgBasicRateType,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgPayGroup after update of BRProgPayGroup
order 12 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgPayGroup',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgPayGroup,new_record.BRProgPayGroup,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailUpdateBasicRateProgression_BRProgCurrent after update of BRProgCurrent
order 13 on DBA.BasicRateProgression
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BasicRateProgression','BRProgCurrent',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BRProgCurrent,new_record.BRProgCurrent,new_record.EmployeeSysId,new_record.BRProgDate)
end
;
create trigger dba.AuditTrailDeleteDetailRecord after delete order 1 on
DBA.DetailRecord
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CurrentBasicRate',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentBasicRate,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'AllocatedBasicRate',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.AllocatedBasicRate,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'PreviousHrDays',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.PreviousHrDays,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CurrentHrDays',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CurrentHrDays,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalTotalWage',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalTotalWage,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalTotalGrossWage',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalTotalGrossWage,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalOTAmount',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalOTAmount,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalOTBackPay',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalOTBackPay,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalShiftAmount',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalShiftAmount,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalLveDeductAmt',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalLveDeductAmt,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalBackPay',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalBackPay,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalGrossWage',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalGrossWage,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','DetailRecord',
    'CalNetWage',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.CalNetWage,
    '',old_record.DetailRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID)
end
;
create trigger dba.AuditTrailInsertDetailRecord after insert order 2 on
DBA.DetailRecord
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CurrentBasicRate',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentBasicRate,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'AllocatedBasicRate',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.AllocatedBasicRate,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'PreviousHrDays',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PreviousHrDays,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CurrentHrDays',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CurrentHrDays,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalTotalWage',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalTotalWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalTotalGrossWage',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalTotalGrossWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalOTAmount',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalOTAmount,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalOTBackPay',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalOTBackPay,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalShiftAmount',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalShiftAmount,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalLveDeductAmt',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalLveDeductAmt,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalBackPay',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalBackPay,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalGrossWage',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalGrossWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','DetailRecord',
    'CalNetWage',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.CalNetWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CurrentBasicRate after update of CurrentBasicRate
order 3 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CurrentBasicRate',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentBasicRate,new_record.CurrentBasicRate,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_AllocatedBasicRate after update of AllocatedBasicRate
order 4 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'AllocatedBasicRate',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.AllocatedBasicRate,new_record.AllocatedBasicRate,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_PreviousHrDays after update of PreviousHrDays
order 5 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'PreviousHrDays',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.PreviousHrDays,new_record.PreviousHrDays,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CurrentHrDays after update of CurrentHrDays
order 6 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CurrentHrDays',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CurrentHrDays,new_record.CurrentHrDays,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalTotalWage after update of CalTotalWage
order 7 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalTotalWage',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalTotalWage,new_record.CalTotalWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalTotalGrossWage after update of CalTotalGrossWage
order 8 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalTotalGrossWage',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalTotalGrossWage,new_record.CalTotalGrossWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalOTAmount after update of CalOTAmount
order 9 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalOTAmount',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalOTAmount,new_record.CalOTAmount,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalOTBackPay after update of CalOTBackPay
order 10 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalOTBackPay',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalOTBackPay,new_record.CalOTBackPay,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalShiftAmount after update of CalShiftAmount
order 11 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalShiftAmount',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalShiftAmount,new_record.CalShiftAmount,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalLveDeductAmt after update of CalLveDeductAmt
order 12 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalLveDeductAmt',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalLveDeductAmt,new_record.CalLveDeductAmt,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalBackPay after update of CalBackPay
order 13 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalBackPay',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalBackPay,new_record.CalBackPay,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalGrossWage after update of CalGrossWage
order 14 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalGrossWage',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalGrossWage,new_record.CalGrossWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateDetailRecord_CalNetWage after update of CalNetWage
order 15 on DBA.DetailRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','DetailRecord',
    'CalNetWage',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.CalNetWage,new_record.CalNetWage,
    new_record.DetailRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailDeleteAllowanceRecord after delete order 1 on
DBA.AllowanceRecord
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','AllowanceRecord',
    'AllowanceAmount',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.AllowanceAmount,
    '',old_record.AllowanceSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','AllowanceRecord',
    'AllowanceDeclaredDate',	 FGetEmployeeId(old_record.EmployeeSysId),old_record.AllowanceDeclaredDate,
    '',old_record.AllowanceSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID)
end
;
create trigger dba.AuditTrailInsertAllowanceRecord after insert order 2 on
DBA.AllowanceRecord
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','AllowanceRecord',
    'AllowanceAmount',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.AllowanceAmount,
    new_record.AllowanceSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','AllowanceRecord',
    'AllowanceDeclaredDate',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.AllowanceDeclaredDate,
    new_record.AllowanceSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID)
end
;
create trigger dba.AuditTrailUpdateAllowanceRecord_AllowanceAmount after update of AllowanceAmount
order 3 on DBA.AllowanceRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','AllowanceRecord',
    'AllowanceAmount',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.AllowanceAmount,new_record.AllowanceAmount,
    new_record.AllowanceSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateAllowanceRecord_AllowanceDeclaredDate after update of AllowanceDeclaredDate
order 4 on DBA.AllowanceRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','AllowanceRecord',
    'AllowanceDeclaredDate',	 FGetEmployeeId(new_record.EmployeeSysId),old_record.AllowanceDeclaredDate,new_record.AllowanceDeclaredDate,
    new_record.AllowanceSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger DBA.AuditTrailInsertResidenceStatusRecord after insert order 1 on
DBA.ResidenceStatusRecord
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','ResidenceStatusRecord','ResidenceTypeId',
    FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.ResidenceTypeId,new_record.PersonalSysId,new_record.ResStatusEffectiveDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','ResidenceStatusRecord','ResStatusCareerId',
    FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.ResStatusCareerId,new_record.PersonalSysId,new_record.ResStatusEffectiveDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','ResidenceStatusRecord','ResStatusCurrent',
    FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.ResStatusCurrent,new_record.PersonalSysId,new_record.ResStatusEffectiveDate)
end
;
create trigger DBA.AuditTrailUpdateResidenceStatusRecord_ResidenceTypeId after update of ResidenceTypeId
order 2 on DBA.ResidenceStatusRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','ResidenceStatusRecord','ResidenceTypeId',
    FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.ResidenceTypeId,new_record.ResidenceTypeId,
    new_record.PersonalSysId,new_record.ResStatusEffectiveDate)
end
;
create trigger DBA.AuditTrailUpdateResidenceStatusRecord_ResStatusCareerId after update of ResStatusCareerId
order 3 on DBA.ResidenceStatusRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','ResidenceStatusRecord','ResStatusCareerId',
    FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.ResStatusCareerId,new_record.ResStatusCareerId,
    new_record.PersonalSysId,new_record.ResStatusEffectiveDate)
end
;
create trigger DBA.AuditTrailUpdateResidenceStatusRecord_ResStatusCurrent after update of ResStatusCurrent
order 4 on DBA.ResidenceStatusRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','ResidenceStatusRecord','ResStatusCurrent',
    FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.ResStatusCurrent,new_record.ResStatusCurrent,
    new_record.PersonalSysId,new_record.ResStatusEffectiveDate)
end
;
create trigger DBA.AuditTrailDeleteResidenceStatusRecord after delete order 5 on
DBA.ResidenceStatusRecord
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','ResidenceStatusRecord','ResidenceTypeId',
    FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.ResidenceTypeId,'',old_record.PersonalSysId,old_record.ResStatusEffectiveDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','ResidenceStatusRecord','ResStatusCareerId',
    FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.ResStatusCareerId,'',old_record.PersonalSysId,old_record.ResStatusEffectiveDate);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','ResidenceStatusRecord','ResStatusCurrent',
    FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.ResStatusCurrent,'',old_record.PersonalSysId,old_record.ResStatusEffectiveDate)
end
;
create trigger DBA.AuditTrailInsertSystemUser after insert order 1 on
DBA.SystemUser
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','SystemUser','UserId',
    '','',new_record.UserId,new_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','SystemUser','UserGroupId',
    '','',new_record.UserGroupId,new_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','SystemUser','UserPassword',
    '','','********',new_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','SystemUser','ExpiryDate',
    '','',new_record.ExpiryDate,new_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','SystemUser','SysPersonalSysId',
    '','',new_record.SysPersonalSysId,new_record.UserId,'');
end
;
create trigger DBA.AuditTrailUpdateSystemUser_UserGroupId after update of UserGroupId
order 2 on DBA.SystemUser
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','SystemUser','UserGroupId',
    '',old_record.UserGroupId,new_record.UserGroupId,
    new_record.UserId,'')
end
;
create trigger DBA.AuditTrailUpdateSystemUser_UserPassword after update of UserPassword
order 3 on DBA.SystemUser
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','SystemUser','UserPassword',
    '','********','********',
    new_record.UserId,'')
end
;
create trigger DBA.AuditTrailUpdateSystemUser_ExpiryDate after update of ExpiryDate
order 4 on DBA.SystemUser
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','SystemUser','ExpiryDate',
    '',old_record.ExpiryDate,new_record.ExpiryDate,
    new_record.UserId,'')
end
;
create trigger DBA.AuditTrailUpdateSystemUser_SysPersonalSysId after update of SysPersonalSysId
order 5 on DBA.SystemUser
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','SystemUser','SysPersonalSysId',
    '',old_record.SysPersonalSysId,new_record.SysPersonalSysId,
    new_record.UserId,'')
end
;
create trigger DBA.AuditTrailDeleteSystemUser after delete order 6 on
DBA.SystemUser
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','SystemUser','UserId',
    '',old_record.UserId,'',old_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','SystemUser','UserGroupId',
    '',old_record.UserGroupId,'',old_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','SystemUser','ExpiryDate',
    '',old_record.ExpiryDate,'',old_record.UserId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','SystemUser','SysPersonalSysId',
    '',old_record.SysPersonalSysId,'',old_record.UserId,'');
end
;
create trigger DBA.AuditTrailInsertUserGroup after insert order 1 on
DBA.UserGroup
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','UserGroup','UserGroupId',
    '','',new_record.UserGroupId,new_record.UserGroupId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','UserGroup','UserGroupDesc',
    '','',new_record.UserGroupDesc,new_record.UserGroupId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','UserGroup','UserGroupHideWage',
    '','',new_record.UserGroupHideWage,new_record.UserGroupId,'');
end
;
create trigger DBA.AuditTrailUpdateUserGroup_UserGroupDesc after update of UserGroupDesc
order 2 on DBA.UserGroup
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','UserGroup','UserGroupDesc',
    '',old_record.UserGroupDesc,new_record.UserGroupDesc,
    new_record.UserGroupId,'')
end
;
create trigger DBA.AuditTrailUpdateUserGroup_UserGroupHideWage after update of UserGroupHideWage
order 3 on DBA.UserGroup
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','UserGroup','UserGroupHideWage',
    '',old_record.UserGroupHideWage,new_record.UserGroupHideWage,
    new_record.UserGroupId,'')
end
;
create trigger DBA.AuditTrailDeleteUserGroup after delete order 4 on
DBA.UserGroup
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','UserGroup','UserGroupId',
    '',old_record.UserGroupId,'',old_record.UserGroupId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','UserGroup','UserGroupDesc',
    '',old_record.UserGroupDesc,'',old_record.UserGroupId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','UserGroup','UserGroupHideWage',
    '',old_record.UserGroupHideWage,'',old_record.UserGroupId,'');
end
;
create trigger DBA.AuditTrailInsertUserModuleNoAccess after insert order 1 on
DBA.UserModuleNoAccess
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','UserModuleNoAccess','UserModNoAccessId',
    '','',new_record.UserModNoAccessId,new_record.UserModNoAccessId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','UserModuleNoAccess','UserGroupId',
    '','',new_record.UserGroupId,new_record.UserModNoAccessId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','UserModuleNoAccess','ModuleScreenId',
    '','',new_record.ModuleScreenId,new_record.UserModNoAccessId,'');
end
;
create trigger DBA.AuditTrailDeleteUserModuleNoAccess after delete order 4 on
DBA.UserModuleNoAccess
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','UserModuleNoAccess','UserModNoAccessId',
    '',old_record.UserModNoAccessId,'',old_record.UserModNoAccessId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','UserModuleNoAccess','UserGroupId',
    '',old_record.UserGroupId,'',old_record.UserModNoAccessId,'');
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
    AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2) values(
    connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','UserModuleNoAccess','ModuleScreenId',
    '',old_record.ModuleScreenId,'',old_record.UserModNoAccessId,'');
end
;
create trigger dba.AuditTrailDeleteBankRecord after delete order 1 on
DBA.BankRecord
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentBankBrCode', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentBankBrCode,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentBankCode', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentBankCode,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentAmt', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentAmt,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentCategory', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentCategory,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentValue', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentValue,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentType', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentType,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentBankAccNo', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentBankAccNo,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentBankAccType', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentBankAccType,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'PaymentMode', FGetEmployeeId(old_record.EmployeeSysId),old_record.PaymentMode,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','BankRecord',
    'BeneficiaryName', FGetEmployeeId(old_record.EmployeeSysId),old_record.BeneficiaryName,
    '',old_record.BankRecSGSPGenId,old_record.EmployeeSysId,old_record.PayRecYear,
    old_record.PayRecPeriod,old_record.PayRecSubPeriod,old_record.PayRecID);
end
;
create trigger dba.AuditTrailInsertBankRecord after insert order 2 on
DBA.BankRecord
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentBankBrCode',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentBankBrCode,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentBankCode',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentBankCode,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentAmt',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentAmt,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentCategory',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentCategory,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentValue',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentValue,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentType',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentType,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentBankAccNo',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentBankAccNo,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentBankAccType',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentBankAccType,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'PaymentMode',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.PaymentMode,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','BankRecord',
    'BeneficiaryName',FGetEmployeeId(new_record.EmployeeSysId),'',new_record.BeneficiaryName,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentBankBrCode after update of PaymentBankBrCode
order 3 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentBankBrCode', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentBankBrCode,new_record.PaymentBankBrCode,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentBankCode after update of PaymentBankCode
order 4 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentBankCode', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentBankCode,new_record.PaymentBankCode,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentAmt after update of PaymentAmt
order 5 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentAmt', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentAmt,new_record.PaymentAmt,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentCategory after update of PaymentCategory
order 6 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentCategory', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentCategory,new_record.PaymentCategory,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentValue after update of PaymentValue
order 7 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentValue', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentValue,new_record.PaymentValue,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentType after update of PaymentType
order 8 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentType', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentType,new_record.PaymentType,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentBankAccNo after update of PaymentBankAccNo
order 9 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentBankAccNo', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentBankAccNo,new_record.PaymentBankAccNo,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentBankAccType after update of PaymentBankAccType
order 10 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentBankAccType', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentBankAccType,new_record.PaymentBankAccType,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_PaymentMode after update of PaymentMode
order 11 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'PaymentMode', FGetEmployeeId(new_record.EmployeeSysId),old_record.PaymentMode,new_record.PaymentMode,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;
create trigger dba.AuditTrailUpdateBankRecord_BeneficiaryName after update of BeneficiaryName
order 12 on DBA.BankRecord
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3,AuditKey4,AuditKey5,AuditKey6) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','BankRecord',
    'BeneficiaryName', FGetEmployeeId(new_record.EmployeeSysId),old_record.BeneficiaryName,new_record.BeneficiaryName,
    new_record.BankRecSGSPGenId,new_record.EmployeeSysId,new_record.PayRecYear,
    new_record.PayRecPeriod,new_record.PayRecSubPeriod,new_record.PayRecID);
end
;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddAddress') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddAddress" after update of PersonalAddAddress
order 1 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddAddress', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddAddress,new_record.PersonalAddAddress,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddAddress2') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddAddress2" after update of PersonalAddAddress2
order 2 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddAddress2', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddAddress2,new_record.PersonalAddAddress2,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddAddress3') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddAddress3" after update of PersonalAddAddress3
order 3 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddAddress3', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddAddress3,new_record.PersonalAddAddress3,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddCity') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddCity" after update of PersonalAddCity
order 5 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddCity', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddCity,new_record.PersonalAddCity,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddCountry') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddCountry" after update of PersonalAddCountry
order 4 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddCountry', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddCountry,new_record.PersonalAddCountry,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddMailing') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddMailing" after update of PersonalAddMailing
order 8 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddMailing', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddMailing,new_record.PersonalAddMailing,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddPCode') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddPCode" after update of PersonalAddPCode
order 7 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddPCode', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddPCode,new_record.PersonalAddPCode,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_PersonalAddState') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_PersonalAddState" after update of PersonalAddState
order 6 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'PersonalAddState', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.PersonalAddState,new_record.PersonalAddState,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;


IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailInsertPersonalAddress') then
CREATE TRIGGER "AuditTrailInsertPersonalAddress" after insert order 15 on
DBA.PersonalAddress
referencing new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddAddress',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddAddress,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddAddress2',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddAddress2,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddAddress3',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddAddress3,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddCountry',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddCountry,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddCity',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddCity,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
 
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddState',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddState,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddPCode',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddPCode,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','PersonalAddMailing',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.PersonalAddMailing,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString1',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString1,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString2',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString2,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString3',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString3,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString4',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString4,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString5',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString5,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Insert','PersonalAddress','CustString6',
  FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),'',new_record.CustString6,new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);


end;
END IF;


IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailDeletePersonalAddress') then
CREATE TRIGGER "AuditTrailDeletePersonalAddress" after delete order 16 on
DBA.PersonalAddress
referencing old as old_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddAddress',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddAddress,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddAddress2',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddAddress2,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddAddress3',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddAddress3,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddCountry',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddCountry,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddCity',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddCity,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddState',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddState,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);
  
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddPCode',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddPCode,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','PersonalAddMailing',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.PersonalAddMailing,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString1',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString1,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString2',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString2,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString3',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString3,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString4',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString4,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString5',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString5,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
  AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
  connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Delete','PersonalAddress','CustString6',
  FGetEmployeeIdByPersonalSysId(old_record.PersonalSysId),old_record.CustString6,'',old_record.PersonalAddressId,old_record.PersonalSysId,old_record.ContactLocationId);

end;
END IF;

commit work;