if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewQueryFolder' and user_name(creator) = 'DBA') then
   drop function DBA.InsertNewQueryFolder
end if;

CREATE PROCEDURE DBA.InsertNewQueryFolder(
in In_QueryFolderID char(20),
in In_QueryFolderDesc char(20),
in In_SourceTmplFolderID char(20))
begin
  if not exists(select* from QueryFolder where
      QueryFolder.QueryFolderID = In_QueryFolderID) then
    
    insert into QueryFolder(QueryFolderID,QueryFolderDesc,SourceTmplFolderID) values(In_QueryFolderID,In_QueryFolderDesc,In_SourceTmplFolderID);

    // Create Custom variable records for that Folder
    if (In_SourceTmplFolderID ='' or In_SourceTmplFolderID is null) then

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

    else
        // From Template
        CustomVariablesLoop: for CustomVariablesForLoop as Cur_CustomVariables dynamic scroll cursor for
            select TmplVariables.Keyword1ID as New_Keyword1ID, 
                 TmplVariables.Keyword2ID as New_Keyword2ID,
                 TmplVariables.Keyword3ID as New_Keyword3ID, 
                 TmplVariables.Keyword4ID as New_Keyword4ID,
                 TmplVariables.Keyword5ID as New_Keyword5ID,
                 TmplVariables.StrVar1 as New_StrVar1,
                 TmplVariables.StrVar2 as New_StrVar2, 
                 TmplVariables.StrVar3 as New_StrVar3, 
                 TmplVariables.StrVar4 as New_StrVar4, 
                 TmplVariables.StrVar5 as New_StrVar5, 
                 TmplVariables.NumVar1 as New_NumVar1, 
                 TmplVariables.NumVar2 as New_NumVar2,
                 TmplVariables.NumVar3 as New_NumVar3, 
                 TmplVariables.NumVar4 as New_NumVar4, 
                 TmplVariables.NumVar5 as New_NumVar5,
                 TmplVariables.DateVar1 as New_DateVar1, 
                 TmplVariables.DateVar2 as New_DateVar2, 
                 TmplVariables.Keyword1Desc as New_Keyword1Desc, 
                 TmplVariables.Keyword2Desc as New_Keyword2Desc, 
                 TmplVariables.Keyword3Desc as New_Keyword3Desc, 
                 TmplVariables.Keyword4Desc as New_Keyword4Desc, 
                 TmplVariables.Keyword5Desc as New_Keyword5Desc,
                 TmplVariables.Keyword1DefValue as New_Keyword1DefValue, 
                 TmplVariables.Keyword2DefValue as New_Keyword2DefValue, 
                 TmplVariables.Keyword3DefValue as New_Keyword3DefValue, 
                 TmplVariables.Keyword4DefValue as New_Keyword4DefValue, 
                 TmplVariables.Keyword5DefValue as New_Keyword5DefValue,
                 TmplVariables.StrVar1DefValue as New_StrVar1DefValue, 
                 TmplVariables.StrVar2DefValue as New_StrVar2DefValue, 
                 TmplVariables.StrVar3DefValue as New_StrVar3DefValue, 
                 TmplVariables.StrVar4DefValue as New_StrVar4DefValue, 
                 TmplVariables.StrVar5DefValue as New_StrVar5DefValue, 
                 TmplVariables.NumVar1DefValue as New_NumVar1DefValue, 
                 TmplVariables.NumVar2DefValue as New_NumVar2DefValue, 
                 TmplVariables.NumVar3DefValue as New_NumVar3DefValue, 
                 TmplVariables.NumVar4DefValue as New_NumVar4DefValue, 
                 TmplVariables.NumVar5DefValue as New_NumVar5DefValue, 
                 TmplVariables.DateVar1DefValue as New_DateVar1DefValue, 
                 TmplVariables.DateVar2DefValue as New_DateVar2DefValue from TmplVariables where TmplVariables.TmplFolderID = In_SourceTmplFolderID do
                call InsertNewCustomVariables(In_QueryFolderID, New_Keyword1ID, New_Keyword2ID, New_Keyword3ID, New_Keyword4ID, New_Keyword5ID,
                 New_StrVar1, New_StrVar2, New_StrVar3, New_StrVar4, New_StrVar5, New_NumVar1, New_NumVar2, New_NumVar3, New_NumVar4, New_NumVar5,
                 New_DateVar1, New_DateVar2, New_Keyword1Desc, New_Keyword2Desc, New_Keyword3Desc, New_Keyword4Desc, New_Keyword5Desc,
                 New_Keyword1DefValue, New_Keyword2DefValue, New_Keyword3DefValue, New_Keyword4DefValue, New_Keyword5DefValue,
                 New_StrVar1DefValue, New_StrVar2DefValue, New_StrVar3DefValue, New_StrVar4DefValue, New_StrVar5DefValue,
                 New_NumVar1DefValue, New_NumVar2DefValue, New_NumVar3DefValue, New_NumVar4DefValue, New_NumVar5DefValue,
                 New_DateVar1DefValue, New_DateVar2DefValue);  
        end for;

    end if;

    commit work;

  end if
end;

Commit Work;

