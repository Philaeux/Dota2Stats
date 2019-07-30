function Match=livematchupdate(Match,BO,TN_api_url,TN_api_key,TN_api_token)

for i=1:height(BO)
    MatchBO=Match(strcmp(Match.TOO_ID,BO.id{i,1})==1,:);
    if ~isempty(MatchBO)
        nbmatch=height(MatchBO);
        
        if  sum(MatchBO.rstnews)<nbmatch
            Matchdata=ApiGetDataTNMDetail(TN_api_url,BO.tournament_id{i,1},BO.id{i,1},TN_api_key,TN_api_token);
            Matchgame=ApiGetDataTNGDetail(TN_api_url,BO.tournament_id{i,1},BO.id{i,1},TN_api_key,TN_api_token);
            switch BO.match_format{i}
                case 'one'
                    try
                        steamid=str2double(Matchdata.private_note);
                        % argument de genmatch(dataTN,Matchdata,i,game,format,steamid,pro)
                        MatchBO=upmatch(MatchBO,Matchdata,Matchgame,1,steamid);
                        Match(strcmp(Match.TOO_ID,BO.id{i,1})==1,:)=MatchBO;
                    catch ME
                        disp(ME.message)
                        disp(struct2table(ME.stack))
                    end
                case 'home_away'
                    try
                        steamid=strsplit(Matchdata.private_note,'-');
                        MatchBO=upmatch(MatchBO,Matchdata,Matchgame,2,steamid);
                        Match(strcmp(Match.TOO_ID,BO.id{i,1})==1,:)=MatchBO;
                    catch ME
                        disp(ME.message)
                        disp(struct2table(ME.stack))
                    end
                case 'bo3'
                    try
                        steamid=strsplit(Matchdata.private_note,'-');
                        MatchBO=upmatch(MatchBO,Matchdata,Matchgame,3,steamid);
                        Match(strcmp(Match.TOO_ID,BO.id{i,1})==1,:)=MatchBO;
                    catch ME
                        disp(ME.message)
                        disp(struct2table(ME.stack))
                    end
                case 'bo5'
                    try
                        steamid=strsplit(Matchdata.private_note,'-');
                        MatchBO=upmatch(MatchBO,Matchdata,Matchgame,5,steamid);
                        Match(strcmp(Match.TOO_ID,BO.id{i,1})==1,:)=MatchBO;
                    catch ME
                        disp(ME.message)
                        disp(struct2table(ME.stack))
                    end
            end
        end
    else
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
                    Matchadd=genmatch(BO,Matchdata,i,1,2,str2double(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(BO,Matchdata,i,2,2,str2double(steamid{2}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
            case 'bo3'
                try
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(BO,Matchdata,i,1,3,str2double(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(BO,Matchdata,i,2,3,str2double(steamid{2}),1);
                    Match=[Match;Matchadd];
                    %game3
                    Matchadd=genmatch(BO,Matchdata,i,3,3,str2double(steamid{3}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
            case 'bo5'
                try
                    steamid=strsplit(Matchdata.private_note,'-');
                    %game1
                    Matchadd=genmatch(BO,Matchdata,i,1,5,str2double(steamid{1}),1);
                    Match=[Match;Matchadd];
                    %game2
                    Matchadd=genmatch(BO,Matchdata,i,2,5,str2double(steamid{2}),1);
                    Match=[Match;Matchadd];
                    %game3
                    Matchadd=genmatch(BO,Matchdata,i,3,5,str2double(steamid{3}),1);
                    Match=[Match;Matchadd];
                    %game4
                    Matchadd=genmatch(BO,Matchdata,i,4,5,str2double(steamid{4}),1);
                    Match=[Match;Matchadd];
                    %game5
                    Matchadd=genmatch(BO,Matchdata,i,5,5,str2double(steamid{5}),1);
                    Match=[Match;Matchadd];
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
        end
    end
end
end







