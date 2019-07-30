function GdocExportDraft(Tournois,Player,Team,StatMatch,ContextMatch,StatMatchPlayer,StatPlayerTN,StatHeroPlayerTN,StatPlayer,StatHeroPlayer...
    ,Table_presence,Table_phase1,Table_phase2,Table_phase3,Table_presenceTN,Table_phase1TN,Table_phase2TN,Table_phase3TN)

if nargin==0
    load('sea.mat')
end

idspreadsheetdraft='1d0ZVyYcSloTvonh8P8Rhdd8gXb_JXTj-5tII3He6t_8';
idsheet_Tournois='1638108071';
idsheet_Player='2067926555';
idsheet_Team='1770984999';
idsheet_ContextMatch='2085581849';
idsheet_Table_presence='978247233';
idsheet_Table_phase1='742425865';
idsheet_Table_phase2='1319711077';
idsheet_Table_phase3='845895955';
idsheet_Table_presenceTN='1760027136';
idsheet_Table_phase1TN='144694983';
idsheet_Table_phase2TN='1750504520';
idsheet_Table_phase3TN='389340103';

ContextMatch.start_time=datestr(ContextMatch.start_time(:,1));
ContextMatch.tn_name(:,1)=ContextMatch.tn_name{:,1};

table2sheet(idspreadsheetdraft,idsheet_ContextMatch,ContextMatch);
table2sheet(idspreadsheetdraft,idsheet_Tournois,Tournois);
table2sheet(idspreadsheetdraft,idsheet_Player,Player);
table2sheet(idspreadsheetdraft,idsheet_Team,Team);
table2sheet(idspreadsheetdraft,idsheet_Table_presence,Table_presence);
table2sheet(idspreadsheetdraft,idsheet_Table_phase1,Table_phase1);
table2sheet(idspreadsheetdraft,idsheet_Table_phase2,Table_phase2);
table2sheet(idspreadsheetdraft,idsheet_Table_phase3,Table_phase3);
table2sheet(idspreadsheetdraft,idsheet_Table_presenceTN,Table_presenceTN);
table2sheet(idspreadsheetdraft,idsheet_Table_phase1TN,Table_phase1TN);
table2sheet(idspreadsheetdraft,idsheet_Table_phase2TN,Table_phase2TN);
table2sheet(idspreadsheetdraft,idsheet_Table_phase3TN,Table_phase3TN);

end