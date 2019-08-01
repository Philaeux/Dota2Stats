function [StatPlayer,StatHeroPlayer]=StatMajorti7(StatMatchPlayer,Player)

StatPlayer=table();
StatHeroPlayer=table();

for i=1:height(Player)
    CalcStatPlayer=StatMatchPlayer(StatMatchPlayer.account_id==Player.account_id(i,1),:);
    if ~isempty(CalcStatPlayer)
        StatPlayerAdd=table();
        StatPlayerAdd.account_id=Player.account_id(i,1);
        StatPlayerAdd.team=Player.team_id(i,1);
        StatPlayerAdd.name=Player.Pseudo(i,1);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'assists',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'deaths',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'opm',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'camps_stacked',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_spent',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_damage',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_healing',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'denies',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'last_hits',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'level',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'obs_placed',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'rune_pickups',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'stuns',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'total_gold',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'kda',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'neutral_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'courier_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'observer_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'sentry_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'roshan_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'necronomicon_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'ancient_kills',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'buyback_count',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'observer_uses',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'sentry_uses',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_efficiency_pct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'apm',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'life_state_dead',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'gpmpct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'xpmpct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'kpmpct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'lhpmpct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'hdpmpct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'hhpmpct',StatPlayerAdd);
        [StatPlayerAdd]=genstat(CalcStatPlayer,'tdpmpct',StatPlayerAdd);
        StatPlayer=[StatPlayer;StatPlayerAdd];
    end
    
    HerosList=unique(CalcStatPlayer.hero_id);
    
    for j=1:length(HerosList)
        
        StatPlayerHeroAdd=table();
        StatPlayerAdd.account_id=Player.account_id(i,1);
        StatPlayerAdd.team=Player.team_id(i,1);
        StatPlayerAdd.name=Player.Pseudo(i,1);
        StatPlayerHeroAdd.hero_id=HerosList(j);
        CalcStatHeroPlayer=CalcStatPlayer(CalcStatPlayer.hero_id==HerosList(j),:);
        if ~isempty(CalcStatHeroPlayer)
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'assists',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'deaths',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'opm',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'camps_stacked',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'gold_spent',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'hero_damage',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'hero_healing',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'denies',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'last_hits',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'level',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'obs_placed',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'rune_pickups',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'stuns',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'total_gold',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'kda',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'neutral_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'tower_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'courier_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'lane_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'hero_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'observer_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'sentry_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'roshan_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'necronomicon_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'ancient_kills',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'buyback_count',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'observer_uses',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'sentry_uses',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'lane_efficiency_pct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'apm',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'life_state_dead',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'gpmpct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'xpmpct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'kpmpct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'lhpmpct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'hdpmpct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'hhpmpct',StatPlayerHeroAdd);
        [StatPlayerHeroAdd]=genstat(CalcStatHeroPlayer,'tdpmpct',StatPlayerHeroAdd);
        StatHeroPlayer=[StatHeroPlayer;StatPlayerHeroAdd];
        end
    end
end



end