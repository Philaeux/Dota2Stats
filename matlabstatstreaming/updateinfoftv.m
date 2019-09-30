function updateinfoftv(conn,connftv)
dataplayerapp=pgsqldata(conn,'select * from dota_pro_players');
dataplayerftv=pgsqldata(connftv,'select * from ftvshiba.ftv_s4_player');
datateamapp=pgsqldata(conn,'select * from dota_pro_teams');
datateamftv=pgsqldata(connftv,'select * from ftvshiba.ftv_s4_team');
dataplayersql=table();
datateamsql=table();
if strcmp(dataplayerapp,'No Data')
    for i=1:height(dataplayerftv)
    account_id(i)=sscanf(dataplayerftv.account_id{i,1},'%lu')-uint64(76561197960265728);
    end
    dataplayerftv.account_id=[];
    dataplayerftv.teamname=replace(dataplayerftv.teamname,'''','_');
    dataplayerftv.username=replace(dataplayerftv.username,'''','_');
    for i=1:height(dataplayerftv)
        dataplayersqladd=table();
        dataplayersqladd.id=NaN;
        dataplayersqladd.account_id=account_id(i);
        dataplayersqladd=[dataplayersqladd,dataplayerftv(i,:)];
        dataplayersql=[dataplayersql;dataplayersqladd];
    end
    CBM_PGSQL_Transact_light(conn,'dota_pro_players',dataplayersql.Properties.VariableNames,dataplayersql,'id','public');
else
    for i=1:height(dataplayerftv)
    account_id(i)=sscanf(dataplayerftv.account_id{i,1},'%lu')-uint64(76561197960265728);
    end
    dataplayerftv.account_id=[];
    dataplayerftv.teamname=replace(dataplayerftv.teamname,'''','_');
    dataplayerftv.username=replace(dataplayerftv.username,'''','_');
    for i=1:height(dataplayerftv)
        dataplayersqladd=table();
        dataplayersqladd.id=NaN;
        dataplayersqladd.account_id=account_id(i);
        dataplayersqladd=[dataplayersqladd,dataplayerftv(i,:)];
        dataplayersql=[dataplayersql;dataplayersqladd];
    end
    exec(conn,'delete from public.dota_pro_players');
    CBM_PGSQL_Transact_light(conn,'dota_pro_players',dataplayersql.Properties.VariableNames,dataplayersql,'id','public');
end

if strcmp(datateamapp,'No Data')
    datateamftv.team_name=replace(datateamftv.team_name,'''','_');
    datateamftv.tag=replace(datateamftv.tag,'''','_');
    for i=1:height(datateamftv)
        datateamsqladd=table();
        datateamsqladd.id=NaN;
        datateamsqladd=[datateamsqladd,datateamftv(i,:)];
        datateamsql=[datateamsql;datateamsqladd];
    end
    CBM_PGSQL_Transact_light(conn,'dota_pro_teams',datateamsql.Properties.VariableNames,datateamsql,'id','public');
else
    datateamftv.team_name=replace(datateamftv.team_name,'''','_');
    datateamftv.tag=replace(datateamftv.tag,'''','_');
    for i=1:height(datateamftv)
        datateamsqladd=table();
        datateamsqladd.id=NaN;
        datateamsqladd=[datateamsqladd,datateamftv(i,:)];
        datateamsql=[datateamsql;datateamsqladd];
    end
    exec(conn,'delete from public.dota_pro_teams');
    CBM_PGSQL_Transact_light(conn,'dota_pro_teams',datateamsql.Properties.VariableNames,datateamsql,'id','public');
end
end