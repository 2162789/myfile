if exists (select * from BankSubmitFormat where FormatName = 'Credit Agricole OPTIM') then 
    delete from BankSubmitFormat where formatname = 'Credit Agricole OPTIM';
end if ;
commit work;