function Stat_tn_tn(conn,match_valve,tn_id)
disp('Traitement des stats TN Tournois') 
switch nargin
    case 2   
        %% init
        listtn=unique(match_valve.id_tn);
        nbtn=length(listtn);
        %% algo
        for i=1:nbtn
            CalcStatTeam=match_valve(match_valve.id_tn==listtn(i),:);
            stat_tn_add=table();
            if ~isempty(match_valve)
                stat_tn_add.id_tn=listtn(i);
                stat_tn_add.nb_match=height(CalcStatTeam);
                [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
                [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
            end
            %% insertion SQL
            pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_tn where id_tn=',num2str(listtn(i))])
            insert(conn,'grenouilleapi.public.stat_tn_tn',{'id_tn','nb_match','mean_radiant_win','max_radiant_win','min_radiant_win','tot_radiant_win','mean_duration','max_duration','min_duration','tot_duration'},stat_tn_add);
        end
    case 3        
        %% algo
            CalcStatTeam=match_valve(match_valve.id_tn==tn_id,:);
            stat_tn_add=table();
            if ~isempty(match_valve)
                stat_tn_add.id_tn=tn_id;
                stat_tn_add.nb_match=height(CalcStatTeam);
                [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
                [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
            end  
            %% insertion SQL
            pgsqlexec(conn,['delete from grenouilleapi.public.stat_tn_tn where id_tn=',num2str(tn_id)])
            insert(conn,'grenouilleapi.public.stat_tn_tn',{'id_tn','nb_match','mean_radiant_win','max_radiant_win','min_radiant_win','tot_radiant_win','mean_duration','max_duration','min_duration','tot_duration'},stat_tn_add);
end
disp('Traitement OK')
end

