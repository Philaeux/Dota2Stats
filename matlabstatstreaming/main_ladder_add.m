function main_ladder_add()

if nargin==0
    id_player=49382246;
end

%% Set preferences
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');
setdbprefs('DataReturnFormat','table');

%% Make connection to database
conn = database('ShiBaSQLladder','shiba','FTShiBa26');

try
    %% Récupération de la liste des tournois en base
    rq_sql_tn=['select match_id from dotaladder.public.openmatchplayer where player_id=',num2str(id_player)];
    sql_tn=pgsqldata(conn,rq_sql_tn);
    if strcmp(sql_tn,'No Data')==1
        disp('id tournois inconnue')
        tn_name = input('nom du tournoi : ','s');
        tn=table();
        tn.id_tn=tn_id;
        tn.name_tn=tn_name;
        insert(conn,'shiba.public.tn',{'id_tn','name_tn'},tn);
    else
        disp('Tournois déjà existant...')
    end
    
    %% API VALVE : information ticket
    try
        TktMatch=TktInfo_ApiGetValve(tn_id);
    catch
        disp('api valve indisponible nouvel essai dnas 10 min...')
        pause(600)
    end
    matchs=table([TktMatch.result.matches.series_id].', [TktMatch.result.matches.match_id].', [TktMatch.result.matches.start_time].', [TktMatch.result.matches.radiant_team_id].',...
        [TktMatch.result.matches.dire_team_id].', 'VariableNames', {'series_id', 'match_id', 'start_time', 'radiant_team_id', 'dire_team_id'});
    if tn_id==9870
        matchs.id_tn(matchs.match_id<=3973246064,1)=tn_id;
        matchs.id_tn(matchs.match_id>3973246064,1)=8;
    else
        matchs.id_tn(:,1)=tn_id;
    end
    
    %% Recup match déjà en base
    rq_sql_match=['select * from shiba.public.matchs where id_tn=',num2str(tn_id)];
    sql_match=pgsqldata(conn,rq_sql_match);
    
    %% Insertion des match du ticket en base
    if strcmp(sql_match,'No Data')==1
        insert(conn,'shiba.public.matchs',{'series_id','match_id','start_time','radiant_team_id','dire_team_id','id_tn'},matchs);
        execmatch=table();
        execmatch.match_id=matchs.match_id;
        execmatch.execvalveplayer(:,1)=0;
        execmatch.execvalvepicks(:,1)=0;
        execmatch.execopenpicks(:,1)=0;
        execmatch.execopenplayer(:,1)=0;
        insert(conn,'shiba.public.execmatch',{'match_id','execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatch);
        newmatch=matchs;
    else
        newmatch=setxor(matchs,sql_match);
        if isempty(newmatch)
            disp('pas de nouveau match a ajouter')
        else
            insert(conn,'shiba.public.matchs',{'series_id','match_id','start_time','radiant_team_id','dire_team_id','id_tn'},newmatch);
            execmatch=table();
            execmatch.match_id=newmatch.match_id;
            execmatch.execvalveplayer(:,1)=0;
            execmatch.execvalvepicks(:,1)=0;
            execmatch.execopenpicks(:,1)=0;
            execmatch.execopenplayer(:,1)=0;
            insert(conn,'shiba.public.execmatch',{'match_id','execvalveplayer','execvalvepicks','execopenpicks','execopenplayer'},execmatch);
        end
    end
    
    if ~isempty(newmatch)
        for i=1:height(newmatch)
            %% Recupération des info match source valve
            datavalve=ApiGetValve(newmatch.match_id(i));
            execvalve(datavalve,conn,execmatch);
            
            %% Récupération des info match source opendota
            dataod=ApiGetStatOpen(newmatch.match_id(i));
            execopen(dataod,conn,execmatch);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% algo de fusion
        %% Récupération des informations en base
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        match_open=pgsqldata(conn,'select * from shiba.public.openmatch');
        player_match_valve=pgsqldata(conn,'select * from shiba.public.valveplayermatch');
        match_valve=pgsqldata(conn,'select * from shiba.public.valvematch');
        hero=pgsqldata(conn,'select * from shiba.public.hero');
        
        %% stat tn
        if tn_id==9870
            Stat_tn_player(conn,match_open,8)
            Stat_tn_team(conn,match_valve,8)
            Stat_tn_hero(conn,hero,player_match_valve,match_valve,8)
            Stat_tn_hero_team(conn,player_match_valve,match_valve,8)
            Stat_tn_player_hero(conn,hero,player_match_valve,match_valve,8)
            Stat_tn_tn(conn,match_valve,8)
        else
            Stat_tn_player(conn,match_open,tn_id)
            Stat_tn_team(conn,match_valve,tn_id)
            Stat_tn_hero(conn,hero,player_match_valve,match_valve,tn_id)
            Stat_tn_hero_team(conn,player_match_valve,match_valve,tn_id)
            Stat_tn_player_hero(conn,hero,player_match_valve,match_valve,tn_id)
            Stat_tn_tn(conn,match_valve,tn_id)
        end
    end
catch ME %#ok<NASGU>
    disp('error exec add')
end


end








