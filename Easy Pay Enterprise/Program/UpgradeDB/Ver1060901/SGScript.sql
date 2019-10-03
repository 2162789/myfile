if not exists(select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'BOA (GPS)') then
   insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised)
   values('Salary','BOA (GPS)','RSingBankFormatBOAGPS.dll','InvokeSalaryFormatter',0);
end if;

update LabSurveySetup set QueryCondition = 'employee.employeesysid in (select first employeesysid from employee as em where em.PersonalSysId = employee.personalSysId and (hiredate >= [QStartDate] and hiredate <= [QEndDate]) order by em.hiredate desc) and employee.personalsysid not in (select personalsysid from employee as emp where emp.personalsysid = employee.personalsysid and (cessationdate = ''1899-12-30'' or cessationdate >= [QStartDate]) and (hiredate < [QStartDate]))'
where LabSurveySetupId <= 20 and LabSurveySetupId >= 13;

commit work;