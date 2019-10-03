UPDATE  CPFTableComponent SET MaxCPFAge=75 WHERE CPFTableCodeId like 'EP13%' AND MaxCPFAge=99;

if  exists(SELECT * FROM KeyWord where keywordid='EPFReturn' ) then
   Update KeyWord set keyworduserdefinedname='EPF Return (Borang A)' where keywordid='EPFReturn';
end if;

commit work;