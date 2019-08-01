function GdocExportHerosRecordTI7()

if nargin==0
    load('basesqlti7.mat')
end

idspreadsheetdraft='19Swa5xiAtOjLEp0ShzV8TgCuLQUxAV1ApabWFGrw1oA';
idsheet_Table_herorecord='0';

table2sheet(idspreadsheetdraft,idsheet_Table_herorecord,BD_TI7_StatHeros);
%table2sheet(idspreadsheetdraft,idsheet_Table_metarecord,BD_TI7_MetaRecord);
%table2sheet(idspreadsheetdraft,idsheet_Table_ti7record,BD_TI7_Table_phase2);

end