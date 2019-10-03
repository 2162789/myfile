Update Keyword set KeywordSubproperty=1 where keywordID Not in('SPTMasaRpt','IncomeTaxReports')
and KeywordCategory in('Reports','Submissions');

commit work;