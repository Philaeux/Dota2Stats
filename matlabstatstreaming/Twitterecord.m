function [LIVE_TI7_MetaRecord,LIVE_TI7_PlayerRecords]=Twitterecord(BD_TI7_StatMatchPlayer,LIVE_TI7_PlayerRecords,LIVE_TI7_MetaRecord,LIVE_TI7_Team,LIVE_TI7_Player,LIVE_TI7_Hero,twfr,~)

for i=1:10
    
    player_name=char(LIVE_TI7_Player.Pseudo(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
    if isempty(LIVE_TI7_Player.twitter{LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)})
        player_name_en=char(LIVE_TI7_Player.Pseudo(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
    else
        player_name_en=char(LIVE_TI7_Player.twitter(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
    end
    
    %% assist
    if BD_TI7_StatMatchPlayer.assists(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxassists')==1))
        recvalue=BD_TI7_StatMatchPlayer.assists(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxassists')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxassists')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxassists')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' a battue le record d assist de la méta avec ',num2str(recvalue),' assists avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' assists with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.assists(i,1)>LIVE_TI7_PlayerRecords.maxassists(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.assists(i,1);
        LIVE_TI7_PlayerRecords.maxassists(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en faisant ',num2str(recvalue),' assists avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' assists with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% kill
    if BD_TI7_StatMatchPlayer.kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxkills')==1))
        recvalue=BD_TI7_StatMatchPlayer.kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxkills')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxkills')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxkills')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en faisant ',num2str(recvalue),' kills avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' kills with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.kills(i,1)>LIVE_TI7_PlayerRecords.maxassists(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.kills(i,1);
        LIVE_TI7_PlayerRecords.maxkills(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en faisant ',num2str(recvalue),' kills avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' kills with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% courrier
    if BD_TI7_StatMatchPlayer.courier_kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxcourier')==1))
        recvalue=BD_TI7_StatMatchPlayer.courier_kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxcourier')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxcourier')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxcourier')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en tuant ',num2str(recvalue),' coursiers avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record killing ',num2str(recvalue),' coursier with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.courier_kills(i,1)>LIVE_TI7_PlayerRecords.maxcourier(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.courier_kills(i,1);
        LIVE_TI7_PlayerRecords.maxcourier(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en tuant ',num2str(recvalue),' coursiers avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record killing ',num2str(recvalue),' coursier with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxlasthit
    if BD_TI7_StatMatchPlayer.last_hits(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxlasthit')==1))
        recvalue=BD_TI7_StatMatchPlayer.last_hits(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxlasthit')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxlasthit')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxlasthit')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en faisant ',num2str(recvalue),' last hits avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' last hits with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.last_hits(i,1)>LIVE_TI7_PlayerRecords.maxlasthit(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.last_hits(i,1);
        LIVE_TI7_PlayerRecords.maxlasthit(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en faisant ',num2str(recvalue),' last hits avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' last hits with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxHD
    if BD_TI7_StatMatchPlayer.hero_damage(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxherodom')==1))
        recvalue=BD_TI7_StatMatchPlayer.hero_damage(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxherodom')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxherodom')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxherodom')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en faisant ',num2str(recvalue),' hero damage avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' hero damage with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.hero_damage(i,1)>LIVE_TI7_PlayerRecords.maxherodom(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.hero_damage(i,1);
        LIVE_TI7_PlayerRecords.maxherodom(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en faisant ',num2str(recvalue),' hero damage avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' hero damage with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxdenies
    if BD_TI7_StatMatchPlayer.denies(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxdenies')==1))
        recvalue=BD_TI7_StatMatchPlayer.denies(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxdenies')==1,1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxdenies')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxdenies')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en faisant ',num2str(recvalue),' denies avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' denies with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.denies(i,1)>LIVE_TI7_PlayerRecords.maxdenies(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.denies(i,1);
        LIVE_TI7_PlayerRecords.maxdenies(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en faisant ',num2str(recvalue),' denies avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' denies with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxheroheal
    if BD_TI7_StatMatchPlayer.hero_healing(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxheroheal')==1))
        recvalue=BD_TI7_StatMatchPlayer.hero_healing(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxheroheal')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxheroheal')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxheroheal')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en soignant ',num2str(recvalue),' points de vie avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record healing ',num2str(recvalue),' HP with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.hero_healing(i,1)>LIVE_TI7_PlayerRecords.maxheroheal(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.hero_healing(i,1);
        LIVE_TI7_PlayerRecords.maxheroheal(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en soignant ',num2str(recvalue),' points de vie avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record healing ',num2str(recvalue),' HP with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxkda
    if BD_TI7_StatMatchPlayer.kda(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxkda')==1))
        recvalue=BD_TI7_StatMatchPlayer.kda(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxkda')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxkda')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxkda')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en obtenant ',num2str(recvalue),' KDA avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' KDA with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.kda(i,1)>LIVE_TI7_PlayerRecords.maxkda(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.kda(i,1);
        LIVE_TI7_PlayerRecords.maxkda(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en obtenant ',num2str(recvalue),' KDA avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' KDA with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxCS
    if BD_TI7_StatMatchPlayer.camps_stacked(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxCS')==1))
        recvalue=BD_TI7_StatMatchPlayer.camps_stacked(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxCS')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxCS')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxCS')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en stackant ',num2str(recvalue),' camps avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record stacking ',num2str(recvalue),' camps with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.camps_stacked(i,1)>LIVE_TI7_PlayerRecords.maxCS(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.camps_stacked(i,1);
        LIVE_TI7_PlayerRecords.maxCS(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en stackant ',num2str(recvalue),' camps avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record stacking ',num2str(recvalue),' camps with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxnecrokill
    if BD_TI7_StatMatchPlayer.necronomicon_kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxnecrokill')==1))
        recvalue=BD_TI7_StatMatchPlayer.necronomicon_kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxnecrokill')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxnecrokill')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxnecrokill')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en tuant ',num2str(recvalue),' necronomicon avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record killing ',num2str(recvalue),' necronomicon with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.necronomicon_kills(i,1)>mean(LIVE_TI7_PlayerRecords.maxnecrokill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)))
        recvalue=BD_TI7_StatMatchPlayer.necronomicon_kills(i,1);
        LIVE_TI7_PlayerRecords.maxnecrokill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en tuant ',num2str(recvalue),' necronomicon avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record killing ',num2str(recvalue),' necronomicon with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxneutralkill
    if BD_TI7_StatMatchPlayer.neutral_kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxneutralkill')==1))
        recvalue=BD_TI7_StatMatchPlayer.neutral_kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxneutralkill')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxneutralkill')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxneutralkill')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en tuant ',num2str(recvalue),' neutraux avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record killing ',num2str(recvalue),' neutrals with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.neutral_kills(i,1)>LIVE_TI7_PlayerRecords.maxneutralkill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.neutral_kills(i,1);
        LIVE_TI7_PlayerRecords.maxneutralkill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en tuant ',num2str(recvalue),' neutraux avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record killing ',num2str(recvalue),' neutrals with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxobsplaces
    if BD_TI7_StatMatchPlayer.obs_placed(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxobsplaces')==1))
        recvalue=BD_TI7_StatMatchPlayer.obs_placed(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxobsplaces')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxobsplaces')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxobsplaces')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en placant ',num2str(recvalue),' observer wards avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record placing ',num2str(recvalue),' observer wards with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.obs_placed(i,1)>LIVE_TI7_PlayerRecords.maxobsplaces(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.obs_placed(i,1);
        LIVE_TI7_PlayerRecords.maxobsplaces(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en placant ',num2str(recvalue),' observer wards avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record placing ',num2str(recvalue),' observer wards with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxobskill
    if BD_TI7_StatMatchPlayer.observer_kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxobskill')==1))
        recvalue=BD_TI7_StatMatchPlayer.observer_kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxobskill')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxobskill')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxobskill')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en tuant ',num2str(recvalue),' observer wards avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record killing ',num2str(recvalue),' observer wards with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.observer_kills(i,1)>LIVE_TI7_PlayerRecords.maxobskill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.observer_kills(i,1);
        LIVE_TI7_PlayerRecords.maxobskill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en tuant ',num2str(recvalue),' observer wards avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record killing ',num2str(recvalue),' observer wards with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxopm
    if BD_TI7_StatMatchPlayer.opm(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxopm')==1))
        recvalue=BD_TI7_StatMatchPlayer.opm(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxopm')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxopm')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxopm')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en obtenant ',num2str(recvalue),' OPM avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' GPM with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.opm(i,1)>LIVE_TI7_PlayerRecords.maxopm(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.opm(i,1);
        LIVE_TI7_PlayerRecords.maxopm(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en obtenant ',num2str(recvalue),' OPM avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' GPM with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxrune
    if BD_TI7_StatMatchPlayer.rune_pickups(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxrune')==1))
        recvalue=BD_TI7_StatMatchPlayer.rune_pickups(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxrune')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxrune')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxrune')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en prenant ',num2str(recvalue),' runes avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' runes with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.rune_pickups(i,1)>LIVE_TI7_PlayerRecords.maxrune(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.rune_pickups(i,1);
        LIVE_TI7_PlayerRecords.maxrune(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en prenant ',num2str(recvalue),' runes avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' runes with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxstuns
    if BD_TI7_StatMatchPlayer.stuns(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxstuns')==1))
        recvalue=BD_TI7_StatMatchPlayer.stuns(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxstuns')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxstuns')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxstuns')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en faisant ',num2str(recvalue),' s de stuns avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record getting ',num2str(recvalue),' s of stuns with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.stuns(i,1)>LIVE_TI7_PlayerRecords.maxstuns(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.stuns(i,1);
        LIVE_TI7_PlayerRecords.maxstuns(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en faisant ',num2str(recvalue),' s de stuns avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record getting ',num2str(recvalue),' s of stuns with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxtowerkill
    if BD_TI7_StatMatchPlayer.tower_kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxtowerkill')==1))
        recvalue=BD_TI7_StatMatchPlayer.tower_kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxtowerkill')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxtowerkill')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxtowerkill')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en tuant ',num2str(recvalue),' tours avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record killing ',num2str(recvalue),' towers with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.tower_kills(i,1)>LIVE_TI7_PlayerRecords.maxtowerkill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.tower_kills(i,1);
        LIVE_TI7_PlayerRecords.maxtowerkill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en tuant ',num2str(recvalue),' tours avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record killing ',num2str(recvalue),' towers with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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
    
    %% maxsentrykill
    if BD_TI7_StatMatchPlayer.sentry_kills(i,1)>mean(LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxsentrykill')==1))
        recvalue=BD_TI7_StatMatchPlayer.sentry_kills(i,1);
        LIVE_TI7_MetaRecord.value(strcmp(LIVE_TI7_MetaRecord.type,'maxsentrykill')==1)=recvalue;
        LIVE_TI7_MetaRecord.Player{strcmp(LIVE_TI7_MetaRecord.type,'maxsentrykill')==1,1}=player_name;
        LIVE_TI7_MetaRecord.Team{strcmp(LIVE_TI7_MetaRecord.type,'maxsentrykill')==1,1}=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre le record de la meta en tuant ',num2str(recvalue),' sentrys avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten meta record killing ',num2str(recvalue),' sentrys with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.worldrec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.worldrecen);
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
    elseif BD_TI7_StatMatchPlayer.sentry_kills(i,1)>LIVE_TI7_PlayerRecords.maxsentrykill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))
        recvalue=BD_TI7_StatMatchPlayer.sentry_kills(i,1);
        LIVE_TI7_PlayerRecords.maxsentrykill(LIVE_TI7_PlayerRecords.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))=recvalue;
        teamname=char(LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1)));
        teamnameen=char(LIVE_TI7_Team.twitter(LIVE_TI7_Team.team_id==LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==BD_TI7_StatMatchPlayer.account_id(i,1))));
        heroname=char(LIVE_TI7_Hero.Nom(LIVE_TI7_Hero.ID==BD_TI7_StatMatchPlayer.hero_id(i,1)));
        msgfr=[player_name,' de l équipe ',teamname,' vient de battre son record personnel en tuant ',num2str(recvalue),' sentrys avec ',heroname,' #TI7FR'];
        msgen=['.',player_name_en,' from team ',teamnameen,' has just beaten his personal record killing ',num2str(recvalue),' sentrys with ',heroname,' #TI7'];
        try
            if length(msgfr)<141
                %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.persorec);
                pause(2);twfr.updateStatus(msgfr);
            else
                disp(['msg trop long : ',msgfr]);
            end
            if length(msgen)<141
                %%twen.updateStatus(msgen,'media_ids',twti7.img.persorecen);
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