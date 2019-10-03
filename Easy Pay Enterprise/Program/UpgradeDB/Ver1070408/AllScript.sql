if exists(select * from sys.sysprocedure where proc_name = 'FGetInterfaceCodeMappingID') then
  drop function FGetInterfaceCodeMappingID
end if;
Create FUNCTION DBA.FGetInterfaceCodeMappingID(
in In_InterfaceProjectID char(20),
in In_CodeTableID char(20),
in In_CodeMappingExtID char(20))
RETURNS char(20)
begin
  declare Out_CodeMappingEPEID char(20);
  select CodeMappingEPEID into Out_CodeMappingEPEID from InterfaceCodeMapping where
    InterfaceProjectID = In_InterfaceProjectID and
    CodeTableID = In_CodeTableID and
    CodeMappingExtID = In_CodeMappingExtID;
  if Out_CodeMappingEPEID is null then
    select CodeMappingEPEID into Out_CodeMappingEPEID from InterfaceCodeMapping where
      InterfaceProjectID = In_InterfaceProjectID and
      CodeTableID = In_CodeTableID and
      CodeMappingExtID = '???';
    if Out_CodeMappingEPEID is null then
      set Out_CodeMappingEPEID=In_CodeMappingExtID
    end if
  end if;
  return Out_CodeMappingEPEID;
end;

/*==============================================================*/
/* Revoke access for Sample user on Procedures                  */
/*==============================================================*/
GrantExeLoop: for GrantExeFor as GrantExeCurs dynamic scroll cursor for
select proc_name as In_ProcName from sysprocedure as sp INNER JOIN SYSPROCPERM as ssp on sp.proc_id = ssp.proc_id INNER JOIN sysusers as su on su.uid = ssp.grantee where name = 'Sample' and proc_defn LIKE 'create procedure%' do 
EXECUTE IMMEDIATE ('REVOKE EXECUTE ON ' + In_ProcName + ' FROM Sample');
end for;

commit work;