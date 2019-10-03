if not exists(select * from WageProperty where KeyWordId = 'BasicRateFull' and WageId = 'PHICWage') then
    insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
    values('BasicRateFull','PHICWage',0);
end if;

commit work;