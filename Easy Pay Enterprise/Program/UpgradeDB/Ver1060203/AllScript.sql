UPDATE SubRegistry SET RegProperty7='Select CAST (MaritalStatusCode AS CHAR(20)) as A, MaritalStatusDesc as B from MaritalStatus union select ''???'', ''Wild Card'';'
WHERE RegistryID = 'LeaveRangeBasis' AND SubregistryID= 'MaritalStatus';

COMMIT WORK;