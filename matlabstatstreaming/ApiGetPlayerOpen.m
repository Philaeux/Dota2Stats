function data=ApiGetPlayerOpen(id_player)
testvalve=0;
while testvalve==0
    try
        id_game_rq=num2str(round(id_player));
        RQString=['https://api.opendota.com/api/players/',id_game_rq];
        options = weboptions('Timeout',120);
        data=webread(RQString,options);
        pause(1)
        testvalve=1;
    catch
        disp('api valve indisponible nouvel essai dnas 1 min...')
        pause(60)
    end
end
end