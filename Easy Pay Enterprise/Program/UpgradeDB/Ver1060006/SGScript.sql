Update YEKeyword Set YEProperty1 = 'A' where YEKeyWordId = 'Self';
Update YEKeyword Set YEProperty1 = 'B' where YEKeyWordId = 'Children8-20';
Update YEKeyword Set YEProperty1 = 'C' where YEKeyWordId = 'Children3-7';
Update YEKeyword Set YEProperty1 = 'D' where YEKeyWordId = 'Children<3';
Update YEKeyword Set YEProperty1 = 'E',YEKeyWordDefaultName = 'Add:2% x (Basic salary p.a. x period provided/365)',YEKeyWordUserDefinedName ='Add:2% x (Basic salary p.a. x period provided/365)' where YEKeyWordId = 'plus2%';

Commit Work;