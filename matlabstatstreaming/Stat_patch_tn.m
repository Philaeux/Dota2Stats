function Stat_patch_tn(conn)
disp('Traitement des stats patch Tournois')
patch=pgsqldata(conn,'select * from public.patch');
patchnum=max(patch.patchnum);
match_valve=pgsqldata(conn,'select * from public.join_valvematch');
%% algo
CalcStatTeam=match_valve(match_valve.patch_num==patchnum,:);
stat_tn_add=table();
if ~isempty(match_valve)
    stat_tn_add.id=NaN;
    stat_tn_add.patch_num=patchnum;
    stat_tn_add.nb_match=height(CalcStatTeam);
    [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
    [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
end
%% insertion SQL
%% insertion SQL StatPlayer
rqexist=['select id from public.stat_patch_tn where patch_num=',num2str(patchnum)];
exist1=pgsqldata(conn,rqexist);
if strcmp(exist1,'No Data')==0
    pgsqlexec(conn,['delete from public.stat_patch_tn where patch_num=',num2str(patchnum)])
end
CBM_PGSQL_Transact_light(conn,'stat_patch_tn',stat_tn_add.Properties.VariableNames,stat_tn_add,'id','public');

disp('Traitement OK')
end

