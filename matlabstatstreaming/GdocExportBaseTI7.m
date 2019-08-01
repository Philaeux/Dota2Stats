function GdocExportBaseTI7()

if nargin==0
    load('basesqlti7.mat')
end

idspreadsheetdraft='1DOPR5MhZpNAdgnDo3YaJfNaHqkbYWWENlTZyhO1peqw';
idsheet_Team='0';
idsheet_Player='473444461';
idsheet_ContextMatch='615992634';
idsheet_StatMatch='1927066666';
idsheet_StatMatchPlayer='1477107359';
idsheet_StatHerosPlayer='1717167645';
idsheet_Hero='1115319563';

BD_TI7_ContextMatch.start_time=datestr(BD_TI7_ContextMatch.start_time(:,1));
BD_TI7_ContextMatch.tn_name(:,1)=BD_TI7_ContextMatch.tn_name{:,1};

BD_TI7_StatMatch.tn_name(:,1)=BD_TI7_StatMatch.tn_name{:,1};
BD_TI7_StatMatchPlayer.tn_name(:,1)=BD_TI7_StatMatchPlayer.tn_name{:,1};



table2sheet(idspreadsheetdraft,idsheet_Team,BD_TI7_Team);
table2sheet(idspreadsheetdraft,idsheet_Player,BD_TI7_Player);
table2sheet(idspreadsheetdraft,idsheet_ContextMatch,BD_TI7_ContextMatch);
table2sheet(idspreadsheetdraft,idsheet_StatMatch,BD_TI7_StatMatch);
table2sheet(idspreadsheetdraft,idsheet_StatMatchPlayer,BD_TI7_StatMatchPlayer);
table2sheet(idspreadsheetdraft,idsheet_StatHerosPlayer,BD_TI7_StatHeroPlayer);
table2sheet(idspreadsheetdraft,idsheet_Hero,BD_TI7_Hero);

end