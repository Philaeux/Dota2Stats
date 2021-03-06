function init_player(conn,playerinput,match_id)

%% list player
if isa(playerinput,'struct')
    player=struct2table(playerinput);
else
    player=table();
    for i=1:10
        playeradd=table();
        playeradd.account_id=playerinput{i,1}.account_id;
        playeradd.player_slot=playerinput{i,1}.player_slot;
        player=[player;playeradd];
    end
end

listplayer=player.account_id(:,1);
listsqlplayer=pgsqldata(conn,'select player_id from public.player');

if strcmp(listsqlplayer,'No Data')==1
    playersql=table();
    team_id=pgsqldata(conn,['select radiant_team_id,dire_team_id from public.matchs where match_id=',num2str(match_id)]);
    for i=1:length(listplayer)
        playersqladd=table();
        playersqladd.id=NaN;
        playersqladd.player_id=listplayer(i);
        playerinfo=ApiGetPlayerOpen(listplayer(i));
        if isfield(playerinfo.profile,'name')
            playersqladd.player_name{1,1}=playerinfo.profile.name;
        else
            playersqladd.player_name{1,1}=playerinfo.profile.personaname;
        end
        if isfield(playerinfo.profile,'name')
            if ~isempty(playerinfo.profile.name)
                playersqladd.player_name{1,1}=playerinfo.profile.name;
            else
                if ~isempty(playerinfo.profile.personaname)
                    playersqladd.player_name{1,1}=playerinfo.profile.personaname;
                else
                    playersqladd.player_name{1,1}='null';
                end
            end
        else
            playersqladd.player_name{1,1}=playerinfo.profile.personaname;
        end
        playersql=[playersql;playersqladd];
    end
    CBM_PGSQL_Transact_light(conn,'player',playersql.Properties.VariableNames,playersql,'id','public')
else
    listplayeradd=listplayer(ismember(listplayer,listsqlplayer.player_id)==0);
    listplayercheck=listplayer(ismember(listplayer,listsqlplayer.player_id)==1);
    if ~isempty(listplayeradd)
        playersql=table();
        team_id=pgsqldata(conn,['select radiant_team_id,dire_team_id from public.matchs where match_id=',num2str(match_id)]);
        for i=1:length(listplayeradd)
            playersqladd=table();
            playersqladd.id=NaN;
            playersqladd.player_id=listplayeradd(i);
            playerinfo=ApiGetPlayerOpen(listplayeradd(i));
            if isfield(playerinfo.profile,'name')
                if ~isempty(playerinfo.profile.name)
                    playersqladd.player_name{1,1}=playerinfo.profile.name;
                else
                    if ~isempty(playerinfo.profile.personaname)
                        playersqladd.player_name{1,1}=playerinfo.profile.personaname;
                    else
                        playersqladd.player_name{1,1}='null';
                    end
                end
            else
                playersqladd.player_name{1,1}=playerinfo.profile.personaname;
            end
            if player.player_slot(i,1)<100
                playersqladd.team_id=team_id.radiant_team_id;
            else
                playersqladd.team_id=team_id.dire_team_id;
            end
            playersql=[playersql;playersqladd];
        end
        CBM_PGSQL_Transact_light(conn,'player',playersql.Properties.VariableNames,playersql,'id','public')
    else
        team_id=pgsqldata(conn,['select radiant_team_id,dire_team_id from public.matchs where match_id=',num2str(match_id)]);
        for i=1:length(listplayercheck)
            teamsql=pgsqldata(conn,['select team_id from public.player where player_id=',num2str(listplayercheck(i))]);
            if player.player_slot(player.account_id==listplayercheck(i))<100
                if teamsql.team_id~=team_id.radiant_team_id
                    pgsqlexec(conn,['update public.player set team_id=''',num2str(team_id.radiant_team_id),''' where player_id=',num2str(listplayercheck(i))]);
                end
            else
                if teamsql.team_id~=team_id.dire_team_id
                    pgsqlexec(conn,['update public.player set team_id=''',num2str(team_id.dire_team_id),''' where player_id=',num2str(listplayercheck(i))]);
                end
            end
        end
    end
end
end