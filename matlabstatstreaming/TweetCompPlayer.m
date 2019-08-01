function TweetCompPlayer(LIVE_TI7_CompPlayer,LIVE_TI7_CompPlayerTemp,LIVE_TI7_Player,twfr,~)

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meankills')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meankills')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meankills')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'meankills')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meankills')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meankills')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "+ grande moyenne de kill joueur" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' kill #TI7FR'];
        msgen=['Compendium result "highest player mean of kill" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' kill #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxkills')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxkills')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxkills')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxkills')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxkills')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxkills')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "+ de kill joueur" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' kill #TI7FR'];
        msgen=['Compendium result "player with most kill" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' kill #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meamdeaths')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meamdeaths')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meamdeaths')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'meamdeaths')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meamdeaths')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meamdeaths')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "+ basse moyenne de mort joueur" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' mort #TI7FR'];
        msgen=['Compendium result "lowest player mean of death" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' death #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanassists')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanassists')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meanassists')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanassists')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanassists')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meanassists')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "+ grande moyenne d assist joueur" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' pick #TI7FR'];
        msgen=['Compendium result "highest player mean of assist" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' pick #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxassists')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxassists')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxassists')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxassists')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxassists')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxassists')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "Joueur avec + d assists en 1 game" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' assists #TI7FR'];
        msgen=['Compendium result "highest mean of assists" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' assists #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanlasthit')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanlasthit')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meanlasthit')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanlasthit')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanlasthit')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meanlasthit')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "Joueur avec + de CS moyens" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' CS #TI7FR'];
        msgen=['Compendium result "highest CS average" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' CS #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxlasthit')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxlasthit')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxlasthit')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxlasthit')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxlasthit')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxlasthit')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "Joueur avec + de CS en 1 game" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' CS #TI7FR'];
        msgen=['Compendium result "highest CS in 1 game" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' CS #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxopm')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxopm')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxopm')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxopm')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'maxopm')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'maxopm')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "Joueur avec + de GPM en 1 game" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' GPM #TI7FR'];
        msgen=['Compendium result "highest GPM in 1 game" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' GPM #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanopm')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanopm')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meanopm')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanopm')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'meanopm')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'meanopm')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "Joueur avec + de GPM moyen" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' GPM #TI7FR'];
        msgen=['Compendium result "highest GPM average" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' GPM #TI7'];
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

if ~isempty(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'nb_heros')==1))
    if strcmp(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'nb_heros')==1),LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'nb_heros')==1))==0
        compvalue=num2str(LIVE_TI7_CompPlayerTemp.value(strcmp(LIVE_TI7_CompPlayerTemp.type,'nb_heros')==1));
        compplayer=char(LIVE_TI7_CompPlayerTemp.Player(strcmp(LIVE_TI7_CompPlayerTemp.type,'nb_heros')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1})
            compplayeren=compplayer;
        else
            compplayeren=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayer)==1});
        end
        compplayerold=char(LIVE_TI7_CompPlayer.Player(strcmp(LIVE_TI7_CompPlayer.type,'nb_heros')==1));
        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1})
            compplayerolden=compplayerold;
        else
            compplayerolden=char(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,compplayerold)==1});
        end
        msgfr=['Le résultat compendium "Joueur avec le + de héros joués" est passé de ',compplayerold,' à ',compplayer,' avec : ',compvalue,' héros #TI7FR'];
        msgen=['Compendium result "player with most heroes" has just moved from ',compplayerolden,' to ',compplayeren,' with : ',compvalue,' heroes #TI7'];
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