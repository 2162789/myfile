CREATE PROCEDURE "DBA"."ASQLGrantSelect"(In In_UserID char(20))
BEGIN

    IF EXISTS (SELECT user_name FROM SysUser WHERE user_name=In_UserID) THEN
    EXECUTE IMMEDIATE ('REVOKE CONNECT FROM ' + In_UserID); 
    END IF;
    
    EXECUTE IMMEDIATE ('GRANT CONNECT TO ' + In_UserID + ' IDENTIFIED BY ' + In_UserID);
    
	GrantLoop: for GrantFor as GrantCurs dynamic scroll cursor for
    SELECT table_name AS In_TableName FROM SysTable WHERE table_type='VIEW' AND table_name LIKE 'View_Alc%' do
    EXECUTE IMMEDIATE ('GRANT SELECT ON ' + In_TableName + ' TO ' + In_UserID);
    end for;
    
	GrantExeLoop: for GrantExeFor as GrantExeCurs dynamic scroll cursor for
	SELECT proc_name as In_ProcName from SysProcedure where Creator=1 and proc_defn like 'create function%' do
    EXECUTE IMMEDIATE ('GRANT EXECUTE ON ' + In_ProcName + ' TO ' + In_UserID);
    end for;
    
    EXECUTE IMMEDIATE ('GRANT MEMBERSHIP IN GROUP DBA TO ' + In_UserID);
 
END