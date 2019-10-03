if exists(select 1 from sys.sysviews where viewname = 'View_SYSTABLE') then
    DROP VIEW View_SYSTABLE;
end if;
  
if NOT exists(select 1 from sys.sysviews where viewname = 'View_SYSTABLE') then
  /* ============================================================ */
  /*   View: View_SYSTABLE                                        */
  /* ============================================================ */
CREATE VIEW "DBA"."View_SYSTABLE"
    AS 
  SELECT 
  SYS.SYSTAB.Table_Name AS Table_Name,  
  SYS.SYSTAB.Table_Type_Str AS Table_type,
  SYS.SYSTAB.Creator AS Creator,
  SYS.SYSTAB.Table_Id AS Table_Id
  FROM SYS.SYSTAB;

end if;


Update  SubRegistry set  RegProperty2 ='Residence Type Of New Born'   where SubRegistryId = 'ChildResidence';


Commit Work;