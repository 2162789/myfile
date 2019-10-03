/* Update Max Salary to 999999999 instead of 999999 */
Update CPFTableComponent Set MaxSalary = 999999999 Where CPFTableCodeId = 'PHIC14' And MinSalary = 35000 And MinCPFAge = 0 And MaxSalary = 999999;
Update CPFTableComponent Set MaxSalary = 999999999 Where CPFTableCodeId = 'SSS14' And MinSalary = 15750 And MinCPFAge = 0 And MaxSalary = 999999;;
Update CPFTableComponent Set MaxSalary = 999999999 Where CPFTableCodeId = 'HDMF05' And MinSalary = 5001 And MinCPFAge = 0 And MaxSalary = 999999;;

commit work;