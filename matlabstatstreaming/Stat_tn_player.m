function Stat_tn_player(conn,match_open,tn_id)
disp('Traitement des stats TN Player') 
switch nargin
    case 2
        
        %% init tn
        list_tn=unique(match_open.id_tn);
        nb_tn=length(list_tn);

        for k=1:nb_tn
            
            
            %% init player
            player_match_open=pgsqldata(conn,['select * from grenouilleapi.public.openplayermatch inner join grenouilleapi.public.openmatch on openplayermatch.match_id=openmatch.match_id where id_tn=',num2str(list_tn(k))]);
            list_player=unique(player_match_open.account_id);
            nb_player=length(list_player);
            
            %% algo
            for i=1:nb_player
                CalcStatPlayer=player_match_open(player_match_open.account_id==list_player(i),:);
                if ~isempty(CalcStatPlayer)
                    StatPlayerAdd=table();
                    StatPlayerAdd.account_id=list_player(i);
                    StatPlayerAdd.id_tn=list_tn(k);
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
                    
                end
                %% insertion SQL
                
                pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_player where account_id=',num2str(list_player(i)),' and id_tn=',num2str(list_tn(k))])
                insert(conn,'grenouilleapi.public.stat_tn_player',{'account_id','id_tn','mean_obs_placed','max_obs_placed','min_obs_placed','tot_obs_placed','mean_sen_placed','max_sen_placed','min_sen_placed',...
                    'tot_sen_placed','mean_kills','max_kills','min_kills','tot_kills','mean_deaths','max_deaths','min_deaths','tot_deaths','mean_assists','max_assists','min_assists','tot_assists','mean_camps_stacked',...
                    'max_camps_stacked','min_camps_stacked','tot_camps_stacked','mean_creep_stacked','max_creep_stacked','min_creep_stacked','tot_creep_stacked','mean_last_hits','max_last_hits','min_last_hits',...
                    'tot_last_hits','mean_denies','max_denies','min_denies','tot_denies','mean_gold_per_min','max_gold_per_min','min_gold_per_min','tot_gold_per_min','mean_xp_per_min','max_xp_per_min',...
                    'min_xp_per_min','tot_xp_per_min','mean_level','max_level','min_level','tot_level','mean_gold','max_gold','min_gold','tot_gold','mean_gold_spent','max_gold_spent','min_gold_spent',...
                    'tot_gold_spent','mean_firstblood_claimed','max_firstblood_claimed','min_firstblood_claimed','tot_firstblood_claimed','mean_roshans_kill','max_roshans_kill','min_roshans_kill',...
                    'tot_roshans_kill','mean_tower_kill','max_tower_kill','min_tower_kill','tot_tower_kill','mean_kda','max_kda','min_kda','tot_kda','mean_hero_damage','max_hero_damage','min_hero_damage',...
                    'tot_hero_damage','mean_tower_damage','max_tower_damage','min_tower_damage','tot_tower_damage','mean_hero_healing','max_hero_healing','min_hero_healing','tot_hero_healing','mean_rune_pickups',...
                    'max_rune_pickups','min_rune_pickups','tot_rune_pickups','mean_dd_pickups','max_dd_pickups','min_dd_pickups','tot_dd_pickups','mean_haste_pickups','max_haste_pickups','min_haste_pickups',...
                    'tot_haste_pickups','mean_regen_pickups','max_regen_pickups','min_regen_pickups','tot_regen_pickups','mean_invi_pickups','max_invi_pickups','min_invi_pickups','tot_invi_pickups','mean_illu_pickups',...
                    'max_illu_pickups','min_illu_pickups','tot_illu_pickups','mean_bounty_pickups','max_bounty_pickups','min_bounty_pickups','tot_bounty_pickups','mean_arcane_pickups','max_arcane_pickups',...
                    'min_arcane_pickups','tot_arcane_pickups','mean_stun','max_stun','min_stun','tot_stun','mean_teamfight_part','max_teamfight_part','min_teamfight_part','tot_teamfight_part','mean_lane_effi',...
                    'max_lane_effi','min_lane_effi','tot_lane_effi','mean_lane_effi_pct','max_lane_effi_pct','min_lane_effi_pct','tot_lane_effi_pct','mean_lane','max_lane','min_lane','tot_lane','mean_lane_role',...
                    'max_lane_role','min_lane_role','tot_lane_role','mean_apm','max_apm','min_apm','tot_apm','mean_dead_time','max_dead_time','min_dead_time','tot_dead_time','mean_tango','max_tango','min_tango',...
                    'tot_tango','mean_tpscroll','max_tpscroll','min_tpscroll','tot_tpscroll','mean_arcane_boots','max_arcane_boots','min_arcane_boots','tot_arcane_boots','mean_clarity','max_clarity','min_clarity',...
                    'tot_clarity','mean_smoke_of_deceit','max_smoke_of_deceit','min_smoke_of_deceit','tot_smoke_of_deceit','mean_quelling_blade','max_quelling_blade','min_quelling_blade','tot_quelling_blade',...
                    'mean_phase_boots','max_phase_boots','min_phase_boots','tot_phase_boots','mean_shadow_amulet','max_shadow_amulet','min_shadow_amulet','tot_shadow_amulet','mean_invis_sword','max_invis_sword',...
                    'min_invis_sword','tot_invis_sword','mean_pipe','max_pipe','min_pipe','tot_pipe','mean_soul_ring','max_soul_ring','min_soul_ring','tot_soul_ring','mean_medallion_of_courage',...
                    'max_medallion_of_courage','min_medallion_of_courage','tot_medallion_of_courage','mean_helm_of_the_dominator','max_helm_of_the_dominator','min_helm_of_the_dominator',...
                    'tot_helm_of_the_dominator','mean_branches','max_branches','min_branches','tot_branches','mean_tome_of_knowledge','max_tome_of_knowledge','min_tome_of_knowledge','tot_tome_of_knowledge',...
                    'mean_diffusal_blade','max_diffusal_blade','min_diffusal_blade','tot_diffusal_blade','mean_power_treads','max_power_treads','min_power_treads','tot_power_treads','mean_bottle','max_bottle',...
                    'min_bottle','tot_bottle','mean_glimmer_cape','max_glimmer_cape','min_glimmer_cape','tot_glimmer_cape','mean_black_king_bar','max_black_king_bar','min_black_king_bar','tot_black_king_bar',...
                    'mean_silver_edge','max_silver_edge','min_silver_edge','tot_silver_edge','mean_blink','max_blink','min_blink','tot_blink','mean_blade_mail','max_blade_mail','min_blade_mail','tot_blade_mail',...
                    'mean_travel_boots','max_travel_boots','min_travel_boots','tot_travel_boots','mean_urn_of_shadows','max_urn_of_shadows','min_urn_of_shadows','tot_urn_of_shadows','mean_guardian_greaves',...
                    'max_guardian_greaves','min_guardian_greaves','tot_guardian_greaves','mean_hurricane_pike','max_hurricane_pike','min_hurricane_pike','tot_hurricane_pike','mean_cheese','max_cheese',...
                    'min_cheese','tot_cheese','mean_solar_crest','max_solar_crest','min_solar_crest','tot_solar_crest','mean_mjollnir','max_mjollnir','min_mjollnir','tot_mjollnir','mean_dust','max_dust',...
                    'min_dust','tot_dust','mean_spirit_vessel','max_spirit_vessel','min_spirit_vessel','tot_spirit_vessel','mean_cyclone','max_cyclone','min_cyclone','tot_cyclone','mean_manta','max_manta',...
                    'min_manta','tot_manta','mean_refresher_shard','max_refresher_shard','min_refresher_shard','tot_refresher_shard','mean_moon_shard','max_moon_shard','min_moon_shard','tot_moon_shard',...
                    'mean_crimson_guard','max_crimson_guard','min_crimson_guard','tot_crimson_guard','mean_butterfly','max_butterfly','min_butterfly','tot_butterfly','mean_rod_of_atos','max_rod_of_atos',...
                    'min_rod_of_atos','tot_rod_of_atos','mean_orchid','max_orchid','min_orchid','tot_orchid','mean_shivas_guard','max_shivas_guard','min_shivas_guard','tot_shivas_guard','mean_dagon','max_dagon',...
                    'min_dagon','tot_dagon','mean_veil_of_discord','max_veil_of_discord','min_veil_of_discord','tot_veil_of_discord','mean_ethereal_blade','max_ethereal_blade','min_ethereal_blade',...
                    'tot_ethereal_blade','mean_ghost','max_ghost','min_ghost','tot_ghost','mean_nullifier','max_nullifier','min_nullifier','tot_nullifier','mean_satanic','max_satanic','min_satanic',...
                    'tot_satanic','mean_sheepstick','max_sheepstick','min_sheepstick','tot_sheepstick','mean_heavens_halberd','max_heavens_halberd','min_heavens_halberd','tot_heavens_halberd','mean_mekansm',...
                    'max_mekansm','min_mekansm','tot_mekansm'},StatPlayerAdd);
                
            end
        end
    case 3
               
        
        %% init player
        player_match_open=pgsqldata(conn,['select * from grenouilleapi.public.openplayermatch inner join grenouilleapi.public.openmatch on openplayermatch.match_id=openmatch.match_id where id_tn=',num2str(tn_id)]);
        list_player=unique(player_match_open.account_id);
        nb_player=length(list_player);
        
        %% algo
        for i=1:nb_player
            CalcStatPlayer=player_match_open(player_match_open.account_id==list_player(i),:);
            if ~isempty(CalcStatPlayer)
                StatPlayerAdd=table();
                StatPlayerAdd.account_id=list_player(i);
                StatPlayerAdd.id_tn=tn_id;
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
                
            end
            %% insertion SQL
            
            pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_player where account_id=',num2str(list_player(i)),' and id_tn=',num2str(tn_id)])
            insert(conn,'grenouilleapi.public.stat_tn_player',{'account_id','id_tn','mean_obs_placed','max_obs_placed','min_obs_placed','tot_obs_placed','mean_sen_placed','max_sen_placed','min_sen_placed',...
                'tot_sen_placed','mean_kills','max_kills','min_kills','tot_kills','mean_deaths','max_deaths','min_deaths','tot_deaths','mean_assists','max_assists','min_assists','tot_assists','mean_camps_stacked',...
                'max_camps_stacked','min_camps_stacked','tot_camps_stacked','mean_creep_stacked','max_creep_stacked','min_creep_stacked','tot_creep_stacked','mean_last_hits','max_last_hits','min_last_hits',...
                'tot_last_hits','mean_denies','max_denies','min_denies','tot_denies','mean_gold_per_min','max_gold_per_min','min_gold_per_min','tot_gold_per_min','mean_xp_per_min','max_xp_per_min',...
                'min_xp_per_min','tot_xp_per_min','mean_level','max_level','min_level','tot_level','mean_gold','max_gold','min_gold','tot_gold','mean_gold_spent','max_gold_spent','min_gold_spent',...
                'tot_gold_spent','mean_firstblood_claimed','max_firstblood_claimed','min_firstblood_claimed','tot_firstblood_claimed','mean_roshans_kill','max_roshans_kill','min_roshans_kill',...
                'tot_roshans_kill','mean_tower_kill','max_tower_kill','min_tower_kill','tot_tower_kill','mean_kda','max_kda','min_kda','tot_kda','mean_hero_damage','max_hero_damage','min_hero_damage',...
                'tot_hero_damage','mean_tower_damage','max_tower_damage','min_tower_damage','tot_tower_damage','mean_hero_healing','max_hero_healing','min_hero_healing','tot_hero_healing','mean_rune_pickups',...
                'max_rune_pickups','min_rune_pickups','tot_rune_pickups','mean_dd_pickups','max_dd_pickups','min_dd_pickups','tot_dd_pickups','mean_haste_pickups','max_haste_pickups','min_haste_pickups',...
                'tot_haste_pickups','mean_regen_pickups','max_regen_pickups','min_regen_pickups','tot_regen_pickups','mean_invi_pickups','max_invi_pickups','min_invi_pickups','tot_invi_pickups','mean_illu_pickups',...
                'max_illu_pickups','min_illu_pickups','tot_illu_pickups','mean_bounty_pickups','max_bounty_pickups','min_bounty_pickups','tot_bounty_pickups','mean_arcane_pickups','max_arcane_pickups',...
                'min_arcane_pickups','tot_arcane_pickups','mean_stun','max_stun','min_stun','tot_stun','mean_teamfight_part','max_teamfight_part','min_teamfight_part','tot_teamfight_part','mean_lane_effi',...
                'max_lane_effi','min_lane_effi','tot_lane_effi','mean_lane_effi_pct','max_lane_effi_pct','min_lane_effi_pct','tot_lane_effi_pct','mean_lane','max_lane','min_lane','tot_lane','mean_lane_role',...
                'max_lane_role','min_lane_role','tot_lane_role','mean_apm','max_apm','min_apm','tot_apm','mean_dead_time','max_dead_time','min_dead_time','tot_dead_time','mean_tango','max_tango','min_tango',...
                'tot_tango','mean_tpscroll','max_tpscroll','min_tpscroll','tot_tpscroll','mean_arcane_boots','max_arcane_boots','min_arcane_boots','tot_arcane_boots','mean_clarity','max_clarity','min_clarity',...
                'tot_clarity','mean_smoke_of_deceit','max_smoke_of_deceit','min_smoke_of_deceit','tot_smoke_of_deceit','mean_quelling_blade','max_quelling_blade','min_quelling_blade','tot_quelling_blade',...
                'mean_phase_boots','max_phase_boots','min_phase_boots','tot_phase_boots','mean_shadow_amulet','max_shadow_amulet','min_shadow_amulet','tot_shadow_amulet','mean_invis_sword','max_invis_sword',...
                'min_invis_sword','tot_invis_sword','mean_pipe','max_pipe','min_pipe','tot_pipe','mean_soul_ring','max_soul_ring','min_soul_ring','tot_soul_ring','mean_medallion_of_courage',...
                'max_medallion_of_courage','min_medallion_of_courage','tot_medallion_of_courage','mean_helm_of_the_dominator','max_helm_of_the_dominator','min_helm_of_the_dominator',...
                'tot_helm_of_the_dominator','mean_branches','max_branches','min_branches','tot_branches','mean_tome_of_knowledge','max_tome_of_knowledge','min_tome_of_knowledge','tot_tome_of_knowledge',...
                'mean_diffusal_blade','max_diffusal_blade','min_diffusal_blade','tot_diffusal_blade','mean_power_treads','max_power_treads','min_power_treads','tot_power_treads','mean_bottle','max_bottle',...
                'min_bottle','tot_bottle','mean_glimmer_cape','max_glimmer_cape','min_glimmer_cape','tot_glimmer_cape','mean_black_king_bar','max_black_king_bar','min_black_king_bar','tot_black_king_bar',...
                'mean_silver_edge','max_silver_edge','min_silver_edge','tot_silver_edge','mean_blink','max_blink','min_blink','tot_blink','mean_blade_mail','max_blade_mail','min_blade_mail','tot_blade_mail',...
                'mean_travel_boots','max_travel_boots','min_travel_boots','tot_travel_boots','mean_urn_of_shadows','max_urn_of_shadows','min_urn_of_shadows','tot_urn_of_shadows','mean_guardian_greaves',...
                'max_guardian_greaves','min_guardian_greaves','tot_guardian_greaves','mean_hurricane_pike','max_hurricane_pike','min_hurricane_pike','tot_hurricane_pike','mean_cheese','max_cheese',...
                'min_cheese','tot_cheese','mean_solar_crest','max_solar_crest','min_solar_crest','tot_solar_crest','mean_mjollnir','max_mjollnir','min_mjollnir','tot_mjollnir','mean_dust','max_dust',...
                'min_dust','tot_dust','mean_spirit_vessel','max_spirit_vessel','min_spirit_vessel','tot_spirit_vessel','mean_cyclone','max_cyclone','min_cyclone','tot_cyclone','mean_manta','max_manta',...
                'min_manta','tot_manta','mean_refresher_shard','max_refresher_shard','min_refresher_shard','tot_refresher_shard','mean_moon_shard','max_moon_shard','min_moon_shard','tot_moon_shard',...
                'mean_crimson_guard','max_crimson_guard','min_crimson_guard','tot_crimson_guard','mean_butterfly','max_butterfly','min_butterfly','tot_butterfly','mean_rod_of_atos','max_rod_of_atos',...
                'min_rod_of_atos','tot_rod_of_atos','mean_orchid','max_orchid','min_orchid','tot_orchid','mean_shivas_guard','max_shivas_guard','min_shivas_guard','tot_shivas_guard','mean_dagon','max_dagon',...
                'min_dagon','tot_dagon','mean_veil_of_discord','max_veil_of_discord','min_veil_of_discord','tot_veil_of_discord','mean_ethereal_blade','max_ethereal_blade','min_ethereal_blade',...
                'tot_ethereal_blade','mean_ghost','max_ghost','min_ghost','tot_ghost','mean_nullifier','max_nullifier','min_nullifier','tot_nullifier','mean_satanic','max_satanic','min_satanic',...
                'tot_satanic','mean_sheepstick','max_sheepstick','min_sheepstick','tot_sheepstick','mean_heavens_halberd','max_heavens_halberd','min_heavens_halberd','tot_heavens_halberd','mean_mekansm',...
                'max_mekansm','min_mekansm','tot_mekansm'},StatPlayerAdd);
            
        end
        
end
disp('Traitement OK')
end

