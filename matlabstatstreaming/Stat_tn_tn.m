function Stat_tn_tn(conn,tn_id,type)
disp('Traitement des stats TN Tournois')
match_valve=pgsqldata(conn,['select * from public.join_valvematch where id_tn=',num2str(tn_id)]);
switch type
    case 'main'
        %% algo
        CalcStatTeam=match_valve(match_valve.id_tn==tn_id & match_valve.is_qualif==0,:);
        stat_tn_add=table();
        if ~isempty(match_valve)
            stat_tn_add.id=NaN;
            stat_tn_add.id_tn=tn_id;
            stat_tn_add.is_qualif=0;
            stat_tn_add.nb_match=height(CalcStatTeam);
            [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
            [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
        end
        %% insertion SQL
        %% insertion SQL StatPlayer
        rqexist=['select id from public.stat_tn_tn where tn_id=',num2str(tn_id),' and is_qualif=0'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_tn where tn_id=',num2str(tn_id),' and is_qualif=0'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_tn',stat_tn_add.Properties.VariableNames,stat_tn_add,'id','public');
    case 'qualif'
        %% algo
        CalcStatTeam=match_valve(match_valve.id_tn==tn_id & match_valve.is_qualif==1,:);
        stat_tn_add=table();
        if ~isempty(match_valve)
            stat_tn_add.id=NaN;
            stat_tn_add.id_tn=tn_id;
            stat_tn_add.is_qualif=1;
            stat_tn_add.nb_match=height(CalcStatTeam);
            [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
            [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
        end
        %% insertion SQL
        %% insertion SQL StatPlayer
        rqexist=['select id from public.stat_tn_tn where tn_id=',num2str(tn_id),' and is_qualif=1'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_tn where tn_id=',num2str(tn_id),' and is_qualif=1'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_tn',stat_tn_add.Properties.VariableNames,stat_tn_add,'id','public');
    case 'all'
        %% algo
        CalcStatTeam=match_valve(match_valve.id_tn==tn_id,:);
        stat_tn_add=table();
        if ~isempty(match_valve)
            stat_tn_add.id=NaN;
            stat_tn_add.id_tn=tn_id;
            stat_tn_add.is_qualif=NaN;
            stat_tn_add.nb_match=height(CalcStatTeam);
            [stat_tn_add]=genstat(CalcStatTeam,'radiant_win',stat_tn_add);
            [stat_tn_add]=genstat(CalcStatTeam,'duration',stat_tn_add);
        end
        %% insertion SQL
        %% insertion SQL StatPlayer
        rqexist=['select id from public.stat_tn_tn where tn_id=',num2str(tn_id),' and is_qualif=null'];
        exist1=pgsqldata(conn,rqexist);
        if strcmp(exist1,'No Data')==0
            pgsqlexec(conn,['delete from public.stat_tn_tn where tn_id=',num2str(tn_id),' and is_qualif=null'])
        end
        CBM_PGSQL_Transact_light(conn,'stat_tn_tn',stat_tn_add.Properties.VariableNames,stat_tn_add,'id','public');
end
disp('Traitement OK')
end

