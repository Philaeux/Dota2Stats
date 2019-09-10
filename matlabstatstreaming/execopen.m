function execmatchadd=execopen(dataod,conn,execmatch)



%% player info
try
    %     switch class(datavalve.result.players(1,1))
    %         case 'cell'
    players=table();
    try
        disp(['Traitement api.open de ',dataod.radiant_team.name,' vs ',dataod.dire_team.name])
    catch
    end
    execmatchadd=table();
    execmatchadd.execopenpicks=execmatch.execopenpicks(execmatch.match_id==dataod.match_id);
    execmatchadd.execopenplayer=execmatch.execopenplayer(execmatch.match_id==dataod.match_id);
    if dataod.game_mode==2
        if isempty(dataod.version)==0
            if execmatchadd.execopenplayer<5
                for i=1:10
                    %% player info
                    playersadd=table;
                    playersadd.id=NaN;
                    playersadd.account_id=dataod.players{i,1}.account_id;
                    playersadd.player_slot=dataod.players{i,1}.player_slot;
                    playersadd.hero_id=dataod.players{i,1}.hero_id;
                    %% item
                    playersadd.item_0=dataod.players{i,1}.item_0;
                    playersadd.item_1=dataod.players{i,1}.item_1;
                    playersadd.item_2=dataod.players{i,1}.item_2;
                    playersadd.item_3=dataod.players{i,1}.item_3;
                    playersadd.item_4=dataod.players{i,1}.item_4;
                    playersadd.item_5=dataod.players{i,1}.item_5;
                    playersadd.backpack_0=dataod.players{i,1}.backpack_0;
                    playersadd.backpack_1=dataod.players{i,1}.backpack_1;
                    playersadd.backpack_2=dataod.players{i,1}.backpack_2;
                    if isfield(dataod.players{i,1},'purchase_ward_observer')
                        playersadd.purchased_obs=dataod.players{i,1}.purchase_ward_observer;
                    else
                        playersadd.purchased_obs=0;
                    end
                    if isfield(dataod.players{i,1},'purchase_ward_sentry')
                        playersadd.purchased_sen=dataod.players{i,1}.purchase_ward_sentry;
                    else
                        playersadd.purchased_sen=0;
                    end
                    if isfield(dataod.players{i,1},'purchase_tpscroll')
                        playersadd.purchased_tp=dataod.players{i,1}.purchase_tpscroll;
                    else
                        playersadd.purchased_tp=0;
                    end
                    playersadd.obs_placed=dataod.players{i,1}.obs_placed;
                    playersadd.obs_placed=dataod.players{i,1}.obs_placed;
                    playersadd.sen_placed=dataod.players{i,1}.sen_placed;
                    %% KDA
                    playersadd.kills=dataod.players{i,1}.kills;
                    playersadd.deaths=dataod.players{i,1}.deaths;
                    playersadd.assists=dataod.players{i,1}.assists;
                    playersadd.leaver_status=dataod.players{i,1}.leaver_status;
                    playersadd.camps_stacked=dataod.players{i,1}.camps_stacked;
                    playersadd.creep_stacked=dataod.players{i,1}.creeps_stacked;
                    playersadd.firstblood_claimed=dataod.players{i,1}.firstblood_claimed;
                    %% LH gold level
                    playersadd.last_hits=dataod.players{i,1}.last_hits;
                    playersadd.denies=dataod.players{i,1}.denies;
                    playersadd.gold_per_min=dataod.players{i,1}.gold_per_min;
                    playersadd.xp_per_min=dataod.players{i,1}.xp_per_min;
                    playersadd.level=dataod.players{i,1}.level;
                    playersadd.gold=dataod.players{i,1}.gold;
                    playersadd.gold_spent=dataod.players{i,1}.gold_spent;
                    playersadd.roshans_kill=dataod.players{i,1}.roshans_killed;
                    playersadd.tower_kill=dataod.players{i,1}.towers_killed;
                    playersadd.kda=dataod.players{i,1}.kda;
                    playarsadd.neutral_kill=dataod.players{i,1}.neutral_kills;
                    playarsadd.courrier_kill=dataod.players{i,1}.courier_kills;
                    playarsadd.obs_kill=dataod.players{i,1}.observer_kills;
                    playarsadd.sen_kill=dataod.players{i,1}.sentry_kills;
                    playarsadd.necro_kill=dataod.players{i,1}.necronomicon_kills;
                    playarsadd.ancient_kill=dataod.players{i,1}.ancient_kills;
                    playarsadd.bb_count=dataod.players{i,1}.buyback_count;
                    %% Damage
                    playersadd.hero_damage=dataod.players{i,1}.hero_damage;
                    playersadd.tower_damage=dataod.players{i,1}.tower_damage;
                    playersadd.hero_healing=dataod.players{i,1}.hero_healing;
                    playersadd.max_hero_hit_value=dataod.players{i,1}.max_hero_hit.value;
                    if ~isempty(dataod.players{i,1}.max_hero_hit.inflictor)
                        playersadd.max_hero_hit_type{1,1}=dataod.players{i,1}.max_hero_hit.inflictor;
                    else
                        playersadd.max_hero_hit_type{1,1}='phisical_hit';
                    end
                    %% rune
                    playersadd.rune_pickups=dataod.players{i,1}.rune_pickups;
                    if dataod.players{i,1}.rune_pickups==0
                        playersadd.dd_pickups=0;
                        playersadd.haste_pickups=0;
                        playersadd.regen_pickups=0;
                        playersadd.invi_pickups=0;
                        playersadd.illu_pickups=0;
                        playersadd.bounty_pickups=0;
                        playersadd.arcane_pickups=0;
                    else
                        playersadd.dd_pickups=0;
                        playersadd.haste_pickups=0;
                        playersadd.regen_pickups=0;
                        playersadd.invi_pickups=0;
                        playersadd.illu_pickups=0;
                        playersadd.bounty_pickups=0;
                        playersadd.arcane_pickups=0;
                        runetype=fieldnames(dataod.players{i,1}.runes);
                        for j=1:length(runetype)
                            switch runetype{j,1}
                                case 'x0'
                                    playersadd.dd_pickups=dataod.players{i,1}.runes.x0;
                                case 'x1'
                                    playersadd.haste_pickups=dataod.players{i,1}.runes.x1;
                                case 'x2'
                                    playersadd.regen_pickups=dataod.players{i,1}.runes.x2;
                                case 'x3'
                                    playersadd.invi_pickups=dataod.players{i,1}.runes.x3;
                                case 'x4'
                                    playersadd.illu_pickups=dataod.players{i,1}.runes.x4;
                                case 'x5'
                                    playersadd.bounty_pickups=dataod.players{i,1}.runes.x5;
                                case 'x6'
                                    playersadd.arcane_pickups=dataod.players{i,1}.runes.x6;
                            end
                        end
                    end
                    %% micelanious
                    playersadd.stun=dataod.players{i,1}.stuns;
                    playersadd.teamfight_part=dataod.players{i,1}.teamfight_participation;
                    playersadd.lane_effi=dataod.players{i,1}.lane_efficiency;
                    playersadd.lane_effi_pct=dataod.players{i,1}.lane_efficiency_pct;
                    playersadd.lane=dataod.players{i,1}.lane;
                    playersadd.lane_role=dataod.players{i,1}.lane_role;
                    playersadd.is_roaming=dataod.players{i,1}.is_roaming;
                    playersadd.apm=dataod.players{i,1}.actions_per_min;
                    playersadd.dead_time=dataod.players{i,1}.life_state_dead;
                    playersadd.match_id=dataod.match_id;
                    
                    %% gestion des items
                    list_item=struct2table(dataod.players{i,1}.item_uses);
                    list_name=list_item.Properties.VariableNames;
                    playersadd.tango=NaN;
                    playersadd.tpscroll=NaN;
                    playersadd.arcane_boots=NaN;
                    playersadd.clarity=NaN;
                    playersadd.smoke_of_deceit=NaN;
                    playersadd.quelling_blade=NaN;
                    playersadd.phase_boots=NaN;
                    playersadd.shadow_amulet=NaN;
                    playersadd.invis_sword=NaN;
                    playersadd.pipe=NaN;
                    playersadd.soul_ring=NaN;
                    playersadd.medallion_of_courage=NaN;
                    playersadd.helm_of_the_dominator=NaN;
                    playersadd.branches=NaN;
                    playersadd.tome_of_knowledge=NaN;
                    playersadd.diffusal_blade=NaN;
                    playersadd.power_treads=NaN;
                    playersadd.bottle=NaN;
                    playersadd.glimmer_cape=NaN;
                    playersadd.black_king_bar=NaN;
                    playersadd.silver_edge=NaN;
                    playersadd.blink=NaN;
                    playersadd.blade_mail=NaN;
                    playersadd.travel_boots=NaN;
                    playersadd.urn_of_shadows=NaN;
                    playersadd.guardian_greaves=NaN;
                    playersadd.hurricane_pike=NaN;
                    playersadd.cheese=NaN;
                    playersadd.solar_crest=NaN;
                    playersadd.mjollnir=NaN;
                    playersadd.dust=NaN;
                    playersadd.spirit_vessel=NaN;
                    playersadd.cyclone=NaN;
                    playersadd.manta=NaN;
                    playersadd.refresher_shard=NaN;
                    playersadd.moon_shard=NaN;
                    playersadd.crimson_guard=NaN;
                    playersadd.butterfly=NaN;
                    playersadd.rod_of_atos=NaN;
                    playersadd.orchid=NaN;
                    playersadd.shivas_guard=NaN;
                    playersadd.dagon=NaN;
                    playersadd.veil_of_discord=NaN;
                    playersadd.ethereal_blade=NaN;
                    playersadd.ghost=NaN;
                    playersadd.nullifier=NaN;
                    playersadd.satanic=NaN;
                    playersadd.sheepstick=NaN;
                    playersadd.heavens_halberd=NaN;
                    playersadd.mekansm=NaN;
                    for j=1:length(list_name)
                        switch list_name{j}
                            case 'tango'
                                playersadd.tango=list_item.tango;
                            case 'tpscroll'
                                playersadd.tpscroll=list_item.tpscroll;
                            case 'arcane_boots'
                                playersadd.arcane_boots=list_item.arcane_boots;
                            case 'clarity'
                                playersadd.clarity=list_item.clarity;
                            case 'smoke_of_deceit'
                                playersadd.smoke_of_deceit=list_item.smoke_of_deceit;
                            case 'quelling_blade'
                                playersadd.quelling_blade=list_item.quelling_blade;
                            case 'phase_boots'
                                playersadd.phase_boots=list_item.phase_boots;
                            case 'shadow_amulet'
                                playersadd.shadow_amulet=list_item.shadow_amulet;
                            case 'invis_sword'
                                playersadd.invis_sword=list_item.invis_sword;
                            case 'pipe'
                                playersadd.pipe=list_item.pipe;
                            case 'soul_ring'
                                playersadd.soul_ring=list_item.soul_ring;
                            case 'medallion_of_courage'
                                playersadd.medallion_of_courage=list_item.medallion_of_courage;
                            case 'helm_of_the_dominator'
                                playersadd.helm_of_the_dominator=list_item.helm_of_the_dominator;
                            case 'branches'
                                playersadd.branches=list_item.branches;
                            case 'tome_of_knowledge'
                                playersadd.tome_of_knowledge=list_item.tome_of_knowledge;
                            case 'diffusal_blade'
                                playersadd.diffusal_blade=list_item.diffusal_blade;
                            case 'power_treads'
                                playersadd.power_treads=list_item.power_treads;
                            case 'bottle'
                                playersadd.bottle=list_item.bottle;
                            case 'glimmer_cape'
                                playersadd.glimmer_cape=list_item.glimmer_cape;
                            case 'black_king_bar'
                                playersadd.black_king_bar=list_item.black_king_bar;
                            case 'silver_edge'
                                playersadd.silver_edge=list_item.silver_edge;
                            case 'blink'
                                playersadd.blink=list_item.blink;
                            case 'blade_mail'
                                playersadd.blade_mail=list_item.blade_mail;
                            case 'travel_boots'
                                playersadd.travel_boots=list_item.travel_boots;
                            case 'urn_of_shadows'
                                playersadd.urn_of_shadows=list_item.urn_of_shadows;
                            case 'guardian_greaves'
                                playersadd.guardian_greaves=list_item.guardian_greaves;
                            case 'hurricane_pike'
                                playersadd.hurricane_pike=list_item.hurricane_pike;
                            case 'cheese'
                                playersadd.cheese=list_item.cheese;
                            case 'solar_crest'
                                playersadd.solar_crest=list_item.solar_crest;
                            case 'mjollnir'
                                playersadd.mjollnir=list_item.mjollnir;
                            case 'dust'
                                playersadd.dust=list_item.dust;
                            case 'spirit_vessel'
                                playersadd.spirit_vessel=list_item.spirit_vessel;
                            case 'cyclone'
                                playersadd.cyclone=list_item.cyclone;
                            case 'manta'
                                playersadd.manta=list_item.manta;
                            case 'refresher_shard'
                                playersadd.refresher_shard=list_item.refresher_shard;
                            case 'moon_shard'
                                playersadd.moon_shard=list_item.moon_shard;
                            case 'crimson_guard'
                                playersadd.crimson_guard=list_item.crimson_guard;
                            case 'butterfly'
                                playersadd.butterfly=list_item.butterfly;
                            case 'rod_of_atos'
                                playersadd.rod_of_atos=list_item.rod_of_atos;
                            case 'orchid'
                                playersadd.orchid=list_item.orchid;
                            case 'shivas_guard'
                                playersadd.shivas_guard=list_item.shivas_guard;
                            case {'dagon','dagon_1','dagon_2','dagon_3','dagon_4'}
                                list_dagon=intersect(list_item.Properties.VariableNames,{'dagon','dagon_1','dagon_2','dagon_3','dagon_4'});
                                nb_dagon=length(list_dagon);
                                use_dagon=0;
                                for k=1:nb_dagon
                                    use_dagon=use_dagon+list_item.(list_dagon{k});
                                end
                                playersadd.dagon=use_dagon;
                            case 'veil_of_discord'
                                playersadd.veil_of_discord=list_item.veil_of_discord;
                            case 'ethereal_blade'
                                playersadd.ethereal_blade=list_item.ethereal_blade;
                            case 'ghost'
                                playersadd.ghost=list_item.ghost;
                            case 'nullifier'
                                playersadd.nullifier=list_item.nullifier;
                            case 'satanic'
                                playersadd.satanic=list_item.satanic;
                            case 'sheepstick'
                                playersadd.sheepstick=list_item.sheepstick;
                            case 'heavens_halberd'
                                playersadd.heavens_halberd=list_item.heavens_halberd;
                            case 'mekansm'
                                playersadd.mekansm=list_item.mekansm;
                        end
                    end
                    %%Benchmarks
                    playersadd.bench_gpm_value=dataod.players{i,1}.benchmarks.gold_per_min.raw;
                    playersadd.bench_gpm_pct=dataod.players{i,1}.benchmarks.gold_per_min.pct;
                    playersadd.bench_xppm_value=dataod.players{i,1}.benchmarks.xp_per_min.raw;
                    playersadd.bench_xppm_pct=dataod.players{i,1}.benchmarks.xp_per_min.pct;
                    playersadd.bench_kpm_value=dataod.players{i,1}.benchmarks.kills_per_min.raw;
                    playersadd.bench_kpm_pct=dataod.players{i,1}.benchmarks.kills_per_min.pct;
                    playersadd.bench_lhpm_value=dataod.players{i,1}.benchmarks.last_hits_per_min.raw;
                    playersadd.bench_lhpm_pct=dataod.players{i,1}.benchmarks.last_hits_per_min.pct;
                    playersadd.bench_damagepm_value=dataod.players{i,1}.benchmarks.hero_damage_per_min.raw;
                    playersadd.bench_damagepm_pct=dataod.players{i,1}.benchmarks.hero_damage_per_min.pct;
                    playersadd.bench_healingpm_value=dataod.players{i,1}.benchmarks.hero_healing_per_min.raw;
                    playersadd.bench_healingpm_pct=dataod.players{i,1}.benchmarks.hero_healing_per_min.pct;
                    playersadd.bench_todam_value=dataod.players{i,1}.benchmarks.tower_damage.raw;
                    playersadd.bench_todam_pct=dataod.players{i,1}.benchmarks.tower_damage.pct;
                    playersadd.bench_stunspm_value=dataod.players{i,1}.benchmarks.stuns_per_min.raw;
                    playersadd.bench_stunspm_pct=dataod.players{i,1}.benchmarks.stuns_per_min.pct;
                    playersadd.bench_lhten_value=dataod.players{i,1}.benchmarks.lhten.raw;
                    playersadd.bench_lhten_pct=dataod.players{i,1}.benchmarks.lhten.pct;
                    
                    %% player fun
                    %% chatweel
                    % all
                    nb_chat=length(dataod.chat);
                    chat=table();
                    for j=1:nb_chat
                        chatadd=table();
                        chattemp=struct2table(dataod.chat{j,1});
                        chatadd.time=chattemp.time;
                        chatadd.type{1,1}=chattemp.type;
                        chatadd.key=str2double(chattemp.key);
                        chatadd.slot=chattemp.slot;
                        chatadd.player_slot=chattemp.player_slot;
                        chat=[chat;chatadd]; %#ok<AGROW>
                    end
                    chat=chat(strcmp(chat.type,'chatwheel')==1,:);
                    chatplayer=chat(chat.player_slot==playersadd.player_slot,:);
                    if isempty(chatplayer)
                        playersadd.nb_chatw=0;
                        playersadd.nb_ceb=0;
                    else
                        playersadd.nb_chatw=height(chatplayer);
                        %% ceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeb id 230
                        chatceb=chatplayer(chatplayer.key==230,:);
                        if isempty(chatceb)
                            playersadd.nb_ceb=0;
                        else
                            playersadd.nb_ceb=height(chatceb);
                        end
                    end
                    %% useless apm
                    playersadd.apmx1=dataod.players{i,1}.actions.x1;
                    %% le bergers
                    nb_moutonitem=playersadd.sheepstick;
                    nb_moutonrastha=0;
                    nb_moutonlion=0;
                    nb_moutonmorph=0;
                    nb_moutonrubick=0;
                    if playersadd.hero_id==27
                        nb_moutonrastha=dataod.players{i,1}.ability_uses.shadow_shaman_voodoo;
                    end
                    if playersadd.hero_id==26
                        nb_moutonlion=dataod.players{i,1}.ability_uses.lion_voodoo;
                    end
                    if playersadd.hero_id==10
                        if isfield(dataod.players{i,1}.ability_uses,'lion_voodoo')
                            nb_moutonmorph1=dataod.players{j,1}.ability_uses.lion_voodoo;
                        else
                            nb_moutonmorph1=0;
                        end
                        if isfield(dataod.players{i,1}.ability_uses,'shadow_shaman_voodoo')
                            nb_moutonmorph2=dataod.players{i,1}.ability_uses.shadow_shaman_voodoo;
                        else
                            nb_moutonmorph2=0;
                        end
                        nb_moutonmorph=nb_moutonmorph1+nb_moutonmorph2;
                    end
                    if playersadd.hero_id==86
                        if isfield(dataod.players{i,1}.ability_uses,'lion_voodoo')
                            nb_moutonrubick1=dataod.players{i,1}.ability_uses.lion_voodoo;
                        else
                            nb_moutonrubick1=0;
                        end
                        if isfield(dataod.players{i,1}.ability_uses,'shadow_shaman_voodoo')
                            nb_moutonrubick2=dataod.players{i,1}.ability_uses.shadow_shaman_voodoo;
                        else
                            nb_moutonrubick2=0;
                        end
                        nb_moutonrubick=nb_moutonrubick1+nb_moutonrubick2;
                    end
                    playersadd.nb_mouton=nb_moutonrubick+nb_moutonmorph+nb_moutonlion+nb_moutonrastha+nb_moutonitem;
                    %% permanent buff
                    playersadd.permanent_buffs=0;
                    if playersadd.hero_id==74
                        if isfield(dataod.players{i,1}.permanent_buffs,'stack_count')
                            permanent_buffs=struct2table(dataod.players{i,1}.permanent_buffs);
                            if ~isempty(permanent_buffs.stack_count(permanent_buffs.permanent_buff==3))
                                playersadd.permanent_buffs=permanent_buffs.stack_count(permanent_buffs.permanent_buff==3);
                            end
                        end
                    end
                    if playersadd.hero_id==93
                        if isfield(dataod.players{i,1}.permanent_buffs,'stack_count')
                            permanent_buffs=struct2table(dataod.players{i,1}.permanent_buffs);
                            if ~isempty(permanent_buffs.stack_count(permanent_buffs.permanent_buff==8))
                                playersadd.permanent_buffs=permanent_buffs.stack_count(permanent_buffs.permanent_buff==8);
                            end
                        end
                    end
                    if playersadd.hero_id==14
                        if isfield(dataod.players{i,1}.permanent_buffs,'stack_count')
                            permanent_buffs=struct2table(dataod.players{i,1}.permanent_buffs);
                            if ~isempty(permanent_buffs.stack_count(permanent_buffs.permanent_buff==4))
                                playersadd.permanent_buffs=permanent_buffs.stack_count(permanent_buffs.permanent_buff==4);
                            end
                        end
                    end
                    
                    %% le professeur
                    if isfield(dataod.players{i,1}.purchase,'tome_of_knowledge')
                        playersadd.nb_xpbook_buy=dataod.players{i,1}.purchase.tome_of_knowledge;
                    else
                        playersadd.nb_xpbook_buy=0;
                    end
                    if isfield(dataod.players{i,1}.item_uses,'tome_of_knowledge')
                        playersadd.nb_xpbook_use=dataod.players{i,1}.item_uses.tome_of_knowledge;
                    else
                        playersadd.nb_xpbook_use=0;
                    end
                    playersadd.delta_xpbook=playersadd.nb_xpbook_buy-playersadd.nb_xpbook_use;
                    %% pinger
                    if isfield(dataod.players{i,1},'pings')
                        if ~isempty(dataod.players{i,1}.pings)
                            playersadd.pings=dataod.players{i,1}.pings;
                        else
                            playersadd.pings=0;
                        end
                    else
                        playersadd.pings=0;
                    end
                    %% concat
                    players=[players;playersadd]; %#ok<AGROW>
                    
                    
                end
                %% verifier si le match exist
                RQexist2=['select id from public.openplayermatch where openplayermatch.match_id=',num2str(dataod.match_id)];
                existsql2=pgsqldata(conn,RQexist2);
                if strcmp(existsql2,'No Data')==1
                    CBM_PGSQL_Transact_light(conn,'openplayermatch',players.Properties.VariableNames,players,'id','public');
                    existsql3=pgsqldata(conn,RQexist2);
                    if strcmp(existsql3,'No Data')==1
                        disp('transact nOK')
                        execmatchadd.execopenplayer=0;
                    else
                        disp('transact OK')
                        execmatchadd.execopenplayer=6;
                    end
                else
                    pgsqlexec(conn,['delete from public.openplayermatch where openplayermatch.match_id=',num2str(dataod.match_id)])
                    CBM_PGSQL_Transact_light(conn,'openplayermatch',players.Properties.VariableNames,players,'id','public');
                    existsql4=pgsqldata(conn,RQexist2);
                    if strcmp(existsql4,'No Data')==1
                        disp('transact nOK')
                        execmatchadd.execopenplayer=0;
                    else
                        disp('transact OK')
                        execmatchadd.execopenplayer=6;
                    end
                end
            end
            %%match info
            if execmatchadd.execopenpicks<5
                picks=table();
                picks.match_id=dataod.match_id;
                if dataod.leagueid==9870
                    if dataod.match_id<=3973246064
                        picks.id_tn=dataod.leagueid;
                    else
                        picks.id_tn=8;
                    end
                else
                    picks.id_tn=dataod.leagueid;
                end
                picks.radiant_team_id=dataod.radiant_team_id;
                picks.dire_team_id=dataod.dire_team_id;
                picks.randiant_score=dataod.radiant_score;
                picks.dire_score=dataod.dire_score;
                picks.duration=dataod.duration;
                picks.firstpick=[dataod.picks_bans(1).team].'; %0=radiant 1=dire
                picks.radiant_win=double(dataod.radiant_win);
                picks.firstbloodtime=dataod.first_blood_time;
                if length(dataod.picks_bans)==22
                    switch picks.firstpick
                        case 0 %radiant
                            picks.radiant_b1=[dataod.picks_bans(1).hero_id].';
                            picks.radiant_b2=[dataod.picks_bans(3).hero_id].';
                            picks.radiant_b3=[dataod.picks_bans(5).hero_id].';
                            picks.radiant_b4=[dataod.picks_bans(11).hero_id].';
                            picks.radiant_b5=[dataod.picks_bans(13).hero_id].';
                            picks.radiant_b6=[dataod.picks_bans(20).hero_id].';
                            picks.radiant_p1=[dataod.picks_bans(7).hero_id].';
                            picks.radiant_p2=[dataod.picks_bans(10).hero_id].';
                            picks.radiant_p3=[dataod.picks_bans(16).hero_id].';
                            picks.radiant_p4=[dataod.picks_bans(18).hero_id].';
                            picks.radiant_p5=[dataod.picks_bans(21).hero_id].';
                            picks.dire_b1=[dataod.picks_bans(2).hero_id].';
                            picks.dire_b2=[dataod.picks_bans(4).hero_id].';
                            picks.dire_b3=[dataod.picks_bans(6).hero_id].';
                            picks.dire_b4=[dataod.picks_bans(12).hero_id].';
                            picks.dire_b5=[dataod.picks_bans(14).hero_id].';
                            picks.dire_b6=[dataod.picks_bans(19).hero_id].';
                            picks.dire_p1=[dataod.picks_bans(8).hero_id].';
                            picks.dire_p2=[dataod.picks_bans(9).hero_id].';
                            picks.dire_p3=[dataod.picks_bans(15).hero_id].';
                            picks.dire_p4=[dataod.picks_bans(17).hero_id].';
                            picks.dire_p5=[dataod.picks_bans(22).hero_id].';
                        otherwise %dire
                            picks.radiant_b1=[dataod.picks_bans(2).hero_id].';
                            picks.radiant_b2=[dataod.picks_bans(4).hero_id].';
                            picks.radiant_b3=[dataod.picks_bans(6).hero_id].';
                            picks.radiant_b4=[dataod.picks_bans(12).hero_id].';
                            picks.radiant_b5=[dataod.picks_bans(14).hero_id].';
                            picks.radiant_b6=[dataod.picks_bans(19).hero_id].';
                            picks.radiant_p1=[dataod.picks_bans(8).hero_id].';
                            picks.radiant_p2=[dataod.picks_bans(9).hero_id].';
                            picks.radiant_p3=[dataod.picks_bans(15).hero_id].';
                            picks.radiant_p4=[dataod.picks_bans(17).hero_id].';
                            picks.radiant_p5=[dataod.picks_bans(22).hero_id].';
                            picks.dire_b1=[dataod.picks_bans(1).hero_id].';
                            picks.dire_b2=[dataod.picks_bans(3).hero_id].';
                            picks.dire_b3=[dataod.picks_bans(5).hero_id].';
                            picks.dire_b4=[dataod.picks_bans(11).hero_id].';
                            picks.dire_b5=[dataod.picks_bans(13).hero_id].';
                            picks.dire_b6=[dataod.picks_bans(20).hero_id].';
                            picks.dire_p1=[dataod.picks_bans(7).hero_id].';
                            picks.dire_p2=[dataod.picks_bans(10).hero_id].';
                            picks.dire_p3=[dataod.picks_bans(16).hero_id].';
                            picks.dire_p4=[dataod.picks_bans(18).hero_id].';
                            picks.dire_p5=[dataod.picks_bans(21).hero_id].';
                    end
                else
                    picks.radiant_b1=NaN;
                    picks.radiant_b2=NaN;
                    picks.radiant_b3=NaN;
                    picks.radiant_b4=NaN;
                    picks.radiant_b5=NaN;
                    picks.radiant_b6=NaN;
                    picks.radiant_p1=NaN;
                    picks.radiant_p2=NaN;
                    picks.radiant_p3=NaN;
                    picks.radiant_p4=NaN;
                    picks.radiant_p5=NaN;
                    picks.dire_b1=NaN;
                    picks.dire_b2=NaN;
                    picks.dire_b3=NaN;
                    picks.dire_b4=NaN;
                    picks.dire_b5=NaN;
                    picks.dire_b6=NaN;
                    picks.dire_p1=NaN;
                    picks.dire_p2=NaN;
                    picks.dire_p3=NaN;
                    picks.dire_p4=NaN;
                    picks.dire_p5=NaN;
                end
                if isfield(dataod,'comeback')
                    picks.comeback=dataod.comeback;
                    picks.stomp=dataod.stomp;
                else
                    picks.comeback=NaN;
                    picks.stomp=NaN;
                end
                
                
                
                %% insertion sql
                %% verifier si le match exist
                RQexist=['select id from public.openmatch where openmatch.match_id=',num2str(dataod.match_id)];
                existsql=pgsqldata(conn,RQexist);
                if strcmp(existsql,'No Data')==1
                    CBM_PGSQL_inject1l_light(conn,'openmatch',picks.Properties.VariableNames,picks,'id',NaN,'public','add');
                else
                    CBM_PGSQL_inject1l_light(conn,'openmatch',picks.Properties.VariableNames,picks,'id',existsql.id,'public','update');
                end
                execmatchadd.execopenpicks=6;
            end
        else
            disp('Traitement nOK pas de teamfight dans la partie')
            execmatchadd.execopenplayer=0;
            execmatchadd.execopenpicks=0;
            CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',dataod.match_id,'public','update');
        end
    else
        disp('Traitement nOK autre mode que cm')
        execmatchadd.execopenplayer=7;
        execmatchadd.execopenpicks=7;
        CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',dataod.match_id,'public','update');
    end
    CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',dataod.match_id,'public','update');
    disp('Traitement OK')
catch ME %#ok<NASGU>
    if execmatchadd.execopenpicks<5
        execmatchadd.execopenpicks=execmatchadd.execopenpicks+1;
    end
    if execmatchadd.execopenplayer<5
        execmatchadd.execopenplayer=execmatchadd.execopenplayer+1;
    end
    CBM_PGSQL_inject1l_light(conn,'execmatch',execmatchadd.Properties.VariableNames,execmatchadd,'match_id',dataod.match_id,'public','update');
    disp('Traitement nOK')
end

end