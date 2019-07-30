function [BO,Match]=InitLiveTNMatch(TN_api_url,TN_api_key,TN_api_token,Tournoi)

Match=table();

%% leagueID



League_ID_pro=Tournoi.TOO_ID;
BO=struct2table(ApiGetDataTNMList(TN_api_url,League_ID_pro,TN_api_key,TN_api_token));




if ~isempty(BO)
    for i=1:height(BO)
        Matchdata=ApiGetDataTNMDetail(TN_api_url,League_ID_pro,BO.id{i,1},TN_api_key,TN_api_token);
        switch BO.match_format{i}
            case 'one'
                try
                    SteamID=str2double(Matchdata.private_note);
                    % argument de genmatch(dataTN,Matchdata,i,game,format,steamid,pro)
                    Matchadd=genmatch(BO,Matchdata,i,1,1,SteamID,1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
            case 'home_away'
                try
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(BO,Matchdata,i,1,2,str2num(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(BO,Matchdata,i,2,2,str2num(steamid{2}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
            case 'bo3'
                try
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(BO,Matchdata,i,1,3,str2num(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(BO,Matchdata,i,2,3,str2num(steamid{2}),1);
                    Match=[Match;Matchadd];
                    %game3
                    Matchadd=genmatch(BO,Matchdata,i,3,3,str2num(steamid{3}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
            case 'bo5'
                try
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(BO,Matchdata,i,1,5,str2num(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(BO,Matchdata,i,2,5,str2num(steamid{2}),1);
                    Match=[Match;Matchadd];
                    %game3
                    Matchadd=genmatch(BO,Matchdata,i,3,5,str2num(steamid{3}),1);
                    Match=[Match;Matchadd];
                    %game4
                    Matchadd=genmatch(BO,Matchdata,i,4,5,str2num(steamid{4}),1);
                    Match=[Match;Matchadd];
                    %game5
                    Matchadd=genmatch(BO,Matchdata,i,5,5,str2num(steamid{5}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
        end
    end
else
    disp('tournoi pro vide')
end






