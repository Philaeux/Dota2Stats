function TweetCompHeros(LIVE_TI7_CompHeros,LIVE_TI7_CompHerosTemp,twfr,~)


if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxpick')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxpick')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxpick')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'maxpick')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxpick')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxpick')==1));
        msgfr=['Le r�sultat compendium "h�ro le plus pick" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' pick #TI7FR'];
        msgen=['Compendium result "most pick hero" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' pick #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxban')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxban')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxban')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'maxban')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxban')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxban')==1));
        msgfr=['Le r�sultat compendium "h�ro le plus ban" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' ban #TI7FR'];
        msgen=['Compendium result "most ban hero" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' ban #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanwin')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanwin')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanwin')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'meanwin')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanwin')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanwin')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant le + haut % de victoire" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' win #TI7FR'];
        msgen=['Compendium result "highest winrate hero" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' win #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanassist')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanassist')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanassist')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'meanassist')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanassist')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanassist')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant la + haute moyenne d assists" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' assist #TI7FR'];
        msgen=['Compendium result "hero with highest mean of assists" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' assist #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meankill')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meankill')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meankill')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'meankill')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meankill')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meankill')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant la + haute moyenne de kill" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' kills #TI7FR'];
        msgen=['Compendium result "hero with highest mean of kills" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' kills #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meandeath')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meandeath')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meandeath')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'meandeath')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meandeath')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meandeath')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant la + basse moyenne de mort" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' morts #TI7FR'];
        msgen=['Compendium result "hero with lowest mean of deaths" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' deaths #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanxpm')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanxpm')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanxpm')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'meanxpm')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanxpm')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanxpm')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant la + haute moyenne d XPM" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' XPM #TI7FR'];
        msgen=['Compendium result "hero with highest mean of XPM" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' XPM #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxkill')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxkill')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxkill')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'maxkill')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxkill')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxkill')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant le + grand nb de kill" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' kills #TI7FR'];
        msgen=['Compendium result "hero with highest nb of kill" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' kills #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxlasthit')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxlasthit')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxlasthit')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'maxlasthit')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'maxlasthit')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'maxlasthit')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant le + grand nb de LH" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' LH #TI7FR'];
        msgen=['Compendium result "hero with highest nb of LH" has just moved from ',compheroold,' to ',comphero,' with : ',compvalue,' LH #TI7'];
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

if ~isempty(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanlasthit')==1))
    if strcmp(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanlasthit')==1),LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanlasthit')==1))==0
        compvalue=num2str(LIVE_TI7_CompHerosTemp.value(strcmp(LIVE_TI7_CompHerosTemp.type,'meanlasthit')==1));
        comphero=char(LIVE_TI7_CompHerosTemp.Hero(strcmp(LIVE_TI7_CompHerosTemp.type,'meanlasthit')==1));
        compheroold=char(LIVE_TI7_CompHeros.Hero(strcmp(LIVE_TI7_CompHeros.type,'meanlasthit')==1));
        msgfr=['Le r�sultat compendium "h�ro ayant la + grande moyenne de LH" est pass� de ',compheroold,' � ',comphero,' avec : ',compvalue,' LH #TI7FR'];
        msgen=['Compendium result "hero with highest mean of LH" has moved beaten from ',compheroold,' to ',comphero,' with : ',compvalue,' LH #TI7'];
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