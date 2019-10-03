
if exists(select * from sys.sysprocedure where proc_name = 'DeleteComBank') then
  drop procedure DeleteComBank;
end if;

CREATE PROCEDURE "DBA"."DeleteComBank"(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(50))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo) then
    delete from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo;
    commit work;
  end if;
end;


if exists(select * from sys.sysprocedure where proc_name = 'FGetLveCreditExpired') then
  drop procedure FGetLveCreditExpired;
end if;

CREATE FUNCTION "DBA"."FGetLveCreditExpired"(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_ExpiredDate date)
returns double
begin
  declare Out_TotalExpired double;
  declare Out_TotalTaken double;
  declare In_ExpiredTakenDays double;
  declare In_ExpiredDays double;
  declare In_RemainTakenDays double;
  /*
  Create Temporary Table to store the Credit Leave Application so as to strike off one expired if taken
  */
  if not exists(select* from Systable where Table_name = 'ExpiredLeaveRecord') then
    create global temporary table dba.ExpiredLeaveRecord(
      ExpiredLeaveRecordId integer not null default autoincrement,
      LeaveAppSGSPGenId char(30) not null,
      LveRecDate date not null,
      LveRecStartTime time not null,
      LveRecConvertDays double not null,
      primary key(ExpiredLeaveRecordId),
      ) on commit delete rows;
    message 'Expired Leave Record Table Created' type info to client
  else
    delete from ExpiredLeaveRecord
  end if;
  /*
  Get Credit Leave that has expire date
  */
  set Out_TotalExpired=0;
  CreditLeaveLoop: for CreditLeaveFor as CreditLeaveCurs dynamic scroll cursor for
    select CreditExpireDate as In_CreditExpireDate,
      AdjEffectiveDate as In_AdjEffectiveDate,
      AdjDays as In_AdjDays from AdjustCredit where EmployeeSysId = In_EmployeeSysId and
      LeaveTypeId = In_LeaveTypeId and
      CreditExpireDate <= In_ExpiredDate and
      CreditExpireDate <> '1899-12-30' order by AdjEffectiveDate asc,CreditExpireDate asc do
    message cast(In_AdjEffectiveDate as char(10))+' '+cast(In_CreditExpireDate as char(10))+' '+cast(In_AdjDays as char(3)) type info to client;
    set In_ExpiredDays=In_AdjDays;
    /*
    Get Credit Leave that has expire date
    */
    LeaveRecordLoop: for LeaveRecordFor as LeaveRecordCurs dynamic scroll cursor for
      select LeaveApplication.LeaveAppSGSPGenId as In_LeaveAppSGSPGenId,
        LeaveRecord.LveRecDate as In_LveRecDate,
        LeaveRecord.LveRecStartTime as In_LveRecStartTime,
        LeaveRecord.LveRecConvertDays as In_TakenDays from
        LeaveRecord join LeaveApplication where EmployeeSysId = In_EmployeeSysId and
        LeaveApplication.LeaveTypeId = In_LeaveTypeId and
        LeaveRecord.LveRecDate <= In_CreditExpireDate and
        LeaveRecord.LveRecDate >= In_AdjEffectiveDate and 
        LveRecApproved = 1 order by LeaveRecord.LveRecDate asc do
      if(In_ExpiredDays > 0) then
        /*
        Sum the total taken from ExpiredLeaveRecord
        */
        select sum(LveRecConvertDays) into In_ExpiredTakenDays from ExpiredLeaveRecord where
          LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
          LveRecDate = In_LveRecDate and
          LveRecStartTime = In_LveRecStartTime;
        if In_ExpiredTakenDays is null then set In_ExpiredTakenDays=0
        end if;
        set In_RemainTakenDays=In_TakenDays-In_ExpiredTakenDays;
        /*
        Leave Record is already consumed
        */
        if(In_RemainTakenDays > 0) then
          message Space(5)+In_LeaveAppSGSPGenId+' '+
            cast(In_LveRecDate as char(10))+' '+
            cast(In_LveRecStartTime as char(8))+' '+
            cast(In_TakenDays as char(8))+' '+
            cast(In_RemainTakenDays as char(8)) type info to client;
          /*
          Leave application is more than Expired Day
          */
          if(In_RemainTakenDays >= In_ExpiredDays) then
            set In_RemainTakenDays=In_ExpiredDays
          end if;
          /*
          Leave application is marked
          */
          insert into ExpiredLeaveRecord(LeaveAppSGSPGenId,
            LveRecDate,
            LveRecStartTime,
            LveRecConvertDays) values(
            In_LeaveAppSGSPGenId,In_LveRecDate,In_LveRecStartTime,In_RemainTakenDays);
          set In_ExpiredDays=In_ExpiredDays-In_RemainTakenDays;
          message Space(10)+'Taken : '+cast(In_RemainTakenDays as char(8)) type info to client
        end if
      end if end for;
    /*
    End of Leave Application Loop
    */
    if In_ExpiredDays > 0 then
      set Out_TotalExpired=Out_TotalExpired+In_ExpiredDays
    end if;
    message Space(5)+'Expired :  '+cast(In_ExpiredDays as char(8)) type info to client end for;
  /*
  End of Credit Leave Loop
  */
  message 'Total Expired :  '+cast(Out_TotalExpired as char(8)) type info to client;
  delete from ExpiredLeaveRecord;
  return Out_TotalExpired
end;



if exists(select * from sys.sysprocedure where proc_name = 'GrantTMSViewPermission') then
  drop procedure GrantTMSViewPermission;
end if;

CREATE PROCEDURE "DBA"."GrantTMSViewPermission"(In In_UserID char(50))
BEGIN

Declare In_Count int;

IF EXISTS(select * from licenserecord where functionlist like '%Sage Product Integration%') THEN
  SELECT count(SubRegistryID) into In_Count from subregistry where registryid='SageProdIntegrate';
  IF(In_Count>0) THEN
    ViewListLoop: for ViewListFor as curs dynamic scroll cursor for
    select RegProperty1 as In_View from subregistry where registryid='SageProdIntegrate' do
    EXECUTE IMMEDIATE ('GRANT SELECT  ON ' + In_View  +' TO ' + In_UserID);
    end for
  END IF;
END IF;

IF EXISTS(select * from ProductFeatures WHERE  Function LIKE '%Sage Product Integration%'
           AND PublishDate <= DATE(NOW())         
           AND ExpiryDate >=  DATE(NOW()) ) THEN          
                   
  SELECT count(SubRegistryID) into In_Count from subregistry where registryid='SageProdIntegrate';
  IF(In_Count>0) THEN
    ViewListLoop: for ViewListFor as cursprod dynamic scroll cursor for
    select RegProperty1 as In_View from subregistry where registryid='SageProdIntegrate' do
    EXECUTE IMMEDIATE ('GRANT SELECT  ON ' + In_View  +' TO ' + In_UserID);
    end for
  END IF;    
END IF;                

IF EXISTS(select * from licenserecord where functionlist like '%TMS Vendor%') THEN
  SELECT count(SubRegistryID) into In_Count from subregistry where registryid='TMS Vendor';
  IF(In_Count>0) THEN
    ViewListLoop: for ViewListFor as cursTMS dynamic scroll cursor for
    select RegProperty1 as In_View from subregistry where registryid='TMS Vendor' do
    EXECUTE IMMEDIATE ('GRANT SELECT  ON ' + In_View  +' TO ' + In_UserID);
    end for
  END IF;
END IF;

END;


if exists(select * from sys.sysprocedure where proc_name = 'InsertNewComBank') then
  drop procedure InsertNewComBank;
end if;


CREATE PROCEDURE "DBA"."InsertNewComBank"(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(50),
in In_ComAccType char(50))
begin
  declare Char_ComBankName char(60);
  select Bank.BankName into Char_ComBankName from Bank where
    Bank.BankId = In_ComBankCode;
  if not exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo) then
    insert into CompanyBank(ComBankCode,
      CompanyId,ComBankBranchCode,
      ComAccountNo,ComBankName,
      ComAccType) values(
      In_ComBankCode,In_CompanyId,In_ComBankBranchCode,
      In_ComAccountNo,Char_ComBankName,In_ComAccType);
    commit work;
  end if;
end;


if exists(select * from sys.sysprocedure where proc_name = 'RevokeTMSViewPermission') then
  drop procedure RevokeTMSViewPermission;
end if;

CREATE PROCEDURE "DBA"."RevokeTMSViewPermission"(In In_UserID char(50))
BEGIN

Declare In_Count int;

SELECT count(SubRegistryID) into In_Count from subregistry where registryid in('SageProdIntegrate','TMS Vendor');
  IF(In_Count>0) THEN
    ViewListLoop: for ViewListFor as curs dynamic scroll cursor for
    select RegProperty1 as In_View from subregistry where registryid in('SageProdIntegrate','TMS Vendor') do
     IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
       WHERE  ST.table_Name=In_View and SU.name in(In_UserID) and SP.selectauth='Y') THEN
       EXECUTE IMMEDIATE ('REVOKE ALL  ON ' + In_View + ' FROM ' + In_UserID);
     END IF;
    end for
  END IF;

END;


if exists(select * from sys.sysprocedure where proc_name = 'UpdateComBankAccNo') then
  drop procedure UpdateComBankAccNo;
end if;

CREATE PROCEDURE "DBA"."UpdateComBankAccNo"(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComOldAccountNo char(50),
in In_ComNewAccNo char(50))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComOldAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    update CompanyBank set
      CompanyBank.ComAccountNo = In_ComNewAccNo where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComOldAccountNo and
      CompanyBank.CompanyId = In_CompanyId;
    commit work;
  end if;
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateComBankAccType') then
  drop procedure UpdateComBankAccType;
end if;


CREATE PROCEDURE "DBA"."UpdateComBankAccType"(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(50),
in In_ComAccType char(50))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    update CompanyBank set
      CompanyBank.ComAccType = In_ComAccType where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId;
    commit work;
  end if;
end;


if exists(select * from sys.sysprocedure where proc_name = 'UpdateComBankAccount') then
  drop procedure UpdateComBankAccount;
end if;

CREATE PROCEDURE "DBA"."UpdateComBankAccount"(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(50),
in In_ComNewAccountNo char(50),
in In_ComAccType char(20))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    if In_ComAccountNo <> In_ComNewAccountNo then
      update CompanyBank set
        CompanyBank.ComAccountNo = In_ComNewAccountNo,
        CompanyBank.ComAccType = In_ComAccType where
        CompanyBank.ComBankCode = In_ComBankCode and
        CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
        CompanyBank.ComAccountNo = In_ComAccountNo and
        CompanyBank.CompanyId = In_CompanyId;
      commit work;
    else
      update CompanyBank set
        CompanyBank.ComAccType = In_ComAccType where
        CompanyBank.ComBankCode = In_ComBankCode and
        CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
        CompanyBank.ComAccountNo = In_ComAccountNo and
        CompanyBank.CompanyId = In_CompanyId;
      commit work;
    end if;
  end if;
end;


if exists(select * from sys.sysprocedure where proc_name = 'UpdateComBankBranch') then
  drop procedure UpdateComBankBranch;
end if;

CREATE PROCEDURE "DBA"."UpdateComBankBranch"(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(50),
in In_ComNewBankBranchCode char(20))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    update CompanyBank set
      CompanyBank.ComBankBranchCode = In_ComNewBankBranchCode where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId;
    commit work;
  end if;
end
;

if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_AllowanceID') then
  ALTER VIEW "DBA"."View_TMS_AllowanceID"
   AS
   SELECT FormulaId as PayElementId, FormulaDesc as PayElementDesc, FormulaType, (IF (SELECT 1 FROM FormulaProperty WHERE FormulaId=Formula.FormulaId and KeywordId = 'GRPCode') IS NULL THEN 0 ELSE 1 ENDIF) AS IsGRPCode 
, FormulaSubCategory FROM Formula WHERE FormulaSubCategory IN ('Allowance','Deduction') AND FormulaActive=1 AND FormulaType IN ('Free', 'Formula');


else

CREATE VIEW "DBA"."View_TMS_AllowanceID"
   AS
   SELECT FormulaId as PayElementId, FormulaDesc as PayElementDesc, FormulaType, (IF (SELECT 1 FROM FormulaProperty WHERE FormulaId=Formula.FormulaId and KeywordId = 'GRPCode') IS NULL THEN 0 ELSE 1 ENDIF) AS IsGRPCode 
, FormulaSubCategory FROM Formula WHERE FormulaSubCategory IN ('Allowance','Deduction') AND FormulaActive=1 AND FormulaType IN ('Free', 'Formula');

end if;

commit work;