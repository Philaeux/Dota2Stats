function [BD_TI7_RecordTeam]=recordteam(BD_TI7_StatTeam)

BD_TI7_RecordTeam=BD_TI7_StatTeam;
BD_TI7_RecordTeam(:,{'mean_is_fp','max_is_fp','min_is_fp','tot_is_fp','mean_is_radiant','max_is_radiant','min_is_radiant','tot_is_radiant','mean_is_win','max_is_win','min_is_win','tot_is_win','mean_kills'}) = [];
BD_TI7_RecordTeam(:,{'min_kills','tot_kills','mean_assist'}) = [];
BD_TI7_RecordTeam(:,{'min_assist','tot_assist','mean_deaths'}) = [];
BD_TI7_RecordTeam(:,{'min_deaths','tot_deaths','mean_temps'}) = [];
BD_TI7_RecordTeam(:,'tot_temps') = [];

end