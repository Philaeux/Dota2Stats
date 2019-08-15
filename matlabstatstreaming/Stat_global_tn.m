function Stat_global_tn(conn)
disp('Traitement des stats patch Tournois')
match_valve=pgsqldata(conn,'select * from public.join_valvematch');
%% algo
CalcStatTeam=match_valve;
stat_tn_add=table();
if ~isempty(match_valve)
    stat_tn_add.id=NaN;
    stat_tn_add.nb_match=height(CalcStatTeam);
    [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
    [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
end
%% insertion SQL
%% insertion SQL StatPlayer
rqexist='select id from public.stat_global_tn';
exist1=pgsqldata(conn,rqexist);
if strcmp(exist1,'No Data')==0
    pgsqlexec(conn,'delete from public.stat_global_tn')
end
CBM_PGSQL_Transact_light(conn,'stat_global_tn',stat_tn_add.Properties.VariableNames,stat_tn_add,'id','public');

disp('Traitement OK')
end

