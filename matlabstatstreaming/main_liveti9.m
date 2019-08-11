function main_liveti9()

try
    
    %% con sql
    %% Set preferences
    setdbprefs('NullNumberRead', 'NaN');
    setdbprefs('NullStringRead', 'null');
    setdbprefs('DataReturnFormat','table');
    
    %% Make connection to database
    load('sql.mat','config');
    conn = database(config.odbc,config.user,config.pass);
    serveur_sql_ok = -1;
    while serveur_sql_ok ~= 0
        disp('Tentative de connexion avec PGSQL...');
        if isempty(conn.Catalogs)==1
            disp('Echec de connexion à PGSQL, nouvelle tentative dans 1min...');
            pause(60)
            conn = database(config.odbc,config.user,config.pass);
        else
            serveur_sql_ok = 0;
            disp('Connexion à PGSQL CBM OK !');
        end
    end
    
    %% trouver les tournois a surveiller
    tn=pgsqldata(conn,'select * from public.tn');
    tn_running=tn(tn.closed==0,:);
    
    %% initialisation patch
    init_patch=pgsqldata(conn,'select update,id from public.patch order by patchdate desc limit 1');
    if init_patch.update==0
        initpatch(conn);
        pgsqlexec(conn,['update patch set init_patch=1 where patch.id=',num2str(init_patch.id)]);
    end
    %% Boucle plusieurs tournosi a update
    for i=1:heigth(tn_running)
        %% API VALVE : information ticket
        tn_id=tn_running.id_tn(i,1);
        TktMatch=TktInfo_ApiGetValve(tn_id);
        %% update des informations equipes et joueurs
        updateteam(conn,TktMatch)
        %% Recup match déjà en base
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
            if isempty(newmatch)
                disp('pas de nouveau match a ajouter')
            else
                CBM_PGSQL_Transact_light(conn,'matchs',newmatch.Properties.VariableNames,newmatch,'id','public')
                execmatch=table();
                execmatch.match_id=newmatch.match_id;
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
            for j=1:height(newmatchvalve)
                %% Recupération des info match source valve
                datavalve=ApiGetValve(newmatchvalve.match_id(j));
                init_player(conn,datavalve.result.players,newmatchvalve.match_id(j));
                execvalve(datavalve,conn,newmatchvalve);
            end
        end
        disp('Traitement Valve OK')
        %% liste des match a execopen<5
        rqopen='select match_id,id,execopenplayer,execopenpicks from public.execmatch where execopenplayer<5 or execopenpicks<5';
        newmatchopen=pgsqldata(conn,rqopen);
        if strcmp(newmatchopen,'No Data')==0
            for j=1:height(newmatchopen)
                %% Récupération des info match source opendota
                dataod=ApiGetStatOpen(newmatchopen.match_id(j));
                init_player(conn,dataod.players,newmatchopen.match_id(j));
                execopen(dataod,conn,newmatchopen);
            end
        end
        disp('Traitement Open OK')
        
        %% algo de fusion
        %% Récupération des informations en base
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %% stat à update
        %% boucle pour le tournois add
        nb_nm_wth_qualif=heigth(newmatch);
        tn_with_qualif=
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
        
        
        
        
        
        
    end %end for tn i
    %% Algo de fusion update toutes stat
    %% boucle stat sur le patch
    Stat_patch_player(conn)
    Stat_patch_team(conn)
    Stat_patch_hero(conn)
    Stat_patch_team_hero(conn)
    Stat_patch_player_hero(conn)
    %Stat_patch_tn(conn)
    
    %% boucle stat sur le global bdd
    Stat_global_player(conn)
    Stat_global_team(conn)
    Stat_global_hero(conn)
    Stat_global_team_hero(conn)
    Stat_global_player_hero(conn)
    %Stat_global_tn(conn)
    
catch ME
    disp(ME.message)
    disp(struct2table(ME.stack))
end


end