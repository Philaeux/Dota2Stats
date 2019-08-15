function main_liveti9()

nolimit=0;
date_scan_tn=datetime('now');
date_scan_fusion=datetime('now');
date_scan_loopback=datetime('now');
while nolimit==0
    try
        disp(['start main_live_ti9 loop time : ',datestr(datetime('now'))])
        tic
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
                conn=database(config.odbc,config.user,config.pass);
            else
                serveur_sql_ok = 0;
                disp('Connexion à PGSQL dota2stats OK !');
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
        for i=1:height(tn_running)
            disp(['start check new match pour : ',tn_running.name_tn{i}])
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
                    disp(['nombre de match ajouté = ',num2str(height(execmatch))])
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
            execmatchopen=table();
            if strcmp(newmatchopen,'No Data')==0
                for j=1:height(newmatchopen)
                    %% Récupération des info match source opendota
                    dataod=ApiGetStatOpen(newmatchopen.match_id(j));
                    init_player(conn,dataod.players,newmatchopen.match_id(j));
                    execmatchopenadd=execopen(dataod,conn,newmatchopen);
                    execmatchopen=[execmatchopen;execmatchopenadd]; %#ok<AGROW>
                end
            end
            disp('Traitement Open OK')
            %% algo de fusion
            if ~isempty(execmatchopen)
                nb_match_out_open=height(execmatchopen(execmatchopen.execopenplayer==6,:));
                if nb_match_out_open>0
                    disp('Start algo fusion tn')
                    tn_with_qualif=tn.withqualif(tn.id_tn==tn_id);
                    tn_qualif_closed=tn.qualifclosed(tn.id_tn==tn_id);
                    if tn_with_qualif==1
                        if tn_qualif_closed==1
                            Stat_tn_player(conn,tn_id,'main');
                            Stat_tn_team(conn,tn_id,'main');
                            Stat_tn_hero(conn,tn_id,'main');
                            Stat_tn_hero_team(conn,tn_id,'main');
                            Stat_tn_player_hero(conn,tn_id,'main');
                            Stat_tn_tn(conn,tn_id,'main');
                        else
                            Stat_tn_player(conn,tn_id,'qualif')
                            Stat_tn_team(conn,tn_id,'qualif')
                            Stat_tn_hero(conn,tn_id,'qualif')
                            Stat_tn_hero_team(conn,tn_id,'qualif')
                            Stat_tn_player_hero(conn,tn_id,'qualif')
                            Stat_tn_tn(conn,tn_id,'qualif');
                        end
                    end
                    disp('Traitement algo fusion tn OK')
                end
            end
        end %end for tn i
        
        %% Algo de fusion update toutes stat
        %% boucle stat sur le patch
        if datetime('now')-date_scan_fusion>duration(0,30,0)
            disp('Start algo fusion globaux')
            Stat_tn_player(conn,tn_id,'all')
            Stat_tn_team(conn,tn_id,'all')
            Stat_tn_hero(conn,tn_id,'all')
            Stat_tn_hero_team(conn,tn_id,'all')
            Stat_tn_player_hero(conn,tn_id,'all')
            Stat_tn_tn(conn,tn_id,'all');
            
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
            Stat_global_tn(conn)
            date_scan_fusion=datetime('now');
            disp('Traitement algo fusion globaux OK')
        end
        
    catch ME
        disp(ME.message)
        disp(struct2table(ME.stack))
        nolimit=1;
    end
    close(conn);
    tpsexe=toc;
    disp(['end main_live_ti9 loop time : ',datestr(datetime('now')),' in : ',num2str(tpsexe)])
    
end
end