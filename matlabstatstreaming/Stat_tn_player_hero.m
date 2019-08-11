function Stat_tn_player_hero(conn,tn_id,type)
disp('Traitement des stats TN Player Heros')
hero=pgsqldata(conn,'select * from public.hero');
player_match_valve=pgsqldata(conn,['select * from public.join_valveplayermatch where tn_id=',num2str(tn_id)]);
match_valve=pgsqldata(conn,['select * from public.join_valvematch where id_tn=',num2str(tn_id)]);

switch type
    case 'main'
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve(match_valve.is_qualif==0,:);
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
        if nb_match>0
            for l=1:nb_match
                playermatchtnadd=player_match_valve(player_match_valve.match_id==listmatch(l),:);
                playermatchtn=[playermatchtn;playermatchtnadd]; %#ok<AGROW>
            end
            
            for j=1:height(matchvalvetn)
                player_temp=playermatchtn(playermatchtn.match_id==matchvalvetn.match_id(j),:);
                if matchvalvetn.radiant_win(j)==1
                    player_temp.is_win(1:5,1)=1;
                    player_temp.is_win(6:10,1)=0;
                else
                    player_temp.is_win(1:5,1)=0;
                    player_temp.is_win(6:10,1)=1;
                end
                player_match_valve2=[player_match_valve2;player_temp]; %#ok<AGROW>
            end
            list_player=unique(player_match_valve2.account_id);
            nb_player=length(list_player);
            StatHerosPlayer=table();
            for m=1:nb_player
                StatHerosPlayerAdd=table();
                player_match_valve3=player_match_valve2(player_match_valve2.account_id==list_player(m),:);
                for i=1:height(hero)
                    CalcStatHero=player_match_valve3(player_match_valve3.hero_id==hero.id(i,1),:);
                    if ~isempty(CalcStatHero)
                        StatHerosadd=table();
                        StatHerosadd.id=NaN;
                        StatHerosadd.hero_id=hero.id(i,1);
                        StatHerosadd.id_tn=tn_id;
                        StatHerosadd.is_qualif=0;
                        StatHerosadd.account_id=list_player(m);
                        StatHerosadd.nb_pick=height(CalcStatHero);
                        StatHerosadd.nb_ban=height(matchvalvetn(matchvalvetn.dire_b1==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b2==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b3==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b4==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b5==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b6==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b1==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b2==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b3==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b4==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b5==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b6==StatHerosadd.hero_id,:));
                        StatHerosadd.nb_match=height(matchvalvetn);
                        [StatHerosadd]=genstat(CalcStatHero,'is_win',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'kills',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'assists',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'deaths',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'last_hits',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'denies',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'gold_per_min',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'xp_per_min',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'hero_damage',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'tower_damage',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'level',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'hero_healing',StatHerosadd);
                        StatHerosPlayerAdd=[StatHerosPlayerAdd;StatHerosadd];
                    end
                end
                StatHerosPlayer=[StatHerosPlayer;StatHerosPlayerAdd];
            end
            
            rqexist=['select id from public.stat_tn_player_hero where id_tn=',num2str(tn_id),' and is_qualif=0'];
            exist1=pgsqldata(conn,rqexist);
            if strcmp(exist1,'No Data')==0
                pgsqlexec(conn,['delete from public.stat_tn_player_hero where id_tn=',num2str(tn_id),' and is_qualif=0'])
            end
            CBM_PGSQL_Transact_light(conn,'stat_tn_player_hero',StatHerosPlayer.Properties.VariableNames,StatHerosPlayer,'id','public');
        end
    case 'qualif'
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve(match_valve.is_qualif==1,:);
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
        if nb_match>0
            for l=1:nb_match
                playermatchtnadd=player_match_valve(player_match_valve.match_id==listmatch(l),:);
                playermatchtn=[playermatchtn;playermatchtnadd]; %#ok<AGROW>
            end
            
            for j=1:height(matchvalvetn)
                player_temp=playermatchtn(playermatchtn.match_id==matchvalvetn.match_id(j),:);
                if matchvalvetn.radiant_win(j)==1
                    player_temp.is_win(1:5,1)=1;
                    player_temp.is_win(6:10,1)=0;
                else
                    player_temp.is_win(1:5,1)=0;
                    player_temp.is_win(6:10,1)=1;
                end
                player_match_valve2=[player_match_valve2;player_temp]; %#ok<AGROW>
            end
            list_player=unique(player_match_valve2.account_id);
            nb_player=length(list_player);
            StatHerosPlayer=table();
            for m=1:nb_player
                StatHerosPlayerAdd=table();
                player_match_valve3=player_match_valve2(player_match_valve2.account_id==list_player(m),:);
                for i=1:height(hero)
                    CalcStatHero=player_match_valve3(player_match_valve3.hero_id==hero.id(i,1),:);
                    if ~isempty(CalcStatHero)
                        StatHerosadd=table();
                        StatHerosadd.id=NaN;
                        StatHerosadd.hero_id=hero.id(i,1);
                        StatHerosadd.id_tn=tn_id;
                        StatHerosadd.is_qualif=1;
                        StatHerosadd.account_id=list_player(m);
                        StatHerosadd.nb_pick=height(CalcStatHero);
                        StatHerosadd.nb_ban=height(matchvalvetn(matchvalvetn.dire_b1==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b2==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b3==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b4==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b5==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b6==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b1==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b2==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b3==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b4==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b5==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b6==StatHerosadd.hero_id,:));
                        StatHerosadd.nb_match=height(matchvalvetn);
                        [StatHerosadd]=genstat(CalcStatHero,'is_win',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'kills',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'assists',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'deaths',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'last_hits',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'denies',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'gold_per_min',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'xp_per_min',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'hero_damage',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'tower_damage',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'level',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'hero_healing',StatHerosadd);
                        StatHerosPlayerAdd=[StatHerosPlayerAdd;StatHerosadd];
                    end
                end
                StatHerosPlayer=[StatHerosPlayer;StatHerosPlayerAdd];
            end
            
            rqexist=['select id from public.stat_tn_player_hero where id_tn=',num2str(tn_id),' and is_qualif=1'];
            exist1=pgsqldata(conn,rqexist);
            if strcmp(exist1,'No Data')==0
                pgsqlexec(conn,['delete from public.stat_tn_player_hero where id_tn=',num2str(tn_id),' and is_qualif=1'])
            end
            CBM_PGSQL_Transact_light(conn,'stat_tn_player_hero',StatHerosPlayer.Properties.VariableNames,StatHerosPlayer,'id','public');
        end
    case 'all'
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve;
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
        if nb_match>0
            for l=1:nb_match
                playermatchtnadd=player_match_valve(player_match_valve.match_id==listmatch(l),:);
                playermatchtn=[playermatchtn;playermatchtnadd]; %#ok<AGROW>
            end
            
            for j=1:height(matchvalvetn)
                player_temp=playermatchtn(playermatchtn.match_id==matchvalvetn.match_id(j),:);
                if matchvalvetn.radiant_win(j)==1
                    player_temp.is_win(1:5,1)=1;
                    player_temp.is_win(6:10,1)=0;
                else
                    player_temp.is_win(1:5,1)=0;
                    player_temp.is_win(6:10,1)=1;
                end
                player_match_valve2=[player_match_valve2;player_temp]; %#ok<AGROW>
            end
            list_player=unique(player_match_valve2.account_id);
            nb_player=length(list_player);
            StatHerosPlayer=table();
            for m=1:nb_player
                StatHerosPlayerAdd=table();
                player_match_valve3=player_match_valve2(player_match_valve2.account_id==list_player(m),:);
                for i=1:height(hero)
                    CalcStatHero=player_match_valve3(player_match_valve3.hero_id==hero.id(i,1),:);
                    if ~isempty(CalcStatHero)
                        StatHerosadd=table();
                        StatHerosadd.id=NaN;
                        StatHerosadd.hero_id=hero.id(i,1);
                        StatHerosadd.id_tn=tn_id;
                        StatHerosadd.is_qualif=NaN;
                        StatHerosadd.account_id=list_player(m);
                        StatHerosadd.nb_pick=height(CalcStatHero);
                        StatHerosadd.nb_ban=height(matchvalvetn(matchvalvetn.dire_b1==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b2==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b3==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b4==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b5==StatHerosadd.hero_id | ...
                            matchvalvetn.dire_b6==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b1==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b2==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b3==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b4==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b5==StatHerosadd.hero_id | ...
                            matchvalvetn.radiant_b6==StatHerosadd.hero_id,:));
                        StatHerosadd.nb_match=height(matchvalvetn);
                        [StatHerosadd]=genstat(CalcStatHero,'is_win',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'kills',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'assists',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'deaths',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'last_hits',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'denies',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'gold_per_min',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'xp_per_min',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'hero_damage',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'tower_damage',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'level',StatHerosadd);
                        [StatHerosadd]=genstat(CalcStatHero,'hero_healing',StatHerosadd);
                        StatHerosPlayerAdd=[StatHerosPlayerAdd;StatHerosadd];
                    end
                end
                StatHerosPlayer=[StatHerosPlayer;StatHerosPlayerAdd];
            end
            
            rqexist=['select id from public.stat_tn_player_hero where id_tn=',num2str(tn_id),' and is_qualif=null'];
            exist1=pgsqldata(conn,rqexist);
            if strcmp(exist1,'No Data')==0
                pgsqlexec(conn,['delete from public.stat_tn_player_hero where id_tn=',num2str(tn_id),' and is_qualif=null'])
            end
            CBM_PGSQL_Transact_light(conn,'stat_tn_player_hero',StatHerosPlayer.Properties.VariableNames,StatHerosPlayer,'id','public');
        end
end


disp('Traitement OK')
end