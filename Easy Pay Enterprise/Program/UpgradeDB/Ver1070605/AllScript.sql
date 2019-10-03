Read UpgradeDB\Ver1070605\ESSTrigger.sql;

if exists(select * from sys.sysprocedure where proc_name = 'IsESSTrigger') then
  drop function IsESSTrigger;
end if;
CREATE function DBA.IsESSTrigger(
)
returns smallint
BEGIN
	Declare Out_BooleanAttr smallint;
    Select BooleanAttr into Out_BooleanAttr From SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'ESSTrigger';
    return Out_BooleanAttr;
END;

commit work;