function matchsql=init_match(matchs,tn_id,conn)

rq_sql_tn=['select * from public.tn where id_tn=',num2str(tn_id)];
tninfo=pgsqldata(conn,rq_sql_tn);
matchsql=table();
matchsql.id(1:height(matchs),1)=NaN;
matchsql.match_id=matchs.match_id;
start_time=datetime(matchs.start_time,'ConvertFrom','posixtime');
patchdate=pgsqldata(conn,'select * from public.patch order by patchdate desc');
for i=1:height(matchsql)
    matchdate=start_time(i);
    matchspacer=table();
    matchspacer.id=patchdate.id;
    matchspacer.patchnum=patchdate.patchnum;
    matchspacer.delta=days(matchdate-patchdate.patchdate);
    matchsql.patch_id(i,1)=matchspacer.id(matchspacer.delta==min(matchspacer.delta(matchspacer.delta>0)));
    matchsql.patch_num(i,1)=matchspacer.patchnum(matchspacer.delta==min(matchspacer.delta(matchspacer.delta>0)));
    if tninfo.withqualif==1
        if matchdate>tninfo.qualifend
            matchsql.is_qualif(i,1)=0;
        else
            matchsql.is_qualif(i,1)=1;
        end
    else
        matchsql.is_qualif(i,1)=0;
    end
end
matchsql.start_time(:,1)=start_time;
matchsql.id_tn(:,1)=tn_id;
matchsql.series_id(:,1)=matchs.series_id;
matchsql.radiant_team_id(:,1)=matchs.radiant_team_id;
matchsql.dire_team_id(:,1)=matchs.dire_team_id;
matchsql=matchsql(matchsql.series_id~=0,:);
end %function