  /* ============================================================ */
  /*   View: View_SYSTABLE                                        */
  /* ============================================================ */
  CREATE VIEW "DBA"."View_SYSTABLE"
    AS 
  SELECT 
  SYS.SYSTAB.Table_Name AS Table_Name,  
  SYS.SYSTAB.Table_Type_Str AS Table_type,
  SYS.SYSTAB.Creator AS Creator
  FROM SYS.SYSTAB;


  /* ============================================================ */
  /*   View: View_SYSCOLUMNS */
  /* ============================================================ */
  CREATE VIEW "DBA"."View_SYSCOLUMNS"
    AS
  SELECT 
  SYS.SYSCOLUMNS.ColType AS ColType,  
  SYS.SYSCOLUMNS.tname AS tname,
  SYS.SYSCOLUMNS.cname AS cname,
  SYS.SYSCOLUMNS.Length AS Length,
  SYS.SYSCOLUMNS.ColNo AS ColNo
  FROM SYS.SYSCOLUMNS;


  /* ============================================================ */
  /*   View: View_SYSTABCOL*/
  /* ============================================================ */
  CREATE VIEW "DBA"."View_SYSTABCOL"
    AS
  SELECT 
  SYS.SYSTABCOL.Column_Name AS Column_Name,  
  SYS.SYSTABCOL.Column_Id AS Column_Id
  FROM SYS.SYSTABCOL;

Commit Work;