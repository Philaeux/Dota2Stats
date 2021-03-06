CREATE TABLE IF NOT EXISTS dota_heroes(
    id int PRIMARY KEY,
    name varchar(255) UNIQUE,
    short_name varchar(255) UNIQUE,
    display_name varchar(255) UNIQUE
);
INSERT INTO dota_heroes(id, name, short_name, display_name) VALUES
    (1, 'npc_dota_hero_antimage', 'antimage', 'Anti-Mage'),
    (2, 'npc_dota_hero_axe', 'axe', 'Axe'),
    (3, 'npc_dota_hero_bane', 'bane', 'Bane'),
    (4, 'npc_dota_hero_bloodseeker', 'bloodseeker', 'Bloodseeker'),
    (5, 'npc_dota_hero_crystal_maiden', 'crystal_maiden', 'Crystal Maiden'),
    (6, 'npc_dota_hero_drow_ranger', 'drow_ranger', 'Drow Ranger'),
    (7, 'npc_dota_hero_earthshaker', 'earthshaker', 'Earthshaker'),
    (8, 'npc_dota_hero_juggernaut', 'juggernaut', 'Juggernaut'),
    (9, 'npc_dota_hero_mirana', 'mirana', 'Mirana'),
    (11, 'npc_dota_hero_nevermore', 'shadow_fiend', 'Shadow Fiend'),
    (10, 'npc_dota_hero_morphling', 'morphling', 'Morphling'),
    (12, 'npc_dota_hero_phantom_lancer', 'phantom_lancer', 'Phantom Lancer'),
    (13, 'npc_dota_hero_puck', 'puck', 'Puck'),
    (14, 'npc_dota_hero_pudge', 'pudge', 'Pudge'),
    (15, 'npc_dota_hero_razor', 'razor', 'Razor'),
    (16, 'npc_dota_hero_sand_king', 'sand_king', 'Sand King'),
    (17, 'npc_dota_hero_storm_spirit', 'storm_spirit', 'Storm Spirit'),
    (18, 'npc_dota_hero_sven', 'sven', 'Sven'),
    (19, 'npc_dota_hero_tiny', 'tiny', 'Tiny'),
    (20, 'npc_dota_hero_vengefulspirit', 'vengeful_spirit', 'Vengeful Spirit'),
    (21, 'npc_dota_hero_windrunner', 'windranger', 'Windranger'),
    (22, 'npc_dota_hero_zuus', 'zeus', 'Zeus'),
    (23, 'npc_dota_hero_kunkka', 'kunkka', 'Kunkka'),
    (25, 'npc_dota_hero_lina', 'lina', 'Lina'),
    (31, 'npc_dota_hero_lich', 'lich', 'Lich'),
    (26, 'npc_dota_hero_lion', 'lion', 'Lion'),
    (27, 'npc_dota_hero_shadow_shaman', 'shadow_shaman', 'Shadow Shaman'),
    (28, 'npc_dota_hero_slardar', 'slardar', 'Slardar'),
    (29, 'npc_dota_hero_tidehunter', 'tidehunter', 'Tidehunter'),
    (30, 'npc_dota_hero_witch_doctor', 'witch_doctor', 'Witch Doctor'),
    (32, 'npc_dota_hero_riki', 'riki', 'Riki'),
    (33, 'npc_dota_hero_enigma', 'enigma', 'Enigma'),
    (34, 'npc_dota_hero_tinker', 'tinker', 'Tinker'),
    (35, 'npc_dota_hero_sniper', 'sniper', 'Sniper'),
    (36, 'npc_dota_hero_necrolyte', 'necrophos', 'Necrophos'),
    (37, 'npc_dota_hero_warlock', 'warlock', 'Warlock'),
    (38, 'npc_dota_hero_beastmaster', 'beastmaster', 'Beastmaster'),
    (39, 'npc_dota_hero_queenofpain', 'queenofpain', 'Queen of Pain'),
    (40, 'npc_dota_hero_venomancer', 'venomancer', 'Venomancer'),
    (41, 'npc_dota_hero_faceless_void', 'faceless_void', 'Faceless Void'),
    (42, 'npc_dota_hero_skeleton_king', 'wraith_king', 'Wraith King'),
    (43, 'npc_dota_hero_death_prophet', 'death_prophet', 'Death Prophet'),
    (44, 'npc_dota_hero_phantom_assassin', 'phantom_assassin', 'Phantom Assassin'),
    (45, 'npc_dota_hero_pugna', 'pugna', 'Pugna'),
    (46, 'npc_dota_hero_templar_assassin', 'templar_assassin', 'Templar Assassin'),
    (47, 'npc_dota_hero_viper', 'viper', 'Viper'),
    (48, 'npc_dota_hero_luna', 'luna', 'Luna'),
    (49, 'npc_dota_hero_dragon_knight', 'dragon_knight', 'Dragon Knight'),
    (50, 'npc_dota_hero_dazzle', 'dazzle', 'Dazzle'),
    (51, 'npc_dota_hero_rattletrap', 'clockwerk', 'Clockwerk'),
    (52, 'npc_dota_hero_leshrac', 'leshrac', 'Leshrac'),
    (53, 'npc_dota_hero_furion', 'furion', 'Nature''s Prophet'),
    (54, 'npc_dota_hero_life_stealer', 'lifestealer', 'Lifestealer'),
    (55, 'npc_dota_hero_dark_seer', 'dark_seer', 'Dark Seer'),
    (56, 'npc_dota_hero_clinkz', 'clinkz', 'Clinkz'),
    (57, 'npc_dota_hero_omniknight', 'omniknight', 'Omniknight'),
    (58, 'npc_dota_hero_enchantress', 'enchantress', 'Enchantress'),
    (59, 'npc_dota_hero_huskar', 'huskar', 'Huskar'),
    (60, 'npc_dota_hero_night_stalker', 'night_stalker', 'Night Stalker'),
    (61, 'npc_dota_hero_broodmother', 'broodmother', 'Broodmother'),
    (62, 'npc_dota_hero_bounty_hunter', 'bounty_hunter', 'Bounty Hunter'),
    (63, 'npc_dota_hero_weaver', 'weaver', 'Weaver'),
    (64, 'npc_dota_hero_jakiro', 'jakiro', 'Jakiro'),
    (65, 'npc_dota_hero_batrider', 'batrider', 'Batrider'),
    (66, 'npc_dota_hero_chen', 'chen', 'Chen'),
    (67, 'npc_dota_hero_spectre', 'spectre', 'Spectre'),
    (69, 'npc_dota_hero_doom_bringer', 'doom', 'Doom'),
    (68, 'npc_dota_hero_ancient_apparition', 'ancient_apparition', 'Ancient Apparition'),
    (70, 'npc_dota_hero_ursa', 'ursa', 'Ursa'),
    (71, 'npc_dota_hero_spirit_breaker', 'spirit_breaker', 'Spirit Breaker'),
    (72, 'npc_dota_hero_gyrocopter', 'gyrocopter', 'Gyrocopter'),
    (73, 'npc_dota_hero_alchemist', 'alchemist', 'Alchemist'),
    (74, 'npc_dota_hero_invoker', 'invoker', 'Invoker'),
    (75, 'npc_dota_hero_silencer', 'silencer', 'Silencer'),
    (76, 'npc_dota_hero_obsidian_destroyer', 'outworld_devourer', 'Outworld Devourer'),
    (77, 'npc_dota_hero_lycan', 'lycan', 'Lycanthrope'),
    (78, 'npc_dota_hero_brewmaster', 'brewmaster', 'Brewmaster'),
    (79, 'npc_dota_hero_shadow_demon', 'shadow_demon', 'Shadow Demon'),
    (80, 'npc_dota_hero_lone_druid', 'lone_druid', 'Lone Druid'),
    (81, 'npc_dota_hero_chaos_knight', 'chaos_knight', 'Chaos Knight'),
    (82, 'npc_dota_hero_meepo', 'meepo', 'Meepo'),
    (83, 'npc_dota_hero_treant', 'treant', 'Treant Protector'),
    (84, 'npc_dota_hero_ogre_magi', 'ogre_magi', 'Ogre Magi'),
    (85, 'npc_dota_hero_undying', 'undying', 'Undying'),
    (86, 'npc_dota_hero_rubick', 'rubick', 'Rubick'),
    (87, 'npc_dota_hero_disruptor', 'disruptor', 'Disruptor'),
    (88, 'npc_dota_hero_nyx_assassin', 'nyx_assassin', 'Nyx Assassin'),
    (89, 'npc_dota_hero_naga_siren', 'naga_siren', 'Naga Siren'),
    (90, 'npc_dota_hero_keeper_of_the_light', 'keeper_of_the_light', 'Keeper of the Light'),
    (91, 'npc_dota_hero_wisp', 'wisp', 'Wisp'),
    (92, 'npc_dota_hero_visage', 'visage', 'Visage'),
    (93, 'npc_dota_hero_slark', 'slark', 'Slark'),
    (94, 'npc_dota_hero_medusa', 'medusa', 'Medusa'),
    (95, 'npc_dota_hero_troll_warlord', 'troll_warlord', 'Troll Warlord'),
    (96, 'npc_dota_hero_centaur', 'centaur', 'Centaur Warrunner'),
    (97, 'npc_dota_hero_magnataur', 'magnus', 'Magnus'),
    (98, 'npc_dota_hero_shredder', 'timbersaw', 'Timbersaw'),
    (99, 'npc_dota_hero_bristleback', 'bristleback', 'Bristleback'),
    (100, 'npc_dota_hero_tusk', 'tusk', 'Tusk'),
    (101, 'npc_dota_hero_skywrath_mage', 'skywrath_mage', 'Skywrath Mage'),
    (102, 'npc_dota_hero_abaddon', 'abaddon', 'Abaddon'),
    (103, 'npc_dota_hero_elder_titan', 'elder_titan', 'Elder Titan'),
    (104, 'npc_dota_hero_legion_commander', 'legion_commander', 'Legion Commander'),
    (105, 'npc_dota_hero_techies', 'techies', 'Techies'),
    (106, 'npc_dota_hero_ember_spirit', 'ember_spirit', 'Ember Spirit'),
    (107, 'npc_dota_hero_earth_spirit', 'earth_spirit', 'Earth Spirit'),
    (108, 'npc_dota_hero_abyssal_underlord', 'abyssal_underlord', 'Abyssal Underlord'),
    (109, 'npc_dota_hero_terrorblade', 'terrorblade', 'Terrorblade'),
    (110, 'npc_dota_hero_phoenix', 'phoenix', 'Phoenix'),
    (111, 'npc_dota_hero_oracle', 'oracle', 'Oracle'),
    (112, 'npc_dota_hero_winter_wyvern', 'winter_wyvern', 'Winter Wyvern'),
    (113, 'npc_dota_hero_arc_warden', 'arc_warden', 'Arc Warden'),
    (114, 'npc_dota_hero_monkey_king', 'monkey_king', 'Monkey King'),
    (119, 'npc_dota_hero_dark_willow', 'dark_willow', 'Dark Willow'),
    (120, 'npc_dota_hero_pangolier', 'pangolier', 'Pangolier'),
    (121, 'npc_dota_hero_grimstroke', 'grimstroke', 'Grimstroke'),
    (129, 'npc_dota_hero_mars', 'mars', 'Mars');

CREATE TABLE IF NOT EXISTS dota_items(
    id int PRIMARY KEY,
    name varchar(255) UNIQUE,
    short_name varchar(255) UNIQUE,
    display_name varchar(255) UNIQUE
);
INSERT INTO dota_items(id, name, short_name, display_name) VALUES
    (1, 'item_blink', 'blink', 'Blink Dagger'),
    (2, 'item_blades_of_attack', 'blades_of_attack', 'Blades of Attack'),
    (3, 'item_broadsword', 'broadsword', 'Broadsword'),
    (4, 'item_chainmail', 'chainmail', 'Chainmail'),
    (5, 'item_claymore', 'claymore', 'Claymore'),
    (6, 'item_helm_of_iron_will', 'helm_of_iron_will', 'Helm of Iron Will'),
    (7, 'item_javelin', 'javelin', 'Javelin'),
    (8, 'item_mithril_hammer', 'mithril_hammer', 'Mithril Hammer'),
    (9, 'item_platemail', 'platemail', 'Platemail'),
    (10, 'item_quarterstaff', 'quarterstaff', 'Quarterstaff'),
    (11, 'item_quelling_blade', 'quelling_blade', 'Quelling Blade'),
    (12, 'item_ring_of_protection', 'ring_of_protection', 'Ring of Protection'),
    (13, 'item_gauntlets', 'gauntlets', 'Gauntlets of Strength'),
    (14, 'item_slippers', 'slippers', 'Slippers of Agility'),
    (15, 'item_mantle', 'mantle', 'Mantle of Intelligence'),
    (16, 'item_branches', 'branches', 'Iron Branch'),
    (17, 'item_belt_of_strength', 'belt_of_strength', 'Belt of Strength'),
    (18, 'item_boots_of_elves', 'boots_of_elves', 'Band of Elvenskin'),
    (19, 'item_robe', 'robe', 'Robe of the Magi'),
    (20, 'item_circlet', 'circlet', 'Circlet'),
    (21, 'item_ogre_axe', 'ogre_axe', 'Ogre Axe'),
    (22, 'item_blade_of_alacrity', 'blade_of_alacrity', 'Blade of Alacrity'),
    (23, 'item_staff_of_wizardry', 'staff_of_wizardry', 'Staff of Wizardry'),
    (24, 'item_ultimate_orb', 'ultimate_orb', 'Ultimate Orb'),
    (25, 'item_gloves', 'gloves', 'Gloves of Haste'),
    (26, 'item_lifesteal', 'lifesteal', 'Morbid Mask'),
    (27, 'item_ring_of_regen', 'ring_of_regen', 'Ring of Regen'),
    (28, 'item_sobi_mask', 'sobi_mask', 'Sage''s Mask'),
    (29, 'item_boots', 'boots', 'Boots of Speed'),
    (30, 'item_gem', 'gem', 'Gem of True Sight'),
    (31, 'item_cloak', 'cloak', 'Cloak'),
    (32, 'item_talisman_of_evasion', 'talisman_of_evasion', 'Talisman of Evasion'),
    (33, 'item_cheese', 'cheese', 'Cheese'),
    (34, 'item_magic_stick', 'magic_stick', 'Magic Stick'),
    (35, 'item_recipe_magic_wand', 'recipe_magic_wand', 'Recipe: Magic Wand'),
    (36, 'item_magic_wand', 'magic_wand', 'Magic Wand'),
    (37, 'item_ghost', 'ghost', 'Ghost Scepter'),
    (38, 'item_clarity', 'clarity', 'Clarity'),
    (39, 'item_flask', 'flask', 'Healing Salve'),
    (40, 'item_dust', 'dust', 'Dust of Appearance'),
    (41, 'item_bottle', 'bottle', 'Bottle'),
    (42, 'item_ward_observer', 'ward_observer', 'Observer Ward'),
    (43, 'item_ward_sentry', 'ward_sentry', 'Sentry Ward'),
    (44, 'item_tango', 'tango', 'Tango'),
    (45, 'item_courier', 'courier', 'Animal Courier'),
    (46, 'item_tpscroll', 'tpscroll', 'Town Portal Scroll'),
    (47, 'item_recipe_travel_boots', 'recipe_travel_boots', 'Recipe: Boots of Travel'),
    (48, 'item_travel_boots', 'travel_boots', 'Boots of Travel'),
    (49, 'item_recipe_phase_boots', 'recipe_phase_boots', 'Recipe: Phase Boots'),
    (50, 'item_phase_boots', 'phase_boots', 'Phase Boots'),
    (51, 'item_demon_edge', 'demon_edge', 'Demon Edge'),
    (52, 'item_eagle', 'eagle', 'Eaglesong'),
    (53, 'item_reaver', 'reaver', 'Reaver'),
    (54, 'item_relic', 'relic', 'Sacred Relic'),
    (55, 'item_hyperstone', 'hyperstone', 'Hyperstone'),
    (56, 'item_ring_of_health', 'ring_of_health', 'Ring of Health'),
    (57, 'item_void_stone', 'void_stone', 'Void Stone'),
    (58, 'item_mystic_staff', 'mystic_staff', 'Mystic Staff'),
    (59, 'item_energy_booster', 'energy_booster', 'Energy Booster'),
    (60, 'item_point_booster', 'point_booster', 'Point Booster'),
    (61, 'item_vitality_booster', 'vitality_booster', 'Vitality Booster'),
    (62, 'item_recipe_power_treads', 'recipe_power_treads', 'Recipe: Power Treads'),
    (63, 'item_power_treads', 'power_treads', 'Power Treads'),
    (64, 'item_recipe_hand_of_midas', 'recipe_hand_of_midas', 'Recipe: Hand of Midas'),
    (65, 'item_hand_of_midas', 'hand_of_midas', 'Hand of Midas'),
    (66, 'item_recipe_oblivion_staff', 'recipe_oblivion_staff', 'Recipe: Oblivion Staff'),
    (67, 'item_oblivion_staff', 'oblivion_staff', 'Oblivion Staff'),
    (68, 'item_recipe_pers', 'recipe_pers', 'Recipe: Perseverance'),
    (69, 'item_pers', 'pers', 'Perseverance'),
    (70, 'item_recipe_poor_mans_shield', 'recipe_poor_mans_shield', 'Recipe: Poor Man''s Shield'),
    (71, 'item_poor_mans_shield', 'poor_mans_shield', 'Poor Man''s Shield'),
    (72, 'item_recipe_bracer', 'recipe_bracer', 'Recipe: Bracer'),
    (73, 'item_bracer', 'bracer', 'Bracer'),
    (74, 'item_recipe_wraith_band', 'recipe_wraith_band', 'Recipe: Wraith Band'),
    (75, 'item_wraith_band', 'wraith_band', 'Wraith Band'),
    (76, 'item_recipe_null_talisman', 'recipe_null_talisman', 'Recipe: Null Talisman'),
    (77, 'item_null_talisman', 'null_talisman', 'Null Talisman'),
    (78, 'item_recipe_mekansm', 'recipe_mekansm', 'Recipe: Mekansm'),
    (79, 'item_mekansm', 'mekansm', 'Mekansm'),
    (80, 'item_recipe_vladmir', 'recipe_vladmir', 'Recipe: Vladmir''s Offering'),
    (81, 'item_vladmir', 'vladmir', 'Vladmir''s Offering'),
    (84, 'item_flying_courier', 'flying_courier', 'Flying Courier'),
    (85, 'item_recipe_buckler', 'recipe_buckler', 'Recipe: Buckler'),
    (86, 'item_buckler', 'buckler', 'Buckler'),
    (87, 'item_recipe_ring_of_basilius', 'recipe_ring_of_basilius', 'Recipe: Ring of Basilius'),
    (88, 'item_ring_of_basilius', 'ring_of_basilius', 'Ring of Basilius'),
    (89, 'item_recipe_pipe', 'recipe_pipe', 'Recipe: Pipe of Insight'),
    (90, 'item_pipe', 'pipe', 'Pipe of Insight'),
    (91, 'item_recipe_urn_of_shadows', 'recipe_urn_of_shadows', 'Recipe: Urn of Shadows'),
    (92, 'item_urn_of_shadows', 'urn_of_shadows', 'Urn of Shadows'),
    (93, 'item_recipe_headdress', 'recipe_headdress', 'Recipe: Headdress'),
    (94, 'item_headdress', 'headdress', 'Headdress'),
    (95, 'item_recipe_sheepstick', 'recipe_sheepstick', 'Recipe: Scythe of Vyse'),
    (96, 'item_sheepstick', 'sheepstick', 'Scythe of Vyse'),
    (97, 'item_recipe_orchid', 'recipe_orchid', 'Recipe: Orchid Malevolence'),
    (98, 'item_orchid', 'orchid', 'Orchid Malevolence'),
    (99, 'item_recipe_cyclone', 'recipe_cyclone', 'Recipe: Eul''s Scepter of Divinity'),
    (100, 'item_cyclone', 'cyclone', 'Eul''s Scepter of Divinity'),
    (101, 'item_recipe_force_staff', 'recipe_force_staff', 'Recipe: Force Staff'),
    (102, 'item_force_staff', 'force_staff', 'Force Staff'),
    (103, 'item_recipe_dagon', 'recipe_dagon', 'Recipe: Dagon'),
    (104, 'item_dagon', 'dagon', 'Dagon'),
    (105, 'item_recipe_necronomicon', 'recipe_necronomicon', 'Recipe: Necronomicon'),
    (106, 'item_necronomicon', 'necronomicon', 'Necronomicon'),
    (107, 'item_recipe_ultimate_scepter', 'recipe_ultimate_scepter', 'Recipe: Aghanim''s Scepter'),
    (108, 'item_ultimate_scepter', 'ultimate_scepter', 'Aghanim''s Scepter'),
    (109, 'item_recipe_refresher', 'recipe_refresher', 'Recipe: Refresher Orb'),
    (110, 'item_refresher', 'refresher', 'Refresher Orb'),
    (111, 'item_recipe_assault', 'recipe_assault', 'Recipe: Assault Cuirass'),
    (112, 'item_assault', 'assault', 'Assault Cuirass'),
    (113, 'item_recipe_heart', 'recipe_heart', 'Recipe: Heart of Tarrasque'),
    (114, 'item_heart', 'heart', 'Heart of Tarrasque'),
    (115, 'item_recipe_black_king_bar', 'recipe_black_king_bar', 'Recipe: Black King Bar'),
    (116, 'item_black_king_bar', 'black_king_bar', 'Black King Bar'),
    (117, 'item_aegis', 'aegis', 'Aegis of the Immortal'),
    (118, 'item_recipe_shivas_guard', 'recipe_shivas_guard', 'Recipe: Shiva''s Guard'),
    (119, 'item_shivas_guard', 'shivas_guard', 'Shiva''s Guard'),
    (120, 'item_recipe_bloodstone', 'recipe_bloodstone', 'Recipe: Bloodstone'),
    (121, 'item_bloodstone', 'bloodstone', 'Bloodstone'),
    (122, 'item_recipe_sphere', 'recipe_sphere', 'Recipe: Linken''s Sphere'),
    (123, 'item_sphere', 'sphere', 'Linken''s Sphere'),
    (124, 'item_recipe_vanguard', 'recipe_vanguard', 'Recipe: Vanguard'),
    (125, 'item_vanguard', 'vanguard', 'Vanguard'),
    (126, 'item_recipe_blade_mail', 'recipe_blade_mail', 'Recipe: Blade Mail'),
    (127, 'item_blade_mail', 'blade_mail', 'Blade Mail'),
    (128, 'item_recipe_soul_booster', 'recipe_soul_booster', 'Recipe: Soul Booster'),
    (129, 'item_soul_booster', 'soul_booster', 'Soul Booster'),
    (130, 'item_recipe_hood_of_defiance', 'recipe_hood_of_defiance', 'Recipe: Hood of Defiance'),
    (131, 'item_hood_of_defiance', 'hood_of_defiance', 'Hood of Defiance'),
    (132, 'item_recipe_rapier', 'recipe_rapier', 'Recipe: Divine Rapier'),
    (133, 'item_rapier', 'rapier', 'Divine Rapier'),
    (134, 'item_recipe_monkey_king_bar', 'recipe_monkey_king_bar', 'Recipe: Monkey King Bar'),
    (135, 'item_monkey_king_bar', 'monkey_king_bar', 'Monkey King Bar'),
    (136, 'item_recipe_radiance', 'recipe_radiance', 'Recipe: Radiance'),
    (137, 'item_radiance', 'radiance', 'Radiance'),
    (138, 'item_recipe_butterfly', 'recipe_butterfly', 'Recipe: Butterfly'),
    (139, 'item_butterfly', 'butterfly', 'Butterfly'),
    (140, 'item_recipe_greater_crit', 'recipe_greater_crit', 'Recipe: Daedalus'),
    (141, 'item_greater_crit', 'greater_crit', 'Daedalus'),
    (142, 'item_recipe_basher', 'recipe_basher', 'Recipe: Skull Basher'),
    (143, 'item_basher', 'basher', 'Skull Basher'),
    (144, 'item_recipe_bfury', 'recipe_bfury', 'Recipe: Battle Fury'),
    (145, 'item_bfury', 'bfury', 'Battle Fury'),
    (146, 'item_recipe_manta', 'recipe_manta', 'Recipe: Manta Style'),
    (147, 'item_manta', 'manta', 'Manta Style'),
    (148, 'item_recipe_lesser_crit', 'recipe_lesser_crit', 'Recipe: Crystalys'),
    (149, 'item_lesser_crit', 'lesser_crit', 'Crystalys'),
    (150, 'item_recipe_armlet', 'recipe_armlet', 'Recipe: Armlet of Mardiggian'),
    (151, 'item_armlet', 'armlet', 'Armlet of Mordiggian'),
    (152, 'item_invis_sword', 'invis_sword', 'Shadow Blade'),
    (153, 'item_recipe_sange_and_yasha', 'recipe_sange_and_yasha', 'Recipe: Sange and Yasha'),
    (154, 'item_sange_and_yasha', 'sange_and_yasha', 'Sange and Yasha'),
    (155, 'item_recipe_satanic', 'recipe_satanic', 'Recipe: Satanic'),
    (156, 'item_satanic', 'satanic', 'Satanic'),
    (157, 'item_recipe_mjollnir', 'recipe_mjollnir', 'Recipe: Mjollnir'),
    (158, 'item_mjollnir', 'mjollnir', 'Mjollnir'),
    (159, 'item_recipe_skadi', 'recipe_skadi', 'Recipe: Eye of Skadi'),
    (160, 'item_skadi', 'skadi', 'Eye of Skadi'),
    (161, 'item_recipe_sange', 'recipe_sange', 'Recipe: Sange'),
    (162, 'item_sange', 'sange', 'Sange'),
    (163, 'item_recipe_helm_of_the_dominator', 'recipe_helm_of_the_dominator', 'Recip: Helm of the Dominator'),
    (164, 'item_helm_of_the_dominator', 'helm_of_the_dominator', 'Helm of the Dominator'),
    (165, 'item_recipe_maelstrom', 'recipe_maelstrom', 'Recipe: Maelstrom'),
    (166, 'item_maelstrom', 'maelstrom', 'Maelstrom'),
    (167, 'item_recipe_desolator', 'recipe_desolator', 'Recipe: Desolator'),
    (168, 'item_desolator', 'desolator', 'Desolator'),
    (169, 'item_recipe_yasha', 'recipe_yasha', 'Recipe: Yasha'),
    (170, 'item_yasha', 'yasha', 'Yasha'),
    (171, 'item_recipe_mask_of_madness', 'recipe_mask_of_madness', 'Recipe: Mask of Madness'),
    (172, 'item_mask_of_madness', 'mask_of_madness', 'Mask of Madness'),
    (173, 'item_recipe_diffusal_blade', 'recipe_diffusal_blade', 'Recipe: Diffusal Blade'),
    (174, 'item_diffusal_blade', 'diffusal_blade', 'Diffusal Blade'),
    (175, 'item_recipe_ethereal_blade', 'recipe_ethereal_blade', 'Recipe: Ethereal Blade'),
    (176, 'item_ethereal_blade', 'ethereal_blade', 'Ethereal Blade'),
    (177, 'item_recipe_soul_ring', 'recipe_soul_ring', 'Recipe: Soul Ring'),
    (178, 'item_soul_ring', 'soul_ring', 'Soul Ring'),
    (179, 'item_recipe_arcane_boots', 'recipe_arcane_boots', 'Recipe: Arcane Boots'),
    (180, 'item_arcane_boots', 'arcane_boots', 'Arcane Boots'),
    (181, 'item_orb_of_venom', 'orb_of_venom', 'Orb of Venom'),
    (182, 'item_stout_shield', 'stout_shield', 'Stout Shield'),
    (183, 'item_recipe_invis_sword', 'recipe_invis_sword', 'Recipe: Shadow Blade'),
    (184, 'item_recipe_ancient_janggo', 'recipe_ancient_janggo', 'Recipe: Drum of Endurance'),
    (185, 'item_ancient_janggo', 'ancient_janggo', 'Drum of Endurance'),
    (186, 'item_recipe_medallion_of_courage', 'recipe_medallion_of_courage', 'Recipe: Medallion of Courage'),
    (187, 'item_medallion_of_courage', 'medallion_of_courage', 'Medallion of Courage'),
    (188, 'item_smoke_of_deceit', 'smoke_of_deceit', 'Smoke of Deceit'),
    (189, 'item_recipe_veil_of_discord', 'recipe_veil_of_discord', 'Recipe: Veil of Discord'),
    (190, 'item_veil_of_discord', 'veil_of_discord', 'Veil of Discord'),
    (191, 'item_recipe_necronomicon_2', 'recipe_necronomicon_2', 'Recipe: Necronomicon 2'),
    (192, 'item_recipe_necronomicon_3', 'recipe_necronomicon_3', 'Recipe: Necronomicon 3'),
    (193, 'item_necronomicon_2', 'necronomicon_2', 'Necronomicon 2'),
    (194, 'item_necronomicon_3', 'necronomicon_3', 'Necronomicon 3'),
    (195, 'item_recipe_diffusal_blade_2', 'recipe_diffusal_blade_2', 'Recipe: Diffusal Blade 2'),
    (196, 'item_diffusal_blade_2', 'diffusal_blade_2', 'Diffusal Blade 2'),
    (197, 'item_recipe_dagon_2', 'recipe_dagon_2', 'Recipe: Dagon 2'),
    (198, 'item_recipe_dagon_3', 'recipe_dagon_3', 'Recipe: Dagon 3'),
    (199, 'item_recipe_dagon_4', 'recipe_dagon_4', 'Recipe: Dagon 4'),
    (200, 'item_recipe_dagon_5', 'recipe_dagon_5', 'Recipe: Dagon 5'),
    (201, 'item_dagon_2', 'dagon_2', 'Dagon 2'),
    (202, 'item_dagon_3', 'dagon_3', 'Dagon 3'),
    (203, 'item_dagon_4', 'dagon_4', 'Dagon 4'),
    (204, 'item_dagon_5', 'dagon_5', 'Dagon 5'),
    (205, 'item_recipe_rod_of_atos', 'recipe_rod_of_atos', 'Recipe: Rod of Atos'),
    (206, 'item_rod_of_atos', 'rod_of_atos', 'Rod of Atos'),
    (207, 'item_recipe_abyssal_blade', 'recipe_abyssal_blade', 'Recipe: Abyssal Blade'),
    (208, 'item_abyssal_blade', 'abyssal_blade', 'Abyssal Blade'),
    (209, 'item_recipe_heavens_halberd', 'recipe_heavens_halberd', 'Recipe: Heaven''s Halberd'),
    (210, 'item_heavens_halberd', 'heavens_halberd', 'Heaven''s Halberd'),
    (211, 'item_recipe_ring_of_aquila', 'recipe_ring_of_aquila', 'Recipe: Ring of Aquila'),
    (212, 'item_ring_of_aquila', 'ring_of_aquila', 'Ring of Aquila'),
    (213, 'item_recipe_tranquil_boots', 'recipe_tranquil_boots', 'Recipe: Tranquil Boots'),
    (214, 'item_tranquil_boots', 'tranquil_boots', 'Tranquil Boots'),
    (215, 'item_shadow_amulet', 'shadow_amulet', 'Shadow Amulet'),
    (216, 'item_enchanted_mango', 'enchanted_mango', 'Enchanted Mango'),
    (217, 'item_recipe_ward_dispenser', 'recipe_ward_dispenser', 'Recipe: Observer and Sentry Wards'),
    (218, 'item_ward_dispenser', 'ward_dispenser', 'Observer and Sentry Wards'),
    (219, 'item_recipe_travel_boots_2', 'recipe_travel_boots_2', 'Recipe: Boots of Travel 2'),
    (220, 'item_travel_boots_2', 'travel_boots_2', 'Boots of Travel 2'),
    (221, 'item_recipe_lotus_orb', 'recipe_lotus_orb', 'Recipe: Lotus Orb'),
    (222, 'item_recipe_meteor_hammer', 'recipe_meteor_hammer', 'Recipe: Meteor Hammer'),
    (223, 'item_meteor_hammer', 'meteor_hammer', 'Meteor Hammer'),
    (224, 'item_recipe_nullifier', 'recipe_nullifier', 'Recipe: Nullifier'),
    (225, 'item_nullifier', 'nullifier', 'Nullifier'),
    (226, 'item_lotus_orb', 'lotus_orb', 'Lotus Orb'),
    (227, 'item_recipe_solar_crest', 'recipe_solar_crest', 'Recipe: Solar Crest'),
    (228, 'item_recipe_octarine_core', 'recipe_octarine_core', 'Recipe: Octarine Core'),
    (229, 'item_solar_crest', 'solar_crest', 'Solar Crest'),
    (230, 'item_recipe_guardian_greaves', 'recipe_guardian_greaves', 'Recipe: Guardian Greaves'),
    (231, 'item_guardian_greaves', 'guardian_greaves', 'Guardian Greaves'),
    (232, 'item_aether_lens', 'aether_lens', 'Aether Lens'),
    (233, 'item_recipe_aether_lens', 'recipe_aether_lens', 'Recipe: Aether Lens'),
    (234, 'item_recipe_dragon_lance', 'recipe_dragon_lance', 'Recipe: Dragon Lance'),
    (235, 'item_octarine_core', 'octarine_core', 'Octarine Core'),
    (236, 'item_dragon_lance', 'dragon_lance', 'Dragon Lance'),
    (237, 'item_faerie_fire', 'faerie_fire', 'Faerie Fire'),
    (238, 'item_recipe_iron_talon', 'recipe_iron_talon', 'Recipe: Iron Talon1'),
    (239, 'item_iron_talon', 'iron_talon', 'Iron Talon'),
    (240, 'item_blight_stone', 'blight_stone', 'Blight Stone'),
    (241, 'item_tango_single', 'tango_single', 'Tango (Shared)'),
    (242, 'item_crimson_guard', 'crimson_guard', 'Crimson Guard'),
    (243, 'item_recipe_crimson_guard', 'recipe_crimson_guard', 'Recipe: Crimson Guard'),
    (244, 'item_wind_lace', 'wind_lace', 'Wind Lace'),
    (245, 'item_recipe_bloodthorn', 'recipe_bloodthorn', 'Recipe: Bloodthorn'),
    (246, 'item_recipe_moon_shard', 'recipe_moon_shard', 'Recipe: Moon Shard'),
    (247, 'item_moon_shard', 'moon_shard', 'Moon Shard'),
    (248, 'item_recipe_silver_edge', 'recipe_silver_edge', 'Recipe: Silver Edge'),
    (249, 'item_silver_edge', 'silver_edge', 'Silver Edge'),
    (250, 'item_bloodthorn', 'bloodthorn', 'Bloodthorn'),
    (251, 'item_recipe_echo_sabre', 'recipe_echo_sabre', 'Recipe: Echo Sabre'),
    (252, 'item_echo_sabre', 'echo_sabre', 'Echo Sabre'),
    (253, 'item_recipe_glimmer_cape', 'recipe_glimmer_cape', 'Recipe: Glimmer Cape'),
    (254, 'item_glimmer_cape', 'glimmer_cape', 'Glimmer Cape'),
    (255, 'item_recipe_aeon_disk', 'recipe_aeon_disk', 'Recipe: Aeon Disk'),
    (256, 'item_aeon_disk', 'aeon_disk', 'Aeon Disk'),
    (257, 'item_tome_of_knowledge', 'tome_of_knowledge', 'Tome of Knowledge'),
    (258, 'item_recipe_kaya', 'recipe_kaya', 'Recipe: Kaya'),
    (259, 'item_kaya', 'kaya', 'Kaya'),
    (260, 'item_refresher_shard', 'refresher_shard', 'Refresher Shard'),
    (261, 'item_crown', 'crown', 'Crown'),
    (262, 'item_recipe_hurricane_pike', 'recipe_hurricane_pike', 'Recipe: Hurricane Pike'),
    (263, 'item_hurricane_pike', 'hurricane_pike', 'Hurricane Pike'),
    (265, 'item_infused_raindrop', 'infused_raindrop', 'Infused Raindrops'),
    (266, 'item_recipe_spirit_vessel', 'recipe_spirit_vessel', 'Recipe: Spirit Vessel'),
    (267, 'item_spirit_vessel', 'spirit_vessel', 'Spirit Vessel'),
    (268, 'item_recipe_holy_locket', 'recipe_holy_locket', 'Recipe: Holy Locket'),
    (269, 'item_holy_locket', 'holy_locket', 'Holy Locket'),
    (270, 'item_recipe_ultimate_scepter_2', 'recipe_ultimate_scepter_2', 'Recipe: Aghanim''s Scepter 2'),
    (271, 'item_ultimate_scepter_2', 'ultimate_scepter_2', 'Aghanim''s Scepter 2'),
    (272, 'item_recipe_kaya_and_sange', 'recipe_kaya_and_sange', 'Recipe: Kaya and Sange'),
    (273, 'item_kaya_and_sange', 'kaya_and_sange', 'Kaya and Sange'),
    (274, 'item_recipe_yasha_and_kaya', 'recipe_yasha_and_kaya', 'Recipe: Yasha and Kaya'),
    (277, 'item_yasha_and_kaya', 'yasha_and_kaya', 'Yasha and Kaya'),
    (279, 'item_ring_of_tarrasque', 'ring_of_tarrasque', 'Ring of Tarrasque');

CREATE TABLE IF NOT EXISTS dota_pro_teams(
    id bigint PRIMARY KEY,
    name varchar(255) UNIQUE
);

INSERT INTO dota_pro_teams(id, name) VALUES
    (15, 'PSG.LGD'),
    (36, 'Natus Vincere'),
    (39, 'Evil Geniuses'),
    (2163, 'Team Liquid'),
    (111474, 'Alliance'),
    (350190, 'Fnatic'),
    (543897, 'Mineski'),
    (726228, 'Vici Gaming'),
    (1838315, 'Team Secret'),
    (1883502, 'Virtus Pro'),
    (2108395, 'TNC Predator'),
    (2586976, 'OG'),
    (2626685, 'Keen Gaming'),
    (2672298, 'Infamous'),
    (6209804, 'Royal Never Give Up'),
    (6214538, 'Newbee'),
    (6214973, 'Ninjas in Pyjamas'),
    (6666989, 'Chaos Esports Club');

CREATE TABLE IF NOT EXISTS dota_pro_players(
    account_id bigint PRIMARY KEY,
    team_id bigint references dota_pro_teams(id),
    nickname varchar(255),
    name varchar(255) UNIQUE,
    position int
);
INSERT INTO dota_pro_players(account_id, team_id, nickname, name, position) VALUES
    (125581247, 15, 'Ame', 'Wang Chunyu', 1),
    (106863163, 15, 'Maybe', 'Lu Yao', 2),
    (94738847, 15, 'Chalice', 'Yang Shenyi', 3),
    (101695162, 15, 'fy', 'Xu Linsen', 4),
    (94296097, 15, 'xNova', 'Yap Jian Wei', 5),
    (114619230, 36, 'Crystallize', 'Vladislav Krystanek', 1),
    (171981096, 36, 'MagicaL', 'Idan Vardanian', 2),
    (234699894, 36, 'Blizzy', 'Evgeniy Ree', 3),
    (111030315, 36, 'Zayac', 'Bakyt Emilzhanov', 4),
    (117421467, 36, 'SoNNeikO', 'Akbar Butaev', 5),
    (86745912, 39, 'Arteezy', 'Artour Babaev', 1),
    (111620041, 39, 'SumaiL', 'Syed Sumail Hassan', 2),
    (41231571, 39, 's4', 'Gustav Magnusson', 3),
    (25907144, 39, 'Cr1t-', 'Andreas Nielsen', 4),
    (94155156, 39, 'Fly', 'Tal Aizik', 5),
    (105248644, 2163, 'Miracle-', 'Amer Al-Barkawi', 1),
    (86700461, 2163, 'w33', 'Aliwi Omar', 2),
    (34505203, 2163, 'MinD_ContRoL', 'Ivan Ivanov', 3),
    (101356886, 2163, 'GH', 'Maroun Merhej', 4),
    (82262664, 2163, 'KuroKy', 'Kuro Salehi Takhasomi', 5),
    (152962063, 111474, 'miCKe', 'Michael Vu', 1),
    (86738694, 111474, 'qojqva', 'Maximilian Bröcker', 2),
    (77490514, 111474, 'Boxi', 'Samuel Svahn', 3),
    (401792574, 111474, 'Taiga', 'Tommy Le', 4),
    (54580962, 111474, 'iNSaNiA', 'Aydin Sarkohi', 5),
    (100471531, 350190, 'Jabz', 'Anucha Jirawong', 1),
    (154715080, 350190, 'Abed', 'Abed Azel Yusop', 2),
    (84772440, 350190, 'iceiceice', 'Daryl Koh Pei Xiang', 3),
    (102099826, 350190, 'Dj', 'Djardel Mampusti', 4),
    (145550466, 350190, 'DuBu', 'Kim Doo-young', 5),
    (412753955, 543897, 'Nikobaby', 'Nikolay Nikolov', 1),
    (113457795, 543897, 'Moon', 'Kam Boon Seng', 2),
    (87012746, 543897, 'kpii', 'Damien Chok', 3),
    (192914280, 543897, 'Bimbi', 'Ryan Jay Qui', 4),
    (91443418, 543897, 'ninjaboogie', 'Michael Ross Jr.', 5),
    (137193239, 726228, 'Paparazi', 'Zhang Chengjun', 1),
    (107803494, 726228, 'Ori', 'Zeng Jiaoyang', 2),
    (139937922, 726228, 'Yang', 'Zhou Haiyang', 3),
    (182331313, 726228, 'Fade', 'Pan Yi', 4),
    (143693439, 726228, 'Dy', 'Ding Cong', 5),
    (121769650, 1838315, 'Nisha', 'Michał Jankowski', 1),
    (116585378, 1838315, 'MidOne', 'Yeik Nai Zheng', 2),
    (73562326, 1838315, 'zai', 'Ludwig Wåhlberg', 3),
    (89117038, 1838315, 'YapzOr', 'Yazied Jaradat', 4),
    (87278757, 1838315, 'Puppey', 'Clement Ivanov', 5),
    (132851371, 1883502, 'RAMZES666', 'Roman Kushnarev', 1),
    (106573901, 1883502, 'No[o]ne', 'Vladimir Minenko', 2),
    (92423451, 1883502, '9pasha', 'Pavel Khvastunov', 3),
    (159020918, 1883502, 'RodjER', 'Vladimir Nikogosyan', 4),
    (134556694, 1883502, 'Solo', 'Alexei Berezin', 5),
    (152545459, 2108395, 'Gabbi', 'Kim Villafuerte', 1),
    (164532005, 2108395, 'Armel', 'Armel Paul Tabios', 2),
    (184950344, 2108395, 'Kuku', 'Carlo Palad', 3),
    (155494381, 2108395, 'Tims', 'Timothy Randrup', 4),
    (173476224, 2108395, 'eyyou', 'Nico Barcelon', 5),
    (311360822, 2586976, 'ana', 'Anathan Pham', 1),
    (94054712, 2586976, 'Topson', 'Topias Taavitsainen', 2),
    (88271237, 2586976, 'Ceb', 'Sébastien Debs', 3),
    (26771994, 2586976, 'JerAx', 'Jesse Vainikka', 4),
    (19672354, 2586976, 'N0tail', 'Johan Sundstein', 5),
    (135878232, 2626685, 'old chicken', 'Wang Zhiyong', 1),
    (255219872, 2626685, '一', 'Zhai Jingkai', 2),
    (134276083, 2626685, 'eLeVeN', 'Ren Yangwei', 3),
    (139876032, 2626685, 'Kaka', 'Hu Liangzhi', 4),
    (397462905, 2626685, 'dark', 'Song Runxi', 5),
    (164685175, 2672298, 'K1', 'Hector Antonio Rodriguez', 1),
    (153836240, 2672298, 'Chris Luck', 'Jean Pierre Gonzales', 2),
    (292921272, 2672298, 'Wisper', 'Adrian Cespedes Dobles', 3),
    (157989498, 2672298, 'Scofield', 'Elvis De la Cruz Peña', 4),
    (119631156, 2672298, 'Stinger', 'Steven Vargas', 5),
    (148215639, 6209804, 'Monet', 'Du Peng', 1),
    (139822354, 6209804, 'Setsu', 'Gao Zhenxiong', 2),
    (186627166, 6209804, 'Flyby', 'Su Lei', 3),
    (89423756, 6209804, 'LaNm', 'Zhang Zhicheng', 4),
    (119576842, 6209804, 'ah fu', 'Tue Soon Chuan', 5),
    (108452107, 6214538, 'YawaR', 'Yawar Hassan', 1),
    (221666230, 6214538, 'CCnC', 'Quinn Callahan', 2),
    (10366616, 6214538, 'Sneyking', 'Jingjun Wu', 3),
    (86726887, 6214538, 'MSS', 'Arif Anwar', 4),
    (6922000, 6214538, 'pieliedie', 'Johan Åström', 5),
    (97590558, 6214973, 'Ace', 'Marcus Hoelgaard', 1),
    (86799300, 6214973, 'Fata', 'Adrian Trinks', 2),
    (86698277, 6214973, '33', 'Neta Shapira', 3),
    (103735745, 6214973, 'Saksa', 'Martin Sazdov', 4),
    (86727555, 6214973, 'ppd', 'Peter Dager', 5),
    (142139318, 6666989, 'vtFαded', 'Cheng Jia Hao', 1),
    (72312627, 6666989, 'MATUMBAMAN', 'Lasse Urpalainen', 2),
    (169025618, 6666989, 'KheZu', 'Maurice Gutmann', 3),
    (98172857, 6666989, 'MiLAN', 'Milan Kozomara', 4),
    (87382579, 6666989, 'MISERY', 'Rasmus Berth Filipsen', 5);

CREATE TABLE IF NOT EXISTS group_stage(
    team_id bigint PRIMARY KEY references dota_pro_teams(id),
    group_number int NOT NULL,
    color varchar(255) NOT NULL,
    wins int NOT NULL,
    loses int NOT NULL,
    position int NOT NULL
);
