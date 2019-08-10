function Stat_tn_team(conn,tn_id,type)
disp('Traitement des stats TN Team')
match_valve=pgsqldata(conn,['select * from public.join_valvematch where id_tn=',num2str(tn_id)]);
switch type
    case 'main'
        %% algo
        StatTeam=table();
        match_valve_tn=match_valve(match_valve.is_qualif==0,:);
        list_team_radiant=unique(match_valve_tn.radiant_team_id);
        list_team_dire=unique(match_valve_tn.dire_team_id);
        list_team=union(list_team_dire,list_team_radiant);
        nb_team=length(list_team);
        
        %% Bounty prise / bounty disponible init
        rq_bounty=['select account_id,player_slot,matchs.is_qualif,openmatch.id_tn,openmatch.radiant_team_id,openmatch.dire_team_id,hero_id,openmatch.match_id,bounty_pickups from openplayermatch inner join openmatch on openplayermatch.match_id = openmatch.match_id inner join matchs on openplayermatch.match_id = matchs.match_id where openmatch.id_tn =',num2str(tn_id),' and matchs.is_qualif = 0'];
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
                StatTeamAdd.id=NaN;
                StatTeamAdd.team_id=list_team(i);
                StatTeamAdd.tn_id=tn_id;
                StatTeamAdd.is_qualif=0;
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
        rqexist=['select id from public.stat_tn_team where tn_id=',num2str(tn_id),' and is_qualif=0'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_team where tn_id=',num2str(tn_id),' and is_qualif=0'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_team',StatTeam.Properties.VariableNames,StatTeam,'id','public');
        
    case 'qualif'
        %% algo
        StatTeam=table();
        match_valve_tn=match_valve(match_valve.is_qualif==1,:);
        list_team_radiant=unique(match_valve_tn.radiant_team_id);
        list_team_dire=unique(match_valve_tn.dire_team_id);
        list_team=union(list_team_dire,list_team_radiant);
        nb_team=length(list_team);
        
        %% Bounty prise / bounty disponible init
        rq_bounty=['select account_id,player_slot,matchs.is_qualif,openmatch.id_tn,openmatch.radiant_team_id,openmatch.dire_team_id,hero_id,openmatch.match_id,bounty_pickups from openplayermatch inner join openmatch on openplayermatch.match_id = openmatch.match_id inner join matchs on openplayermatch.match_id = matchs.match_id where openmatch.id_tn =',num2str(tn_id),' and matchs.is_qualif = 0'];
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
                StatTeamAdd.id=NaN;
                StatTeamAdd.team_id=list_team(i);
                StatTeamAdd.tn_id=tn_id;
                StatTeamAdd.is_qualif=1;
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
        rqexist=['select id from public.stat_tn_team where tn_id=',num2str(tn_id),' and is_qualif=1'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_team where tn_id=',num2str(tn_id),' and is_qualif=1'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_team',StatTeam.Properties.VariableNames,StatTeam,'id','public');
    case 'all'
        %% algo
        StatTeam=table();
        match_valve_tn=match_valve;
        list_team_radiant=unique(match_valve_tn.radiant_team_id);
        list_team_dire=unique(match_valve_tn.dire_team_id);
        list_team=union(list_team_dire,list_team_radiant);
        nb_team=length(list_team);
        
        %% Bounty prise / bounty disponible init
        rq_bounty=['select account_id,player_slot,matchs.is_qualif,openmatch.id_tn,openmatch.radiant_team_id,openmatch.dire_team_id,hero_id,openmatch.match_id,bounty_pickups from openplayermatch inner join openmatch on openplayermatch.match_id = openmatch.match_id inner join matchs on openplayermatch.match_id = matchs.match_id where openmatch.id_tn =',num2str(tn_id),' and matchs.is_qualif = 0'];
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
                StatTeamAdd.id=NaN;
                StatTeamAdd.team_id=list_team(i);
                StatTeamAdd.tn_id=tn_id;
                StatTeamAdd.is_qualif=NaN;
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
        rqexist=['select id from public.stat_tn_team where tn_id=',num2str(tn_id),' and is_qualif=null'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_team where tn_id=',num2str(tn_id),' and is_qualif=null'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_team',StatTeam.Properties.VariableNames,StatTeam,'id','public');
        
        
end
disp('Traitement OK')
end

