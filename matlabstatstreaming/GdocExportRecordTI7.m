function GdocExportRecordTI7()

if nargin==0
    load('basesqlti7.mat')
end

idspreadsheetdraft='1vG96rQjrDvHv2J9WLxVLgafcTmaQdi-L0Zhhh443FHo';
idsheet_Table_playerrecord='0';
idsheet_Table_metarecord='161773958';
idsheet_Table_ti7record='1316484535';


table2sheet(idspreadsheetdraft,idsheet_Table_playerrecord,BD_TI7_PlayerRecords);
table2sheet(idspreadsheetdraft,idsheet_Table_metarecord,BD_TI7_MetaRecord);
%table2sheet(idspreadsheetdraft,idsheet_Table_ti7record,BD_TI7_Table_phase2);

end