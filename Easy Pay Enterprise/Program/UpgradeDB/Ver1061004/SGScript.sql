if not exists (select * from DBA.BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'BNP (CONNEXIS G3)') then
  insert into DBA.BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'BNP (CONNEXIS G3)', 'RSingBankFormatBNPCONNEXISG3.dll', 'InvokeSalaryFormatter', 0)
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_EE_Add_CPF') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_EE_Add_CPF', 'Employee Additional CPF', 'Employee Additional CPF', 'EXPORT', 0, 0, 0, 'ContriAddEECPF', 154, 2, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_ER_Add_CPF') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_ER_Add_CPF', 'Employer Additional CPF', 'Employer Additional CPF', 'EXPORT', 0, 0, 0, 'ContriAddERCPF', 155, 2, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_EE_Add_CPF_Prev') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_EE_Add_CPF_Prev', 'Employee Additional CPF (Prev)', 'Employee Additional CPF (Prev)', 'EXPORT', 0, 0, 0, 'ContriAddEECPF', 156, 8, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_ER_Add_CPF_Prev') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_ER_Add_CPF_Prev', 'Employer Additional CPF (Prev)', 'Employer Additional CPF (Prev)', 'EXPORT', 0, 0, 0, 'ContriAddERCPF', 157, 8, 0, '')
end if;

commit work;