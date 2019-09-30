function execguardian(datamatch,conn)

%% init
separateur=0.5;

%% insertion info match guardian open match
retrive=check_data_quality(datamatch);

if retrive==1
        add_openmatch(conn,datamatch)
        for pos_player=1:10
            account_id=datamatch.players{pos_player,1}.account_id;
            
            if ~isempty(account_id)
                selectQ=sprintf('select * from player where player.player_id=%f',account_id);
                data_player=select(conn,selectQ);
                if ~isempty(data_player)
                    %             start update player name
                    player_name=datamatch.players{pos_player,1}.personaname;
                    update_player(conn,account_id,player_name)
                    %             end update player name
                    add_openplayermatch(conn,datamatch,pos_player)
                else
                    add_player(conn,account_id,0)
                    add_openplayermatch(conn,datamatch,pos_player)
                end
            end
            
        end
        add_match(conn,match_id_list(i),1);
        match_id_list_processed=[match_id_list_processed,match_id_list(i)];
    end
end

%% insertion info match guardian open player match

%% insertion info guardian player data

%% insertion info player hero data

%% insertion info guardian flag

%% insertion info reverseprint






test=1;
end