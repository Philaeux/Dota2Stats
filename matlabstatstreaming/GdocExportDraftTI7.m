function GdocExportDraftTI7()

if nargin==0
    load('basesqlti7.mat')
end

idspreadsheetdraft='1OOeZvh1kW3nQStcQh9-AxDgzCYbYbSqB2s23fSnE_Bs';
idsheet_Table_presence='0';
idsheet_Table_phase1='1988858422';
idsheet_Table_phase2='1316484535';
idsheet_Table_phase3='761933540';

table2sheet(idspreadsheetdraft,idsheet_Table_presence,BD_TI7_Table_presence);
table2sheet(idspreadsheetdraft,idsheet_Table_phase1,BD_TI7_Table_phase1);
table2sheet(idspreadsheetdraft,idsheet_Table_phase2,BD_TI7_Table_phase2);
table2sheet(idspreadsheetdraft,idsheet_Table_phase3,BD_TI7_Table_phase3);

end