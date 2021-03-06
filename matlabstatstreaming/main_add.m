function main_add(tn_id)
% main_exe('auto',9870)


%% Set preferences
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');
setdbprefs('DataReturnFormat','table');

%% Make connection to database
load('sql.mat','config');
conn = database(config.odbc,config.user,config.pass);

try
    %% initialisation patch
    init_patch=pgsqldata(conn,'select update,id from public.patch order by patchdate desc limit 1');
    if init_patch.update==0
        initpatch(conn);
        pgsqlexec(conn,['update patch set init_patch=1 where patch.id=',num2str(init_patch.id)]);
    end
    
    %% R�cup�ration de la liste des tournois en base
    rq_sql_tn=['select id from public.tn where id_tn=',num2str(tn_id)];
    sql_tn=pgsqldata(conn,rq_sql_tn);
    if strcmp(sql_tn.id,'No Data')==1
        disp('id tournois inconnue')
        tn_name = input('nom du tournoi : ','s');
        tn_closed = input('closed tn 1 = yes 0 = no : ','s');
        tn_closed = str2double(tn_closed);
        tn_end = input('date end tn aaaa-mm-dd : ','s');
        tn_end = datetime(tn_end);
        tn_type = input('tn type major/minor : ','s');
        tn_quali = input('tn with qualification phase 1 = yes 0 = no : ','s');
        tn_quali = str2double(tn_quali);
        if tn_quali==1
            tn_qualifendate=input('date qualif end tn aaaa-mm-dd : ','s');
            tn_qualifendate= datetime(tn_qualifendate);
            tn_quali_end = input('tn qualification closed 1 = yes 0 = no  : ','s');
            tn_quali_end = str2double(tn_quali_end);
        else
            tn_qualifendate = NaT;
            tn_quali_end = NaN;
        end
        tn=table();
        tn.id_tn=tn_id;
        tn.name_tn{1,1}=tn_name;
        tn.closed=tn_closed;
        tn.dateend=tn_end;
        tn.withqualif{1,1}=tn_quali;
        tn.qualifend=tn_qualifendate;
        tn.type{1,1}=tn_type;
        tn.qualifclosed=tn_quali_end;
        CBM_PGSQL_inject1l_light(conn,'tn',tn.Properties.VariableNames,tn,'id',NaN,'public','add')
    else
        disp('Tournois d�j� existant...')
    end
    
    %% API VALVE : information ticket
    testvalve=0;
    while testvalve==0
        try
            TktMatch=TktInfo_ApiGetValve(tn_id);
            testvalve=1;
        catch
            disp('api valve indisponible nouvel essai dnas 1 min...')
            pause(60)
        end
    end
    %%update des informations equipes et joueurs
    updateteam(conn,TktMatch)
    
    %% Recup match d�j� en base
    rq_sql_match=['select * from public.matchs where id_tn=',num2str(tn_id)];
    sql_match=pgsqldata(conn,rq_sql_match);
    matchsql=init_match(TktMatch,tn_id,conn);
    
    %% Insertion des match du ticket en base
    if strcmp(sql_match,'No Data')==1
        CBM_PGSQL_Transact_light(conn,'matchs',matchsql.Properties.VariableNames,matchsql,'id','public')
        execmatch=table();
        execmatch.match_id=matchsql.match_id;
        execmatch.id(:,1)=NaN;
        execmatch.execvalveplayer(:,1)=0;
        execmatch.execvalvepicks(:,1)=0;
        execmatch.execopenpicks(:,1)=0;
        execmatch.execopenplayer(:,1)=0;
        CBM_PGSQL_Transact_light(conn,'execmatch',execmatch.Properties.VariableNames,execmatch,'id','public')
    else
        newmatch=setxor(matchsql.match_id,sql_match.match_id);
        newmatchsql=table();
        newmatchsql=matchsql(ismember(matchsql.match_id,newmatch),:);
        if isempty(newmatchsql)
            disp('pas de nouveau match a ajouter')
        else
            CBM_PGSQL_Transact_light(conn,'matchs',newmatchsql.Properties.VariableNames,newmatchsql,'id','public')
            execmatch=table();
            execmatch.match_id=newmatchsql.match_id;
            execmatch.id(:,1)=NaN;
            execmatch.execvalveplayer(:,1)=0;
            execmatch.execvalvepicks(:,1)=0;
            execmatch.execopenpicks(:,1)=0;
            execmatch.execopenplayer(:,1)=0;
            CBM_PGSQL_Transact_light(conn,'execmatch',execmatch.Properties.VariableNames,execmatch,'id','public')
        end
    end
    
    %% liste des match a execvalve<5
    rqvalve='select match_id,id,execvalveplayer,execvalvepicks from public.execmatch where execvalveplayer<5 or execvalvepicks<5';
    newmatchvalve=pgsqldata(conn,rqvalve);
    if strcmp(newmatchvalve,'No Data')==0
        for i=1:height(newmatchvalve)
            %% Recup�ration des info match source valve
            datavalve=ApiGetValve(newmatchvalve.match_id(i));
            init_player(conn,datavalve.result.players,newmatchvalve.match_id(i));
            execvalve(datavalve,conn,newmatchvalve);
        end
    end
    disp('Traitement Valve OK')
    %% liste des match a execopen<5
    rqopen='select match_id,id,execopenplayer,execopenpicks from public.execmatch where execopenplayer<5 or execopenpicks<5';
    newmatchopen=pgsqldata(conn,rqopen);
    if strcmp(newmatchopen,'No Data')==0
        for i=1:height(newmatchopen)
            %% R�cup�ration des info match source opendota
            dataod=ApiGetStatOpen(newmatchopen.match_id(i));
            init_player(conn,dataod.players,newmatchopen.match_id(i));
            execopen(dataod,conn,newmatchopen);
        end
    end
    disp('Traitement Open OK')
    
    %% algo de fusion
    %% R�cup�ration des informations en base
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% stat sur un tournois
    %% boucle pour le tournois add
    tn_with_qualif=pgsqldata(conn,['select withqualif from public.tn where id_tn=',num2str(tn_id)]);
    if tn_with_qualif.withqualif==1
        Stat_tn_player(conn,tn_id,'main')
        Stat_tn_player(conn,tn_id,'qualif')
        Stat_tn_player(conn,tn_id,'all')
        Stat_tn_team(conn,tn_id,'main')
        Stat_tn_team(conn,tn_id,'qualif')
        Stat_tn_team(conn,tn_id,'all')
        Stat_tn_hero(conn,tn_id,'main')
        Stat_tn_hero(conn,tn_id,'qualif')
        Stat_tn_hero(conn,tn_id,'all')
        Stat_tn_hero_team(conn,tn_id,'main')
        Stat_tn_hero_team(conn,tn_id,'qualif')
        Stat_tn_hero_team(conn,tn_id,'all')
        Stat_tn_player_hero(conn,tn_id,'main')
        Stat_tn_player_hero(conn,tn_id,'qualif')
        Stat_tn_player_hero(conn,tn_id,'all')
    else
        Stat_tn_player(conn,tn_id,'all')
        Stat_tn_team(conn,tn_id,'all')
        Stat_tn_hero(conn,tn_id,'all')
        Stat_tn_hero_team(conn,tn_id,'all')
        Stat_tn_player_hero(conn,tn_id,'all')
    end
    
    %% boucle stat sur le patch
    Stat_patch_player(conn)
    Stat_patch_team(conn)
    Stat_patch_hero(conn)
    Stat_patch_team_hero(conn)
    Stat_patch_player_hero(conn)
    Stat_patch_tn(conn)
    
    %% boucle stat sur le global bdd
    Stat_global_player(conn)
    Stat_global_team(conn)
    Stat_global_hero(conn)
    Stat_global_team_hero(conn)
    Stat_global_player_hero(conn)
    %Stat_global_tn(conn)
    
    %% advanced statistique
    
    
    
catch ME %#ok<NASGU>
    disp('error exec add')
end

end

