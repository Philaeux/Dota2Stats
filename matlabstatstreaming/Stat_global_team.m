function Stat_global_team(conn,match_valve)

%% init
StatTeam=table();
list_team_radiant=unique(match_valve.radiant_team_id);
list_team_dire=unique(match_valve.dire_team_id);
list_team=union(list_team_dire,list_team_radiant);
nb_team=length(list_team);

%% algo
for i=1:nb_team
    CalcStatTeam=match_valve((match_valve.radiant_team_id==list_team(i) | match_valve.dire_team_id==list_team(i)),:);
    for j=1:height(CalcStatTeam)
        if CalcStatTeam.radiant_team_id(j,1)==list_team(i,1)
            CalcStatTeam.is_radiant(j,1)=1;
            if CalcStatTeam.radiant_win(j,1)==1
                CalcStatTeam.is_win(j,1)=1;
                CalcStatTeam.is_radiant_win(j,1)=1;
                CalcStatTeam.is_dire_win(j,1)=0;
            else
                CalcStatTeam.is_win(j,1)=0;
                CalcStatTeam.is_radiant_win(j,1)=0;
                CalcStatTeam.is_dire_win(j,1)=0;
            end
            if CalcStatTeam.firstpick(j,1)==0
                CalcStatTeam.is_firstpick(j,1)=1;
            else
                CalcStatTeam.is_firstpick(j,1)=0;
            end
        else
            CalcStatTeam.is_radiant(j,1)=0;
            if CalcStatTeam.radiant_win(j,1)==1
                CalcStatTeam.is_win(j,1)=0;
                CalcStatTeam.is_radiant_win(j,1)=0;
                CalcStatTeam.is_dire_win(j,1)=0;
            else
                CalcStatTeam.is_win(j,1)=1;
                CalcStatTeam.is_radiant_win(j,1)=0;
                CalcStatTeam.is_dire_win(j,1)=1;
            end
            if CalcStatTeam.firstpick(j,1)==0
                CalcStatTeam.is_firstpick(j,1)=0;
            else
                CalcStatTeam.is_firstpick(j,1)=1;
            end
        end
    end
    if ~isempty(CalcStatTeam)
        StatTeamAdd=table();
        StatTeamAdd.team_id=list_team(i);
        [StatTeamAdd]=genstat(CalcStatTeam,'is_radiant',StatTeamAdd);
        [StatTeamAdd]=genstat(CalcStatTeam,'is_radiant_win',StatTeamAdd);
        [StatTeamAdd]=genstat(CalcStatTeam,'is_dire_win',StatTeamAdd);
        [StatTeamAdd]=genstat(CalcStatTeam,'is_win',StatTeamAdd);
        [StatTeamAdd]=genstat(CalcStatTeam,'is_firstpick',StatTeamAdd);
        [StatTeamAdd]=genstat(CalcStatTeam,'duration',StatTeamAdd);
        StatTeamAdd.nb_match=height(CalcStatTeam);
        StatTeam=[StatTeam;StatTeamAdd];
        
    end
end

%% insertion SQL
pgsqlexec(conn,'delete from grenouilleapi.public.stat_global_team')
insert(conn,'grenouilleapi.public.stat_global_team',{'team_id','mean_is_radiant','max_is_radiant','min_is_radiant','tot_is_radiant','mean_is_radiant_win','max_is_radiant_win',...
    'min_is_radiant_win','tot_is_radiant_win','mean_is_dire_win','max_is_dire_win','min_is_dire_win','tot_is_dire_win','mean_is_win','max_is_win','min_is_win','tot_is_win',...
    'mean_is_firstpick','max_is_firstpick','min_is_firstpick','tot_is_firstpick','mean_duration','max_duration','min_duration','tot_duration','nb_match'},StatTeam);


end

