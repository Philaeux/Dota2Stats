function Stat_tn_player(conn,tn_id,type)
disp('Traitement des stats TN Player')

%% init player
player_match_open=pgsqldata(conn,['select * from public.join_stat_tn_player where tn_id=',num2str(tn_id)]);

switch type
    case 'main'
        
        list_player=unique(player_match_open.account_id(player_match_open.is_qualif==0));
        nb_player=length(list_player);
        StatPlayer=table();
        %% algo
        for i=1:nb_player
            CalcStatPlayer=player_match_open(player_match_open.account_id==list_player(i) & player_match_open.is_qualif==0,:);
            if ~isempty(CalcStatPlayer)
                StatPlayerAdd=table();
                StatPlayerAdd.id=NaN;
                StatPlayerAdd.account_id=list_player(i);
                StatPlayerAdd.tn_id=tn_id;
                StatPlayerAdd.is_qualif=0;
                StatPlayerAdd.patch_num=max(CalcStatPlayer.patch_num);
                StatPlayerAdd.patch_id=max(CalcStatPlayer.patch_id);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'obs_placed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'sen_placed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'kills',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'deaths',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'assists',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'camps_stacked',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'creep_stacked',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'last_hits',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'denies',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_per_min',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'xp_per_min',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'level',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_spent',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'firstblood_claimed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'roshans_kill',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_kill',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'kda',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_damage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_damage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_healing',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'rune_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dd_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'haste_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'regen_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'invi_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'illu_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bounty_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'arcane_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'stun',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'teamfight_part',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_effi',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_effi_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_role',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'apm',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dead_time',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tango',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tpscroll',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'arcane_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'clarity',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'smoke_of_deceit',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'quelling_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'phase_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'shadow_amulet',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'invis_sword',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'pipe',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'soul_ring',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'medallion_of_courage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'helm_of_the_dominator',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'branches',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tome_of_knowledge',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'diffusal_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'power_treads',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bottle',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'glimmer_cape',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'black_king_bar',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'silver_edge',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'blink',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'blade_mail',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'travel_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'urn_of_shadows',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'guardian_greaves',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hurricane_pike',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'cheese',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'solar_crest',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'mjollnir',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dust',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'spirit_vessel',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'cyclone',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'manta',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'refresher_shard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'moon_shard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'crimson_guard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'butterfly',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'rod_of_atos',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'orchid',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'shivas_guard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dagon',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'veil_of_discord',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'ethereal_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'ghost',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'nullifier',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'satanic',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'sheepstick',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'heavens_halberd',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'mekansm',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'is_roaming',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_obs',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_sen',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_tp',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_gpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_gpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_xppm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_xppm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_kpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_kpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_damagepm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_damagepm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_healingpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_healingpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_todam_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_todam_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_stunspm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_stunspm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhten_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhten_pct',StatPlayerAdd);
                % traitement max hit
                StatPlayerAdd.max_hit_value=max(CalcStatPlayer.max_hero_hit_value);
                x_type=find(max(CalcStatPlayer.max_hero_hit_value));
                StatPlayerAdd.max_hit_type=CalcStatPlayer.max_hero_hit_type(x_type,1); %#ok<FNDSB>
                StatPlayer=[StatPlayer;StatPlayerAdd]; %#ok<AGROW>
            end
        end
        %% insertion SQL StatPlayer
        rqexist=['select id from public.stat_tn_player where tn_id=',num2str(tn_id),' and is_qualif=0'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_player where tn_id=',num2str(tn_id),' and is_qualif=0'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_player',StatPlayer.Properties.VariableNames,StatPlayer,'id','public');
    case 'qualif'
        list_player=unique(player_match_open.account_id(player_match_open.is_qualif==1));
        nb_player=length(list_player);
        StatPlayer=table();
        %% algo
        for i=1:nb_player
            CalcStatPlayer=player_match_open(player_match_open.account_id==list_player(i) & player_match_open.is_qualif==1,:);
            if ~isempty(CalcStatPlayer)
                StatPlayerAdd=table();
                StatPlayerAdd.id=NaN;
                StatPlayerAdd.account_id=list_player(i);
                StatPlayerAdd.tn_id=tn_id;
                StatPlayerAdd.is_qualif=1;
                StatPlayerAdd.patch_num=max(CalcStatPlayer.patch_num);
                StatPlayerAdd.patch_id=max(CalcStatPlayer.patch_id);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'obs_placed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'sen_placed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'kills',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'deaths',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'assists',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'camps_stacked',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'creep_stacked',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'last_hits',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'denies',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_per_min',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'xp_per_min',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'level',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_spent',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'firstblood_claimed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'roshans_kill',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_kill',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'kda',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_damage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_damage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_healing',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'rune_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dd_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'haste_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'regen_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'invi_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'illu_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bounty_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'arcane_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'stun',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'teamfight_part',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_effi',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_effi_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_role',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'apm',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dead_time',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tango',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tpscroll',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'arcane_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'clarity',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'smoke_of_deceit',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'quelling_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'phase_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'shadow_amulet',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'invis_sword',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'pipe',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'soul_ring',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'medallion_of_courage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'helm_of_the_dominator',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'branches',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tome_of_knowledge',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'diffusal_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'power_treads',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bottle',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'glimmer_cape',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'black_king_bar',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'silver_edge',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'blink',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'blade_mail',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'travel_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'urn_of_shadows',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'guardian_greaves',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hurricane_pike',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'cheese',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'solar_crest',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'mjollnir',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dust',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'spirit_vessel',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'cyclone',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'manta',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'refresher_shard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'moon_shard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'crimson_guard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'butterfly',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'rod_of_atos',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'orchid',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'shivas_guard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dagon',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'veil_of_discord',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'ethereal_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'ghost',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'nullifier',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'satanic',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'sheepstick',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'heavens_halberd',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'mekansm',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'is_roaming',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_obs',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_sen',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_tp',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_gpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_gpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_xppm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_xppm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_kpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_kpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_damagepm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_damagepm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_healingpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_healingpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_todam_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_todam_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_stunspm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_stunspm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhten_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhten_pct',StatPlayerAdd);
                % traitement max hit
                StatPlayerAdd.max_hit_value=max(CalcStatPlayer.max_hero_hit_value);
                x_type=find(max(CalcStatPlayer.max_hero_hit_value));
                StatPlayerAdd.max_hit_type=CalcStatPlayer.max_hero_hit_type(x_type,1); %#ok<FNDSB>
                StatPlayer=[StatPlayer;StatPlayerAdd]; %#ok<AGROW>
            end
        end
        %% insertion SQL StatPlayer
        rqexist=['select id from public.stat_tn_player where tn_id=',num2str(tn_id),' and is_qualif=1'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_player where tn_id=',num2str(tn_id)],' and is_qualif=1')
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_player',StatPlayer.Properties.VariableNames,StatPlayer,'id','public');
    case 'all'
        list_player=unique(player_match_open.account_id);
        nb_player=length(list_player);
        StatPlayer=table();
        %% algo
        for i=1:nb_player
            CalcStatPlayer=player_match_open(player_match_open.account_id==list_player(i),:);
            if ~isempty(CalcStatPlayer)
                StatPlayerAdd=table();
                StatPlayerAdd.id=NaN;
                StatPlayerAdd.account_id=list_player(i);
                StatPlayerAdd.tn_id=tn_id;
                StatPlayerAdd.is_qualif=NaN;
                StatPlayerAdd.patch_num=max(CalcStatPlayer.patch_num);
                StatPlayerAdd.patch_id=max(CalcStatPlayer.patch_id);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'obs_placed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'sen_placed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'kills',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'deaths',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'assists',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'camps_stacked',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'creep_stacked',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'last_hits',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'denies',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_per_min',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'xp_per_min',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'level',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'gold_spent',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'firstblood_claimed',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'roshans_kill',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_kill',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'kda',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_damage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tower_damage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hero_healing',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'rune_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dd_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'haste_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'regen_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'invi_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'illu_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bounty_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'arcane_pickups',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'stun',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'teamfight_part',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_effi',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_effi_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'lane_role',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'apm',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dead_time',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tango',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tpscroll',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'arcane_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'clarity',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'smoke_of_deceit',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'quelling_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'phase_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'shadow_amulet',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'invis_sword',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'pipe',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'soul_ring',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'medallion_of_courage',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'helm_of_the_dominator',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'branches',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'tome_of_knowledge',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'diffusal_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'power_treads',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bottle',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'glimmer_cape',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'black_king_bar',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'silver_edge',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'blink',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'blade_mail',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'travel_boots',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'urn_of_shadows',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'guardian_greaves',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'hurricane_pike',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'cheese',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'solar_crest',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'mjollnir',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dust',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'spirit_vessel',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'cyclone',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'manta',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'refresher_shard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'moon_shard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'crimson_guard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'butterfly',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'rod_of_atos',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'orchid',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'shivas_guard',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'dagon',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'veil_of_discord',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'ethereal_blade',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'ghost',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'nullifier',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'satanic',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'sheepstick',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'heavens_halberd',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'mekansm',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'is_roaming',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_obs',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_sen',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'purchased_tp',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_gpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_gpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_xppm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_xppm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_kpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_kpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_damagepm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_damagepm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_healingpm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_healingpm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_todam_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_todam_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_stunspm_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_stunspm_pct',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhten_value',StatPlayerAdd);
                [StatPlayerAdd]=genstat(CalcStatPlayer,'bench_lhten_pct',StatPlayerAdd);
                % traitement max hit
                StatPlayerAdd.max_hit_value=max(CalcStatPlayer.max_hero_hit_value);
                x_type=find(max(CalcStatPlayer.max_hero_hit_value));
                StatPlayerAdd.max_hit_type=CalcStatPlayer.max_hero_hit_type(x_type,1); %#ok<FNDSB>
                StatPlayer=[StatPlayer;StatPlayerAdd]; %#ok<AGROW>
            end
        end
        %% insertion SQL StatPlayer
        rqexist=['select id from public.stat_tn_player where tn_id=',num2str(tn_id),' and is_qualif=null'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_player where tn_id=',num2str(tn_id),' and is_qualif=null'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_player',StatPlayer.Properties.VariableNames,StatPlayer,'id','public');
        
end


disp('Traitement OK')
end

