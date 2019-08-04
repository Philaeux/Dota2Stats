function data=ApiGetPlayerOpen(id_player)

try
id_game_rq=num2str(round(id_player));
RQString=['https://api.opendota.com/api/players/',id_game_rq];
options = weboptions('Timeout',120);
data=webread(RQString,options);
pause(1)
catch ME
    pause(60)
    disp('api open indisponible nouvel essai dnas 1 min...')
    try
        data=webread(RQString,options);
    catch
        pause(60)
        disp('api open indisponible nouvel essai dnas 1 min...')
        try
            data=webread(RQString,options);
        catch
            disp('api open offline...')
        end
    end
end

end