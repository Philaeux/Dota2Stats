function execmatch=execopen(dataod,conn,execmatch)



%% player info
try
    %     switch class(datavalve.result.players(1,1))
    %         case 'cell'
    players=table();
    try
    disp(['Traitement api.open de ',dataod.radiant_team.name,' vs ',dataod.dire_team.name])
    catch
    end
    
    for i=1:10
        %% vérification des infos players
        playerdata=table();
        playerdata.player_id=dataod.players{i,1}.account_id;
        if isempty(dataod.players{i,1}.name)
            if isempty(dataod.players{i,1}.personaname)
                playerdata.player_name{1,1}='nopseudso';
            else
                playerdata.player_name{1,1}=dataod.players{i,1}.personaname;
            end
        else
            playerdata.player_name{1,1}=dataod.players{i,1}.name;
        end
        if dataod.players{i,1}.player_slot<100
            playerdata.team_id=dataod.radiant_team_id;
        else
            playerdata.team_id=dataod.dire_team_id;
        end
        rq_sql_player=['select * from grenouilleapi.public.player where player_id=',num2str(playerdata.player_id)];
        sql_player=pgsqldata(conn,rq_sql_player);
        if strcmp(sql_player,'No Data')==1
            insert(conn,'grenouilleapi.public.player',{'player_id','player_name','team_id'},playerdata);
        else
            if sql_player.team_id~=playerdata.team_id
                update(conn,'grenouilleapi.public.player',{'player_id','player_name','team_id'},playerdata,['where player_id =',num2str(playerdata.player_id)]);
            end
        end
        %% player info
        playersadd=table;
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
        playersadd.obs_placed=dataod.players{i,1}.obs_placed;
        playersadd.sen_placed=dataod.players{i,1}.sen_placed;
        %% KDA
        playersadd.kills=dataod.players{i,1}.kills;
        playersadd.deaths=dataod.players{i,1}.deaths;
        playersadd.assists=dataod.players{i,1}.assists;
        playersadd.leaver_status=dataod.players{i,1}.leaver_status;
        playersadd.camps_stacked=dataod.players{i,1}.camps_stacked;
        playersadd.creep_stacked=dataod.players{i,1}.creeps_stacked;
        %% LH gold level
        playersadd.last_hits=dataod.players{i,1}.last_hits;
        playersadd.denies=dataod.players{i,1}.denies;
        playersadd.gold_per_min=dataod.players{i,1}.gold_per_min;
        playersadd.xp_per_min=dataod.players{i,1}.xp_per_min;
        playersadd.level=dataod.players{i,1}.level;
        playersadd.gold=dataod.players{i,1}.gold;
        playersadd.gold_spent=dataod.players{i,1}.gold_spent;
        playersadd.firstblood_claimed=dataod.players{i,1}.firstblood_claimed;
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
        playersadd.apm=dataod.players{i,1}.actions_per_min;
        playersadd.dead_time=dataod.players{i,1}.life_state_dead;
        playersadd.match_id=dataod.match_id;
        %% gestion des items
        list_item=struct2table(dataod.players{1, 1}.item_uses);
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
        
        players=[players;playersadd]; %#ok<AGROW>
    end   
    
    %%match info
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
    if length(dataod.picks_bans)==22
        switch picks.firstpick
            case 0 %radiant
                picks.radiant_B1=[dataod.picks_bans(1).hero_id].';
                picks.radiant_B2=[dataod.picks_bans(3).hero_id].';
                picks.radiant_B3=[dataod.picks_bans(5).hero_id].';
                picks.radiant_B4=[dataod.picks_bans(11).hero_id].';
                picks.radiant_B5=[dataod.picks_bans(13).hero_id].';
                picks.radiant_B6=[dataod.picks_bans(20).hero_id].';
                picks.rabiant_P1=[dataod.picks_bans(7).hero_id].';
                picks.rabiant_P2=[dataod.picks_bans(10).hero_id].';
                picks.rabiant_P3=[dataod.picks_bans(16).hero_id].';
                picks.rabiant_P4=[dataod.picks_bans(18).hero_id].';
                picks.rabiant_P5=[dataod.picks_bans(21).hero_id].';
                picks.dire_B1=[dataod.picks_bans(2).hero_id].';
                picks.dire_B2=[dataod.picks_bans(4).hero_id].';
                picks.dire_B3=[dataod.picks_bans(6).hero_id].';
                picks.dire_B4=[dataod.picks_bans(12).hero_id].';
                picks.dire_B5=[dataod.picks_bans(14).hero_id].';
                picks.dire_B6=[dataod.picks_bans(19).hero_id].';
                picks.dire_P1=[dataod.picks_bans(8).hero_id].';
                picks.dire_P2=[dataod.picks_bans(9).hero_id].';
                picks.dire_P3=[dataod.picks_bans(15).hero_id].';
                picks.dire_P4=[dataod.picks_bans(17).hero_id].';
                picks.dire_P5=[dataod.picks_bans(22).hero_id].';
            otherwise %dire
                picks.radiant_B1=[dataod.picks_bans(2).hero_id].';
                picks.radiant_B2=[dataod.picks_bans(4).hero_id].';
                picks.radiant_B3=[dataod.picks_bans(6).hero_id].';
                picks.radiant_B4=[dataod.picks_bans(12).hero_id].';
                picks.radiant_B5=[dataod.picks_bans(14).hero_id].';
                picks.radiant_B6=[dataod.picks_bans(19).hero_id].';
                picks.rabiant_P1=[dataod.picks_bans(8).hero_id].';
                picks.rabiant_P2=[dataod.picks_bans(9).hero_id].';
                picks.rabiant_P3=[dataod.picks_bans(15).hero_id].';
                picks.rabiant_P4=[dataod.picks_bans(17).hero_id].';
                picks.rabiant_P5=[dataod.picks_bans(22).hero_id].';
                picks.dire_B1=[dataod.picks_bans(1).hero_id].';
                picks.dire_B2=[dataod.picks_bans(3).hero_id].';
                picks.dire_B3=[dataod.picks_bans(5).hero_id].';
                picks.dire_B4=[dataod.picks_bans(11).hero_id].';
                picks.dire_B5=[dataod.picks_bans(13).hero_id].';
                picks.dire_B6=[dataod.picks_bans(20).hero_id].';
                picks.dire_P1=[dataod.picks_bans(7).hero_id].';
                picks.dire_P2=[dataod.picks_bans(10).hero_id].';
                picks.dire_P3=[dataod.picks_bans(16).hero_id].';
                picks.dire_P4=[dataod.picks_bans(18).hero_id].';
                picks.dire_P5=[dataod.picks_bans(21).hero_id].';
        end
    else
        picks.radiant_B1=NaN;
        picks.radiant_B2=NaN;
        picks.radiant_B3=NaN;
        picks.radiant_B4=NaN;
        picks.radiant_B5=NaN;
        picks.radiant_B6=NaN;
        picks.rabiant_P1=NaN;
        picks.rabiant_P2=NaN;
        picks.rabiant_P3=NaN;
        picks.rabiant_P4=NaN;
        picks.rabiant_P5=NaN;
        picks.dire_B1=NaN;
        picks.dire_B2=NaN;
        picks.dire_B3=NaN;
        picks.dire_B4=NaN;
        picks.dire_B5=NaN;
        picks.dire_B6=NaN;
        picks.dire_P1=NaN;
        picks.dire_P2=NaN;
        picks.dire_P3=NaN;
        picks.dire_P4=NaN;
        picks.dire_P5=NaN;
    end
    if isfield(dataod,'comeback')
        picks.comeback=dataod.comeback;
        picks.stomp=dataod.stomp;
    else
        picks.comeback=NaN;
        picks.stomp=NaN;
    end
    
    
    
    %% insertion sql
    execmatchadd=execmatch(execmatch.match_id==dataod.match_id,:);
    %% verifier si le match exist
    RQexist=['select *_id from grenouilleapi.public.openmatch where match_id=',num2str(dataod.match_id)];
    existsql=pgsqldata(conn,RQexist);
    if strcmp(existsql,'No Data')==1
        insert(conn,'grenouilleapi.public.openmatch',{'match_id','id_tn','radiant_team_id','dire_team_id','randiant_score','dire_score','duration','firstpick','radiant_win','radiant_B1','radiant_B2','radiant_B3',...
            'radiant_B4','radiant_B5','radiant_B6','rabiant_P1','rabiant_P2','rabiant_P3','rabiant_P4','rabiant_P5','dire_B1','dire_B2','dire_B3','dire_B4','dire_B5','dire_B6','dire_P1','dire_P2','dire_P3',...
            'dire_P4','dire_P5','comeback','stomp'},picks);
    else
        pgsqlexec(conn,['delete from grenouilleapi.public.openmatch where match_id=',num2str(dataod.match_id)])
        insert(conn,'grenouilleapi.public.openmatch',{'match_id','id_tn','radiant_team_id','dire_team_id','randiant_score','dire_score','duration','firstpick','radiant_win','radiant_B1','radiant_B2','radiant_B3',...
            'radiant_B4','radiant_B5','radiant_B6','rabiant_P1','rabiant_P2','rabiant_P3','rabiant_P4','rabiant_P5','dire_B1','dire_B2','dire_B3','dire_B4','dire_B5','dire_B6','dire_P1','dire_P2','dire_P3',...
            'dire_P4','dire_P5','comeback','stomp'},picks);
    end
    
    execmatchadd.execopenpicks=1;
    %% verifier si le match exist
    RQexist2=['select * from grenouilleapi.public.openplayermatch where openplayermatch.match_id=',num2str(dataod.match_id)];
    existsql2=pgsqldata(conn,RQexist2);
    if strcmp(existsql2,'No Data')==1
        insert(conn,'grenouilleapi.public.openplayermatch',{'account_id','player_slot','hero_id','item_0','item_1','item_2','item_3','item_4','item_5','backpack_0','backpack_1','backpack_2','obs_placed',...
            'sen_placed','kills','deaths','assists','leaver_status','camps_stacked','creep_stacked','last_hits','denies','gold_per_min','xp_per_min','level','gold','gold_spent','firstblood_claimed',...
            'roshans_kill','tower_kill','kda','hero_damage','tower_damage','hero_healing','rune_pickups','dd_pickups','haste_pickups','regen_pickups','invi_pickups','illu_pickups','bounty_pickups',...
            'arcane_pickups','stun','teamfight_part','lane_effi','lane_effi_pct','lane','lane_role','apm','dead_time','match_id','tango','tpscroll','arcane_boots','clarity','smoke_of_deceit',...
            'quelling_blade','phase_boots','shadow_amulet','invis_sword','pipe','soul_ring','medallion_of_courage','helm_of_the_dominator','branches','tome_of_knowledge','diffusal_blade','power_treads',...
            'bottle','glimmer_cape','black_king_bar','silver_edge','blink','blade_mail','travel_boots','urn_of_shadows','guardian_greaves','hurricane_pike','cheese','solar_crest','mjollnir','dust',...
            'spirit_vessel','cyclone','manta','refresher_shard','moon_shard','crimson_guard','butterfly','rod_of_atos','orchid','shivas_guard','dagon','veil_of_discord','ethereal_blade','ghost','nullifier','satanic',...
            'sheepstick','heavens_halberd','mekansm'},players);
    else
        pgsqlexec(conn,['delete from grenouilleapi.public.openplayermatch where openplayermatch.match_id=',num2str(dataod.match_id)])
        insert(conn,'grenouilleapi.public.openplayermatch',{'account_id','player_slot','hero_id','item_0','item_1','item_2','item_3','item_4','item_5','backpack_0','backpack_1','backpack_2','obs_placed',...
            'sen_placed','kills','deaths','assists','leaver_status','camps_stacked','creep_stacked','last_hits','denies','gold_per_min','xp_per_min','level','gold','gold_spent','firstblood_claimed',...
            'roshans_kill','tower_kill','kda','hero_damage','tower_damage','hero_healing','rune_pickups','dd_pickups','haste_pickups','regen_pickups','invi_pickups','illu_pickups','bounty_pickups',...
            'arcane_pickups','stun','teamfight_part','lane_effi','lane_effi_pct','lane','lane_role','apm','dead_time','match_id','tango','tpscroll','arcane_boots','clarity','smoke_of_deceit',...
            'quelling_blade','phase_boots','shadow_amulet','invis_sword','pipe','soul_ring','medallion_of_courage','helm_of_the_dominator','branches','tome_of_knowledge','diffusal_blade','power_treads',...
            'bottle','glimmer_cape','black_king_bar','silver_edge','blink','blade_mail','travel_boots','urn_of_shadows','guardian_greaves','hurricane_pike','cheese','solar_crest','mjollnir','dust',...
            'spirit_vessel','cyclone','manta','refresher_shard','moon_shard','crimson_guard','butterfly','rod_of_atos','orchid','shivas_guard','dagon','veil_of_discord','ethereal_blade','ghost','nullifier','satanic',...
            'sheepstick','heavens_halberd','mekansm'},players);
    end
    execmatchadd.execopenplayer=1;
    update(conn,'grenouilleapi.public.execmatch',{'match_id','execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatchadd,['where match_id =',num2str(dataod.match_id)]);
    execmatch(execmatch.match_id==dataod.match_id,:)=execmatchadd;
    disp('Traitement OK')
catch ME
    execmatchadd=execmatch(execmatch.match_id==dataod.match_id,:);
    if execmatchadd.execopenpicks==0
        execmatchadd.execopenpicks=2;
    end
    if execmatchadd.execopenplayer==0
        execmatchadd.execopenplayer=2;
    end
    update(conn,'grenouilleapi.public.execmatch',{'match_id','execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatchadd,['where match_id =',num2str(dataod.match_id)]);
    execmatch(execmatch.match_id==dataod.match_id,:)=execmatchadd;
    disp('Traitement nOK')
end

end