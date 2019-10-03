/* Audit Trail - Bank Beneficiary Name */
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePaymentBankInfo') then
   drop trigger AuditTrailDeletePaymentBankInfo
end if;
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
end;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPaymentBankInfo') then
   drop trigger AuditTrailInsertPaymentBankInfo
end if;
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
end;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_BeneficiaryName') then
   drop trigger AuditTrailUpdatePaymentBankInfo_BeneficiaryName
end if;
create trigger dba.AuditTrailUpdatePaymentBankInfo_BeneficiaryName after update of BeneficiaryName
order 12 on DBA.PaymentBankInfo
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PaymentBankInfo','BeneficiaryName',
	 FGetEmployeeId(new_record.EmployeeSysId),old_record.BeneficiaryName,new_record.BeneficiaryName,new_record.PayBankSGSPGenId)
end;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewPersonalAttachment') then
   drop procedure InsertNewPersonalAttachment
end if;
Create PROCEDURE "DBA"."InsertNewPersonalAttachment"(
in In_PersonalSysId integer,
in In_PersonalAttFileName char(100),
in In_PersonalAttOrgFilePath char(255),
in In_PersonalAttDescription char(255),
in In_PersonalAttCategory char(100),
in In_PersonalAttCreatedByEPE smallint,
out Out_PersonalAttachmentId integer
)
BEGIN
    select Max(PersonalAttachmentId) into Out_PersonalAttachmentId from PersonalAttachment;
    if(Out_PersonalAttachmentId is null) then set Out_PersonalAttachmentId=1
    else set Out_PersonalAttachmentId=Out_PersonalAttachmentId+1
    end if;
	Insert into PersonalAttachment(PersonalAttachmentId,PersonalSysId,PersonalAttFileName,PersonalAttOrgFilePath,PersonalAttDescription,PersonalAttCategory,PersonalAttCreatedByEPE)
    Values(Out_PersonalAttachmentId,In_PersonalSysId,In_PersonalAttFileName,In_PersonalAttOrgFilePath,In_PersonalAttDescription,In_PersonalAttCategory,In_PersonalAttCreatedByEPE);
    commit work;
END
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdatePersonalAttachment') then
   drop procedure UpdatePersonalAttachment
end if;
Create PROCEDURE "DBA"."UpdatePersonalAttachment"( 
in In_PersonalAttachmentId integer,
in In_PersonalAttFileName char(100),
in In_PersonalAttOrgFilePath char(255),
in In_PersonalAttDescription char(255),
in In_PersonalAttCategory char(100),
in In_PersonalAttCreatedByEPE smallint,
out Out_ErrorCode integer
)
BEGIN
   if exists(select * from PersonalAttachment where PersonalAttachmentId = In_PersonalAttachmentId) Then
      Update PersonalAttachment Set 
       PersonalAttFileName = In_PersonalAttFileName,
       PersonalAttOrgFilePath = In_PersonalAttOrgFilePath,
       PersonalAttDescription = In_PersonalAttDescription,
       PersonalAttCategory = In_PersonalAttCategory,
	   PersonalAttCreatedByEPE = In_PersonalAttCreatedByEPE
     where PersonalAttachmentId = In_PersonalAttachmentId;
     Commit work;
     set Out_ErrorCode=1;
    else
     set Out_ErrorCode=0;
    end if;
END
;

commit work;