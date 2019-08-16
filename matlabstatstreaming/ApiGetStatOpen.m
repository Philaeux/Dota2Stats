function data=ApiGetStatOpen(id_game)
testvalve=0;
while testvalve==0
    try
        id_game_rq=num2str(round(id_game));
        RQString=['https://api.opendota.com/api/matches/',id_game_rq];
        options = weboptions('Timeout',120);
        data=webread(RQString,options);
        pause(1)
        testvalve=1;
    catch
        disp('api opendota indisponible nouvel essai dnas 1 min...')
        pause(60)
    end
end
end