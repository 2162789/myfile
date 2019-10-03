/* KeyWord */
if not exists(select * from Keyword Where KeyWordId = 'BPJSPensProrate') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('BPJSPensProrate','Prorate','Prorate','BPJSPensResProcess',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'BPJSPensFull') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('BPJSPensFull','No Prorate','No Prorate','BPJSPensResProcess',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'BPJSPensNoContri') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('BPJSPensNoContri','No Contribution','No Contribution','BPJSPensResProcess',0,0,0,'',0,0,0,'')
end if;

/* SubRegistry */
if not exists(select * from SubRegistry where RegistryId = 'PayOption' and SubRegistryId = 'BPJSPensResProcess') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayOption','BPJSPensResProcess','','','','','','','','','','',0,0,'',0,'BPJSPensProrate','','1899-12-30','1899-12-30 00:00:00');
end if;

/* HSBC (iFile) */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'HSBC (iFile)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'HSBC (iFile)', 'RIndoBankFormatHSBCiFile.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;