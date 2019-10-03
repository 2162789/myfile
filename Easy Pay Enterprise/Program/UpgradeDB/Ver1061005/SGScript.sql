if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'UOB (BIBPlus)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'UOB (BIBPlus)', 'RSingBankFormatUOBBIBPlus.dll', 'InvokeSalaryFormatter', 0);
  update BankSubmitFormat set StringField6 = 'SALA' where BankSubmitSubmitForId = 'Salary' and FormatName = 'UOB (BIBPlus)';
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'CitiBank (Business G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'CitiBank (Business G3)', 'RSingBankFormatCitibankBusinessG3.dll', 'InvokeSalaryFormatter', 0);
else
  update BankSubmitFormat set DllName = 'RSingBankFormatCitibankBusinessG3.dll' where BankSubmitSubmitForId = 'Salary' and FormatName = 'CitiBank (Business G3)';
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'CIMB (Giro G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'CIMB (Giro G3)', 'RSingBankFormatCIMBGiroG3.dll', 'InvokeSalaryFormatter', 0);
end if;

if exists (select 1 from sys.syscolumns where tname='BankBranch' and cname='BankBranchString1') then
  update BankBranch set BankBranchString1 = 'ABNASGSGXXX' where BankId = '7010' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BKKBSGSGXXX' where BankId = '7047' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BNINSGSGXXX' where BankId = '7056' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BOFASG2XXXX' where BankId = '7065' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BKCHSGSGXXX' where BankId = '7083' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BEASSGSGXXX' where BankId = '7092' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BKIDSGSGXXX' where BankId = '7108' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BSGPSGSGXXX' where BankId = '7117' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BOTKSGSXXXX' where BankId = '7126' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'CRLYSGSGXXX' where BankId = '7135' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'SCBLSGSGXXX' where BankId = '7144' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'CHASSGSGXXX' where BankId = '7153' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'DBSSSGSGXXX' where BankId = '7171' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'FAEASGSGXXX' where BankId = '7199' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'CITISGSGXXX' where BankId = '7214' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'HSBCSGSGXXX' where BankId = '7232' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'IDIBSGSGXXX' where BankId = '7241' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'IOBASGSGXXX' where BankId = '7250' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'HLBBSGSGXXX' where BankId = '7287' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'MBBESGSGXXX' where BankId = '7302' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'OCBCSGSGXXX' where BankId = '7339' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'UCBASGSGXXX' where BankId = '7357' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'RHBBSGSGXXX' where BankId = '7366' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'UOVBSGSGXXX' where BankId = '7375' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BNPASGSGXXX' where BankId = '7418' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'DEUTSGSGXXX' where BankId = '7463' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'SMBCSGSGXXX' where BankId = '7472' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'KOEXSGSGXXX' where BankId = '7490' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'MHCBSGSGXXX' where BankId = '7621' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'UBSWSGSGXXX' where BankId = '7685' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'DNBASGSGXXX' where BankId = '7737' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'FCBKSGSGXXX' where BankId = '7764' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'SBINSGSGXXX' where BankId = '7791' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'SOGESGSGXXX' where BankId = '7852' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'ANZBSGSXXXX' where BankId = '7931' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'CIBBSGSGXXX' where BankId = '7986' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'NATASGSGXXX' where BankId = '8077' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'STBCSGSGXXX' where BankId = '8101' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'BCITSGSGXXX' where BankId = '8350' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'RABOSGSGXXX' where BankId = '8439' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'MTBCSGSGXXX' where BankId = '8475' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'HANDSGSGXXX' where BankId = '8493' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'NDEASGSGXXX' where BankId = '8518' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'ESSESGSGXXX' where BankId = '8527' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'COBASGSXXXX' where BankId = '8606' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'ICBKSGSGXXX' where BankId = '8712' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'SOLASGSGXXX' where BankId = '8873' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'COMMSGSGXXX' where BankId = '8916' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'CRESSGSGXXX' where BankId = '9016' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'ICICSGSGXXX' where BankId = '9186' and ISNULL(BankBranchString1, '') = '';
  update BankBranch set BankBranchString1 = 'CTCBSGSGXXX' where BankId = '9353' and ISNULL(BankBranchString1, '') = '';
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'ABN & RBS (SAP/Global)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'ABN & RBS (SAP/Global)', 'RSingBankFormatABNRBSSAPGlobal.dll', 'InvokeSalaryFormatter', 0);
  update BankSubmitFormat set StringField4 = 'SALA' where BankSubmitSubmitForId = 'Salary' and FormatName = 'ABN & RBS (SAP/Global)';
end if;

commit work;