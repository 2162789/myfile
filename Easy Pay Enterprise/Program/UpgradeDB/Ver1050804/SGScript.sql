if not exists(select 1 from UsageItem where UsageGrpID='StatutoryInfo' and UsageItemID='EECountNoMAWProj') then
insert into UsageItem values('EECountNoMAWProj','StatutoryInfo','Employee Count with no MAW Projection','Cessation Cut-Off Year','Cessation Cut-Off Period','','IntegerValue','SELECT CAST(YEAR(TODAY(*)) AS CHAR(4)) AS Key1, CAST(MONTH(TODAY(*)) AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(A.EmployeeSysId) AS RetValue FROM Employee A JOIN CPFProgression B ON A.EmployeeSysId=B.EmployeeSysId ','WHERE YEAR(CessationDate) > YEAR(TODAY(*)) OR (YEAR(CessationDate) = YEAR(TODAY(*)) AND MONTH(CessationDate) >= MONTH(TODAY(*)) OR CessationDate = ''18991230'') AND CPFProgCurrent=1 AND CPFMAWOption=-1;');
end if;

if not exists(select 1 from UsageItem where UsageGrpID='StatutoryInfo' and UsageItemID='EECountMAWLimit') then
insert into UsageItem values('EECountMAWLimit','StatutoryInfo','Employee Count with Maximum Additional Wage (MAW) Limit','Cessation Cut-Off Year','Cessation Cut-Off Period','','IntegerValue','SELECT CAST(YEAR(TODAY(*)) AS CHAR(4)) AS Key1, CAST(MONTH(TODAY(*)) AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(A.EmployeeSysId) AS RetValue FROM Employee A JOIN CPFProgression B ON A.EmployeeSysId=B.EmployeeSysId ','WHERE YEAR(CessationDate) > YEAR(TODAY(*)) OR (YEAR(CessationDate) = YEAR(TODAY(*)) AND MONTH(CessationDate) >= MONTH(TODAY(*)) OR CessationDate = ''18991230'') AND CPFProgCurrent=1 AND CPFMAWOption=0;');
end if;

if not exists(select 1 from UsageItem where UsageGrpID='StatutoryInfo' and UsageItemID='EECountOrdWageProj') then
insert into UsageItem values('EECountOrdWageProj','StatutoryInfo','Employee Count with Ordinary Wage Projection','Cessation Cut-Off Year','Cessation Cut-Off Period','','IntegerValue','SELECT CAST(YEAR(TODAY(*)) AS CHAR(4)) AS Key1, CAST(MONTH(TODAY(*)) AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(A.EmployeeSysId) AS RetValue FROM Employee A JOIN CPFProgression B ON A.EmployeeSysId=B.EmployeeSysId ','WHERE YEAR(CessationDate) > YEAR(TODAY(*)) OR (YEAR(CessationDate) = YEAR(TODAY(*)) AND MONTH(CessationDate) >= MONTH(TODAY(*)) OR CessationDate = ''18991230'') AND CPFProgCurrent=1 AND CPFMAWOption=1;');
end if;


commit work;