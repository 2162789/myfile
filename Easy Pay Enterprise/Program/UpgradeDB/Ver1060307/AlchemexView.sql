IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name='FGetLatestResStatusByDate') THEN
    DROP FUNCTION FGetLatestResStatusByDate;
END IF;

Create FUNCTION DBA.FGetLatestResStatusByDate( 
in In_EmployeeId char(30),
in In_Date date )
RETURNS char(20)
DETERMINISTIC
BEGIN
	DECLARE Out_LatestResStatus char(10);
	Declare Temp_PersonalSysId integer;
    Select PersonalSysId into Temp_PersonalSysId from Employee where EmployeeId = In_EmployeeId;
    Select first ResidenceTypeId into Out_LatestResStatus from ResidenceStatusRecord
    where PersonalSysId = Temp_PersonalSysId And ResStatusEffectiveDate <= In_Date 
    order by ResStatusEffectiveDate desc;
	RETURN Out_LatestResStatus;
END
;

IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='ASQLGrantSelect') THEN
    DROP PROCEDURE ASQLGrantSelect;
END IF;
CREATE PROCEDURE DBA.ASQLGrantSelect(In In_UserID char(20))
BEGIN
	GrantLoop: for GrantFor as GrantCurs dynamic scroll cursor for
    SELECT table_name AS In_TableName FROM SysTable WHERE table_type='VIEW' AND table_name LIKE 'View_Alc%' do
    EXECUTE IMMEDIATE ('GRANT SELECT ON ' + In_TableName + ' TO ' + In_UserID);
    end for;
    
	GrantExeLoop: for GrantExeFor as GrantExeCurs dynamic scroll cursor for
	SELECT proc_name as In_ProcName from SysProcedure where Creator=1 and proc_defn like 'create function%' do
    EXECUTE IMMEDIATE ('GRANT EXECUTE ON ' + In_ProcName + ' TO ' + In_UserID);
    end for;
END;

CALL DBA.ASQLGrantSelect('AlchemexUser');
DROP Procedure DBA.ASQLGrantSelect;

commit work;