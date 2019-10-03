READ UpgradeDB\Ver1060201\MY_StoredProc.sql;
READ UpgradeDB\Ver1060201\MY_Tax2012.sql;


/* Update MalTaxDetails */
Update MalTaxDetails Set IsHandicapped = 0 Where IsHandicapped is null;
Update MalTaxDetails Set MalTaxScheme = 'Resident' Where MalTaxScheme is null;


Commit Work;