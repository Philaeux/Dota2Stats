function Stat_patch_hero(conn)
disp('Traitement des stats patch Heros')
hero=pgsqldata(conn,'select * from public.hero');
patch=pgsqldata(conn,'select * from public.patch');
patchnum=max(patch.patchnum);
player_match_valve=pgsqldata(conn,['select * from public.join_valveplayermatch where patch_num=',num2str(patchnum)]);
match_valve=pgsqldata(conn,['select * from public.join_valvematch where patch_num=',num2str(patchnum)]);

StatHero=table();
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
    for i=1:height(hero)
        CalcStatHero=player_match_valve2(player_match_valve2.hero_id==hero.id(i,1),:);
        StatHerosadd=table();
        StatHerosadd.id=NaN;
        StatHerosadd.hero_id=hero.id(i,1);
        StatHerosadd.patch_num=patchnum;
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
        StatHero=[StatHero;StatHerosadd]; %#ok<AGROW>
    end
    
    %% insertion SQL StatPlayer
    rqexist=['select id from public.stat_patch_hero where patch_num=',num2str(patchnum)];
    exist1=pgsqldata(conn,rqexist);
    if strcmp(exist1,'No Data')==0
        pgsqlexec(conn,['delete from public.stat_patch_hero where patch_num=',num2str(patchnum)])
    end
    CBM_PGSQL_Transact_light(conn,'stat_patch_hero',StatHero.Properties.VariableNames,StatHero,'id','public');
end
disp('Traitement OK')
end