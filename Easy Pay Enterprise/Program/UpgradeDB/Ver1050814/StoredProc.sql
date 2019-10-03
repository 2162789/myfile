if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewQueryFolder' and user_name(creator) = 'DBA') then
   drop function DBA.InsertNewQueryFolder
end if;

CREATE PROCEDURE "DBA"."InsertNewQueryFolder"(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(100),
in In_SourceTmplFolderID char(20))
begin
  if not exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    insert into QueryFolder(QueryFolderID,QueryFolderDesc,SourceTmplFolderID) values(In_QueryFolderID,In_QueryFolderDesc,In_SourceTmplFolderID);

    // Inserts the CustomVariables
    call InsertNewCustomVariables(In_QueryFolderID, 
        '','','','','', // Keyword
        '','','','','', // StrVar
        '','','','','', // NumVar
        '','', //DateVar
        '','','','','', // Keyword Desc
        '','','','','', // Keyword Def Value
        '','','','','', // String Def Value
        NULL,NULL,NULL,NULL,NULL, // Num Def Value
        '1899-12-31','1899-12-31'); //Date Def Value
     
  commit work
  end if
end;

Commit Work;

