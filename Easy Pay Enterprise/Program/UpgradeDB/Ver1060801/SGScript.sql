if not exists (select formatname from banksubmitformat where banksubmitsubmitforid='Salary' and formatname='BEA') Then
insert banksubmitformat(banksubmitsubmitforid,formatname,dllname,formatterinvoke,iscustomised) values ('Salary','BEA','RSingBankFormatBEA.dll','InvokeSalaryFormatter',0);
end if;

update FormulaRange set Constant2 = 0 where FormulaRangeId = 1 and FormulaId = '0114STA55$50ERA';
update FormulaRange set Constant2 = 500 where FormulaRangeId = 1 and FormulaId = '0114STA60$500EEA';
update FormulaRange set Constant2 = 0 where FormulaRangeId = 1 and FormulaId = '0114P3A60$500EEA';
update FormulaRange set Constant2 = 500 where FormulaRangeId = 1 and FormulaId = '0114P3A60$500EEA';

Commit work;