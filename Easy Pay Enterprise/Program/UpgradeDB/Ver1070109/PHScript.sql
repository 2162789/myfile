Update PhPrevEmployer Set PENonTax13MOthers = 0 Where PENonTax13MOthers is null;
Update PhPrevEmployer Set PENonTaxSalaryOthers= 0 Where PENonTaxSalaryOthers is null;
Update PhPrevEmployer Set PENonTaxSSSOthers = 0 Where PENonTaxSSSOthers is null;
Update PhPrevEmployer Set PETax13MOthers = 0 Where PETax13MOthers is null;
Update PhPrevEmployer Set PETaxSalaryOthers = 0 Where PETaxSalaryOthers is null;
Update PhPrevEmployer Set PEErTaxWithheld = 0 Where PEErTaxWithheld is null;
Update PhPrevEmployer Set PEBasicSalaryMWE = 0 Where PEBasicSalaryMWE is null;
Update PhPrevEmployer Set PEHolidayPayMWE = 0 Where PEHolidayPayMWE is null;
Update PhPrevEmployer Set PEOvertimeMWE = 0 Where PEOvertimeMWE is null;
Update PhPrevEmployer Set PENightShiftMWE = 0 Where PENightShiftMWE is null;
Update PhPrevEmployer Set PEHazardPayMWE = 0 Where PEHazardPayMWE is null;
Update PhPrevEmployer Set PETaxBasicSalary = 0 Where PETaxBasicSalary is null;
Update PhPrevEmployer Set PEDeMinimis = 0 Where PEDeMinimis is null;

commit work;