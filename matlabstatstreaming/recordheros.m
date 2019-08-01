function [BD_TI7_RecordHeros]=recordheros(BD_TI7_StatHeros)

BD_TI7_RecordHeros=BD_TI7_StatHeros;
BD_TI7_RecordHeros(:,{'nb_pick','nb_ban','mean_is_win','max_is_win','min_is_win','tot_is_win'}) = [];
BD_TI7_RecordHeros(:,'mean_kills') = [];
BD_TI7_RecordHeros(:,{'min_kills','tot_kills','mean_assists'}) = [];
BD_TI7_RecordHeros(:,{'min_assists','tot_assists','mean_deaths'}) = [];
BD_TI7_RecordHeros(:,{'min_deaths','tot_deaths','mean_last_hits'}) = [];
BD_TI7_RecordHeros(:,{'min_last_hits','tot_last_hits','mean_xpmraw'}) = [];
BD_TI7_RecordHeros(:,{'min_xpmraw','tot_xpmraw','mean_opm'}) = [];
BD_TI7_RecordHeros(:,{'min_opm','tot_opm'}) = [];
BD_TI7_RecordHeros(:,'mean_hero_damage') = [];
BD_TI7_RecordHeros(:,{'min_hero_damage','tot_hero_damage'}) = [];
BD_TI7_RecordHeros(:,{'min_hero_healing','tot_hero_healing','mean_denies'}) = [];
BD_TI7_RecordHeros(:,{'min_denies','tot_denies','mean_stuns'}) = [];
BD_TI7_RecordHeros(:,{'min_stuns','tot_stuns','mean_kda'}) = [];
BD_TI7_RecordHeros(:,{'min_kda','tot_kda','mean_neutral_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_neutral_kills','tot_neutral_kills','mean_tower_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_tower_kills','tot_tower_kills','mean_courier_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_courier_kills','tot_courier_kills','mean_observer_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_observer_kills','tot_observer_kills','mean_sentry_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_sentry_kills','tot_sentry_kills','mean_roshan_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_roshan_kills','tot_roshan_kills','mean_ancient_kills'}) = [];
BD_TI7_RecordHeros(:,{'min_ancient_kills','tot_ancient_kills'}) = [];
BD_TI7_RecordHeros(:,'mean_TF') = [];
BD_TI7_RecordHeros(:,{'min_TF','tot_TF'}) = [];

end