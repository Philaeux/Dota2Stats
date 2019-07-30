function StatHero(conn,Hero,player_match_valve,match_valve)

BD_TI7_StatHeros=table();

for i=1:height(Hero)
    CalcStatHero=BD_TI7_StatMatchPlayer(BD_TI7_StatMatchPlayer.hero_id==BD_TI7_Hero.ID(i,1),:);

    BD_TI7_StatHerosadd=table();
    BD_TI7_StatHerosadd.hero_id=BD_TI7_Hero.ID(i,1);
    BD_TI7_StatHerosadd.hero_name=BD_TI7_Hero.Nom(i,1);
    BD_TI7_StatHerosadd.nb_pick=height(BD_TI7_StatMatchPlayer(BD_TI7_StatMatchPlayer.hero_id==BD_TI7_StatHerosadd.hero_id,:));
    BD_TI7_StatHerosadd.nb_ban=height(BD_TI7_ContextMatch(BD_TI7_ContextMatch.BanD1==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanD2==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanD3==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanD4==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanD5==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanR1==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanR2==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanR3==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanR4==BD_TI7_StatHerosadd.hero_id | ...
        BD_TI7_ContextMatch.BanR5==BD_TI7_StatHerosadd.hero_id,:));
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'is_win',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'assists',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'deaths',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'last_hits',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'xpmraw',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'opm',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'hero_damage',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'hero_healing',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'denies',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'stuns',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'kda',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'neutral_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'tower_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'courier_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'observer_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'sentry_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'roshan_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'ancient_kills',BD_TI7_StatHerosadd);
    [BD_TI7_StatHerosadd]=genstat(CalcStatHero,'TF',BD_TI7_StatHerosadd);
    BD_TI7_StatHeros=[BD_TI7_StatHeros;BD_TI7_StatHerosadd]; %#ok<AGROW>
  
end

end