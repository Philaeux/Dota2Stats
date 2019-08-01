function data=TktInfo_ApiGetValve(id_game)

id_game_rq=num2str(round(id_game));
RQString=['http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=FB3E80CED3B660BF4A064B030E3F424F&league_id=',id_game_rq];
options = weboptions('Timeout',60);
data=webread(RQString,options);

end


