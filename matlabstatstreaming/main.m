function main()

tn_id=10810;

%% Set preferences
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');
setdbprefs('DataReturnFormat','table');

%% Make connection to database
conn = database('ShiBaSQL','shiba','FTShiBa26');

%% Debug mod
% pgsqlexec(conn,'DELETE from shiba.public.matchs')
% pgsqlexec(conn,'DELETE from shiba.public.valvematch')
% pgsqlexec(conn,'DELETE from shiba.public.valveplayermatch')
% pgsqlexec(conn,'DELETE from shiba.public.openmatch')
% pgsqlexec(conn,'DELETE from shiba.public.openplayermatch')
% pgsqlexec(conn,'DELETE from shiba.public.execmatch')

%% Récupération de la liste des tournois en base
% rq_sql_tn=['select * from shiba.public.tn where id_tn=',num2str(tn_id)];
% sql_tn=pgsqldata(conn,rq_sql_tn);
% if strcmp(sql_tn,'No Data')==1
%     disp('id tournois inconnue')
%     tn_name = input('nom du tournoi : ','s');
%     tn=table();
%     tn.id_tn=tn_id;
%     tn.name_tn=tn_name;
%     insert(conn,'shiba.public.tn',{'id_tn','name_tn'},tn);
% else
%     disp('Tournois déjà existant...')
% end
% 
% % API VALVE : information ticket
% TktMatch=TktInfo_ApiGetValve(tn_id);
% matchs=table([TktMatch.result.matches.series_id].', [TktMatch.result.matches.match_id].', [TktMatch.result.matches.start_time].', [TktMatch.result.matches.radiant_team_id].',...
%     [TktMatch.result.matches.dire_team_id].', 'VariableNames', {'series_id', 'match_id', 'start_time', 'radiant_team_id', 'dire_team_id'});
% matchs.id_tn(:,1)=tn_id;
% 
% % Recup match déjà en base
% rq_sql_match=['select * from shiba.public.matchs where id_tn=',num2str(tn_id)];
% sql_match=pgsqldata(conn,rq_sql_match);
% 
% % Insertion des match du ticket en base
% if strcmp(sql_match,'No Data')==1
%     insert(conn,'shiba.public.matchs',{'series_id','match_id','start_time','radiant_team_id','dire_team_id','id_tn'},matchs);
%     execmatch=table();
%     execmatch.match_id=matchs.match_id;
%     execmatch.execdraft(:,1)=0;
%     execmatch.execplayer(:,1)=0;
%     execmatch.execteam(:,1)=0;
%     execmatch.execherostat(:,1)=0;
%     execmatch.execplayerstat(:,1)=0;
%     execmatch.execteamstat(:,1)=0;
%     execmatch.exectn(:,1)=0;
%     execmatch.execcomp(:,1)=0;
%     execmatch.execvalveplayer(:,1)=0;
%     execmatch.execvalvepicks(:,1)=0;
%     execmatch.execopenpicks(:,1)=0;
%     execmatch.execopenplayer(:,1)=0;
%     insert(conn,'shiba.public.execmatch',{'match_id','execdraft','execplayer','execteam','execherostat','execplayerstat','execteamstat','exectn','execcomp',...
%         'execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatch);
%     newmatch=matchs;
% else
%     newmatch=setxor(matchs,sql_match);
%     if isempty(newmatch)
%         disp('pas de nouveau match a ajouter')
%     else
%         insert(conn,'shiba.public.matchs',{'series_id','match_id','start_time','radiant_team_id','dire_team_id','id_tn'},newmatch);
%         execmatch=table();
%         execmatch.match_id=newmatch.match_id;
%         execmatch.execdraft(:,1)=0;
%         execmatch.execplayer(:,1)=0;
%         execmatch.execteam(:,1)=0;
%         execmatch.execherostat(:,1)=0;
%         execmatch.execplayerstat(:,1)=0;
%         execmatch.execteamstat(:,1)=0;
%         execmatch.exectn(:,1)=0;
%         execmatch.execcomp(:,1)=0;
%         execmatch.execvalveplayer(:,1)=0;
%         execmatch.execvalvepicks(:,1)=0;
%         execmatch.execopenpicks(:,1)=0;
%         execmatch.execopenplayer(:,1)=0;
%         insert(conn,'shiba.public.execmatch',{'match_id','execdraft','execplayer','execteam','execherostat','execplayerstat','execteamstat','exectn','execcomp',...
%             'execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatch);
%     end
% end
% 
% for i=1:height(newmatch)
%     % Recupération des info match source valve
%     datavalve=ApiGetValve(newmatch.match_id(i));
%     execvalve(datavalve,conn,execmatch);
%     
%     % Récupération des info match source opendota
%     dataod=ApiGetStatOpen(newmatch.match_id(i));
%     execopen(dataod,conn,execmatch);
%     % Dispatch en base
%     test=1;
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% algo de fusion
%% Récupération des informations en base
player_match_open=pgsqldata(conn,'select * from shiba.public.openplayermatch');
match_open=pgsqldata(conn,'select * from shiba.public.openmatch');
player_match_valve=pgsqldata(conn,'select * from shiba.public.valveplayermatch');
match_valve=pgsqldata(conn,'select * from shiba.public.valvematch');
%match=pgsqldata(conn,'select * from shiba.public.matchs');
%tn=pgsqldata(conn,'select * from shiba.public.tn');
%team=pgsqldata(conn,'select * from shiba.public.team');
%player=pgsqldata(conn,'select * from shiba.public.player');
hero=pgsqldata(conn,'select * from shiba.public.hero');

%% stat global player sur les 4 derniers tournois
Stat_global_player(conn,player_match_open)
Stat_global_team(conn,match_valve)
Stat_global_hero(conn,hero,player_match_valve,match_valve)
Stat_global_tn(conn,match_valve)
Stat_tn_player(conn,match_open)
Stat_tn_team(conn,match_valve)
Stat_tn_hero(conn,hero,player_match_valve,match_valve)
Stat_tn_tn(conn,match_valve)


close(conn)
clear prefs conn
