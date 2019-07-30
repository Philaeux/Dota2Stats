function [mvp_name,mvp_score,mvp_heros,StatMatchMVP,ContextMatch]=mvp_matchti7(datamatch,ContextMatch,StatMatchPlayer,Hero,Player)
%%% A partir des données, qui est le MVP du match %%%

StatMatchMVP=table();

for i=1:10
    
    %% Récupération du nom des joueurs id match %%
    StatMatchMVP.player_id(i,1)=datamatch.players{i}.account_id;
    StatMatchMVP.match_id(i,1)=datamatch.match_id;
    
    %% Récupération du nombre de kills %%
    StatMatchMVP.KD(i,1)=5+0.3*(datamatch.players{i}.kills-datamatch.players{i}.deaths);
    
    %% Récupération du GPM %%
    StatMatchMVP.GPM(i,1)=0.002*datamatch.players{i}.gold_per_min;
    
    %% Récupération du Last Hit %%
    StatMatchMVP.LH(i,1)=0.003*(datamatch.players{i}.last_hits+datamatch.players{i}.denies);
    
    %% Récupération du temps de Stun %%
    StatMatchMVP.Stuns(i,1)=0.05*datamatch.players{i}.stuns;
    
    %% Récupération du LH de Towers %%
    StatMatchMVP.LHTowers(i,1)=datamatch.players{i}.tower_kills;
    
    %% Récupération du LH de Rosh %%
    try
        StatMatchMVP.Rosh(i,1)=datamatch.players{i}.killed.npc_dota_roshan;
    catch
        StatMatchMVP.Rosh(i,1)=0;
    end
    
    %% Récupération des Observers %%
    StatMatchMVP.Observers(i,1)=0.5*datamatch.players{i}.obs_placed;
    
    %% Récupération du nombre de Stack %%
    StatMatchMVP.Stacks(i,1)=0.5*datamatch.players{i}.camps_stacked;
    
    %% Récupération du nb rune %%
    StatMatchMVP.Runes(i,1)=0.25*length(datamatch.players{i}.runes_log);
    
    %% Récupération du FirstBlood %%
    if datamatch.players{i}.firstblood_claimed==1
        StatMatchMVP.FB(i,1)=4;
    else
        StatMatchMVP.FB(i,1)=0;
    end
    
    %% Récupération du %TF %%
    if i<6
        StatMatchMVP.TF(i,1)=5*((datamatch.players{i}.assists+datamatch.players{i}.kills)/datamatch.radiant_score);
    else
        StatMatchMVP.TF(i,1)=5*((datamatch.players{i}.assists+datamatch.players{i}.kills)/datamatch.dire_score);
    end
    
    %% Calcul des point MVP %%
    
    StatMatchMVP.pt_fantasy(i,1)=StatMatchMVP.KD(i,1)+StatMatchMVP.GPM(i,1)+StatMatchMVP.LH(i,1)+StatMatchMVP.LH(i,1)...
        +StatMatchMVP.Stuns(i,1)+StatMatchMVP.LHTowers(i,1)+StatMatchMVP.Rosh(i,1)+StatMatchMVP.Observers(i,1)+StatMatchMVP.Stacks(i,1)...
        +StatMatchMVP.Runes(i,1)+StatMatchMVP.FB(i,1)+StatMatchMVP.TF(i,1);
end

mvp_score=num2str(max(StatMatchMVP.pt_fantasy));
mvp_id=StatMatchMVP.player_id(StatMatchMVP.pt_fantasy==max(StatMatchMVP.pt_fantasy),1);


mvp_name=char(Player.Pseudo(Player.account_id==mvp_id));

mvp_heros=char(Hero.Nom(Hero.ID==StatMatchPlayer.hero_id(StatMatchPlayer.account_id==mvp_id)));
ContextMatch.mvp_id(1,1)=mvp_id;
ContextMatch.mvp_hero_id(1,1)=StatMatchPlayer.hero_id(StatMatchPlayer.account_id==mvp_id);
ContextMatch.mvp_hero_name{1,1}=mvp_heros;
ContextMatch.mvp_name{1,1}=mvp_name;





end