If not exists (select * from formulaproperty where formulaid='Std 1.00 Day Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 1.00 Day Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 1.00 HR Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 1.00 HR Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 1.50 Day Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 1.50 Day Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 1.50 HR Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 1.50 HR Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 10.00 Fix Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 10.00 Fix Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 15.00 Fix Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 15.00 Fix Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 2.00 Day Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 2.00 Day Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 2.00 HR Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 2.00 HR Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 2.50 Day Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 2.50 Day Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 2.50 HR Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 2.50 HR Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 3.00 Day Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 3.00 Day Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 3.00 HR Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 3.00 HR Rate','TaxOneTimeProjCode');
End if;

If not exists (select * from formulaproperty where formulaid='Std 5.00 Fix Rate' and keywordid='TaxOneTimeProjCode') then
Insert into formulaproperty (formulaid,keywordid)Values('Std 5.00 Fix Rate','TaxOneTimeProjCode');
End if;


commit work;