function Stat_tn_hero_team(conn,tn_id,type)
disp('Traitement des stats TN Team Heros')
player_match_valve=pgsqldata(conn,['select * from public.join_valveplayermatch where tn_id=',num2str(tn_id)]);
match_valve=pgsqldata(conn,['select * from public.join_valvematch where id_tn=',num2str(tn_id)]);
player=pgsqldata(conn,'select * from public.player');
switch type
    case 'main'
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve(match_valve.is_qualif==0 & ~isnan(match_valve.radiant_b1),:);
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
        for l=1:nb_match
            playermatchtnadd=player_match_valve(player_match_valve.match_id==listmatch(l),:);
            playermatchtn=[playermatchtn;playermatchtnadd]; %#ok<AGROW>
        end
        nb_matchvalvetn=height(matchvalvetn);
        for j=1:nb_matchvalvetn
            player_temp=playermatchtn(playermatchtn.match_id==matchvalvetn.match_id(j),:);
            if matchvalvetn.radiant_win(j)==1
                player_temp.is_win(1:5,1)=1;
                player_temp.is_win(6:10,1)=0;
            else
                player_temp.is_win(1:5,1)=0;
                player_temp.is_win(6:10,1)=1;
            end
            for m=1:10
                player_temp.team_id(m)=player.team_id(player.player_id==player_temp.account_id(m));
            end
            player_match_valve2=[player_match_valve2;player_temp]; %#ok<AGROW>
        end
        list_team=unique([matchvalvetn.radiant_team_id;matchvalvetn.dire_team_id]);
        nb_team=length(list_team);
        StatHerosTeam=table();
        for n=1:nb_team
            player_match_valve3=player_match_valve2(player_match_valve2.team_id==list_team(n),:);
            StatHerosTeamAdd=table();
            matchvalvetnteam=matchvalvetn((matchvalvetn.radiant_team_id==list_team(n) | matchvalvetn.dire_team_id==list_team(n)),:);
            table_ban=table();
            for o=1:height(matchvalvetnteam)
                table_ban_add=table();
                if matchvalvetnteam.radiant_team_id(o)==list_team(n)
                    table_ban_add.P1=matchvalvetnteam.radiant_p1(o);
                    table_ban_add.P2=matchvalvetnteam.radiant_p2(o);
                    table_ban_add.P3=matchvalvetnteam.radiant_p3(o);
                    table_ban_add.P4=matchvalvetnteam.radiant_p4(o);
                    table_ban_add.P5=matchvalvetnteam.radiant_p5(o);
                    table_ban_add.PA1=matchvalvetnteam.dire_p1(o);
                    table_ban_add.PA2=matchvalvetnteam.dire_p2(o);
                    table_ban_add.PA3=matchvalvetnteam.dire_p3(o);
                    table_ban_add.PA4=matchvalvetnteam.dire_p4(o);
                    table_ban_add.PA5=matchvalvetnteam.dire_p5(o);
                    table_ban_add.B1=matchvalvetnteam.radiant_b1(o);
                    table_ban_add.B2=matchvalvetnteam.radiant_b2(o);
                    table_ban_add.B3=matchvalvetnteam.radiant_b3(o);
                    table_ban_add.B4=matchvalvetnteam.radiant_b4(o);
                    table_ban_add.B5=matchvalvetnteam.radiant_b5(o);
                    table_ban_add.B6=matchvalvetnteam.radiant_b6(o);
                    table_ban_add.BA1=matchvalvetnteam.dire_b1(o);
                    table_ban_add.BA2=matchvalvetnteam.dire_b2(o);
                    table_ban_add.BA3=matchvalvetnteam.dire_b3(o);
                    table_ban_add.BA4=matchvalvetnteam.dire_b4(o);
                    table_ban_add.BA5=matchvalvetnteam.dire_b5(o);
                    table_ban_add.BA6=matchvalvetnteam.dire_b6(o);
                    table_ban=[table_ban;table_ban_add];
                else
                    table_ban_add.P1=matchvalvetnteam.dire_p1(o);
                    table_ban_add.P2=matchvalvetnteam.dire_p2(o);
                    table_ban_add.P3=matchvalvetnteam.dire_p3(o);
                    table_ban_add.P4=matchvalvetnteam.dire_p4(o);
                    table_ban_add.P5=matchvalvetnteam.dire_p5(o);
                    table_ban_add.PA1=matchvalvetnteam.radiant_p1(o);
                    table_ban_add.PA2=matchvalvetnteam.radiant_p2(o);
                    table_ban_add.PA3=matchvalvetnteam.radiant_p3(o);
                    table_ban_add.PA4=matchvalvetnteam.radiant_p4(o);
                    table_ban_add.PA5=matchvalvetnteam.radiant_p5(o);
                    table_ban_add.B1=matchvalvetnteam.dire_b1(o);
                    table_ban_add.B2=matchvalvetnteam.dire_b2(o);
                    table_ban_add.B3=matchvalvetnteam.dire_b3(o);
                    table_ban_add.B4=matchvalvetnteam.dire_b4(o);
                    table_ban_add.B5=matchvalvetnteam.dire_b5(o);
                    table_ban_add.B6=matchvalvetnteam.dire_b6(o);
                    table_ban_add.BA1=matchvalvetnteam.radiant_b1(o);
                    table_ban_add.BA2=matchvalvetnteam.radiant_b2(o);
                    table_ban_add.BA3=matchvalvetnteam.radiant_b3(o);
                    table_ban_add.BA4=matchvalvetnteam.radiant_b4(o);
                    table_ban_add.BA5=matchvalvetnteam.radiant_b5(o);
                    table_ban_add.BA6=matchvalvetnteam.radiant_b6(o);
                    table_ban=[table_ban;table_ban_add];
                end
            end
            list_hero_use=unique([table_ban.P1;table_ban.P2;table_ban.P3;table_ban.P4;table_ban.P5;...
                table_ban.PA1;table_ban.PA2;table_ban.PA3;table_ban.PA4;table_ban.PA5;...
                table_ban.B1;table_ban.B2;table_ban.B3;table_ban.B4;table_ban.B5;table_ban.B6;...
                table_ban.BA1;table_ban.BA2;table_ban.BA3;table_ban.BA4;table_ban.BA5;table_ban.BA6]);
            nb_hero_use=length(list_hero_use);
            for i=1:nb_hero_use
                CalcStatHero=player_match_valve3(player_match_valve3.hero_id==list_hero_use(i),:);
                StatHerosadd=table();
                StatHerosadd.id=NaN;
                StatHerosadd.hero_id=list_hero_use(i);
                StatHerosadd.id_tn=tn_id;
                StatHerosadd.is_qualif=0;
                StatHerosadd.team_id=list_team(n);
                StatHerosadd.nb_pick=height(CalcStatHero);
                nb_pick_against=table_ban(table_ban.PA1==list_hero_use(i) | ...
                    table_ban.PA2==list_hero_use(i) | ...
                    table_ban.PA3==list_hero_use(i) | ...
                    table_ban.PA4==list_hero_use(i) | ...
                    table_ban.PA5==list_hero_use(i),:);
                StatHerosadd.nb_pick_against=height(nb_pick_against);
                nb_ban=table_ban(table_ban.B1==list_hero_use(i) | ...
                    table_ban.B2==list_hero_use(i) | ...
                    table_ban.B3==list_hero_use(i) | ...
                    table_ban.B4==list_hero_use(i) | ...
                    table_ban.B5==list_hero_use(i) | ...
                    table_ban.B6==list_hero_use(i),:);
                StatHerosadd.nb_ban=height(nb_ban);
                nb_ban_against=table_ban(table_ban.BA1==list_hero_use(i) | ...
                    table_ban.BA2==list_hero_use(i) | ...
                    table_ban.BA3==list_hero_use(i) | ...
                    table_ban.BA4==list_hero_use(i) | ...
                    table_ban.BA5==list_hero_use(i) | ...
                    table_ban.BA6==list_hero_use(i),:);
                StatHerosadd.nb_ban_against=height(nb_ban_against);
                StatHerosadd.nb_match=height(matchvalvetnteam);
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
                StatHerosTeamAdd=[StatHerosTeamAdd;StatHerosadd];
            end
            StatHerosTeam=[StatHerosTeam;StatHerosTeamAdd]; %#ok<AGROW>
        end
        rqexist=['select id from public.stat_tn_team_hero where id_tn=',num2str(tn_id),' and is_qualif=0'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_team_hero where id_tn=',num2str(tn_id),' and is_qualif=0'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_team_hero',StatHerosTeam.Properties.VariableNames,StatHerosTeam,'id','public');
    case 'qualif'
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve(match_valve.is_qualif==1 & ~isnan(match_valve.radiant_b1),:);
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
        for l=1:nb_match
            playermatchtnadd=player_match_valve(player_match_valve.match_id==listmatch(l),:);
            playermatchtn=[playermatchtn;playermatchtnadd]; %#ok<AGROW>
        end
        nb_matchvalvetn=height(matchvalvetn);
        for j=1:nb_matchvalvetn
            player_temp=playermatchtn(playermatchtn.match_id==matchvalvetn.match_id(j),:);
            if matchvalvetn.radiant_win(j)==1
                player_temp.is_win(1:5,1)=1;
                player_temp.is_win(6:10,1)=0;
            else
                player_temp.is_win(1:5,1)=0;
                player_temp.is_win(6:10,1)=1;
            end
            for m=1:10
                player_temp.team_id(m)=player.team_id(player.player_id==player_temp.account_id(m));
            end
            player_match_valve2=[player_match_valve2;player_temp]; %#ok<AGROW>
        end
        list_team=unique([matchvalvetn.radiant_team_id;matchvalvetn.dire_team_id]);
        nb_team=length(list_team);
        StatHerosTeam=table();
        for n=1:nb_team
            player_match_valve3=player_match_valve2(player_match_valve2.team_id==list_team(n),:);
            StatHerosTeamAdd=table();
            matchvalvetnteam=matchvalvetn((matchvalvetn.radiant_team_id==list_team(n) | matchvalvetn.dire_team_id==list_team(n)),:);
            table_ban=table();
            for o=1:height(matchvalvetnteam)
                table_ban_add=table();
                if matchvalvetnteam.radiant_team_id(o)==list_team(n)
                    table_ban_add.P1=matchvalvetnteam.radiant_p1(o);
                    table_ban_add.P2=matchvalvetnteam.radiant_p2(o);
                    table_ban_add.P3=matchvalvetnteam.radiant_p3(o);
                    table_ban_add.P4=matchvalvetnteam.radiant_p4(o);
                    table_ban_add.P5=matchvalvetnteam.radiant_p5(o);
                    table_ban_add.PA1=matchvalvetnteam.dire_p1(o);
                    table_ban_add.PA2=matchvalvetnteam.dire_p2(o);
                    table_ban_add.PA3=matchvalvetnteam.dire_p3(o);
                    table_ban_add.PA4=matchvalvetnteam.dire_p4(o);
                    table_ban_add.PA5=matchvalvetnteam.dire_p5(o);
                    table_ban_add.B1=matchvalvetnteam.radiant_b1(o);
                    table_ban_add.B2=matchvalvetnteam.radiant_b2(o);
                    table_ban_add.B3=matchvalvetnteam.radiant_b3(o);
                    table_ban_add.B4=matchvalvetnteam.radiant_b4(o);
                    table_ban_add.B5=matchvalvetnteam.radiant_b5(o);
                    table_ban_add.B6=matchvalvetnteam.radiant_b6(o);
                    table_ban_add.BA1=matchvalvetnteam.dire_b1(o);
                    table_ban_add.BA2=matchvalvetnteam.dire_b2(o);
                    table_ban_add.BA3=matchvalvetnteam.dire_b3(o);
                    table_ban_add.BA4=matchvalvetnteam.dire_b4(o);
                    table_ban_add.BA5=matchvalvetnteam.dire_b5(o);
                    table_ban_add.BA6=matchvalvetnteam.dire_b6(o);
                    table_ban=[table_ban;table_ban_add];
                else
                    table_ban_add.P1=matchvalvetnteam.dire_p1(o);
                    table_ban_add.P2=matchvalvetnteam.dire_p2(o);
                    table_ban_add.P3=matchvalvetnteam.dire_p3(o);
                    table_ban_add.P4=matchvalvetnteam.dire_p4(o);
                    table_ban_add.P5=matchvalvetnteam.dire_p5(o);
                    table_ban_add.PA1=matchvalvetnteam.radiant_p1(o);
                    table_ban_add.PA2=matchvalvetnteam.radiant_p2(o);
                    table_ban_add.PA3=matchvalvetnteam.radiant_p3(o);
                    table_ban_add.PA4=matchvalvetnteam.radiant_p4(o);
                    table_ban_add.PA5=matchvalvetnteam.radiant_p5(o);
                    table_ban_add.B1=matchvalvetnteam.dire_b1(o);
                    table_ban_add.B2=matchvalvetnteam.dire_b2(o);
                    table_ban_add.B3=matchvalvetnteam.dire_b3(o);
                    table_ban_add.B4=matchvalvetnteam.dire_b4(o);
                    table_ban_add.B5=matchvalvetnteam.dire_b5(o);
                    table_ban_add.B6=matchvalvetnteam.dire_b6(o);
                    table_ban_add.BA1=matchvalvetnteam.radiant_b1(o);
                    table_ban_add.BA2=matchvalvetnteam.radiant_b2(o);
                    table_ban_add.BA3=matchvalvetnteam.radiant_b3(o);
                    table_ban_add.BA4=matchvalvetnteam.radiant_b4(o);
                    table_ban_add.BA5=matchvalvetnteam.radiant_b5(o);
                    table_ban_add.BA6=matchvalvetnteam.radiant_b6(o);
                    table_ban=[table_ban;table_ban_add];
                end
            end
            list_hero_use=unique([table_ban.P1;table_ban.P2;table_ban.P3;table_ban.P4;table_ban.P5;...
                table_ban.PA1;table_ban.PA2;table_ban.PA3;table_ban.PA4;table_ban.PA5;...
                table_ban.B1;table_ban.B2;table_ban.B3;table_ban.B4;table_ban.B5;table_ban.B6;...
                table_ban.BA1;table_ban.BA2;table_ban.BA3;table_ban.BA4;table_ban.BA5;table_ban.BA6]);
            nb_hero_use=length(list_hero_use);
            for i=1:nb_hero_use
                CalcStatHero=player_match_valve3(player_match_valve3.hero_id==list_hero_use(i),:);
                StatHerosadd=table();
                StatHerosadd.id=NaN;
                StatHerosadd.hero_id=list_hero_use(i);
                StatHerosadd.id_tn=tn_id;
                StatHerosadd.is_qualif=1;
                StatHerosadd.team_id=list_team(n);
                StatHerosadd.nb_pick=height(CalcStatHero);
                nb_pick_against=table_ban(table_ban.PA1==list_hero_use(i) | ...
                    table_ban.PA2==list_hero_use(i) | ...
                    table_ban.PA3==list_hero_use(i) | ...
                    table_ban.PA4==list_hero_use(i) | ...
                    table_ban.PA5==list_hero_use(i),:);
                StatHerosadd.nb_pick_against=height(nb_pick_against);
                nb_ban=table_ban(table_ban.B1==list_hero_use(i) | ...
                    table_ban.B2==list_hero_use(i) | ...
                    table_ban.B3==list_hero_use(i) | ...
                    table_ban.B4==list_hero_use(i) | ...
                    table_ban.B5==list_hero_use(i) | ...
                    table_ban.B6==list_hero_use(i),:);
                StatHerosadd.nb_ban=height(nb_ban);
                nb_ban_against=table_ban(table_ban.BA1==list_hero_use(i) | ...
                    table_ban.BA2==list_hero_use(i) | ...
                    table_ban.BA3==list_hero_use(i) | ...
                    table_ban.BA4==list_hero_use(i) | ...
                    table_ban.BA5==list_hero_use(i) | ...
                    table_ban.BA6==list_hero_use(i),:);
                StatHerosadd.nb_ban_against=height(nb_ban_against);
                StatHerosadd.nb_match=height(matchvalvetnteam);
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
                StatHerosTeamAdd=[StatHerosTeamAdd;StatHerosadd];
            end
            StatHerosTeam=[StatHerosTeam;StatHerosTeamAdd]; %#ok<AGROW>
        end
        rqexist=['select id from public.stat_tn_team_hero where id_tn=',num2str(tn_id),' and is_qualif=1'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_team_hero where id_tn=',num2str(tn_id),' and is_qualif=1'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_team_hero',StatHerosTeam.Properties.VariableNames,StatHerosTeam,'id','public');
    case 'all'
        player_match_valve2=table();
        playermatchtn=table();
        matchvalvetn=match_valve(~isnan(match_valve.radiant_b1),:);
        listmatch=unique(matchvalvetn.match_id);
        nb_match=length(listmatch);
        for l=1:nb_match
            playermatchtnadd=player_match_valve(player_match_valve.match_id==listmatch(l),:);
            playermatchtn=[playermatchtn;playermatchtnadd]; %#ok<AGROW>
        end
        nb_matchvalvetn=height(matchvalvetn);
        for j=1:nb_matchvalvetn
            player_temp=playermatchtn(playermatchtn.match_id==matchvalvetn.match_id(j),:);
            if matchvalvetn.radiant_win(j)==1
                player_temp.is_win(1:5,1)=1;
                player_temp.is_win(6:10,1)=0;
            else
                player_temp.is_win(1:5,1)=0;
                player_temp.is_win(6:10,1)=1;
            end
            for m=1:10
                player_temp.team_id(m)=player.team_id(player.player_id==player_temp.account_id(m));
            end
            player_match_valve2=[player_match_valve2;player_temp]; %#ok<AGROW>
        end
        list_team=unique([matchvalvetn.radiant_team_id;matchvalvetn.dire_team_id]);
        nb_team=length(list_team);
        StatHerosTeam=table();
        for n=1:nb_team
            player_match_valve3=player_match_valve2(player_match_valve2.team_id==list_team(n),:);
            StatHerosTeamAdd=table();
            matchvalvetnteam=matchvalvetn((matchvalvetn.radiant_team_id==list_team(n) | matchvalvetn.dire_team_id==list_team(n)),:);
            table_ban=table();
            for o=1:height(matchvalvetnteam)
                table_ban_add=table();
                if matchvalvetnteam.radiant_team_id(o)==list_team(n)
                    table_ban_add.P1=matchvalvetnteam.radiant_p1(o);
                    table_ban_add.P2=matchvalvetnteam.radiant_p2(o);
                    table_ban_add.P3=matchvalvetnteam.radiant_p3(o);
                    table_ban_add.P4=matchvalvetnteam.radiant_p4(o);
                    table_ban_add.P5=matchvalvetnteam.radiant_p5(o);
                    table_ban_add.PA1=matchvalvetnteam.dire_p1(o);
                    table_ban_add.PA2=matchvalvetnteam.dire_p2(o);
                    table_ban_add.PA3=matchvalvetnteam.dire_p3(o);
                    table_ban_add.PA4=matchvalvetnteam.dire_p4(o);
                    table_ban_add.PA5=matchvalvetnteam.dire_p5(o);
                    table_ban_add.B1=matchvalvetnteam.radiant_b1(o);
                    table_ban_add.B2=matchvalvetnteam.radiant_b2(o);
                    table_ban_add.B3=matchvalvetnteam.radiant_b3(o);
                    table_ban_add.B4=matchvalvetnteam.radiant_b4(o);
                    table_ban_add.B5=matchvalvetnteam.radiant_b5(o);
                    table_ban_add.B6=matchvalvetnteam.radiant_b6(o);
                    table_ban_add.BA1=matchvalvetnteam.dire_b1(o);
                    table_ban_add.BA2=matchvalvetnteam.dire_b2(o);
                    table_ban_add.BA3=matchvalvetnteam.dire_b3(o);
                    table_ban_add.BA4=matchvalvetnteam.dire_b4(o);
                    table_ban_add.BA5=matchvalvetnteam.dire_b5(o);
                    table_ban_add.BA6=matchvalvetnteam.dire_b6(o);
                    table_ban=[table_ban;table_ban_add];
                else
                    table_ban_add.P1=matchvalvetnteam.dire_p1(o);
                    table_ban_add.P2=matchvalvetnteam.dire_p2(o);
                    table_ban_add.P3=matchvalvetnteam.dire_p3(o);
                    table_ban_add.P4=matchvalvetnteam.dire_p4(o);
                    table_ban_add.P5=matchvalvetnteam.dire_p5(o);
                    table_ban_add.PA1=matchvalvetnteam.radiant_p1(o);
                    table_ban_add.PA2=matchvalvetnteam.radiant_p2(o);
                    table_ban_add.PA3=matchvalvetnteam.radiant_p3(o);
                    table_ban_add.PA4=matchvalvetnteam.radiant_p4(o);
                    table_ban_add.PA5=matchvalvetnteam.radiant_p5(o);
                    table_ban_add.B1=matchvalvetnteam.dire_b1(o);
                    table_ban_add.B2=matchvalvetnteam.dire_b2(o);
                    table_ban_add.B3=matchvalvetnteam.dire_b3(o);
                    table_ban_add.B4=matchvalvetnteam.dire_b4(o);
                    table_ban_add.B5=matchvalvetnteam.dire_b5(o);
                    table_ban_add.B6=matchvalvetnteam.dire_b6(o);
                    table_ban_add.BA1=matchvalvetnteam.radiant_b1(o);
                    table_ban_add.BA2=matchvalvetnteam.radiant_b2(o);
                    table_ban_add.BA3=matchvalvetnteam.radiant_b3(o);
                    table_ban_add.BA4=matchvalvetnteam.radiant_b4(o);
                    table_ban_add.BA5=matchvalvetnteam.radiant_b5(o);
                    table_ban_add.BA6=matchvalvetnteam.radiant_b6(o);
                    table_ban=[table_ban;table_ban_add];
                end
            end
            list_hero_use=unique([table_ban.P1;table_ban.P2;table_ban.P3;table_ban.P4;table_ban.P5;...
                table_ban.PA1;table_ban.PA2;table_ban.PA3;table_ban.PA4;table_ban.PA5;...
                table_ban.B1;table_ban.B2;table_ban.B3;table_ban.B4;table_ban.B5;table_ban.B6;...
                table_ban.BA1;table_ban.BA2;table_ban.BA3;table_ban.BA4;table_ban.BA5;table_ban.BA6]);
            nb_hero_use=length(list_hero_use);
            for i=1:nb_hero_use
                CalcStatHero=player_match_valve3(player_match_valve3.hero_id==list_hero_use(i),:);
                StatHerosadd=table();
                StatHerosadd.id=NaN;
                StatHerosadd.hero_id=list_hero_use(i);
                StatHerosadd.id_tn=tn_id;
                StatHerosadd.is_qualif=NaN;
                StatHerosadd.team_id=list_team(n);
                StatHerosadd.nb_pick=height(CalcStatHero);
                nb_pick_against=table_ban(table_ban.PA1==list_hero_use(i) | ...
                    table_ban.PA2==list_hero_use(i) | ...
                    table_ban.PA3==list_hero_use(i) | ...
                    table_ban.PA4==list_hero_use(i) | ...
                    table_ban.PA5==list_hero_use(i),:);
                StatHerosadd.nb_pick_against=height(nb_pick_against);
                nb_ban=table_ban(table_ban.B1==list_hero_use(i) | ...
                    table_ban.B2==list_hero_use(i) | ...
                    table_ban.B3==list_hero_use(i) | ...
                    table_ban.B4==list_hero_use(i) | ...
                    table_ban.B5==list_hero_use(i) | ...
                    table_ban.B6==list_hero_use(i),:);
                StatHerosadd.nb_ban=height(nb_ban);
                nb_ban_against=table_ban(table_ban.BA1==list_hero_use(i) | ...
                    table_ban.BA2==list_hero_use(i) | ...
                    table_ban.BA3==list_hero_use(i) | ...
                    table_ban.BA4==list_hero_use(i) | ...
                    table_ban.BA5==list_hero_use(i) | ...
                    table_ban.BA6==list_hero_use(i),:);
                StatHerosadd.nb_ban_against=height(nb_ban_against);
                StatHerosadd.nb_match=height(matchvalvetnteam);
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
                StatHerosTeamAdd=[StatHerosTeamAdd;StatHerosadd];
            end
            StatHerosTeam=[StatHerosTeam;StatHerosTeamAdd]; %#ok<AGROW>
        end
        rqexist=['select id from public.stat_tn_team_hero where id_tn=',num2str(tn_id),' and is_qualif=null'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_team_hero where id_tn=',num2str(tn_id),' and is_qualif=null'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_team_hero',StatHerosTeam.Properties.VariableNames,StatHerosTeam,'id','public');
        
        
end
disp('Traitement OK')
end