function execmatch=execvalve(datavalve,conn,execmatch)

try
    disp(['Traitement api.valve de ',datavalve.result.radiant_name,' vs ',datavalve.result.dire_name])
    execmatchadd=table();
    execmatchadd.execvalvepicks=execmatch.execvalvepicks(execmatch.match_id==datavalve.result.match_id);
    execmatchadd.execvalveplayer=execmatch.execvalveplayer(execmatch.match_id==datavalve.result.match_id);
    %% info ticket valve
    if datavalve.result.game_mode==2
        if execmatchadd.execvalveplayer<5
            switch class(datavalve.result.players(1,1))
                case 'cell'
                    players=table();
                    for i=1:10
                        if length(fieldnames(datavalve.result.players{1,1}))==21
                            playersadd=table;
                            playersadd.id=NaN;
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
                            playersadd.id=NaN;
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
                            if isfield(datavalve.result.players{i,1},'hero_damage')
                                playersadd.hero_damage=datavalve.result.players{i,1}.hero_damage;
                                playersadd.tower_damage=datavalve.result.players{i,1}.tower_damage;
                                playersadd.hero_healing=datavalve.result.players{i,1}.hero_healing;
                                playersadd.gold=datavalve.result.players{i,1}.gold;
                                playersadd.gold_spent=datavalve.result.players{i,1}.gold_spent;
                                playersadd.scaled_hero_damage=datavalve.result.players{i,1}.scaled_hero_damage;
                                playersadd.scaled_tower_damage=datavalve.result.players{i,1}.scaled_tower_damage;
                                playersadd.scaled_hero_healing=datavalve.result.players{i,1}.scaled_hero_healing;
                            else
                                playersadd.hero_damage=NaN;
                                playersadd.tower_damage=NaN;
                                playersadd.hero_healing=NaN;
                                playersadd.gold=NaN;
                                playersadd.gold_spent=NaN;
                                playersadd.scaled_hero_damage=NaN;
                                playersadd.scaled_tower_damage=NaN;
                                playersadd.scaled_hero_healing=NaN;
                            end
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
                        players.id(:,1)=NaN;
                        players.match_id(:,1)=datavalve.result.match_id;
                    else
                        players = table([datavalve.result.players.account_id].', [datavalve.result.players.player_slot].', [datavalve.result.players.hero_id].', [datavalve.result.players.item_0].', [datavalve.result.players.item_1].', [datavalve.result.players.item_2].', [datavalve.result.players.item_3].', [datavalve.result.players.item_4].', [datavalve.result.players.item_5].', [datavalve.result.players.backpack_0].', [datavalve.result.players.backpack_1].', [datavalve.result.players.backpack_2].', [datavalve.result.players.kills].', [datavalve.result.players.deaths].', [datavalve.result.players.assists].', [datavalve.result.players.leaver_status].', [datavalve.result.players.last_hits].', [datavalve.result.players.denies].', [datavalve.result.players.gold_per_min].', [datavalve.result.players.xp_per_min].', [datavalve.result.players.level].', [datavalve.result.players.hero_damage].', [datavalve.result.players.tower_damage].', [datavalve.result.players.hero_healing].', [datavalve.result.players.gold].', [datavalve.result.players.gold_spent].', [datavalve.result.players.scaled_hero_damage].', [datavalve.result.players.scaled_tower_damage].', [datavalve.result.players.scaled_hero_healing].', 'VariableNames', {'account_id', 'player_slot', 'hero_id', 'item_0', 'item_1', 'item_2', 'item_3', 'item_4', 'item_5', 'backpack_0', 'backpack_1', 'backpack_2', 'kills', 'deaths', 'assists', 'leaver_status', 'last_hits', 'denies', 'gold_per_min', 'xp_per_min', 'level', 'hero_damage', 'tower_damage', 'hero_healing', 'gold', 'gold_spent', 'scaled_hero_damage', 'scaled_tower_damage', 'scaled_hero_healing'});
                        players.id(:,1)=NaN;
                        players.match_id(:,1)=datavalve.result.match_id;
                    end
            end
            %% verifier si le match exist
            RQexist2=['select id from public.valveplayermatch where valveplayermatch.match_id=',num2str(datavalve.result.match_id)];
            existsql2=pgsqldata(conn,RQexist2);
            if strcmp(existsql2,'No Data')==1
                CBM_PGSQL_Transact_light(conn,'valveplayermatch',players.Properties.VariableNames,players,'id','public');
                existsql3=pgsqldata(conn,RQexist2);
                if strcmp(existsql3,'No Data')==1
                    disp('transact nOK')
                    execmatchadd.execopenplayer=0;
                else
                    disp('transact OK')
                    execmatchadd.execopenplayer=6;
                end
            else
                pgsqlexec(conn,['delete from public.valveplayermatch where valveplayermatch.match_id=',num2str(datavalve.result.match_id)])
                CBM_PGSQL_Transact_light(conn,'valveplayermatch',players.Properties.VariableNames,players,'id','public');
                existsql4=pgsqldata(conn,RQexist2);
                if strcmp(existsql4,'No Data')==1
                    disp('transact nOK')
                    execmatchadd.execopenplayer=0;
                else
                    disp('transact OK')
                    execmatchadd.execopenplayer=6;
                end
            end
            execmatchadd.execvalveplayer=6;
            CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',datavalve.result.match_id,'public','update');
            disp('Traitement player OK')
        end
        %%match info
        if execmatchadd.execvalvepicks<5
            picks=table();
            picks.match_id=datavalve.result.match_id;
            picks.id_tn=datavalve.result.leagueid;
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
                        picks.radiant_b1=[datavalve.result.picks_bans(1).hero_id].';
                        picks.radiant_b2=[datavalve.result.picks_bans(3).hero_id].';
                        picks.radiant_b3=[datavalve.result.picks_bans(5).hero_id].';
                        picks.radiant_b4=[datavalve.result.picks_bans(11).hero_id].';
                        picks.radiant_b5=[datavalve.result.picks_bans(13).hero_id].';
                        picks.radiant_b6=[datavalve.result.picks_bans(20).hero_id].';
                        picks.radiant_p1=[datavalve.result.picks_bans(7).hero_id].';
                        picks.radiant_p2=[datavalve.result.picks_bans(10).hero_id].';
                        picks.radiant_p3=[datavalve.result.picks_bans(16).hero_id].';
                        picks.radiant_p4=[datavalve.result.picks_bans(18).hero_id].';
                        picks.radiant_p5=[datavalve.result.picks_bans(21).hero_id].';
                        picks.dire_b1=[datavalve.result.picks_bans(2).hero_id].';
                        picks.dire_b2=[datavalve.result.picks_bans(4).hero_id].';
                        picks.dire_b3=[datavalve.result.picks_bans(6).hero_id].';
                        picks.dire_b4=[datavalve.result.picks_bans(12).hero_id].';
                        picks.dire_b5=[datavalve.result.picks_bans(14).hero_id].';
                        picks.dire_b6=[datavalve.result.picks_bans(19).hero_id].';
                        picks.dire_p1=[datavalve.result.picks_bans(8).hero_id].';
                        picks.dire_p2=[datavalve.result.picks_bans(9).hero_id].';
                        picks.dire_p3=[datavalve.result.picks_bans(15).hero_id].';
                        picks.dire_p4=[datavalve.result.picks_bans(17).hero_id].';
                        picks.dire_p5=[datavalve.result.picks_bans(22).hero_id].';
                    otherwise %dire
                        picks.radiant_b1=[datavalve.result.picks_bans(2).hero_id].';
                        picks.radiant_b2=[datavalve.result.picks_bans(4).hero_id].';
                        picks.radiant_b3=[datavalve.result.picks_bans(6).hero_id].';
                        picks.radiant_b4=[datavalve.result.picks_bans(12).hero_id].';
                        picks.radiant_b5=[datavalve.result.picks_bans(14).hero_id].';
                        picks.radiant_b6=[datavalve.result.picks_bans(19).hero_id].';
                        picks.radiant_p1=[datavalve.result.picks_bans(8).hero_id].';
                        picks.radiant_p2=[datavalve.result.picks_bans(9).hero_id].';
                        picks.radiant_p3=[datavalve.result.picks_bans(15).hero_id].';
                        picks.radiant_p4=[datavalve.result.picks_bans(17).hero_id].';
                        picks.radiant_p5=[datavalve.result.picks_bans(22).hero_id].';
                        picks.dire_b1=[datavalve.result.picks_bans(1).hero_id].';
                        picks.dire_b2=[datavalve.result.picks_bans(3).hero_id].';
                        picks.dire_b3=[datavalve.result.picks_bans(5).hero_id].';
                        picks.dire_b4=[datavalve.result.picks_bans(11).hero_id].';
                        picks.dire_b5=[datavalve.result.picks_bans(13).hero_id].';
                        picks.dire_b6=[datavalve.result.picks_bans(20).hero_id].';
                        picks.dire_p1=[datavalve.result.picks_bans(7).hero_id].';
                        picks.dire_p2=[datavalve.result.picks_bans(10).hero_id].';
                        picks.dire_p3=[datavalve.result.picks_bans(16).hero_id].';
                        picks.dire_p4=[datavalve.result.picks_bans(18).hero_id].';
                        picks.dire_p5=[datavalve.result.picks_bans(21).hero_id].';
                end
            else
                picks.radiant_b1=NaN;
                picks.radiant_b2=NaN;
                picks.radiant_b3=NaN;
                picks.radiant_b4=NaN;
                picks.radiant_b5=NaN;
                picks.radiant_b6=NaN;
                picks.radiant_p1=NaN;
                picks.radiant_p2=NaN;
                picks.radiant_p3=NaN;
                picks.radiant_p4=NaN;
                picks.radiant_p5=NaN;
                picks.dire_b1=NaN;
                picks.dire_b2=NaN;
                picks.dire_b3=NaN;
                picks.dire_b4=NaN;
                picks.dire_b5=NaN;
                picks.dire_b6=NaN;
                picks.dire_p1=NaN;
                picks.dire_p2=NaN;
                picks.dire_p3=NaN;
                picks.dire_p4=NaN;
                picks.dire_p5=NaN;
            end
            
            %% verifier si le match exist
            RQexist=['select id from public.valvematch where valvematch.match_id=',num2str(datavalve.result.match_id)];
            existsql=pgsqldata(conn,RQexist);
            if strcmp(existsql,'No Data')==1
                CBM_PGSQL_inject1l_light(conn,'valvematch',picks.Properties.VariableNames,picks,'id',NaN,'public','add');
            else
                CBM_PGSQL_inject1l_light(conn,'valvematch',picks.Properties.VariableNames,picks,'id',existsql.id,'public','update');
            end
            execmatchadd.execvalvepicks=6;
            disp('Traitement match OK')
        end
    else
        disp('Traitement nOK autre mode que cm')
        execmatchadd.execvalveplayer=7;
        execmatchadd.execvalvepicks=7;
        CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',datavalve.result.match_id,'public','update');
    end
catch ME
    if execmatchadd.execvalvepicks<5
        execmatchadd.execvalvepicks=execmatchadd.execvalvepicks+1;
    end
    if execmatchadd.execvalveplayer<5
        execmatchadd.execvalveplayer=execmatchadd.execvalveplayer+1;
    end
    CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',datavalve.result.match_id,'public','update');
    disp('Traitement nOK')
end

end