/* Update Description for fieldname - LongService to Non-monetary Awards */
UPDATE ImportFieldName Set FieldNameUserDefined = 'Non-monetary Awards' Where tablenamephysical = 'iA8ASection4' and fieldnamephysical = 'LongService';

commit work;