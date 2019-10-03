UPDATE AccpacExportLog SET APVersion = '55A' WHERE APVersion IS NULL OR APVersion = '';

commit work;