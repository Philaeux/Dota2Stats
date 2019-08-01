function TweetCompTeam(LIVE_TI7_CompTeam,LIVE_TI7_CompTeamTemp,LIVE_TI7_Team,twfr,~)

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxkills')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxkills')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'maxkills')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'maxkills')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxkills')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'maxkills')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec le + de kills en une game" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' kill #TI7FR'];
        msgen=['Compendium result "team with most kills in a game" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' kills #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meankills')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meankills')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'meankills')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'meankills')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meankills')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'meankills')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec le + de kills en moyenne" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' kill #TI7FR'];
        msgen=['Compendium result "team with most kills average" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' kills #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meandeaths')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meandeaths')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'meandeaths')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'meandeaths')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meandeaths')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'meandeaths')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec le - de morts en une game" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' deaths #TI7FR'];
        msgen=['Compendium result "team with fewest deaths in a game" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' deaths #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxassists')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxassists')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'maxassists')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'maxassists')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxassists')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'maxassists')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec le + d assists en une game" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' assists #TI7FR'];
        msgen=['Compendium result "team with most assists in a game" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' assists #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'mintemps')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'mintemps')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'mintemps')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'mintemps')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'mintemps')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'mintemps')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec la victoire la plus courte" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' seconds #TI7FR'];
        msgen=['Compendium result "team with shortest victory time" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' seconds #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxtemps')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxtemps')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'maxtemps')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'maxtemps')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'maxtemps')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'maxtemps')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec la victoire la plus longue" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' seconds #TI7FR'];
        msgen=['Compendium result "team with longest victory time" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' seconds #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmax')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmax')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'nbherosmax')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmax')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmax')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'nbherosmax')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec le plus de héros pick" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' heroes #TI7FR'];
        msgen=['Compendium result "team with most different picks" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' heroes #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmin')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmin')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'nbherosmin')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmin')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'nbherosmin')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'nbherosmin')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec le moins de héros pick" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' heroes #TI7FR'];
        msgen=['Compendium result "team with fewest different picks" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' heroes #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

if ~isempty(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meantemps')==1))
    if strcmp(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meantemps')==1),LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'meantemps')==1))==0
        compvalue=num2str(LIVE_TI7_CompTeamTemp.value(strcmp(LIVE_TI7_CompTeamTemp.type,'meantemps')==1));
        compteam=char(LIVE_TI7_CompTeamTemp.Team(strcmp(LIVE_TI7_CompTeamTemp.type,'meantemps')==1));
        compteamen=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteam)==1));
        compteamold=char(LIVE_TI7_CompTeam.Team(strcmp(LIVE_TI7_CompTeam.type,'meantemps')==1));
        compteamolden=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,compteamold)==1));
        msgfr=['Le résultat compendium "Team avec les plus longues games en moyenne" est passé de ',compteamold,' à ',compteam,' avec : ',compvalue,' seconds #TI7FR'];
        msgen=['Compendium result "team with game length avg" has just moved from ',compteamolden,' to ',compteamen,' with : ',compvalue,' seconds #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.comp);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.compen);
                %twen.updateStatus(msgen);
            else
                disp(['msg trop long : ',msgen]);
            end
        catch ME
            disp(ME.message)
            disp(struct2table(ME.stack))
        end
        disp(msgfr)
        disp(msgen)
    end
end

end