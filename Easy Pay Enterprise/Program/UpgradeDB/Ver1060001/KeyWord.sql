INSERT INTO KeyWord 
(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
VALUES('EX_ShiftAmount','Shift Amount','Shift Amount','EXPORT',0,0,0,'CalShiftAmount',7,1,0,'');


IF EXISTS(SELECT * FROM "DBA"."SubRegistry" where SubRegistryID='DBCountry' AND  RegProperty1 = 'Singapore') THEN

INSERT INTO KeyWord 
(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
VALUES('EX_MedisaveOrd','Ordinary Medisave','Ordinary Medisave','EXPORT',0,0,0,'CurrentTaxAmount',504,2,0,'');

INSERT INTO KeyWord 
(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
VALUES('EX_MedisaveAdd','Additional Medisave','Additional Medisave','EXPORT',0,0,0,'PreviousTaxAmount',505,2,0,'');

INSERT INTO KeyWord 
(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
VALUES('EX_TotalMedisave','Total Medisave','Total Medisave','EXPORT',0,0,0,'CurrentTaxAmount+PreviousTaxAmount',506,2,0,'');

END IF;