function Stat_tn_hero(conn,hero,player_match_valve,match_valve,tn_id)
disp('Traitement des stats TN Heros') 
switch nargin
    case 4
        list_tn=unique(match_valve.id_tn);
        nb_tn=length(list_tn);
        %% algo
        for k=1:nb_tn
            player_match_valve2=table();
            playermatchtn=table();
            matchvalvetn=match_valve(match_valve.id_tn==list_tn(k),:);
            listmatch=unique(matchvalvetn.match_id);
            nb_tn=length(listmatch);
            for l=1:nb_tn
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
            for i=1:height(hero)
                CalcStatHero=player_match_valve2(player_match_valve2.hero_id==hero.hero_id(i,1),:);
                StatHerosadd=table();
                StatHerosadd.hero_id=hero.hero_id(i,1);
                StatHerosadd.id_tn=list_tn(k);
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
                
                pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_hero where hero_id=',num2str(hero.hero_id(i,1)),' and id_tn=',num2str(list_tn(k))])
                insert(conn,'grenouilleapi.public.stat_tn_hero',{'hero_id','id_tn','nb_pick','nb_ban','nb_match','mean_is_win','max_is_win','min_is_win','tot_is_win','mean_kills','max_kills','min_kills',...
                    'tot_kills','mean_assists','max_assists','min_assists','tot_assists','mean_deaths','max_deaths','min_deaths','tot_deaths','mean_last_hits','max_last_hits','min_last_hits',...
                    'tot_last_hits','mean_denies','max_denies','min_denies','tot_denies','mean_gold_per_min','max_gold_per_min','min_gold_per_min','tot_gold_per_min','mean_xp_per_min',...
                    'max_xp_per_min','min_xp_per_min','tot_xp_per_min','mean_hero_damage','max_hero_damage','min_hero_damage','tot_hero_damage','mean_tower_damage','max_tower_damage','min_tower_damage',...
                    'tot_tower_damage','mean_level','max_level','min_level','tot_level','mean_hero_healing','max_hero_healing','min_hero_healing','tot_hero_healing'},StatHerosadd);
                
            end
        end
    case 5
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve(match_valve.id_tn==tn_id,:);
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
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
        for i=1:height(hero)
            CalcStatHero=player_match_valve2(player_match_valve2.hero_id==hero.hero_id(i,1),:);
            StatHerosadd=table();
            StatHerosadd.hero_id=hero.hero_id(i,1);
            StatHerosadd.id_tn=tn_id;
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
            
            pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_hero where hero_id=',num2str(hero.hero_id(i,1)),' and id_tn=',num2str(tn_id)])
            insert(conn,'grenouilleapi.public.stat_tn_hero',{'hero_id','id_tn','nb_pick','nb_ban','nb_match','mean_is_win','max_is_win','min_is_win','tot_is_win','mean_kills','max_kills','min_kills',...
                'tot_kills','mean_assists','max_assists','min_assists','tot_assists','mean_deaths','max_deaths','min_deaths','tot_deaths','mean_last_hits','max_last_hits','min_last_hits',...
                'tot_last_hits','mean_denies','max_denies','min_denies','tot_denies','mean_gold_per_min','max_gold_per_min','min_gold_per_min','tot_gold_per_min','mean_xp_per_min',...
                'max_xp_per_min','min_xp_per_min','tot_xp_per_min','mean_hero_damage','max_hero_damage','min_hero_damage','tot_hero_damage','mean_tower_damage','max_tower_damage','min_tower_damage',...
                'tot_tower_damage','mean_level','max_level','min_level','tot_level','mean_hero_healing','max_hero_healing','min_hero_healing','tot_hero_healing'},StatHerosadd);
            
        end
        
end
disp('Traitement OK')
end