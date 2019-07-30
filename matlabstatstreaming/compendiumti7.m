function [BD_TI7_CompPlayer,BD_TI7_CompPlayerStat,BD_TI7_CompTeamStat,BD_TI7_CompHeroStat,BD_TI7_CompTeam,BD_TI7_CompHeros,BD_TI7_CompTN]=compendiumti7(BD_TI7_StatMatchPlayer,BD_TI7_StatMatchTeam,BD_TI7_Player,BD_TI7_Team,BD_TI7_StatTeam,BD_TI7_StatPlayer,BD_TI7_StatHeros,BD_TI7_Hero)


%% Player

BD_TI7_CompPlayerStat=table();

for i=1:height(BD_TI7_Player)
    BD_TI7_CompPlayerStatadd=table();
    BD_TI7_CompPlayerStatadd.account_id=BD_TI7_Player.account_id(i,1);
    BD_TI7_CompPlayerStatadd.team_id=BD_TI7_Player.team_id(i,1);
    BD_TI7_CompPlayerStatadd.Pseudo=BD_TI7_Player.Pseudo(i,1);
    BD_TI7_CompPlayerStatadd.team_name=BD_TI7_Player.team_name(i,1);
    if sum(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id)~=0
        BD_TI7_CompPlayerStatadd.meankills=BD_TI7_StatPlayer.mean_kills(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.maxkills=BD_TI7_StatPlayer.max_kills(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.meamdeaths=BD_TI7_StatPlayer.mean_deaths(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.meanassists=BD_TI7_StatPlayer.mean_assists(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.maxassists=BD_TI7_StatPlayer.max_assists(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.meanlasthit=BD_TI7_StatPlayer.mean_last_hits(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.maxlasthit=BD_TI7_StatPlayer.max_last_hits(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.maxopm=BD_TI7_StatPlayer.max_opm(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.meanopm=BD_TI7_StatPlayer.mean_opm(BD_TI7_StatPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,1);
        BD_TI7_CompPlayerStatadd.nb_heros=length(unique(BD_TI7_StatMatchPlayer.hero_id(BD_TI7_StatMatchPlayer.account_id==BD_TI7_CompPlayerStatadd.account_id,:)));
        BD_TI7_CompPlayerStat=[BD_TI7_CompPlayerStat;BD_TI7_CompPlayerStatadd]; %#ok<AGROW>
    end
end

BD_TI7_CompPlayer=table();

for i=5:width(BD_TI7_CompPlayerStat)
    if i==7
        minvalue=min(table2array(BD_TI7_CompPlayerStat(:,i)));
        idx=find(table2array(BD_TI7_CompPlayerStat(:,i))==minvalue,1);
        for j=1:length(BD_TI7_CompPlayerStat{idx,i})
            BD_TI7_CompPlayeradd=table();
            BD_TI7_CompPlayeradd.type=BD_TI7_CompPlayerStat.Properties.VariableNames(i);
            BD_TI7_CompPlayeradd.value=BD_TI7_CompPlayerStat{idx(j),i};
            BD_TI7_CompPlayeradd.Player=BD_TI7_CompPlayerStat{idx(j),3};
            BD_TI7_CompPlayeradd.Team=BD_TI7_CompPlayerStat{idx(j),4};
            BD_TI7_CompPlayer=[BD_TI7_CompPlayer;BD_TI7_CompPlayeradd]; %#ok<AGROW>
        end
    else
        maxvalue=max(table2array(BD_TI7_CompPlayerStat(:,i)));
        idx=find(table2array(BD_TI7_CompPlayerStat(:,i))==maxvalue,1);
        for j=1:length(BD_TI7_CompPlayerStat{idx,i})
            BD_TI7_CompPlayeradd=table();
            BD_TI7_CompPlayeradd.type=BD_TI7_CompPlayerStat.Properties.VariableNames(i);
            BD_TI7_CompPlayeradd.value=BD_TI7_CompPlayerStat{idx(j),i};
            BD_TI7_CompPlayeradd.Player=BD_TI7_CompPlayerStat{idx(j),3};
            BD_TI7_CompPlayeradd.Team=BD_TI7_CompPlayerStat{idx(j),4};
            BD_TI7_CompPlayer=[BD_TI7_CompPlayer;BD_TI7_CompPlayeradd]; %#ok<AGROW>
        end
    end
end

%% team

BD_TI7_CompTeamStat=table();


for i=1:height(BD_TI7_Team)
    BD_TI7_CompTeamStatadd=table();
    BD_TI7_CompTeamStatadd.team_id=BD_TI7_Team.team_id(i,1);
    BD_TI7_CompTeamStatadd.team_name=BD_TI7_Team.name(i,1);
    if sum(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id)~=0
        BD_TI7_CompTeamStatadd.maxkills=BD_TI7_StatTeam.max_kills(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStatadd.meankills=BD_TI7_StatTeam.mean_kills(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStatadd.meandeaths=BD_TI7_StatTeam.mean_deaths(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStatadd.maxassists=BD_TI7_StatTeam.max_assist(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStatadd.mintemps=BD_TI7_StatTeam.min_temps(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStatadd.maxtemps=BD_TI7_StatTeam.max_temps(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStatadd.nbherosmax=length(unique([BD_TI7_StatMatchTeam.pick1(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick2(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick3(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick4(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick5(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id)]));
        BD_TI7_CompTeamStatadd.nbherosmin=length(unique([BD_TI7_StatMatchTeam.pick1(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick2(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick3(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick4(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id);...
            BD_TI7_StatMatchTeam.pick5(BD_TI7_StatMatchTeam.team_id==BD_TI7_CompTeamStatadd.team_id)]));
        BD_TI7_CompTeamStatadd.meantemps=BD_TI7_StatTeam.mean_temps(BD_TI7_StatTeam.team_id==BD_TI7_CompTeamStatadd.team_id,1);
        BD_TI7_CompTeamStat=[BD_TI7_CompTeamStat;BD_TI7_CompTeamStatadd]; %#ok<AGROW>
    end
end

BD_TI7_CompTeam=table();

for i=3:width(BD_TI7_CompTeamStat)
    if i==7 || i==5 || i==10
        minvalue=min(table2array(BD_TI7_CompTeamStat(:,i)));
        idx=find(table2array(BD_TI7_CompTeamStat(:,i))==minvalue,1);
        for j=1:length(BD_TI7_CompTeamStat{idx,i})
            BD_TI7_CompTeamadd=table();
            BD_TI7_CompTeamadd.type=BD_TI7_CompTeamStat.Properties.VariableNames(i);
            BD_TI7_CompTeamadd.value=BD_TI7_CompTeamStat{idx(j),i};
            BD_TI7_CompTeamadd.Team=BD_TI7_CompTeamStat{idx(j),2};
            BD_TI7_CompTeam=[BD_TI7_CompTeam;BD_TI7_CompTeamadd];  %#ok<AGROW>
        end
    else
        maxvalue=max(table2array(BD_TI7_CompTeamStat(:,i)));
        idx=find(table2array(BD_TI7_CompTeamStat(:,i))==maxvalue,1);
        for j=1:length(BD_TI7_CompTeamStat{idx,i})
            BD_TI7_CompTeamadd=table();
            BD_TI7_CompTeamadd.type=BD_TI7_CompTeamStat.Properties.VariableNames(i);
            BD_TI7_CompTeamadd.value=BD_TI7_CompTeamStat{idx(j),i};
            BD_TI7_CompTeamadd.Team=BD_TI7_CompTeamStat{idx(j),2};
            BD_TI7_CompTeam=[BD_TI7_CompTeam;BD_TI7_CompTeamadd]; %#ok<AGROW>
        end
    end
end


%% Hero

BD_TI7_CompHeroStat=table();


for i=1:height(BD_TI7_Hero)
    BD_TI7_CompHeroStatadd=table();
    BD_TI7_CompHeroStatadd.hero_id=BD_TI7_Hero.ID(i,1);
    BD_TI7_CompHeroStatadd.hero_name=BD_TI7_Hero.Nom(i,1);
    if sum(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id)~=0
        BD_TI7_CompHeroStatadd.maxpick=BD_TI7_StatHeros.nb_pick(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.maxban=BD_TI7_StatHeros.nb_ban(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.meanwin=BD_TI7_StatHeros.mean_is_win(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.meanassist=BD_TI7_StatHeros.mean_assists(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.meankill=BD_TI7_StatHeros.mean_kills(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.meandeath=BD_TI7_StatHeros.mean_deaths(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.meanxpm=BD_TI7_StatHeros.mean_xpmraw(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.maxkill=BD_TI7_StatHeros.max_kills(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.maxlasthit=BD_TI7_StatHeros.max_last_hits(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStatadd.meanlasthit=BD_TI7_StatHeros.mean_last_hits(BD_TI7_StatHeros.hero_id==BD_TI7_CompHeroStatadd.hero_id,1);
        BD_TI7_CompHeroStat=[BD_TI7_CompHeroStat;BD_TI7_CompHeroStatadd]; %#ok<AGROW>
    end
end

BD_TI7_CompHeros=table();

for i=3:width(BD_TI7_CompHeroStat)
    if i==3 || i==4 || i==10 || i==11
        maxvalue=max(table2array(BD_TI7_CompHeroStat(:,i)));
        idx=find(table2array(BD_TI7_CompHeroStat(:,i))==maxvalue,1);
        for j=1:length(BD_TI7_CompHeroStat{idx,i})
            BD_TI7_CompHerosadd=table();
            BD_TI7_CompHerosadd.type=BD_TI7_CompHeroStat.Properties.VariableNames(i);
            BD_TI7_CompHerosadd.value=BD_TI7_CompHeroStat{idx(j),i};
            BD_TI7_CompHerosadd.Hero=BD_TI7_CompHeroStat{idx(j),2};
            BD_TI7_CompHeros=[BD_TI7_CompHeros;BD_TI7_CompHerosadd]; %#ok<AGROW>
        end
    elseif i==8
        BD_TI7_CompHeroStat5=BD_TI7_CompHeroStat(BD_TI7_CompHeroStat.maxpick>5,:);
        minvalue=min(table2array(BD_TI7_CompHeroStat5(:,i)));
        idx=find(table2array(BD_TI7_CompHeroStat5(:,i))==minvalue,1);
        for j=1:length(BD_TI7_CompHeroStat5{idx,i})
            BD_TI7_CompHerosadd=table();
            BD_TI7_CompHerosadd.type=BD_TI7_CompHeroStat5.Properties.VariableNames(i);
            BD_TI7_CompHerosadd.value=BD_TI7_CompHeroStat5{idx(j),i};
            BD_TI7_CompHerosadd.Hero=BD_TI7_CompHeroStat5{idx(j),2};
            BD_TI7_CompHeros=[BD_TI7_CompHeros;BD_TI7_CompHerosadd]; %#ok<AGROW>
        end
    else
        BD_TI7_CompHeroStat5=BD_TI7_CompHeroStat(BD_TI7_CompHeroStat.maxpick>5,:);
        maxvalue=max(table2array(BD_TI7_CompHeroStat5(:,i)));
        idx=find(table2array(BD_TI7_CompHeroStat5(:,i))==maxvalue,1);
        for j=1:length(BD_TI7_CompHeroStat5{idx,i})
            BD_TI7_CompHerosadd=table();
            BD_TI7_CompHerosadd.type=BD_TI7_CompHeroStat5.Properties.VariableNames(i);
            BD_TI7_CompHerosadd.value=BD_TI7_CompHeroStat5{idx(j),i};
            BD_TI7_CompHerosadd.Hero=BD_TI7_CompHeroStat5{idx(j),2};
            BD_TI7_CompHeros=[BD_TI7_CompHeros;BD_TI7_CompHerosadd]; %#ok<AGROW>
        end
    end
end




%% TN
BD_TI7_CompTN=table();





end