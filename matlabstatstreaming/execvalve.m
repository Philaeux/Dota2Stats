function execmatch=execvalve(datavalve,conn,execmatch)

try
    %% vérification des info team
    teamdatar=table();
    teamdatad=table();
    teamdatar.team_id=datavalve.result.radiant_team_id;
    teamdatad.team_id=datavalve.result.dire_team_id;
    teamdatar.team_name{1,1}=datavalve.result.radiant_name;
    teamdatad.team_name{1,1}=datavalve.result.dire_name;
    
    disp(['Traitement api.valve de ',datavalve.result.radiant_name,' vs ',datavalve.result.dire_name])
    
    rq_sql_teamr=['select * from grenouilleapi.public.team where team_id=',num2str(teamdatar.team_id)];
    rq_sql_teamd=['select * from grenouilleapi.public.team where team_id=',num2str(teamdatad.team_id)];
    sql_teamr=pgsqldata(conn,rq_sql_teamr);
    sql_teamd=pgsqldata(conn,rq_sql_teamd);
    if strcmp(sql_teamr,'No Data')==1
        insert(conn,'grenouilleapi.public.team',{'team_id','team_name'},teamdatar);
    end
    if strcmp(sql_teamd,'No Data')==1
        insert(conn,'grenouilleapi.public.team',{'team_id','team_name'},teamdatad);
    end
    
    %% info ticket valve
    
    switch class(datavalve.result.players(1,1))
        case 'cell'
            players=table();
            for i=1:10
                if length(fieldnames(datavalve.result.players{1,1}))==21
                    playersadd=table;
                    playersadd.account_id=datavalve.result.players{i,1}.account_id;
                    playersadd.player_slot=datavalve.result.players{i,1}.player_slot;
                    playersadd.hero_id=datavalve.result.players{i,1}.hero_id;
                    playersadd.item_0=datavalve.result.players{i,1}.item_0;
                    playersadd.item_1=datavalve.result.players{i,1}.item_1;
                    playersadd.item_2=datavalve.result.players{i,1}.item_2;
                    playersadd.item_3=datavalve.result.players{i,1}.item_3;
                    playersadd.item_4=datavalve.result.players{i,1}.item_4;
                    playersadd.item_5=datavalve.result.players{i,1}.item_5;
                    playersadd.backpack_0=datavalve.result.players{i,1}.backpack_0;
                    playersadd.backpack_1=datavalve.result.players{i,1}.backpack_1;
                    playersadd.backpack_2=datavalve.result.players{i,1}.backpack_2;
                    playersadd.kills=datavalve.result.players{i,1}.kills;
                    playersadd.deaths=datavalve.result.players{i,1}.deaths;
                    playersadd.assists=datavalve.result.players{i,1}.assists;
                    playersadd.leaver_status=datavalve.result.players{i,1}.leaver_status;
                    playersadd.last_hits=datavalve.result.players{i,1}.last_hits;
                    playersadd.denies=datavalve.result.players{i,1}.denies;
                    playersadd.gold_per_min=datavalve.result.players{i,1}.gold_per_min;
                    playersadd.xp_per_min=datavalve.result.players{i,1}.xp_per_min;
                    playersadd.level=datavalve.result.players{i,1}.level;
                    playersadd.hero_damage=NaN;
                    playersadd.tower_damage=NaN;
                    playersadd.hero_healing=NaN;
                    playersadd.gold=NaN;
                    playersadd.gold_spent=NaN;
                    playersadd.scaled_hero_damage=NaN;
                    playersadd.scaled_tower_damage=NaN;
                    playersadd.scaled_hero_healing=NaN;
                    playersadd.match_id=datavalve.result.match_id;
                else
                    playersadd=table;
                    playersadd.account_id=datavalve.result.players{i,1}.account_id;
                    playersadd.player_slot=datavalve.result.players{i,1}.player_slot;
                    playersadd.hero_id=datavalve.result.players{i,1}.hero_id;
                    playersadd.item_0=datavalve.result.players{i,1}.item_0;
                    playersadd.item_1=datavalve.result.players{i,1}.item_1;
                    playersadd.item_2=datavalve.result.players{i,1}.item_2;
                    playersadd.item_3=datavalve.result.players{i,1}.item_3;
                    playersadd.item_4=datavalve.result.players{i,1}.item_4;
                    playersadd.item_5=datavalve.result.players{i,1}.item_5;
                    playersadd.backpack_0=datavalve.result.players{i,1}.backpack_0;
                    playersadd.backpack_1=datavalve.result.players{i,1}.backpack_1;
                    playersadd.backpack_2=datavalve.result.players{i,1}.backpack_2;
                    playersadd.kills=datavalve.result.players{i,1}.kills;
                    playersadd.deaths=datavalve.result.players{i,1}.deaths;
                    playersadd.assists=datavalve.result.players{i,1}.assists;
                    playersadd.leaver_status=datavalve.result.players{i,1}.leaver_status;
                    playersadd.last_hits=datavalve.result.players{i,1}.last_hits;
                    playersadd.denies=datavalve.result.players{i,1}.denies;
                    playersadd.gold_per_min=datavalve.result.players{i,1}.gold_per_min;
                    playersadd.xp_per_min=datavalve.result.players{i,1}.xp_per_min;
                    playersadd.level=datavalve.result.players{i,1}.level;
                    playersadd.hero_damage=datavalve.result.players{i,1}.hero_damage;
                    playersadd.tower_damage=datavalve.result.players{i,1}.tower_damage;
                    playersadd.hero_healing=datavalve.result.players{i,1}.hero_healing;
                    playersadd.gold=datavalve.result.players{i,1}.gold;
                    playersadd.gold_spent=datavalve.result.players{i,1}.gold_spent;
                    playersadd.scaled_hero_damage=datavalve.result.players{i,1}.scaled_hero_damage;
                    playersadd.scaled_tower_damage=datavalve.result.players{i,1}.scaled_tower_damage;
                    playersadd.scaled_hero_healing=datavalve.result.players{i,1}.scaled_hero_healing;
                    playersadd.match_id=datavalve.result.match_id;
                end
                players=[players;playersadd];
            end
        otherwise
            if length(fieldnames(datavalve.result.players))==21
                players = table([datavalve.result.players.account_id].', [datavalve.result.players.player_slot].', [datavalve.result.players.hero_id].', [datavalve.result.players.item_0].', [datavalve.result.players.item_1].', [datavalve.result.players.item_2].', [datavalve.result.players.item_3].', [datavalve.result.players.item_4].', [datavalve.result.players.item_5].', [datavalve.result.players.backpack_0].', [datavalve.result.players.backpack_1].', [datavalve.result.players.backpack_2].', [datavalve.result.players.kills].', [datavalve.result.players.deaths].', [datavalve.result.players.assists].', [datavalve.result.players.leaver_status].', [datavalve.result.players.last_hits].', [datavalve.result.players.denies].', [datavalve.result.players.gold_per_min].', [datavalve.result.players.xp_per_min].', [datavalve.result.players.level].','VariableNames', {'account_id', 'player_slot', 'hero_id', 'item_0', 'item_1', 'item_2', 'item_3', 'item_4', 'item_5', 'backpack_0', 'backpack_1', 'backpack_2', 'kills', 'deaths', 'assists', 'leaver_status', 'last_hits', 'denies', 'gold_per_min', 'xp_per_min', 'level'});
                players.hero_damage(:,1)=NaN;
                players.tower_damage(:,1)=NaN;
                players.hero_healing(:,1)=NaN;
                players.gold(:,1)=NaN;
                players.gold_spent(:,1)=NaN;
                players.scaled_hero_damage(:,1)=NaN;
                players.scaled_tower_damage(:,1)=NaN;
                players.scaled_hero_healing(:,1)=NaN;
                players.match_id(:,1)=datavalve.result.match_id;
            else
                players = table([datavalve.result.players.account_id].', [datavalve.result.players.player_slot].', [datavalve.result.players.hero_id].', [datavalve.result.players.item_0].', [datavalve.result.players.item_1].', [datavalve.result.players.item_2].', [datavalve.result.players.item_3].', [datavalve.result.players.item_4].', [datavalve.result.players.item_5].', [datavalve.result.players.backpack_0].', [datavalve.result.players.backpack_1].', [datavalve.result.players.backpack_2].', [datavalve.result.players.kills].', [datavalve.result.players.deaths].', [datavalve.result.players.assists].', [datavalve.result.players.leaver_status].', [datavalve.result.players.last_hits].', [datavalve.result.players.denies].', [datavalve.result.players.gold_per_min].', [datavalve.result.players.xp_per_min].', [datavalve.result.players.level].', [datavalve.result.players.hero_damage].', [datavalve.result.players.tower_damage].', [datavalve.result.players.hero_healing].', [datavalve.result.players.gold].', [datavalve.result.players.gold_spent].', [datavalve.result.players.scaled_hero_damage].', [datavalve.result.players.scaled_tower_damage].', [datavalve.result.players.scaled_hero_healing].', 'VariableNames', {'account_id', 'player_slot', 'hero_id', 'item_0', 'item_1', 'item_2', 'item_3', 'item_4', 'item_5', 'backpack_0', 'backpack_1', 'backpack_2', 'kills', 'deaths', 'assists', 'leaver_status', 'last_hits', 'denies', 'gold_per_min', 'xp_per_min', 'level', 'hero_damage', 'tower_damage', 'hero_healing', 'gold', 'gold_spent', 'scaled_hero_damage', 'scaled_tower_damage', 'scaled_hero_healing'});
                players.match_id(:,1)=datavalve.result.match_id;
            end
    end
    
    %%match info
    picks=table();
    picks.match_id=datavalve.result.match_id;
    if datavalve.result.leagueid==9870
        if datavalve.result.match_id<=3973246064
            picks.id_tn=datavalve.result.leagueid;
        else
            picks.id_tn=8;
        end
    else
        picks.id_tn=datavalve.result.leagueid;
    end
    picks.radiant_name{1,1}=datavalve.result.radiant_name;
    picks.dire_name{1,1}=datavalve.result.dire_name;
    picks.radiant_team_id=datavalve.result.radiant_team_id;
    picks.dire_team_id=datavalve.result.dire_team_id;
    picks.randiant_score=datavalve.result.radiant_score;
    picks.dire_score=datavalve.result.dire_score;
    picks.duration=datavalve.result.duration;
    picks.firstpick=[datavalve.result.picks_bans(1).team].'; %0=radiant 1=dire
    picks.radiant_win=double(datavalve.result.radiant_win);
    picks.radiant_drafter=datavalve.result.radiant_captain;
    picks.dire_drafter=datavalve.result.dire_captain;
    if length(datavalve.result.picks_bans)==22
        switch picks.firstpick
            case 0 %radiant
                picks.radiant_B1=[datavalve.result.picks_bans(1).hero_id].';
                picks.radiant_B2=[datavalve.result.picks_bans(3).hero_id].';
                picks.radiant_B3=[datavalve.result.picks_bans(5).hero_id].';
                picks.radiant_B4=[datavalve.result.picks_bans(11).hero_id].';
                picks.radiant_B5=[datavalve.result.picks_bans(13).hero_id].';
                picks.radiant_B6=[datavalve.result.picks_bans(20).hero_id].';
                picks.rabiant_P1=[datavalve.result.picks_bans(7).hero_id].';
                picks.rabiant_P2=[datavalve.result.picks_bans(10).hero_id].';
                picks.rabiant_P3=[datavalve.result.picks_bans(16).hero_id].';
                picks.rabiant_P4=[datavalve.result.picks_bans(18).hero_id].';
                picks.rabiant_P5=[datavalve.result.picks_bans(21).hero_id].';
                picks.dire_B1=[datavalve.result.picks_bans(2).hero_id].';
                picks.dire_B2=[datavalve.result.picks_bans(4).hero_id].';
                picks.dire_B3=[datavalve.result.picks_bans(6).hero_id].';
                picks.dire_B4=[datavalve.result.picks_bans(12).hero_id].';
                picks.dire_B5=[datavalve.result.picks_bans(14).hero_id].';
                picks.dire_B6=[datavalve.result.picks_bans(19).hero_id].';
                picks.dire_P1=[datavalve.result.picks_bans(8).hero_id].';
                picks.dire_P2=[datavalve.result.picks_bans(9).hero_id].';
                picks.dire_P3=[datavalve.result.picks_bans(15).hero_id].';
                picks.dire_P4=[datavalve.result.picks_bans(17).hero_id].';
                picks.dire_P5=[datavalve.result.picks_bans(22).hero_id].';
            otherwise %dire
                picks.radiant_B1=[datavalve.result.picks_bans(2).hero_id].';
                picks.radiant_B2=[datavalve.result.picks_bans(4).hero_id].';
                picks.radiant_B3=[datavalve.result.picks_bans(6).hero_id].';
                picks.radiant_B4=[datavalve.result.picks_bans(12).hero_id].';
                picks.radiant_B5=[datavalve.result.picks_bans(14).hero_id].';
                picks.radiant_B6=[datavalve.result.picks_bans(19).hero_id].';
                picks.rabiant_P1=[datavalve.result.picks_bans(8).hero_id].';
                picks.rabiant_P2=[datavalve.result.picks_bans(9).hero_id].';
                picks.rabiant_P3=[datavalve.result.picks_bans(15).hero_id].';
                picks.rabiant_P4=[datavalve.result.picks_bans(17).hero_id].';
                picks.rabiant_P5=[datavalve.result.picks_bans(22).hero_id].';
                picks.dire_B1=[datavalve.result.picks_bans(1).hero_id].';
                picks.dire_B2=[datavalve.result.picks_bans(3).hero_id].';
                picks.dire_B3=[datavalve.result.picks_bans(5).hero_id].';
                picks.dire_B4=[datavalve.result.picks_bans(11).hero_id].';
                picks.dire_B5=[datavalve.result.picks_bans(13).hero_id].';
                picks.dire_B6=[datavalve.result.picks_bans(20).hero_id].';
                picks.dire_P1=[datavalve.result.picks_bans(7).hero_id].';
                picks.dire_P2=[datavalve.result.picks_bans(10).hero_id].';
                picks.dire_P3=[datavalve.result.picks_bans(16).hero_id].';
                picks.dire_P4=[datavalve.result.picks_bans(18).hero_id].';
                picks.dire_P5=[datavalve.result.picks_bans(21).hero_id].';
        end
    else
        picks.radiant_B1=NaN;
        picks.radiant_B2=NaN;
        picks.radiant_B3=NaN;
        picks.radiant_B4=NaN;
        picks.radiant_B5=NaN;
        picks.radiant_B6=NaN;
        picks.rabiant_P1=NaN;
        picks.rabiant_P2=NaN;
        picks.rabiant_P3=NaN;
        picks.rabiant_P4=NaN;
        picks.rabiant_P5=NaN;
        picks.dire_B1=NaN;
        picks.dire_B2=NaN;
        picks.dire_B3=NaN;
        picks.dire_B4=NaN;
        picks.dire_B5=NaN;
        picks.dire_B6=NaN;
        picks.dire_P1=NaN;
        picks.dire_P2=NaN;
        picks.dire_P3=NaN;
        picks.dire_P4=NaN;
        picks.dire_P5=NaN;
    end
    
    execmatchadd=execmatch(execmatch.match_id==datavalve.result.match_id,:);
    %% verifier si le match exist
    RQexist=['select * from grenouilleapi.public.valvematch where valvematch.match_id=',num2str(datavalve.result.match_id)];
    existsql=pgsqldata(conn,RQexist);
    if strcmp(existsql,'No Data')==1
        insert(conn,'grenouilleapi.public.valvematch',{'match_id','id_tn','radiant_name','dire_name','radiant_team_id','dire_team_id','randiant_score','dire_score','duration','firstpick',...
            'radiant_win','radiant_drafter','dire_drafter','radiant_B1','radiant_B2','radiant_B3','radiant_B4','radiant_B5','radiant_B6','rabiant_P1','rabiant_P2','rabiant_P3','rabiant_P4',...
            'rabiant_P5','dire_B1','dire_B2','dire_B3','dire_B4','dire_B5','dire_B6','dire_P1','dire_P2','dire_P3','dire_P4','dire_P5'},picks);
    else
        pgsqlexec(conn,['delete from grenouilleapi.public.valvematch where valvematch.match_id=',num2str(datavalve.result.match_id)])
        insert(conn,'grenouilleapi.public.valvematch',{'match_id','id_tn','radiant_name','dire_name','radiant_team_id','dire_team_id','randiant_score','dire_score','duration','firstpick',...
            'radiant_win','radiant_drafter','dire_drafter','radiant_B1','radiant_B2','radiant_B3','radiant_B4','radiant_B5','radiant_B6','rabiant_P1','rabiant_P2','rabiant_P3','rabiant_P4',...
            'rabiant_P5','dire_B1','dire_B2','dire_B3','dire_B4','dire_B5','dire_B6','dire_P1','dire_P2','dire_P3','dire_P4','dire_P5'},picks);
    end
    execmatchadd.execvalvepicks=1;
    %% verifier si le match exist
    RQexist2=['select * from grenouilleapi.public.valveplayermatch where valveplayermatch.match_id=',num2str(datavalve.result.match_id)];
    existsql2=pgsqldata(conn,RQexist2);
    if strcmp(existsql2,'No Data')==1
        insert(conn,'grenouilleapi.public.valveplayermatch',{'account_id','player_slot','hero_id','item_0','item_1','item_2','item_3','item_4','item_5','backpack_0','backpack_1','backpack_2',...
            'kills','deaths','assists','leaver_status','last_hits','denies','gold_per_min','xp_per_min','level','hero_damage','tower_damage','hero_healing','gold','gold_spent','scaled_hero_damage',...
            'scaled_tower_damage','scaled_hero_healing','match_id'},players);
    else
        pgsqlexec(conn,['delete from grenouilleapi.public.valveplayermatch where valveplayermatch.match_id=',num2str(datavalve.result.match_id)])
        insert(conn,'grenouilleapi.public.valveplayermatch',{'account_id','player_slot','hero_id','item_0','item_1','item_2','item_3','item_4','item_5','backpack_0','backpack_1','backpack_2',...
            'kills','deaths','assists','leaver_status','last_hits','denies','gold_per_min','xp_per_min','level','hero_damage','tower_damage','hero_healing','gold','gold_spent','scaled_hero_damage',...
            'scaled_tower_damage','scaled_hero_healing','match_id'},players);
    end
    execmatchadd.execvalveplayer=1;
    update(conn,'grenouilleapi.public.execmatch',{'match_id','execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatchadd,['where match_id =',num2str(datavalve.result.match_id)]);
    execmatch(execmatch.match_id==datavalve.result.match_id,:)=execmatchadd;
    disp('Traitement OK')
catch ME
    execmatchadd=execmatch(execmatch.match_id==datavalve.result.match_id,:);
    if execmatchadd.execvalvepicks==0
        execmatchadd.execvalvepicks=2;
    end
    if execmatchadd.execvalveplayer==0
        execmatchadd.execvalveplayer=2;
    end
    update(conn,'grenouilleapi.public.execmatch',{'match_id','execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatchadd,['where match_id =',num2str(datavalve.result.match_id)]);
    execmatch(execmatch.match_id==datavalve.result.match_id,:)=execmatchadd;
    disp('Traitement nOK')
end

end