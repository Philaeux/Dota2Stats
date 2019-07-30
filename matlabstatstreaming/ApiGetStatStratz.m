function data=ApiGetStatStratz(id_game)

try
id_game_rq=num2str(round(id_game));
RQString=['https://api.stratz.com/api/v1/match/',id_game_rq];
options = weboptions('Timeout',120);
data=webread(RQString,options);
pause(1)
catch ME
    pause(60)
    disp('api valve indisponible nouvel essai dnas 1 min...')
    try
        data=webread(RQString,options);
    catch
        pause(60)
        disp('api valve indisponible nouvel essai dnas 1 min...')
        try
            data=webread(RQString,options);
        catch
            pause(600)
            disp('api valve offline...')
        end
    end
end

end