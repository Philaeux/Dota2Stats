function Stat_tn_team(conn,match_valve,tn_id)
disp('Traitement des stats TN Team') 
switch nargin
    case 2
        %% init
        list_tn=unique(match_valve.id_tn);
        nb_tn=length(list_tn);
        %% algo
        for k=1:nb_tn
            match_valve_tn=match_valve(match_valve.id_tn==list_tn(k),:);
            list_team_radiant=unique(match_valve_tn.radiant_team_id);
            list_team_dire=unique(match_valve_tn.dire_team_id);
            list_team=union(list_team_dire,list_team_radiant);
            nb_team=length(list_team);
            for i=1:nb_team
                CalcStatTeam=match_valve_tn((match_valve_tn.radiant_team_id==list_team(i) | match_valve_tn.dire_team_id==list_team(i)),:);
                %% calcul des valeurs ajoutés
                %  winrate radiant dire 
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
                    StatTeamAdd.tn_id=list_tn(k);
                    [StatTeamAdd]=genstat(CalcStatTeam,'is_radiant',StatTeamAdd);
                    [StatTeamAdd]=genstat(CalcStatTeam,'is_radiant_win',StatTeamAdd);
                    [StatTeamAdd]=genstat(CalcStatTeam,'is_dire_win',StatTeamAdd);
                    [StatTeamAdd]=genstat(CalcStatTeam,'is_win',StatTeamAdd);
                    [StatTeamAdd]=genstat(CalcStatTeam,'is_firstpick',StatTeamAdd);
                    [StatTeamAdd]=genstat(CalcStatTeam,'duration',StatTeamAdd);
                    StatTeamAdd.nb_match=height(CalcStatTeam);
                end
                %% insertion SQL
                pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_team where team_id=',num2str(list_team(i,1)),' and tn_id=',num2str(list_tn(k))])
                insert(conn,'grenouilleapi.public.stat_tn_team',{'team_id','tn_id','mean_is_radiant','max_is_radiant','min_is_radiant','tot_is_radiant','mean_is_radiant_win','max_is_radiant_win',...
                    'min_is_radiant_win','tot_is_radiant_win','mean_is_dire_win','max_is_dire_win','min_is_dire_win','tot_is_dire_win','mean_is_win','max_is_win','min_is_win','tot_is_win',...
                    'mean_is_firstpick','max_is_firstpick','min_is_firstpick','tot_is_firstpick','mean_duration','max_duration','min_duration','tot_duration','nb_match'},StatTeamAdd);
            end
            
        end
    case 3
        match_valve_tn=match_valve(match_valve.id_tn==tn_id,:);
        list_team_radiant=unique(match_valve_tn.radiant_team_id);
        list_team_dire=unique(match_valve_tn.dire_team_id);
        list_team=union(list_team_dire,list_team_radiant);
        nb_team=length(list_team);
                
        %% Bounty prise / bounty disponible init
        rq_bounty=['SELECT account_id,player_slot,openmatch.id_tn,openmatch.radiant_team_id,openmatch.dire_team_id,hero_id,openmatch.match_id,bounty_pickups FROM openplayermatch INNER JOIN openmatch ON openplayermatch.match_id=openmatch.match_id WHERE openmatch.id_tn=',num2str(tn_id)];
        match_player_bounty=pgsqldata(conn,rq_bounty);
        
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
                StatTeamAdd.team_id=list_team(i);
                StatTeamAdd.tn_id=tn_id;
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
            %% insertion SQL
            pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_team where team_id=',num2str(list_team(i,1)),' and tn_id=',num2str(tn_id)])
            insert(conn,'grenouilleapi.public.stat_tn_team',{'team_id','tn_id','mean_is_radiant','max_is_radiant','min_is_radiant','tot_is_radiant','mean_is_radiant_win','max_is_radiant_win',...
                'min_is_radiant_win','tot_is_radiant_win','mean_is_dire_win','max_is_dire_win','min_is_dire_win','tot_is_dire_win','mean_is_win','max_is_win','min_is_win','tot_is_win',...
                'mean_is_firstpick','max_is_firstpick','min_is_firstpick','tot_is_firstpick','mean_duration','max_duration','min_duration','tot_duration','nb_match',...
                'win_duration','lose_duration','mean_pct_bounty','max_pct_bounty','min_pct_bounty','tot_pct_bounty'},StatTeamAdd);
        end
        
end
disp('Traitement OK')
end

