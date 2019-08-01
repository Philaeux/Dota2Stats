function matchsql=init_match(TktMatch,tn_id,conn)
matchsql=table();
matchs=table([TktMatch.result.matches.series_id].', [TktMatch.result.matches.match_id].', [TktMatch.result.matches.start_time].', [TktMatch.result.matches.radiant_team_id].',...
    [TktMatch.result.matches.dire_team_id].', 'VariableNames', {'series_id', 'match_id', 'start_time', 'radiant_team_id', 'dire_team_id'});
matchsql.id(1:height(matchs),1)=NaN;
matchsql.match_id=[TktMatch.result.matches.match_id].';
start_time=datetime([TktMatch.result.matches.start_time].','ConvertFrom','posixtime');
patchdate=pgsqldata(conn,'select * from public.patch order by patchdate desc');
for i=1:height(matchsql)
    matchdate=start_time(i);
    matchspacer=table();
    matchspacer.id=patchdate.id;
    matchspacer.patchnum=patchdate.patchnum;
    matchspacer.delta=days(matchdate-patchdate.patchdate);
    matchsql.patch_id(i,1)=matchspacer.id(matchspacer.delta==min(matchspacer.delta(matchspacer.delta>0)));
    matchsql.patch_num(i,1)=matchspacer.patchnum(matchspacer.delta==min(matchspacer.delta(matchspacer.delta>0)));
end
matchsql.start_time(:,1)=start_time;
matchsql.id_tn(:,1)=tn_id;
matchsql.series_id(:,1)=matchs.series_id;
matchsql.radiant_team_id(:,1)=matchs.radiant_team_id;
matchsql.dire_team_id(:,1)=matchs.dire_team_id;
end %function