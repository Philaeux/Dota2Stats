function [StatMatch,ContextMatch,StatMatchPlayer]=StatMatchMajorti7(datamatch,Tournoisadd,Match)
warning off;
StatMatchPlayer=table();
StatMatch=table();
ContextMatch=table();

%disp(['Match ID : ',num2str(datamatch.match_id),' Team A : ',char(Match.TeamName1(Match.SteamID==datamatch.match_id)),' Team B : ',char(Match.TeamName2(Match.SteamID==datamatch.match_id))])

StatMatch.id_tn{1,1}=Tournoisadd.TOO_ID;
ContextMatch.id_tn{1,1}=Tournoisadd.TOO_ID;
StatMatch.tn_name{1,1}=Tournoisadd.Nom;
ContextMatch.tn_name{1,1}=Tournoisadd.Nom;
StatMatch.match_id(1,1)=datamatch.match_id;
ContextMatch.match_id(1,1)=datamatch.match_id;

%% contexte
ContextMatch.start_time(1,1)=datetime(datamatch.start_time,'ConvertFrom','posixtime')+hours(2);
if isfield(datamatch,'radiant_team')==1
    ContextMatch.team_idr(1,1)=datamatch.radiant_team.team_id;
    ContextMatch.namer{1,1}=Match.TeamName1(Match.SteamID==datamatch.match_id);
else
    ContextMatch.team_idr(1,1)=NaN;
    ContextMatch.namer{1,1}=Match.TeamName1(Match.SteamID==datamatch.match_id);
end
if isfield(datamatch,'dire_team')==1
    ContextMatch.team_idd(1,1)=datamatch.dire_team.team_id;
    ContextMatch.named{1,1}=Match.TeamName2(Match.SteamID==datamatch.match_id);
else
    ContextMatch.team_idd(1,1)=NaN;
    ContextMatch.named{1,1}=Match.TeamName2(Match.SteamID==datamatch.match_id);
end
ContextMatch.posi_vote(1,1)=datamatch.positive_votes;
ContextMatch.nega_vote(1,1)=datamatch.negative_votes;
if datamatch.radiant_win==1 %1=radiant 0=dire
    ContextMatch.win{1,1}='Radiant';
else
    ContextMatch.win{1,1}='Dire';
end
ContextMatch.isfp(1,1)=datamatch.picks_bans(1).team;

%% pick
is_pick = [datamatch.picks_bans.is_pick].';
team = [datamatch.picks_bans.team].';
idxr=find(is_pick==1 & team==0);
%pick radiant
ContextMatch.PickR1(1,1)=datamatch.picks_bans(idxr(1)).hero_id;
ContextMatch.PickR2(1,1)=datamatch.picks_bans(idxr(2)).hero_id;
ContextMatch.PickR3(1,1)=datamatch.picks_bans(idxr(3)).hero_id;
ContextMatch.PickR4(1,1)=datamatch.picks_bans(idxr(4)).hero_id;
ContextMatch.PickR5(1,1)=datamatch.picks_bans(idxr(5)).hero_id;
%pick dire
idxd=find(is_pick==1 & team==1);
ContextMatch.PickD1(1,1)=datamatch.picks_bans(idxd(1)).hero_id;
ContextMatch.PickD2(1,1)=datamatch.picks_bans(idxd(2)).hero_id;
ContextMatch.PickD3(1,1)=datamatch.picks_bans(idxd(3)).hero_id;
ContextMatch.PickD4(1,1)=datamatch.picks_bans(idxd(4)).hero_id;
ContextMatch.PickD5(1,1)=datamatch.picks_bans(idxd(5)).hero_id;
%ban radian
idxbr=find(is_pick==0 & team==0);
switch length(idxbr)
    case 1
        ContextMatch.BanR1(1,1)=datamatch.picks_bans(idxbr(1)).hero_id;
        ContextMatch.BanR2(1,1)=NaN;
        ContextMatch.BanR3(1,1)=NaN;
        ContextMatch.BanR4(1,1)=NaN;
        ContextMatch.BanR5(1,1)=NaN;
    case 2
        ContextMatch.BanR1(1,1)=datamatch.picks_bans(idxbr(1)).hero_id;
        ContextMatch.BanR2(1,1)=datamatch.picks_bans(idxbr(2)).hero_id;
        ContextMatch.BanR3(1,1)=NaN;
        ContextMatch.BanR4(1,1)=NaN;
        ContextMatch.BanR5(1,1)=NaN;
    case 3
        ContextMatch.BanR1(1,1)=datamatch.picks_bans(idxbr(1)).hero_id;
        ContextMatch.BanR2(1,1)=datamatch.picks_bans(idxbr(2)).hero_id;
        ContextMatch.BanR3(1,1)=datamatch.picks_bans(idxbr(3)).hero_id;
        ContextMatch.BanR4(1,1)=NaN;
        ContextMatch.BanR5(1,1)=NaN;
    case 4
        ContextMatch.BanR1(1,1)=datamatch.picks_bans(idxbr(1)).hero_id;
        ContextMatch.BanR2(1,1)=datamatch.picks_bans(idxbr(2)).hero_id;
        ContextMatch.BanR3(1,1)=datamatch.picks_bans(idxbr(3)).hero_id;
        ContextMatch.BanR4(1,1)=datamatch.picks_bans(idxbr(4)).hero_id;
        ContextMatch.BanR5(1,1)=NaN;
    case 5
        ContextMatch.BanR1(1,1)=datamatch.picks_bans(idxbr(1)).hero_id;
        ContextMatch.BanR2(1,1)=datamatch.picks_bans(idxbr(2)).hero_id;
        ContextMatch.BanR3(1,1)=datamatch.picks_bans(idxbr(3)).hero_id;
        ContextMatch.BanR4(1,1)=datamatch.picks_bans(idxbr(4)).hero_id;
        ContextMatch.BanR5(1,1)=datamatch.picks_bans(idxbr(5)).hero_id;
    otherwise
        ContextMatch.BanR1(1,1)=NaN;
        ContextMatch.BanR2(1,1)=NaN;
        ContextMatch.BanR3(1,1)=NaN;
        ContextMatch.BanR4(1,1)=NaN;
        ContextMatch.BanR5(1,1)=NaN;
end

%ban radian
idxbd=find(is_pick==0 & team==1);
switch length(idxbd)
    case 1
        ContextMatch.BanD1(1,1)=datamatch.picks_bans(idxbd(1)).hero_id;
        ContextMatch.BanD2(1,1)=NaN;
        ContextMatch.BanD3(1,1)=NaN;
        ContextMatch.BanD4(1,1)=NaN;
        ContextMatch.BanD5(1,1)=NaN;
    case 2
        ContextMatch.BanD1(1,1)=datamatch.picks_bans(idxbd(1)).hero_id;
        ContextMatch.BanD2(1,1)=datamatch.picks_bans(idxbd(2)).hero_id;
        ContextMatch.BanD3(1,1)=NaN;
        ContextMatch.BanD4(1,1)=NaN;
        ContextMatch.BanD5(1,1)=NaN;
    case 3
        ContextMatch.BanD1(1,1)=datamatch.picks_bans(idxbd(1)).hero_id;
        ContextMatch.BanD2(1,1)=datamatch.picks_bans(idxbd(2)).hero_id;
        ContextMatch.BanD3(1,1)=datamatch.picks_bans(idxbd(3)).hero_id;
        ContextMatch.BanD4(1,1)=NaN;
        ContextMatch.BanD5(1,1)=NaN;
    case 4
        ContextMatch.BanD1(1,1)=datamatch.picks_bans(idxbd(1)).hero_id;
        ContextMatch.BanD2(1,1)=datamatch.picks_bans(idxbd(2)).hero_id;
        ContextMatch.BanD3(1,1)=datamatch.picks_bans(idxbd(3)).hero_id;
        ContextMatch.BanD4(1,1)=datamatch.picks_bans(idxbd(4)).hero_id;
        ContextMatch.BanD5(1,1)=NaN;
    case 5
        ContextMatch.BanD1(1,1)=datamatch.picks_bans(idxbd(1)).hero_id;
        ContextMatch.BanD2(1,1)=datamatch.picks_bans(idxbd(2)).hero_id;
        ContextMatch.BanD3(1,1)=datamatch.picks_bans(idxbd(3)).hero_id;
        ContextMatch.BanD4(1,1)=datamatch.picks_bans(idxbd(4)).hero_id;
        ContextMatch.BanD5(1,1)=datamatch.picks_bans(idxbd(5)).hero_id;
    otherwise
        ContextMatch.BanD1(1,1)=NaN;
        ContextMatch.BanD2(1,1)=NaN;
        ContextMatch.BanD3(1,1)=NaN;
        ContextMatch.BanD4(1,1)=NaN;
        ContextMatch.BanD5(1,1)=NaN;
end

%% StatMatch

%statmatch
StatMatch.temps(1,1)=datamatch.duration;
StatMatch.FB_time(1,1)=datamatch.first_blood_time;
StatMatch.dire_score(1,1)=datamatch.dire_score;
StatMatch.radiant_score(1,1)=datamatch.radiant_score;

if isfield(datamatch,'loss')==1
    StatMatch.loss(1,1)=datamatch.loss;
    StatMatch.throw(1,1)=datamatch.throw;
    StatMatch.comeback(1,1)=NaN;
    StatMatch.stomp(1,1)=NaN;
elseif isfield(datamatch,'comeback')==1
    StatMatch.loss(1,1)=NaN;
    StatMatch.throw(1,1)=NaN;
    StatMatch.comeback(1,1)=datamatch.comeback;
    StatMatch.stomp(1,1)=datamatch.stomp;
else
    StatMatch.loss(1,1)=NaN;
    StatMatch.throw(1,1)=NaN;
    StatMatch.comeback(1,1)=NaN;
    StatMatch.stomp(1,1)=NaN;
end

%StatMatch.roshan(i,1)
%StatMatch.FB(i,1)

%% calcul des stat team

%dire
StatMatch.dire_score(1,1)=datamatch.dire_score;
%StatMatch.dire_nb_tour(i,1)
%StatMatch.dire_nb_shrine(i,1)
%StatMatch.dire_nb_roshan(i,1)
%StatMatch.dire_mmr_moyen(i,1)
%StatMatch.dire_roshan_efficiency(i,1) %moyenne du temps entre les repops et les kill
%StatMatch.dire_shrine_efficiency1(i,1) %delta 1T3 et la 1ere shrines
%StatMatch.dire_shrine_efficiency2(i,1) %delta 1T3 et les 2 shrines
%StatMatch.dire_gold_efficiency(i,1) %delta les gold de la carte et les gold farmé

%radiant
StatMatch.radiant_score(1,1)=datamatch.radiant_score;
%StatMatch.radiant_nb_tour(i,1)
%StatMatch.radiant_nb_shrine(i,1)
%StatMatch.radiant_nb_roshan(i,1)
%StatMatch.radiant_mmr_moyen(i,1)
%StatMatch.radiant_roshan_efficiency(i,1) %moyenne du temps entre les repops et les kill
%StatMatch.radiant_shrine_efficiency1(i,1) %delta 1T3 et la 1ere shrines
%StatMatch.radiant_shrine_efficiency2(i,1) %delta 1T3 et les 2 shrines
%StatMatch.radiant_gold_efficiency(i,1) %delta les gold de la carte et les gold farmé

%% calcul des contextmatch
%calcul des positions
%1 - Carry
%2 - Mid
%3 - Offlane
%4 - Wooder
%5 - RoamSafe
%6 - RoamOff
%7 - RoamFull
%8 - Supplane1
%9 - Supplane2
%10 - Supplane3


for i=1:10
    
    
    %ref
    StatMatchPlayer.id_tn{i,1}=Tournoisadd.TOO_ID;
    StatMatchPlayer.tn_name{i,1}=Tournoisadd.Nom;
    StatMatchPlayer.account_id(i,1)=datamatch.players{i,1}.account_id;
    StatMatchPlayer.match_id(i,1)=datamatch.players{i,1}.match_id;
    %hero
    StatMatchPlayer.hero_id(i,1)=datamatch.players{i,1}.hero_id;
    %kda
    StatMatchPlayer.assists(i,1)=datamatch.players{i,1}.assists;
    StatMatchPlayer.deaths(i,1)=datamatch.players{i,1}.deaths;
    StatMatchPlayer.kills(i,1)=datamatch.players{i,1}.kills;
    %stat
    if i<6
        StatMatchPlayer.TF(i,1)=(datamatch.players{i}.assists+datamatch.players{i}.kills)/StatMatch.radiant_score;
    else
        StatMatchPlayer.TF(i,1)=(datamatch.players{i}.assists+datamatch.players{i}.kills)/StatMatch.dire_score;
    end
    if ~isempty(datamatch.players{i}.firstblood_claimed)
        StatMatchPlayer.FB(i,1)=datamatch.players{i}.firstblood_claimed;
    else
        StatMatchPlayer.FB(i,1)=NaN;
    end
    StatMatchPlayer.opm(i,1)=datamatch.players{i,1}.gold_per_min;
    StatMatchPlayer.camps_stacked(i,1)=datamatch.players{i,1}.camps_stacked;
    StatMatchPlayer.gold_spent(i,1)=datamatch.players{i,1}.gold_spent;
    StatMatchPlayer.hero_damage(i,1)=datamatch.players{i,1}.hero_damage;
    StatMatchPlayer.hero_healing(i,1)=datamatch.players{i,1}.hero_healing;
    StatMatchPlayer.denies(i,1)=datamatch.players{i,1}.denies;
    StatMatchPlayer.last_hits(i,1)=datamatch.players{i,1}.last_hits;
    StatMatchPlayer.level(i,1)=datamatch.players{i,1}.level;
    StatMatchPlayer.obs_placed(i,1)=datamatch.players{i,1}.obs_placed;
    StatMatchPlayer.rune_pickups(i,1)=datamatch.players{i,1}.rune_pickups;
    StatMatchPlayer.stuns(i,1)=datamatch.players{i,1}.stuns;
    StatMatchPlayer.total_gold(i,1)=datamatch.players{i,1}.total_gold;
    StatMatchPlayer.total_xp(i,1)=datamatch.players{i,1}.total_xp;
    StatMatchPlayer.kda(i,1)=datamatch.players{i,1}.kda;
    StatMatchPlayer.neutral_kills(i,1)=datamatch.players{i,1}.neutral_kills;
    StatMatchPlayer.tower_kills(i,1)=datamatch.players{i,1}.tower_kills;
    StatMatchPlayer.courier_kills(i,1)=datamatch.players{i,1}.courier_kills;
    StatMatchPlayer.lane_kills(i,1)=datamatch.players{i,1}.lane_kills;
    StatMatchPlayer.hero_kills(i,1)=datamatch.players{i,1}.hero_kills;
    StatMatchPlayer.observer_kills(i,1)=datamatch.players{i,1}.observer_kills;
    StatMatchPlayer.sentry_kills(i,1)=datamatch.players{i,1}.sentry_kills;
    StatMatchPlayer.roshan_kills(i,1)=datamatch.players{i,1}.roshan_kills;
    StatMatchPlayer.necronomicon_kills(i,1)=datamatch.players{i,1}.necronomicon_kills;
    StatMatchPlayer.ancient_kills(i,1)=datamatch.players{i,1}.ancient_kills;
    StatMatchPlayer.buyback_count(i,1)=datamatch.players{i,1}.buyback_count;
    StatMatchPlayer.observer_uses(i,1)=datamatch.players{i,1}.observer_uses;
    StatMatchPlayer.sentry_uses(i,1)=datamatch.players{i,1}.sentry_uses;
    StatMatchPlayer.lane_efficiency(i,1)=datamatch.players{i,1}.lane_efficiency;
    StatMatchPlayer.lane_efficiency_pct(i,1)=datamatch.players{i,1}.lane_efficiency_pct;
    StatMatchPlayer.apm(i,1)=datamatch.players{i,1}.actions_per_min;
    StatMatchPlayer.life_state_dead(i,1)=datamatch.players{i,1}.life_state_dead;
    %item
    StatMatchPlayer.item_0(i,1)=datamatch.players{i,1}.item_0;
    StatMatchPlayer.item_1(i,1)=datamatch.players{i,1}.item_1;
    StatMatchPlayer.item_2(i,1)=datamatch.players{i,1}.item_2;
    StatMatchPlayer.item_3(i,1)=datamatch.players{i,1}.item_3;
    StatMatchPlayer.item_4(i,1)=datamatch.players{i,1}.item_4;
    StatMatchPlayer.item_5(i,1)=datamatch.players{i,1}.item_5;
    StatMatchPlayer.backpack_0(i,1)=datamatch.players{i,1}.backpack_0;
    StatMatchPlayer.backpack_1(i,1)=datamatch.players{i,1}.backpack_1;
    StatMatchPlayer.backpack_2(i,1)=datamatch.players{i,1}.backpack_2;
    %position
    StatMatchPlayer.lane(i,1)=datamatch.players{i,1}.lane;
    StatMatchPlayer.lane_role(i,1)=datamatch.players{i,1}.lane_role;
    StatMatchPlayer.is_roaming(i,1)=datamatch.players{i,1}.is_roaming;
    %effeicienty
    StatMatchPlayer.gpmraw(i,1)=datamatch.players{i,1}.benchmarks.gold_per_min.raw;
    StatMatchPlayer.gpmpct(i,1)=datamatch.players{i,1}.benchmarks.gold_per_min.pct;
    StatMatchPlayer.xpmraw(i,1)=datamatch.players{i,1}.benchmarks.xp_per_min.raw;
    StatMatchPlayer.xpmpct(i,1)=datamatch.players{i,1}.benchmarks.xp_per_min.pct;
    StatMatchPlayer.kpmraw(i,1)=datamatch.players{i,1}.benchmarks.kills_per_min.raw;
    StatMatchPlayer.kpmpct(i,1)=datamatch.players{i,1}.benchmarks.kills_per_min.pct;
    StatMatchPlayer.lhpmraw(i,1)=datamatch.players{i,1}.benchmarks.last_hits_per_min.raw;
    StatMatchPlayer.lhpmpct(i,1)=datamatch.players{i,1}.benchmarks.last_hits_per_min.pct;
    StatMatchPlayer.hdpmraw(i,1)=datamatch.players{i,1}.benchmarks.hero_damage_per_min.raw;
    StatMatchPlayer.hdpmpct(i,1)=datamatch.players{i,1}.benchmarks.hero_damage_per_min.pct;
    StatMatchPlayer.hhpmraw(i,1)=datamatch.players{i,1}.benchmarks.hero_healing_per_min.raw;
    StatMatchPlayer.hhpmpct(i,1)=datamatch.players{i,1}.benchmarks.hero_healing_per_min.pct;
    StatMatchPlayer.tdpmraw(i,1)=datamatch.players{i,1}.benchmarks.tower_damage.raw;
    StatMatchPlayer.tdpmpct(i,1)=datamatch.players{i,1}.benchmarks.tower_damage.pct;
    
    if i<=5
        StatMatchPlayer.is_radian(i,1)=1;
        if datamatch.radiant_win==1
            StatMatchPlayer.is_win(i,1)=1;
        else
            StatMatchPlayer.is_win(i,1)=0;
        end
    else
        StatMatchPlayer.is_radian(i,1)=0;
        if datamatch.radiant_win==1
            StatMatchPlayer.is_win(i,1)=0;
        else
            StatMatchPlayer.is_win(i,1)=1;
        end
    end
end

end