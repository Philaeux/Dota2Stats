function add_openplayermatch(conn,datamatch,pos_player)
% This function should only be used if player's information are public
match_id=datamatch.match_id;
account_id=datamatch.players{pos_player,1}.account_id;

selectQ=sprintf('select * from openplayermatch where openplayermatch.match_id=%f and openplayermatch.account_id=%f' ,match_id,account_id);
match_data=select(conn,selectQ);
if ~isempty(match_data)
    disp("player's data have already been processed")
    return
end

selectQ='select * from openplayermatch limit 1';
data=select(conn,selectQ);
if isempty(data)
    max_id=1;
else
    selectQ='select max(id) from openplayermatch';
    max_id=select(conn,selectQ);
    max_id=max_id.max+1;
end



player_slot=datamatch.players{pos_player,1}.player_slot;
hero_id=datamatch.players{pos_player,1}.hero_id;
item_0=datamatch.players{pos_player,1}.item_0;
item_1=datamatch.players{pos_player,1}.item_1;
item_2=datamatch.players{pos_player,1}.item_2;
item_3=datamatch.players{pos_player,1}.item_3;
item_4=datamatch.players{pos_player,1}.item_4;
item_5=datamatch.players{pos_player,1}.item_5;
backpack_0=datamatch.players{pos_player,1}.backpack_0;
backpack_1=datamatch.players{pos_player,1}.backpack_1;
backpack_2=datamatch.players{pos_player,1}.backpack_2;
obs_placed=datamatch.players{pos_player,1}.obs_placed;
sen_placed=datamatch.players{pos_player,1}.sen_placed;
kills=datamatch.players{pos_player,1}.kills;
deaths=datamatch.players{pos_player,1}.deaths;
assists=datamatch.players{pos_player,1}.assists;
leaver_status=datamatch.players{pos_player,1}.leaver_status;
camps_stacked=datamatch.players{pos_player,1}.camps_stacked;
creep_stacked=datamatch.players{pos_player,1}.creeps_stacked;
last_hits=datamatch.players{pos_player,1}.last_hits;
denies=datamatch.players{pos_player,1}.denies;
gold_per_min=datamatch.players{pos_player,1}.gold_per_min;
xp_per_min=datamatch.players{pos_player,1}.xp_per_min;
level=datamatch.players{pos_player,1}.level;
gold=datamatch.players{pos_player,1}.gold;
gold_spent=datamatch.players{pos_player,1}.gold_spent;
firstblood_claimed=datamatch.players{pos_player,1}.firstblood_claimed;
roshans_kill=datamatch.players{pos_player,1}.roshan_kills;
tower_kill=datamatch.players{pos_player,1}.tower_kills;
kda=datamatch.players{pos_player,1}.kda;
hero_damage=datamatch.players{pos_player,1}.hero_damage;
tower_damage=datamatch.players{pos_player,1}.tower_damage;
hero_healing=datamatch.players{pos_player,1}.hero_healing;
rune_pickups=datamatch.players{pos_player,1}.rune_pickups;
if isfield(datamatch.players{pos_player,1}.runes,'x0')
    dd_pickups=datamatch.players{pos_player,1}.runes.x0;
else
    dd_pickups=0;
end
if isfield(datamatch.players{pos_player,1}.runes,'x1')
    haste_pickups=datamatch.players{pos_player,1}.runes.x1;
else
    haste_pickups=0;
end
if isfield(datamatch.players{pos_player,1}.runes,'x4')
    regen_pickups=datamatch.players{pos_player,1}.runes.x4;
else
    regen_pickups=0;
end
if isfield(datamatch.players{pos_player,1}.runes,'x3')
    invi_pickups=datamatch.players{pos_player,1}.runes.x3;
else
    invi_pickups=0;
end
if isfield(datamatch.players{pos_player,1}.runes,'x2')
    illu_pickups=datamatch.players{pos_player,1}.runes.x2;
else
    illu_pickups=0;
end
if isfield(datamatch.players{pos_player,1}.runes,'x5')
    bounty_pickups=datamatch.players{pos_player,1}.runes.x5;
else
    bounty_pickups=0;
end
if isfield(datamatch.players{pos_player,1}.runes,'x6')
    arcane_pickups=datamatch.players{pos_player,1}.runes.x6;
else
    arcane_pickups=0;
end
stun=datamatch.players{pos_player,1}.stuns;
teamfight_part=datamatch.players{pos_player,1}.teamfight_participation;
lane_effi=datamatch.players{pos_player,1}.lane_efficiency;
lane_effi_pct=datamatch.players{pos_player,1}.lane_efficiency_pct;
lane=datamatch.players{pos_player,1}.lane;
lane_role=datamatch.players{pos_player,1}.lane_role;
apm=datamatch.players{pos_player,1}.actions_per_min;
if isfield(datamatch.players{pos_player,1}.actions,'x1')
    apmx1=datamatch.players{pos_player,1}.actions.x1;
else
    apmx1=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x2')
    apmx2=datamatch.players{pos_player,1}.actions.x2;
else
    apmx2=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x3')
    apmx3=datamatch.players{pos_player,1}.actions.x3;
else
    apmx3=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x4')
    apmx4=datamatch.players{pos_player,1}.actions.x4;
else
    apmx4=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x5')
    apmx5=datamatch.players{pos_player,1}.actions.x5;
else
    apmx5=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x6')
    apmx6=datamatch.players{pos_player,1}.actions.x6;
else
    apmx6=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x8')
    apmx8=datamatch.players{pos_player,1}.actions.x8;
else
    apmx8=0;
end
if isfield(datamatch.players{pos_player,1}.actions,'x10')
    apmx10=datamatch.players{pos_player,1}.actions.x10;
else
    apmx10=0;
end
dead_time=datamatch.players{pos_player,1}.life_state_dead;
if isfield(datamatch.players{pos_player,1}.item_uses,'tango')
    tango=datamatch.players{pos_player,1}.item_uses.tango;
else
    tango=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'tpscroll')
    tpscroll=datamatch.players{pos_player,1}.item_uses.tpscroll;
else
    tpscroll=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'arcane_boots')
    arcane_boots=datamatch.players{pos_player,1}.item_uses.arcane_boots;
else
    arcane_boots=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'clarity')
    clarity=datamatch.players{pos_player,1}.item_uses.clarity;
else
    clarity=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'smoke_of_deceit')
    smoke_of_deceit=datamatch.players{pos_player,1}.item_uses.smoke_of_deceit;
else
    smoke_of_deceit=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'quelling_blade')
    quelling_blade=datamatch.players{pos_player,1}.item_uses.quelling_blade;
else
    quelling_blade=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'phase_boots')
    phase_boots=datamatch.players{pos_player,1}.item_uses.phase_boots;
else
    phase_boots=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'shadow_amulet')
    shadow_amulet=datamatch.players{pos_player,1}.item_uses.shadow_amulet;
else
    shadow_amulet=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'invis_sword')
    invis_sword=datamatch.players{pos_player,1}.item_uses.invis_sword;
else
    invis_sword=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'pipe')
    pipe=datamatch.players{pos_player,1}.item_uses.pipe;
else
    pipe=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'soul_ring')
    soul_ring=datamatch.players{pos_player,1}.item_uses.soul_ring;
else
    soul_ring=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'medallion_of_courage')
    medallion_of_courage=datamatch.players{pos_player,1}.item_uses.medallion_of_courage;
else
    medallion_of_courage=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'helm_of_the_dominator')
    helm_of_the_dominator=datamatch.players{pos_player,1}.item_uses.helm_of_the_dominator;
else
    helm_of_the_dominator=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'branches')
    branches=datamatch.players{pos_player,1}.item_uses.branches;
else
    branches=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'tome_of_knowledge')
    tome_of_knowledge=datamatch.players{pos_player,1}.item_uses.tome_of_knowledge;
else
    tome_of_knowledge=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'diffusal_blade')
    diffusal_blade=datamatch.players{pos_player,1}.item_uses.diffusal_blade;
else
    diffusal_blade=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'power_treads')
    power_treads=datamatch.players{pos_player,1}.item_uses.power_treads;
else
    power_treads=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'bottle')
    bottle=datamatch.players{pos_player,1}.item_uses.bottle;
else
    bottle=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'glimmer_cape')
    glimmer_cape=datamatch.players{pos_player,1}.item_uses.glimmer_cape;
else
    glimmer_cape=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'black_king_bar')
    black_king_bar=datamatch.players{pos_player,1}.item_uses.black_king_bar;
else
    black_king_bar=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'silver_edge')
    silver_edge=datamatch.players{pos_player,1}.item_uses.silver_edge;
else
    silver_edge=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'blink')
    blink=datamatch.players{pos_player,1}.item_uses.blink;
else
    blink=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'blade_mail')
    blade_mail=datamatch.players{pos_player,1}.item_uses.blade_mail;
else
    blade_mail=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'travel_boots')
    travel_boots=datamatch.players{pos_player,1}.item_uses.travel_boots;
else
    travel_boots=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'urn_of_shadows')
    urn_of_shadows=datamatch.players{pos_player,1}.item_uses.urn_of_shadows;
else
    urn_of_shadows=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'guardian_greaves')
    guardian_greaves=datamatch.players{pos_player,1}.item_uses.guardian_greaves;
else
    guardian_greaves=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'hurricane_pike')
    hurricane_pike=datamatch.players{pos_player,1}.item_uses.hurricane_pike;
else
    hurricane_pike=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'cheese')
    cheese=datamatch.players{pos_player,1}.item_uses.cheese;
else
    cheese=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'solar_crest')
    solar_crest=datamatch.players{pos_player,1}.item_uses.solar_crest;
else
    solar_crest=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'mjollnir')
    mjollnir=datamatch.players{pos_player,1}.item_uses.mjollnir;
else
    mjollnir=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'dust')
    dust=datamatch.players{pos_player,1}.item_uses.dust;
else
    dust=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'spirit_vessel')
    spirit_vessel=datamatch.players{pos_player,1}.item_uses.spirit_vessel;
else
    spirit_vessel=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'cyclone')
    cyclone=datamatch.players{pos_player,1}.item_uses.cyclone;
else
    cyclone=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'manta')
    manta=datamatch.players{pos_player,1}.item_uses.manta;
else
    manta=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'refresher_shard')
    refresher_shard=datamatch.players{pos_player,1}.item_uses.refresher_shard;
else
    refresher_shard=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'moon_shard')
    moon_shard=datamatch.players{pos_player,1}.item_uses.moon_shard;
else
    moon_shard=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'crimsom_guard')
    crimsom_guard=datamatch.players{pos_player,1}.item_uses.crimsom_guard;
else
    crimsom_guard=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'butterfly')
    butterfly=datamatch.players{pos_player,1}.item_uses.butterfly;
else
    butterfly=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'rod_of_atos')
    rod_of_atos=datamatch.players{pos_player,1}.item_uses.rod_of_atos;
else
    rod_of_atos=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'orchid')
    orchid=datamatch.players{pos_player,1}.item_uses.orchid;
else
    orchid=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'shivas_guard')
    shivas_guard=datamatch.players{pos_player,1}.item_uses.shivas_guard;
else
    shivas_guard=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'dagon')
    dagon=datamatch.players{pos_player,1}.item_uses.dagon;
else
    dagon=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'veil_of_discord')
    veil_of_discord=datamatch.players{pos_player,1}.item_uses.veil_of_discord;
else
    veil_of_discord=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'ethereal_blade')
    ethereal_blade=datamatch.players{pos_player,1}.item_uses.ethereal_blade;
else
    ethereal_blade=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'ghost')
    ghost=datamatch.players{pos_player,1}.item_uses.ghost;
else
    ghost=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'nullifier')
    nullifier=datamatch.players{pos_player,1}.item_uses.nullifier;
else
    nullifier=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'satanic')
    satanic=datamatch.players{pos_player,1}.item_uses.satanic;
else
    satanic=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'sheepstick')
    sheepstick=datamatch.players{pos_player,1}.item_uses.sheepstick;
else
    sheepstick=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'heavens_halberd')
    heavens_halberd=datamatch.players{pos_player,1}.item_uses.heavens_halberd;
else
    heavens_halberd=NaN;
end
if isfield(datamatch.players{pos_player,1}.item_uses,'mekansm')
    mekansm=datamatch.players{pos_player,1}.item_uses.mekansm;
else
    mekansm=NaN;
end
if isfield(datamatch,'duration')
    duration=datamatch.duration;
else
    duration=0;
end

match_data=[match_data;{max_id,match_id,account_id,player_slot,hero_id,item_0,...
    item_1,item_2,item_3,item_4,item_5,backpack_0,backpack_1,backpack_2,...
    obs_placed,sen_placed,kills,deaths,assists,leaver_status,camps_stacked,...
    creep_stacked,last_hits,denies,gold_per_min,xp_per_min,level,gold,gold_spent,...
    firstblood_claimed,roshans_kill,tower_kill,kda,hero_damage,tower_damage,...
    hero_healing,rune_pickups,dd_pickups,haste_pickups,regen_pickups,invi_pickups,...
    illu_pickups,bounty_pickups,arcane_pickups,stun,teamfight_part,lane_effi,...
    lane_effi_pct,lane,lane_role,apm,apmx1,apmx2,apmx3,apmx4,apmx5,apmx6,...
    apmx8,apmx10,dead_time,tango,tpscroll,arcane_boots,clarity,smoke_of_deceit,...
    quelling_blade,phase_boots,shadow_amulet,invis_sword,pipe,soul_ring,...
    medallion_of_courage,helm_of_the_dominator,branches,tome_of_knowledge,...
    diffusal_blade,power_treads,bottle,glimmer_cape,black_king_bar,silver_edge,...
    blink,blade_mail,travel_boots,urn_of_shadows,guardian_greaves,hurricane_pike,...
    cheese,solar_crest,mjollnir,dust,spirit_vessel,cyclone,manta,refresher_shard,...
    moon_shard,crimsom_guard,butterfly,rod_of_atos,orchid,shivas_guard,dagon,...
    veil_of_discord,ethereal_blade,ghost,nullifier,satanic,sheepstick,...
    heavens_halberd,mekansm,0,duration}];
sqlwrite(conn,'openplayermatch',match_data)





