function updateteam(conn,connftv,TktMatch)

teamtkt=unique([TktMatch.radiant_team_id(TktMatch.series_id~=0);TktMatch.dire_team_id(TktMatch.series_id~=0)]);
teaminfo=pgsqldata(conn,'select * from public.team');
teamsql=table();
if strcmp(teaminfo,'No Data')==1
    for i=1:length(teamtkt)
        teamodota=ApiGetTeamOpen(teamtkt(i));
        if isempty(teamodota)
            teamftv=pgsqldata(connftv,['SELECT name,tag,ingame_id FROM	ftv.team where ingame_id=',num2str(teamtkt(i))]);
            if strcmp(teamftv,'No Data')==1
                teamsqladd=table();
                teamsqladd.id=NaN;
                teamsqladd.team_id=teamtkt(i);
                teamsqladd.team_name{1,1}='null';
                teamsqladd.tag{1,1}='null';
                teamsqladd.wins=NaN;
                teamsqladd.losses=NaN;
            else
                teamsqladd=table();
                teamsqladd.id=NaN;
                teamsqladd.team_id=teamtkt(i);
                teamsqladd.team_name{1,1}=teamftv.name{1,1};
                teamsqladd.tag{1,1}=teamftv.tag{1,1};
                teamsqladd.wins=NaN;
                teamsqladd.losses=NaN;
            end
        else
            teamsqladd=table();
            teamsqladd.id=NaN;
            teamsqladd.team_id=teamodota.team_id;
            teamsqladd.team_name{1,1}=teamodota.name;
            teamsqladd.tag{1,1}=teamodota.tag;
            teamsqladd.wins=teamodota.wins;
            teamsqladd.losses=teamodota.losses;
        end
        teamsql=[teamsql;teamsqladd];
    end
    CBM_PGSQL_Transact_light(conn,'team',teamsql.Properties.VariableNames,teamsql,'id','public')
else
    [delta]=~ismember(teamtkt,teaminfo.team_id);
    if sum(delta)~=0 %toutes les equipe ne sont pas déjà en table
        listnewteam=teamtkt(delta==1);
        for i=1:length(listnewteam)
            teamodota=ApiGetTeamOpen(listnewteam(i));
            if isempty(teamodota)
                teamftv=pgsqldata(connftv,['SELECT name,tag,ingame_id FROM	ftv.team where ingame_id=',num2str(teamtkt(i))]);
                if strcmp(teamftv,'No Data')==1
                    teamsqladd=table();
                    teamsqladd.id=NaN;
                    teamsqladd.team_id=listnewteam(i);
                    teamsqladd.team_name{1,1}='null';
                    teamsqladd.tag{1,1}='null';
                    teamsqladd.wins=NaN;
                    teamsqladd.losses=NaN;
                else
                    teamsqladd=table();
                    teamsqladd.id=NaN;
                    teamsqladd.team_id=listnewteam(i);
                    teamsqladd.team_name{1,1}=teamftv.name{1,1};
                    teamsqladd.tag{1,1}=teamftv.tag{1,1};
                    teamsqladd.wins=NaN;
                    teamsqladd.losses=NaN;
                end
            else
                teamsqladd=table();
                teamsqladd.id=NaN;
                teamsqladd.team_id=teamodota.team_id;
                teamsqladd.team_name{1,1}=teamodota.name;
                teamsqladd.tag{1,1}=teamodota.tag;
                teamsqladd.wins=teamodota.wins;
                teamsqladd.losses=teamodota.losses;
            end
            teamsql=[teamsql;teamsqladd];
        end
        CBM_PGSQL_Transact_light(conn,'team',teamsql.Properties.VariableNames,teamsql,'id','public')
    end
end
