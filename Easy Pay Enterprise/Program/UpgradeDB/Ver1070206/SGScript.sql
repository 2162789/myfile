// Labour Market Survey
update LabSurveySetup set QueryCondition = '(cessationdate = ''1899-12-30'' or cessationdate >= dateadd(dd, -1, [QStartDate])) and (hiredate < [QStartDate])' where LabSurveySetupId between 1 and 12;

update LabSurveySetup set QueryCondition = 'employee.employeesysid in (select first employeesysid from employee as em where em.PersonalSysId = employee.personalSysId and (hiredate >= [QStartDate] and hiredate <= [QEndDate]) order by em.hiredate desc) and employee.personalsysid not in (select personalsysid from employee as emp where emp.personalsysid = employee.personalsysid and (cessationdate = ''1899-12-30'' or cessationdate >= dateadd(dd, -1, [QStartDate])) and (hiredate < [QStartDate]))' where LabSurveySetupId between 13 and 20;

update LabSurveySetup set QueryCondition = '(cessationdate >= dateadd(dd, -1, [QStartDate]) and cessationdate < [QEndDate]) and employee.employeesysid in (select first employeesysid from employee as em where em.PersonalSysId = employee.personalSysId and hiredate <= [QEndDate] order by em.hiredate desc)' where LabSurveySetupId between 21 and 100;

update LabSurveySetup set QueryCondition = '(cessationdate = ''1899-12-30'' or cessationdate >= [QEndDate]) and (hiredate <= [QEndDate])' where LabSurveySetupId between 101 and 114;

commit work;