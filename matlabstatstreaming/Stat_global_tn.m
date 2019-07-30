function Stat_global_tn(conn,match_valve)

%% init
stat_tn=table();

%% algo
if ~isempty(match_valve)
    stat_tn.nb_match=height(match_valve);
    [stat_tn]=genstat(match_valve,'radiant_win',stat_tn);
    [stat_tn]=genstat(match_valve,'duration',stat_tn);
end

%% insertion SQL
pgsqlexec(conn,'delete from grenouilleapi.public.stat_global_tn')
insert(conn,'grenouilleapi.public.stat_global_tn',{'nb_match','mean_radiant_win','max_radiant_win','min_radiant_win','tot_radiant_win','mean_duration','max_duration','min_duration','tot_duration'},stat_tn);


end

