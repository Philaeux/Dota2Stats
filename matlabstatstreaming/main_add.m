function main_add(tn_id)
% main_exe('auto',9870)


%% Set preferences
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');
setdbprefs('DataReturnFormat','table');

%% Make connection to database
conn = database('ShiBaSQL','shiba','FTShiBa26');

try
    %% initialisation patch
    init_patch=pgsqldata(conn,'select patch_init,id from public.patch order by patchdate desc limit 1');
    if init_patch==0
        initpatch(conn);
        pgsqlexec(conn,['update patch set init_patch=1 where patch.id=',num2str(init_patch.id)]);
    end
    
    %% Récupération de la liste des tournois en base
    rq_sql_tn=['select * from shiba.public.tn where id_tn=',num2str(tn_id)];
    sql_tn=pgsqldata(conn,rq_sql_tn);
    if strcmp(sql_tn,'No Data')==1
        disp('id tournois inconnue')
        tn_name = input('nom du tournoi : ','s');
        tn_closed = input('closed tn 1 = yes 0 = no : ','s');
        tn_end = input('date end tn aaaa-mm-dd : ','s');
        tn_type = input('tn type major/minor : ','s');
        tn_quali = input('tn with qualification phase 1 = yes 0 = no : ','s');
        if tn_quali==1
            tn_qualifendate=input('date qualif end tn aaaa-mm-dd : ','s');
            tn_quali_end = input('tn qualification closed 1 = yes 0 = no  : ','s');
        else
            tn_qualifendate = NaT;
            tn_quali_end = NaN;
        end
        tn=table();
        tn.id_tn=tn_id;
        tn.name_tn=tn_name;
        tn.closed=tn_closed;
        tn.dateend=tn_end;
        tn.withqualif=tn_quali;
        tn.qualifend=tn_qualifendate;
        tn.type=tn_type;
        tn.qualifclosed=tn_quali_end;
        insert(conn,'shiba.public.tn',{'id_tn','name_tn','closed','dateend','withqualif','qualifend','qualifend','type','qualifclosed'},tn);
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
        Stat_tn_player(conn,match_open,tn_id)
        Stat_tn_team(conn,match_valve,tn_id)
        Stat_tn_hero(conn,hero,player_match_valve,match_valve,tn_id)
        Stat_tn_hero_team(conn,player_match_valve,match_valve,tn_id)
        Stat_tn_player_hero(conn,hero,player_match_valve,match_valve,tn_id)
        Stat_tn_tn(conn,match_valve,tn_id)
    end
catch ME %#ok<NASGU>
    disp('error exec add')
end

end

