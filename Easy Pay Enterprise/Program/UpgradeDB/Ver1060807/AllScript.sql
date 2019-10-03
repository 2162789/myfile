//RevokeTMSViewPermission

if exists(select * from sys.sysprocedure where proc_name = 'RevokeTMSViewPermission') then
  drop procedure RevokeTMSViewPermission;
end if;

CREATE PROCEDURE "DBA"."RevokeTMSViewPermission"(In In_UserID char(50))
BEGIN

IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_SmartTouch_Employee' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
    EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_SmartTouch_Employee FROM ' + In_UserID);
  END IF;

 IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_SmartTouch_LeaveRecord' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
    EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_SmartTouch_LeaveRecord FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_SmartTouch_BasicRateProgression' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
    EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_SmartTouch_BasicRateProgression FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_Query' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
    EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_Query FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_PayRecID' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
    EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_PayRecID FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_OTRate' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
  EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_OTRate FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_LeaveType' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
  EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_LeaveType FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_JobCode' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
  EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_JobCode FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_Holidays' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
  EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_Holidays FROM ' + In_UserID);
  END IF;

  IF EXISTS(SELECT DISTINCT SU.name FROM SYSTABLEPERM SP JOIN SYSUSERS SU ON SU.uid = SP.grantee JOIN SYSTABLE ST ON ST.table_id = SP.stable_id 
            WHERE  ST.table_Name='View_TMS_AllowanceID' and SU.name in(In_UserID) and SP.selectauth='Y') THEN
  EXECUTE IMMEDIATE ('REVOKE ALL  ON View_TMS_AllowanceID FROM ' + In_UserID);
  END IF;

END;


//GrantTMSViewPermission

if exists(select * from sys.sysprocedure where proc_name = 'GrantTMSViewPermission') then
  drop procedure GrantTMSViewPermission;
end if;

CREATE PROCEDURE "DBA"."GrantTMSViewPermission"(In In_UserID char(50))
BEGIN

IF EXISTS(select * from licenserecord where functionlist like '%Sage Product Integration%') THEN
  EXECUTE IMMEDIATE ('GRANT SELECT  ON  View_TMS_SmartTouch_Employee TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON  View_TMS_SmartTouch_LeaveRecord TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON  View_TMS_SmartTouch_BasicRateProgression  TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_Query  TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_PayRecID TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_OTRate TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_LeaveType TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_JobCode TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_Holidays TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_AllowanceID TO ' + In_UserID);
END IF;
IF EXISTS(select * from licenserecord where functionlist like '%TMS Vendor%') THEN
  EXECUTE IMMEDIATE ('GRANT SELECT  ON  View_TMS_SmartTouch_Employee TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON  View_TMS_SmartTouch_LeaveRecord TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON  View_TMS_SmartTouch_BasicRateProgression  TO ' + In_UserID);
  EXECUTE IMMEDIATE ('GRANT SELECT  ON View_TMS_Query  TO ' + In_UserID);
END IF;

END;


//TMSViewPermission

if exists(select * from sys.sysprocedure where proc_name = 'TMSViewPermission') then
  drop procedure TMSViewPermission;
end if;

CREATE PROCEDURE "DBA"."TMSViewPermission"()
BEGIN
Declare In_Count int;

SELECT count(UserID) into In_Count from SystemUser where UserGroupId ='TMS Vendor';

IF(In_Count>0) THEN
  SystemUserLoop: for SystemUserFor as curs dynamic scroll cursor for
  select UserID as In_UserID from SystemUser where UserGroupId ='TMS Vendor' do
  CALL RevokeTMSViewPermission(In_UserID);
  CALL GrantTMSViewPermission(In_UserID);
  end for
END IF;

END;


//TMSViewUserPermission

if exists(select * from sys.sysprocedure where proc_name = 'TMSViewUserPermission') then
  drop procedure TMSViewUserPermission;
end if;

CREATE PROCEDURE "DBA"."TMSViewUserPermission"(In In_UserID char(50))
BEGIN

 CALL RevokeTMSViewPermission(In_UserID);
 CALL GrantTMSViewPermission(In_UserID);

END;


 /* Insert Formula for System Leave Deduction*/
if not exists(select * from Formula where FormulaId='Sys_ANLDeduction') then
 Insert into Formula Values('Sys_ANLDeduction',1,0,0,'PayElement','Deduction','Formula','','Annual Leave Deduction','',20,1);
 Insert into FormulaRange(FormulaId,FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5)
 Values('Sys_ANLDeduction',1,0,0,'U1 * (-K1) + U2 * (-K2);',0,0,0,0,0,'GRPHourRateAmt','GRPDayRateAmt','','','','','','','','','No of Hours','No of Days','','','');
 Insert into FormulaProperty(FormulaId,KeywordId)  Values('Sys_ANLDeduction','GRPCode');
 Insert into FormulaProperty (FormulaId,KeywordId)Values('Sys_ANLDeduction','GrossSalaryCode');
end if;

if not exists(select * from Subregistry where RegistryId = 'PaySetupDataLv' and SubRegistryid = 'EncashDPayElementID') then
 Insert into Subregistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
 Values ('PaySetupDataLv','EncashDPayElementID','Combo','Annual Leave Balance Deduction Pay Element ID','ShortStringAttr','Y','Formula','FormulaID','SELECT FormulaID, FormulaDesc FROM Formula WHERE FormulaSubCategory IN (''Deduction'') AND FormulaId IN (Select FormulaId FROM FormulaProperty where KeywordID=''GRPCode'');','FormulaId\x0920\x09Formula\x09F','FormulaDesc\x0980\x09Description\x09F','',0.0,0,'',0,'Sys_ANLDeduction','','1899-12-30','1899-12-30 00:00:00.000');
end if;

Update Subregistry SET RegProperty7='SELECT FormulaID, FormulaDesc FROM Formula WHERE FormulaSubCategory IN (''Allowance'') AND FormulaId IN (Select FormulaId FROM FormulaProperty where KeywordID=''GRPCode'');' WHERE SubRegistryId='EncashPayElementID';


exec TMSViewPermission;

commit work;

