function data=ApiGetValve(id_game)

testvalve=0;
while testvalve==0
    try
        id_game_rq=num2str(round(id_game));
        RQString=['http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=FB3E80CED3B660BF4A064B030E3F424F&match_id=',id_game_rq];
        options = weboptions('Timeout',60);
        data=webread(RQString,options);
        testvalve=1;
    catch
        disp('api valve indisponible nouvel essai dnas 1 min...')
        pause(60)
    end
end

end


