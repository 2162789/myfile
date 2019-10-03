UPDATE UsageItem SET Query ='SELECT CAST(PayRecYear AS CHAR(4)) AS Key1, CAST(PayRecPeriod AS CHAR(2)) AS Key2, '''' AS Key3, NULL AS ModDateTime, COUNT(EmployeeSysID) AS RetValue FROM PayPeriodRecord GROUP BY PayRecYear, PayRecPeriod HAVING PayRecYear =(SELECT FIRST PayRecYear ',
QueryCond = 'FROM PayPeriodRecord Order By PayRecYear DESC,PayRecPeriod DESC) AND PayRecPeriod =(SELECT FIRST PayRecPeriod FROM PayPeriodRecord Order By PayRecYear DESC,PayRecPeriod DESC);'
WHERE  UsageItemID = 'PayRecordCount';

COMMIT WORK;

