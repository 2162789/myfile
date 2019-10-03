/* Force all foreign worker SOCSO Progression to 2nd Category */
Update SOCSOProgression 
	JOIN PayEmployee ON PayEmployee.EmployeeSysId = SOCSOProgression.EmployeeSysId 
	JOIN Employee ON PayEmployee.EmployeeSysId = Employee.EmployeeSysId
	Set SOCSOProgSchemeId ='SOCSO2nd' 
	Where SOCSOEffectiveDate >= '2019-01-01' AND SOCSOProgPolicyId='SOCSOYr2019Jan' AND SOCSOProgSchemeId = 'SOCSO1st' 
	AND Employee.ResidenceStatus = 'FW';

commit work;