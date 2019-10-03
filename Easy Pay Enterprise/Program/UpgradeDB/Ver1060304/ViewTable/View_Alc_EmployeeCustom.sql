IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeCustom') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeCustom";
END IF;


CREATE VIEW "DBA"."View_Alc_EmployeeCustom" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, Employee.CustBoolean1 AS CustBoolean1
, Employee.CustBoolean2 AS CustBoolean2
, Employee.CustBoolean3 AS CustBoolean3
, Employee.CustDate1 AS CustDate1
, Employee.CustDate2 AS CustDate2
, Employee.CustDate3 AS CustDate3
, Employee.CustInteger1 AS CustInteger1
, Employee.CustInteger2 AS CustInteger2
, Employee.CustInteger3 AS CustInteger3
, Employee.CustNumeric1 AS CustNumeric1
, Employee.CustNumeric2 AS CustNumeric2
, Employee.CustNumeric3 AS CustNumeric3
, Employee.CustString1 AS CustString1
, Employee.CustString2 AS CustString2
, Employee.CustString3 AS CustString3
, Employee.CustString4 AS CustString4
, Employee.CustString5 AS CustString5
 FROM Employee