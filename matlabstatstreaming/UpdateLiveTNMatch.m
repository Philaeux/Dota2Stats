function [Match]=UpdateLiveTNMatch(TN_api_url,TN_api_key,TN_api_token,Tournoi,Match)

ID=height(Match)+1;

%% leagueID
%Pro
League_ID_pro=Tournoi.TOO_ID;
dataTNpro2=struct2table(ApiGetDataTNMList(TN_api_url,League_ID_pro,TN_api_key,TN_api_token));

if ~isempty(dataTNpro2)
    %% vérifie que le nombre de match pro est identique
    NBMatchupdt=height(dataTNpro2);
    IDXPro=find(Match.ispro==1 & Match.Game==1);
    NBMatch=length(IDXPro);
    if NBMatchupdt>NBMatch
        for i=NBMatch:height(dataTNpro2)
            Matchdata=ApiGetDataTNMDetail(TN_api_url,League_ID_pro,dataTNpro2.id{i,1},TN_api_key,TN_api_token);
            switch dataTNpro2.match_format{i}
                case 'one'
                    SteamID=str2double(Matchdata.private_note);
                    % argument de genmatch(dataTN,Matchdata,i,game,format,steamid,pro)
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,1,1,SteamID,1);
                    Match=[Match Matchadd];
                case 'home_away'
                try
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,1,2,str2num(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,2,2,str2num(steamid{2}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
                case 'bo3'
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,1,3,steamid{1},1);
                    Match=[Match Matchadd];
                    %game2
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,2,3,steamid{2},1);
                    Match=[Match Matchadd];
                    %game3
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,3,3,steamid{3},1);
                    Match=[Match Matchadd];
                case 'bo5'
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,1,5,steamid{1},1);
                    Match=[Match Matchadd];
                    %game2
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,2,5,steamid{1},1);
                    Match=[Match Matchadd];
                    %game3
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,3,5,steamid{1},1);
                    Match=[Match Matchadd];
                    %game4
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,4,5,steamid{1},1);
                    Match=[Match Matchadd];
                    %game5
                    Matchadd=genmatch(dataTNpro2,Matchdata,i,5,5,steamid{1},1);
                    Match=[Match Matchadd];
            end
        end
    end
else
    disp('tournoi pro vide')
end



end