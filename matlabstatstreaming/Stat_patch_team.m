function Stat_patch_team(conn)
disp('Traitement des stats patch Team')
patch=pgsqldata(conn,'select * from public.patch');
match_valve_tn=pgsqldata(conn,['select * from public.join_valvematch where patch_num=',num2str(max(patch.patchnum))]);

%% algo
StatTeam=table();
list_team_radiant=unique(match_valve_tn.radiant_team_id);
list_team_dire=unique(match_valve_tn.dire_team_id);
list_team=union(list_team_dire,list_team_radiant);
nb_team=length(list_team);

%% Bounty prise / bounty disponible init
rq_bounty=['select account_id,player_slot,is_qualif,id_tn,radiant_team_id,dire_team_id,hero_id,match_id,bounty_pickups from join_openplayermatch where join_openplayermatch.patch_num =',num2str(max(patch.patchnum))];
match_player_bounty=pgsqldata(conn,rq_bounty);
if nb_team>0
    for i=1:nb_team
        CalcStatTeam=match_valve_tn((match_valve_tn.radiant_team_id==list_team(i) | match_valve_tn.dire_team_id==list_team(i)),:);
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
            % algo bounty
            if CalcStatTeam.radiant_team_id(j)==list_team(i)
                nb_bounty_pick=nansum(match_player_bounty.bounty_pickups(match_player_bounty.match_id==CalcStatTeam.match_id(j) & match_player_bounty.player_slot<100));
            else
                nb_bounty_pick=nansum(match_player_bounty.bounty_pickups(match_player_bounty.match_id==CalcStatTeam.match_id(j) & match_player_bounty.player_slot>100));
            end
            nb_bounty_dispo=floor(CalcStatTeam.duration(j)/300)*4+4;
            pct_bounty=nb_bounty_pick/nb_bounty_dispo;
            CalcStatTeam.pct_bounty(j)=pct_bounty;
        end
        %   duration win
        win_duration=nanmean(CalcStatTeam.duration(CalcStatTeam.is_win==1));
        %   duration lose
        lose_duration=nanmean(CalcStatTeam.duration(CalcStatTeam.is_win==0));
        
        
        
        if ~isempty(CalcStatTeam)
            StatTeamAdd=table();
            StatTeamAdd.id=NaN;
            StatTeamAdd.team_id=list_team(i);
            StatTeamAdd.patch_num=max(patch.patchnum);
            [StatTeamAdd]=genstat(CalcStatTeam,'is_radiant',StatTeamAdd);
            [StatTeamAdd]=genstat(CalcStatTeam,'is_radiant_win',StatTeamAdd);
            [StatTeamAdd]=genstat(CalcStatTeam,'is_dire_win',StatTeamAdd);
            [StatTeamAdd]=genstat(CalcStatTeam,'is_win',StatTeamAdd);
            [StatTeamAdd]=genstat(CalcStatTeam,'is_firstpick',StatTeamAdd);
            [StatTeamAdd]=genstat(CalcStatTeam,'duration',StatTeamAdd);
            StatTeamAdd.nb_match=height(CalcStatTeam);
            StatTeamAdd.win_duration=win_duration;
            StatTeamAdd.lose_duration=lose_duration;
            [StatTeamAdd]=genstat(CalcStatTeam,'pct_bounty',StatTeamAdd);
        end
        
        StatTeam=[StatTeam;StatTeamAdd]; %#ok<AGROW>
    end
    
    %% insertion SQL StatPlayer
    rqexist=['select id from public.stat_patch_team where patch_num=',num2str(max(patch.patchnum))];
    exist1=pgsqldata(conn,rqexist);
    if strcmp(exist1,'No Data')==0
        pgsqlexec(conn,['delete from public.stat_patch_team where patch_num=',num2str(max(patch.patchnum))])
    end
    CBM_PGSQL_Transact_light(conn,'stat_patch_team',StatTeam.Properties.VariableNames,StatTeam,'id','public');
end


disp('Traitement OK')
end

