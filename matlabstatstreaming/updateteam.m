function updateteam(conn,TktMatch)

series_id = [TktMatch.result.matches.series_id].';
radiant_team_id = [TktMatch.result.matches.radiant_team_id].';
dire_team_id = [TktMatch.result.matches.dire_team_id].';
teamtkt=unique([radiant_team_id(series_id~=0);dire_team_id(series_id~=0)]);
teaminfo=pgsqldata(conn,'select * from public.team');
teamsql=table();
if strcmp(teaminfo,'No Data')==1
    for i=1:length(listteam)
        teamodota=ApiGetTeamOpen(listteam(i));
        teamsqladd=table();
        teamsqladd.id=NaN;
        teamsqladd.team_id=teamodota.team_id;
        teamsqladd.team_name{1,1}=teamodota.name;
        teamsqladd.tag{1,1}=teamodota.tag;
        teamsqladd.wins=teamodota.wins;
        teamsqladd.losses=teamodota.losses;
        teamsql=[teamsql;teamsqladd];
    end
    CBM_PGSQL_Transact_light(conn,'team',teamsql.Properties.VariableNames,teamsql,'id','public')
else
    [delta]=~ismember(teamtkt,teaminfo.team_id);
    if sum(delta)~=0 %toutes les equipe ne sont pas déjà en table
        listnewteam=teamtkt(delta==1);
        for i=1:length(listnewteam)
            teamodota=ApiGetTeamOpen(listnewteam(i));
            teamsqladd=table();
            teamsqladd.id=NaN;
            teamsqladd.team_id=teamodota.team_id;
            teamsqladd.team_name{1,1}=teamodota.name;
            teamsqladd.tag{1,1}=teamodota.tag;
            teamsqladd.wins=teamodota.wins;
            teamsqladd.losses=teamodota.losses;
            teamsql=[teamsql;teamsqladd];
        end
        CBM_PGSQL_Transact_light(conn,'team',teamsql.Properties.VariableNames,teamsql,'id','public')
    end
end
