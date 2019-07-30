function [BD_TI7_PlayerRecords]=persorecord(BD_TI7_Player,BD_TI7_StatPlayer)

BD_TI7_PlayerRecords=table();


for i=1:height(BD_TI7_Player)
    BD_TI7_PlayerRecordsadd=table();
    BD_TI7_PlayerRecordsadd.account_id=BD_TI7_Player.account_id(i,1);
    BD_TI7_PlayerRecordsadd.team_id=BD_TI7_Player.team_id(i,1);
    BD_TI7_PlayerRecordsadd.Pseudo=BD_TI7_Player.Pseudo(i,1);
    BD_TI7_PlayerRecordsadd.team_name=BD_TI7_Player.team_name(i,1);
    BD_TI7_PlayerRecordsadd.maxkills=BD_TI7_StatPlayer.max_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxassists=BD_TI7_StatPlayer.max_assists(i,1);
    BD_TI7_PlayerRecordsadd.maxcourier=BD_TI7_StatPlayer.max_courier_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxCS=BD_TI7_StatPlayer.max_camps_stacked(i,1);
    BD_TI7_PlayerRecordsadd.maxherodom=BD_TI7_StatPlayer.max_hero_damage(i,1);
    BD_TI7_PlayerRecordsadd.maxdenies=BD_TI7_StatPlayer.max_denies(i,1);
    BD_TI7_PlayerRecordsadd.maxheroheal=BD_TI7_StatPlayer.max_hero_healing(i,1);
    BD_TI7_PlayerRecordsadd.maxherokill=BD_TI7_StatPlayer.max_hero_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxkda=BD_TI7_StatPlayer.max_kda(i,1);
    BD_TI7_PlayerRecordsadd.maxlasthit=BD_TI7_StatPlayer.max_last_hits(i,1);
    BD_TI7_PlayerRecordsadd.maxnecrokill=BD_TI7_StatPlayer.max_necronomicon_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxneutralkill=BD_TI7_StatPlayer.max_neutral_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxobsplaces=BD_TI7_StatPlayer.max_obs_placed(i,1);
    BD_TI7_PlayerRecordsadd.maxobskill=BD_TI7_StatPlayer.max_observer_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxopm=BD_TI7_StatPlayer.max_opm(i,1);
    BD_TI7_PlayerRecordsadd.maxrune=BD_TI7_StatPlayer.max_rune_pickups(i,1);
    BD_TI7_PlayerRecordsadd.maxstuns=BD_TI7_StatPlayer.max_stuns(i,1);
    BD_TI7_PlayerRecordsadd.maxtowerkill=BD_TI7_StatPlayer.max_tower_kills(i,1);
    BD_TI7_PlayerRecordsadd.maxsentrykill=BD_TI7_StatPlayer.max_sentry_kills(i,1);
    BD_TI7_PlayerRecords=[BD_TI7_PlayerRecords;BD_TI7_PlayerRecordsadd];
end

end