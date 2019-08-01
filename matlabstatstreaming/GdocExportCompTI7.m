function GdocExportCompTI7()

if nargin==0
    load('basesqlti7.mat')
end

idspreadsheetdraft='1ApmWWCcZPLZiiEEXoANe9Thpj50d-49FWZjjDjJ3Ews';
idsheet_Table_CompHero='0';
idsheet_Table_CompPlayer='423161965';
idsheet_Table_CompTeam='381849000';
idsheet_Table_CompStatHero='178356673';
idsheet_Table_CompStatPlayer='68771022';
idsheet_Table_CompStatTeam='1668087401';

table2sheet(idspreadsheetdraft,idsheet_Table_CompHero,BD_TI7_CompHeros);
table2sheet(idspreadsheetdraft,idsheet_Table_CompPlayer,BD_TI7_CompPlayer);
table2sheet(idspreadsheetdraft,idsheet_Table_CompTeam,BD_TI7_CompTeam);
table2sheet(idspreadsheetdraft,idsheet_Table_CompStatHero,BD_TI7_CompHeroStat);
table2sheet(idspreadsheetdraft,idsheet_Table_CompStatPlayer,BD_TI7_CompPlayerStat);
table2sheet(idspreadsheetdraft,idsheet_Table_CompStatTeam,BD_TI7_CompTeamStat);

end