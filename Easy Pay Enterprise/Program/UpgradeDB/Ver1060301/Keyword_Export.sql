Update Keyword SET KeywordSubCategory='600' WHERE KeywordID='EX_NPLLveAmount';
Update Keyword SET KeywordSubCategory='601' WHERE KeywordID='EX_AbsLveAmount';
Update Keyword SET KeywordSubCategory='603' WHERE KeywordID='EX_CurrentHrDays';
Update Keyword SET KeywordSubCategory='604' WHERE KeywordID='EX_PreviousHrDays';

If not exists(select * from Keyword where KeyWordId = 'EX_LateLveAmount') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_LateLveAmount','Late Amount','Late Amount','EXPORT',0,0,0,'LateLveAmount',602,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_NPLCurDaysTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_NPLCurDaysTaken','Current NPL Taken Days','Current NPL Taken Days','EXPORT',0,0,0,'NPLCurDaysTaken',605,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_NPLLastDaysTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_NPLLastDaysTaken','Last NPL Taken Days','Last NPL Taken Days','EXPORT',0,0,0,'NPLLastDaysTaken',606,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_NPLCurHrsTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_NPLCurHrsTaken','Current NPL Taken Hours','Current NPL Taken Hours','EXPORT',0,0,0,'NPLCurHrsTaken',607,1,0,'');
end if;


If not exists(select * from Keyword where KeyWordId = 'EX_NPLLastHrsTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_NPLLastHrsTaken','Last NPL Taken Hours','Last NPL Taken Hours','EXPORT',0,0,0,'NPLLastHrsTaken',608,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_AbsCurDaysTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES
   ('EX_AbsCurDaysTaken','Current Absent Taken Days','Current Absent Taken Days','EXPORT',0,0,0,'AbsCurDaysTaken',609,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_AbsLastDaysTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES('EX_AbsLastDaysTaken','Last Absent Taken Days','Last Absent Taken Days','EXPORT',0,0,0,'AbsLastDaysTaken',610,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_LateCurHrsTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES('EX_LateCurHrsTaken','Current Late Taken Hours','Current Late Taken Hours','EXPORT',0,0,0,'LateCurHrsTaken',611,1,0,'');
end if;

If not exists(select * from Keyword where KeyWordId = 'EX_LateLastHrsTaken') then
   INSERT INTO Keyword 
   (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   VALUES('EX_LateLastHrsTaken','Last Late Taken Hours','Last Late Taken Hours','EXPORT',0,0,0,'LateLastHrsTaken',612,1,0,'');
end if;

Commit work;
