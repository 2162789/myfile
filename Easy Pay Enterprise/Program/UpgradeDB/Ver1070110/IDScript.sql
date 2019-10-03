/*Show/Hide Menu */

if  exists (select 1 from KeyWord where KeyWordId = 'Final(1721-III)') then
   Update KeyWord set KeyWordUserDefinedName='Bukti Potong Final CSV' where KeyWordId = 'Final(1721-III)';
end if;

if  exists (select 1 from KeyWord where KeyWordId = 'TidakFinal(1721-II)') then
   Update KeyWord set KeyWordUserDefinedName='Bukti Potong Tidak Final CSV' where KeyWordId = 'TidakFinal(1721-II)';
end if;

/*Module Screen*/


if  exists (select 1 from ModuleScreenGroup where MODULESCREENID='PayTax1721FinalCSV') then
   Update ModuleScreenGroup set MODULESCREENNAME='Bukti Potong Final CSV' where MODULESCREENID = 'PayTax1721FinalCSV';
end if;

if  exists (select 1 from ModuleScreenGroup where MODULESCREENID='PayTax1721TidakFinal') then
   Update ModuleScreenGroup set MODULESCREENNAME='Bukti Potong Tidak Final CSV' where MODULESCREENID = 'PayTax1721TidakFinal';
end if;


commit work;
