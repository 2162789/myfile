if exists(select * from sys.sysprocedure where proc_name = 'InsertNewEmpCertification') then
   drop procedure InsertNewEmpCertification
end if;
CREATE PROCEDURE "DBA"."InsertNewEmpCertification"(
In In_EmployeeSysId integer,
In In_CertificationType char(20),
In In_CertificationNo char(20),
In In_CertificationDate date,
In In_Year integer,
In In_Month integer,
out In_EmpCertificationSysId integer
)
BEGIN
	Insert Into EmpCertification(
    EmployeeSysId,
    CertificationType,
    CertificationNo,
    CertificationDate,
    Year,
    Month)
    Values(
    In_EmployeeSysId,
    In_CertificationType,
    In_CertificationNo,
    In_CertificationDate,
    In_Year,
    In_Month);
     
    select Max(EmpCertificationSysId) into In_EmpCertificationSysId from EmpCertification;
END
;

commit work;