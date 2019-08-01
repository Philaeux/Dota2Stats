function LiveTI7()

warning off

%% initisation variable
%récup des information contenu dans les .mat
%debug
load('basesqlti7.mat')
%load('inittest.mat')
load('init.mat')

%récup d'information contenue dans les .xml (fichier de config)

%récup d'information SQL (il faut toujours mieu quand c'est possible
%initialisé les informations utile en SQL au début quite a faire des
%requete assez lourde plutot que de faire des requete d'importation dans la
%boucle live

%% initialisation variable
% id ticket TI7 4947

%id_tn=5498;

%% initialisation toornamanent API
% max 60 requete minute expiration du token après un certain nombre de
% seconde

TN_api_url='api.toornament.com';
TN_api_key='E_Z9HA5jYPDzPHl6MSVYAm45vucQS5xO5JWPO7Zkd3k';
TN_client_id='56fbad72150ba071788b45673d24fsp57tmoo08koscko80oog0ksw0o0000www80ck4owcw8o';
TN_client_secret='2n004o1lohkw0s4cg0go0ooc84kw040csskwc48c4owggosg4k';
TN_api_token=ApiCreateToken(TN_api_url,'oauth/v2/token',TN_client_id,TN_client_secret);

%% intitialisation twitter api
% limitation a 1 tweet minute pas d'expiration du token

import twitty
credentials.ConsumerKey = 'Vztl96yJuIQg3GQbl3kfvK8l0';
credentials.ConsumerSecret = 'ud9JGnHzKxkY0dZ7szAT3XvB7AfQXpayOFxAK8p0M1G1tJjsn0';
credentials.AccessToken = '849937779295481856-s2Zp8krUcEpSwIQhINABqxKk2oyRZGU';
credentials.AccessTokenSecret = 'jKushS8GZdz6moo6rXQsdP54rHyaDEtA10ez7Bl9IXyJO';
twfr = twitty(credentials);
% credentials2.ConsumerKey = 'op2CQUau3rik8idI57bDhxQaW';
% credentials2.ConsumerSecret = 'uDEr0jXMEZvsWJQeiRa8uJLMj6lOEOmAlxI9A1rtHSYqFrrqik';
% credentials2.AccessToken = '888840180383318016-05Fd5NSQ2fSRnp4bzqM5J0ChqxDBdYj';
% credentials2.AccessTokenSecret = 'ZkKnKtsn8oEwiHqUHTUN48E8RS3Pl4AHVaqmJgdk2n8p7';
%twen = twitty(credentials2);
twen=1;

%% recupérer les infos tournois
% création des tables initiale de contexte du tournois
load('livesqlti7.mat')

%% recupérer les infos matchs
% cré la liste des matchs initialement déclaré dans le tournois
if isempty(LIVE_TI7_Match)  %#ok<NODEF>
    try
        [LIVE_TI7_BO,LIVE_TI7_Match]=InitLiveTNMatch(TN_api_url,TN_api_key,TN_api_token,LIVE_TI7_Tournoi);
        save('livesqlti7.mat','LIVE_TI7_Match','LIVE_TI7_BO','-append')
    catch ME
        disp(ME.message)
        disp(struct2table(ME.stack))
    end
end

%% recupérer les infos du ticket valve
% liste des matchs contenu sur le ticket au début du tournois sans interet
% pour l'instant a transphérer dans la boucle live pour confirmer le status
% parser par les serveurs valve pour la récupération de context match
% try
%     TktMatch=TktInfo_ApiGetValve(id_tn);
%     TktMatchTable=struct2table(TktMatch.result.matches);
%     DateLastCheck=datetime(TktMatchTable.start_time(1,1),'ConvertFrom','posixtime');
% catch ME
%     fprintf('%s',ME.message)
% end

%% recupère le status du tournois par toornament pour le pro et l'amateur
% permet de rentré dans la boucle si et seulement si les tournois sont en
% cours
TNPROStatus=ApiGetDataTNSts(TN_api_url,LIVE_TI7_Tournoi.TOO_ID,TN_api_key,TN_api_token);


%% boucle de récupération progressive tourne du lancement du programe a l'obtention du status tournois finit
% Début du programe de check des resultats en live a ce stade si le
% tournois est bien généré dans toornament la table match est non nul et
% les status sont définit pour tous les matchs

while strcmp(TNPROStatus.status,'completed')==0 || strcmp(TNPROStatusAmat.status,'completed')==0
    DateNow=datetime('now');
    disp(DateNow); %permet de voir la boucle evoluer
    
    %% Vérifier entre chaque itération que le nombre de match à pas changé et si oui update
    % cas possible d'ajout de match soit dans le cas d'un round suisse soit
    % dans le cas d'un tournois en plusieurs phase (poule + arbre)
    
    %     try
    %         [LIVE_TI7_Match]=UpdateLiveTNMatch(TN_api_url,TN_api_key,TN_api_token,LIVE_TI7_Tournoi,LIVE_TI7_Match);
    %         save('livesqlti7.mat','LIVE_TI7_Match','-append')
    %     catch ME
    %         disp(ME.message)
    %         disp(struct2table(ME.stack))
    %         % régénère le token toornament si expiré
    %         TN_api_token=ApiCreateToken(TN_api_url,'oauth/v2/token',TN_client_id,TN_client_secret);
    %     end
    
    %% Vérifie si un status a évolué entre chaque itération
    % évolution d'un match de non définit a définit
    % évolution d'un match de en cours a finit
    
    try
        LIVE_TI7_Match=livematchupdate(LIVE_TI7_Match,LIVE_TI7_BO,TN_api_url,TN_api_key,TN_api_token);
        save('livesqlti7.mat','LIVE_TI7_Match','-append')
    catch ME
        disp(ME.message)
        disp(struct2table(ME.stack))
        % régénère le token toornament si expiré
        TN_api_token=ApiCreateToken(TN_api_url,'oauth/v2/token',TN_client_id,TN_client_secret);
    end
    
    
    %% partie match lancé
    % envoie un tweet si un match est définit et que le statut publié sur
    % twitter est à 0 passe le status a 1 après publication
    idxannonce=find(LIVE_TI7_Match.isdefine==1 & LIVE_TI7_Match.isnews==0);
    if ~isempty(idxannonce)
        for i=1:length(idxannonce)
            if ~isnan(LIVE_TI7_Match.SteamID(idxannonce(i)))
                try
                    %% définir les infos équipe
                    TagTeam1=char(LIVE_TI7_Team.tag(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName1{idxannonce(i)})==1));
                    TagTeam2=char(LIVE_TI7_Team.tag(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName2{idxannonce(i)})==1));
                    TagTeam1en=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName1{idxannonce(i)})==1));
                    TagTeam2en=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName2{idxannonce(i)})==1));
                    msgfr=['Le match n°',num2str(LIVE_TI7_Match.Game(idxannonce(i))),' entre ',TagTeam1,' vs ',TagTeam2,' vient de débuter ! http://www.trackdota.com/matches/',num2str(LIVE_TI7_Match.SteamID(idxannonce(i))),' #TI7FR'];
                    msgen=['The game n°',num2str(LIVE_TI7_Match.Game(idxannonce(i))),' between ',TagTeam1en,' & ',TagTeam2en,' has just started ! http://www.trackdota.com/matches/',num2str(LIVE_TI7_Match.SteamID(idxannonce(i))),' #TI7'];
                    %% send to twitter
                    if length(msgfr)<141
                        %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.live);
                        pause(2);twfr.updateStatus(msgfr);
                    else
                        disp(['msg trop long : ',msgfr]);
                    end
                    if length(msgen)<141
                        %%twen.updateStatus(msgen,'media_ids',twti7.img.liveen);
                        %twen.updateStatus(msgen);
                    else
                        disp(['msg trop long : ',msgen]);
                    end
                    disp(msgfr)
                    disp(msgen)
                    LIVE_TI7_Match.isnews(idxannonce(i))=1;
                    save('livesqlti7.mat','LIVE_TI7_Match','-append')
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                    LIVE_TI7_Match.isnews(idxannonce(i))=1;
                end
            else
                %disp('Pas de nouveau match à annoncer')
            end
        end
    else
        disp('Tous les match sont annoncer et pas de nouveau match à annoncer')
    end
    
    %% partie match finie
    % envoie un tweet si un match est finit et que le statut résultat publié sur
    % twitter est à 0 passe le status a 1 après publication
    idxgagnant=find(LIVE_TI7_Match.isend==1 & LIVE_TI7_Match.rstnews==0);
    if ~isempty(idxgagnant)
        for i=1:length(idxgagnant)
            if ~isnan(LIVE_TI7_Match.SteamID(idxgagnant(i)))
                try
                    %% definir l'équipe gagnante
                    TagTeam1=char(LIVE_TI7_Team.tag(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName1{idxgagnant(i)})==1));
                    TagTeam2=char(LIVE_TI7_Team.tag(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName2{idxgagnant(i)})==1));
                    if LIVE_TI7_Match.Gagnant(idxgagnant(i))==1
                        TeamGagnant=TagTeam1;
                        TeamGagnanten=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName1{idxgagnant(i)})==1));
                        TeamPerdant=TagTeam2;
                        TeamPerdanten=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName2{idxgagnant(i)})==1));
                    else
                        TeamGagnant=TagTeam2;
                        TeamGagnanten=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName2{idxgagnant(i)})==1));
                        TeamPerdant=TagTeam1;
                        TeamPerdanten=char(LIVE_TI7_Team.twitter(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName1{idxgagnant(i)})==1));
                    end
                    %% définir le score du match
                    ScoreTeam1=num2str(height(LIVE_TI7_Match(strcmp(LIVE_TI7_Match.TOO_ID,LIVE_TI7_Match.TOO_ID{idxgagnant(i)})==1 & LIVE_TI7_Match.Gagnant==1,:)));
                    ScoreTeam2=num2str(height(LIVE_TI7_Match(strcmp(LIVE_TI7_Match.TOO_ID,LIVE_TI7_Match.TOO_ID{idxgagnant(i)})==1 & LIVE_TI7_Match.Gagnant==2,:)));
                    %% definir le message twitter
                    msgfr=[TeamGagnant,' remporte le match n°',num2str(LIVE_TI7_Match.Game(idxgagnant(i))),' contre ',TeamPerdant,' score du BO : ',TagTeam1,' ',ScoreTeam1,'-',ScoreTeam2,' ',TagTeam2,' https://www.opendota.com/matches/',num2str(LIVE_TI7_Match.SteamID(idxgagnant(i))),' #TI7FR'];
                    msgen=['.',TeamGagnanten,' has just won the game n°',num2str(LIVE_TI7_Match.Game(idxgagnant(i))),' versus ',TeamPerdanten,' BO score : ',TagTeam1,' ',ScoreTeam1,'-',ScoreTeam2,' ',TagTeam2,' https://www.opendota.com/matches/',num2str(LIVE_TI7_Match.SteamID(idxgagnant(i))),' #TI7'];
                    %% send to twitter
                    if length(msgfr)<141
                        %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.matchresult);
                        pause(2);twfr.updateStatus(msgfr);
                    else
                        disp(['msg trop long : ',msgfr]);
                    end
                    if length(msgen)<141
                        %%twen.updateStatus(msgen,'media_ids',twti7.img.matchresulten);
                        %twen.updateStatus(msgen);
                    else
                        disp(['msg trop long : ',msgen]);
                    end
                    LIVE_TI7_Match.rstnews(idxgagnant(i))=1;
                    disp(msgfr)
                    disp(msgen)
                    %% update table etat
                    LIVE_TI7_Match.rstnews(idxgagnant(i))=1;
                    save('livesqlti7.mat','LIVE_TI7_Match','-append')
                    
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                    LIVE_TI7_Match.rstnews(idxgagnant(i))=1;
                    save('livesqlti7.mat','LIVE_TI7_Match','-append')
                end
            else
                %disp('Pas de nouveau résultat à annoncer')
            end
        end
    else
        disp('Tous les résultats sont annoncé et pas de nouveau résultat à annoncer')
    end
    
    %% update du status isparse
    % le status isparse est liéé a la publication des infomations de la
    % partie finie dans l'API VALVE et dans l'API OPEN DOTA
    idxparse=find(LIVE_TI7_Match.rstnews==1 & LIVE_TI7_Match.isparse==0);
    if ~isempty(idxparse)
        for i=1:length(idxparse)
            try
                datamatch=ApiGetStatOpen(LIVE_TI7_Match.SteamID(idxparse(i),1));
                if isfield(datamatch.players,'account_id')==0 && ~isempty(datamatch.players{1,1}.camps_stacked) %% info dans le datamatch
                    if LIVE_TI7_Match.isparse(idxparse(i))==0
                        %% ajout des données match
                        try
                            [LIVE_TI7_StatMatchadd,LIVE_TI7_ContextMatchadd,LIVE_TI7_StatMatchPlayeradd]=StatMatchMajorti7(datamatch,LIVE_TI7_Tournoi,LIVE_TI7_Match);
                            [mvp_name,mvp_score,mvp_heros,LIVE_TI7_StatMatchMVPadd,LIVE_TI7_ContextMatchadd]=mvp_matchti7(datamatch,LIVE_TI7_ContextMatchadd,LIVE_TI7_StatMatchPlayeradd,LIVE_TI7_Hero,LIVE_TI7_Player);
                            LIVE_TI7_StatMatch=[LIVE_TI7_StatMatch;LIVE_TI7_StatMatchadd]; %#ok<AGROW>
                            LIVE_TI7_ContextMatch=[LIVE_TI7_ContextMatch;LIVE_TI7_ContextMatchadd]; %#ok<AGROW>
                            LIVE_TI7_StatMatchPlayer=[LIVE_TI7_StatMatchPlayer;LIVE_TI7_StatMatchPlayeradd]; %#ok<AGROW>
                            LIVE_TI7_StatMatchMVP=[LIVE_TI7_StatMatchMVP;LIVE_TI7_StatMatchMVPadd]; %#ok<AGROW>
                            save('livesqlti7.mat','LIVE_TI7_StatMatch','LIVE_TI7_ContextMatch','LIVE_TI7_StatMatchPlayer','LIVE_TI7_StatMatchMVP','-append')
                            LIVE_TI7_Match.isparse(idxparse(i))=1;
                        catch ME
                            disp(ME.message)
                            disp(struct2table(ME.stack))
                        end
                    end
                    %% Twitter le MVP
                    if LIVE_TI7_Match.mvpnews(idxparse(i))==0
                        if ~isnan(LIVE_TI7_Match.SteamID(idxparse(i)))
                            try
                                TagTeam1=char(LIVE_TI7_Team.tag(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName1{idxparse(i)})==1));
                                TagTeam2=char(LIVE_TI7_Team.tag(strcmp(LIVE_TI7_Team.name,LIVE_TI7_Match.TeamName2{idxparse(i)})==1));
                                msgfr=['Le MVP de ',TagTeam1,' vs ',TagTeam2,' est : ',mvp_name,' avec ',mvp_heros,' et un score fantasy de : ',mvp_score,' #TI7FR'];
                                msgen=['MVP of ',TagTeam1,' vs ',TagTeam2,' is : ',mvp_name,' with ',mvp_heros,' and a Fantasy score of : ',mvp_score,' #TI7'];
                                if length(msgfr)<141
                                    pause(2);twfr.updateStatus(msgfr);
                                    %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.matchmvp);
                                else
                                    disp(['msg trop long : ',msgfr]);
                                end
                                if length(msgen)<141
                                    %%twen.updateStatus(msgen,'media_ids',twti7.img.matchmvpen);
                                    %twen.updateStatus(msgen);
                                else
                                    disp(['msg trop long : ',msgen]);
                                end
                                disp(msgfr)
                                disp(msgen)
                            catch ME
                                disp(ME.message)
                                disp(struct2table(ME.stack))
                                LIVE_TI7_Match.mvpnews(idxparse(i))=1;
                                save('livesqlti7.mat','LIVE_TI7_Match','LIVE_TI7_StatMatchMVP','-append')
                            end
                            nb_match_parse=height(LIVE_TI7_Match(LIVE_TI7_Match.isparse==1,:));
                            %% Twitter le MVP Record
                            % comparaison MVP Record actuel
                            try
                                if twti7.mvprecord.value<str2double(mvp_score)
                                    twti7.mvprecord.value=str2double(mvp_score);
                                    twti7.mvprecord.player=mvp_name;
                                    twti7.mvprecord.hero=mvp_heros;
                                    save('init.mat','twti7','-append')
                                    if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,mvp_name)==1})
                                        mvp_name_en=mvp_name;
                                    else
                                        mvp_name_en=char(LIVE_TI7_Player.twitter(strcmp(LIVE_TI7_Player.Pseudo,mvp_name)==1));
                                    end
                                    msgfr=['Le record de pt Fantasy en un match est maintenant détenue par ',mvp_name,' avec ',mvp_heros,' et un nb points de : ',mvp_score,' pts',' #TI7FR'];
                                    msgen=['New Fantasy point record in one game is achieved by ',mvp_name_en,' with ',mvp_heros,' and : ',mvp_score,' pts',' #TI7'];
                                    if length(msgfr)<141
                                        pause(2);twfr.updateStatus(msgfr);
                                        %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.mvprec);
                                    else
                                        disp(['msg trop long : ',msgfr]);
                                    end
                                    if length(msgen)<141
                                        %%twen.updateStatus(msgen,'media_ids',twti7.img.mvprecen);
                                        %twen.updateStatus(msgen);
                                    else
                                        disp(['msg trop long : ',msgen]);
                                    end
                                    disp(msgfr)
                                    disp(msgen)
                                end
                                LIVE_TI7_Match.mvpnews(idxparse(i))=1;
                                save('livesqlti7.mat','LIVE_TI7_Match','LIVE_TI7_StatMatchMVP','-append')
                            catch ME
                                disp(ME.message)
                                disp(struct2table(ME.stack))
                                LIVE_TI7_Match.mvpnews(idxparse(i))=1;
                                save('livesqlti7.mat','LIVE_TI7_Match','LIVE_TI7_StatMatchMVP','-append')
                            end
                        else
                            disp('Pas de nouveau mvp à annoncer')
                        end
                    end
                    
                    
                    %% Twitter le MVP TI7
                    if LIVE_TI7_Match.mvpnews(idxparse(i))==1 &&  LIVE_TI7_Match.issave(idxparse(i))==0
                        if nb_match_parse>32
                            DateNowMVPTi7=datetime('now');
                            if DateNowMVPTi7>DateScanMVPTi7
                                try
                                    [LIVE_TI7_StatPlayerMVP]=StatPlayerMVP(LIVE_TI7_StatMatchMVP,LIVE_TI7_Player);
                                    save('livesqlti7.mat','LIVE_TI7_StatPlayerMVP','-append')
                                    mvp_new_TI7=max(LIVE_TI7_StatPlayerMVP.mean_pt_fantasy);
                                    if mvp_new_TI7>twti7.mvpti7.value
                                        twti7.mvpti7.value=mvp_new_TI7;
                                        twti7.mvpti7.player=char((LIVE_TI7_StatPlayerMVP.Pseudo(LIVE_TI7_StatPlayerMVP.mean_pt_fantasy==mvp_new_TI7)));
                                        if isempty(LIVE_TI7_Player.twitter{strcmp(LIVE_TI7_Player.Pseudo,twti7.mvpti7.player)==1})
                                            mvpti7_name_en=twti7.mvpti7.player;
                                        else
                                            mvpti7_name_en=char(LIVE_TI7_Player.twitter(strcmp(LIVE_TI7_Player.Pseudo,twti7.mvpti7.player)==1));
                                        end
                                        save('init.mat','twti7','-append')
                                        msgfr=['Pour l instant le MVP de TI7 est ',twti7.mvpti7.player,' avec un nb points moyen de : ',num2str(twti7.mvpti7.value),' pts',' #TI7FR'];
                                        msgen=['For now the MVP of TI7 is ',mvpti7_name_en,' with an average score of ',num2str(twti7.mvpti7.value),' pts',' #TI7'];
                                        if length(msgfr)<141
                                            %pause(2);twfr.updateStatus(msgfr,'media_ids',twti7.img.mvpti7);
                                            pause(2);twfr.updateStatus(msgfr);
                                        else
                                            disp(['msg trop long : ',msgfr]);
                                        end
                                        if length(msgen)<141
                                            %%twen.updateStatus(msgen,'media_ids',twti7.img.mvpti7en);
                                            %twen.updateStatus(msgen);
                                        else
                                            disp(['msg trop long : ',msgen]);
                                        end
                                        disp(msgfr)
                                        disp(msgen)
                                    end
                                    DateScanMVPTi7=datetime('now')+hours(2);
                                catch ME
                                    disp(ME.message)
                                    disp(struct2table(ME.stack))
                                    LIVE_TI7_Match.issave(idxparse(i))=1;
                                end
                            end
                        end
                        
                        %% Twitter les records metas et perso joueurs
                        [LIVE_TI7_MetaRecord,LIVE_TI7_PlayerRecords]=Twitterecord(LIVE_TI7_StatMatchPlayeradd,LIVE_TI7_PlayerRecords,LIVE_TI7_MetaRecord,LIVE_TI7_Team,LIVE_TI7_Player,LIVE_TI7_Hero,twfr,twen);
                        save('livesqlti7.mat','LIVE_TI7_MetaRecord','LIVE_TI7_PlayerRecords','-append')
                        LIVE_TI7_Match.issave(idxparse(i))=1;
                    end
                end
            catch ME
                disp(ME.message)
                disp(struct2table(ME.stack))
            end
        end
    end
    
    %% Création et update des datas tournois
    % Si toutes les team on joué au moins un match
    if ~isempty(LIVE_TI7_StatMatchPlayer)
        if length(unique(LIVE_TI7_StatMatchPlayer.account_id))>85
            try
                [LIVE_TI7_StatPlayer,LIVE_TI7_StatHeroPlayer]=StatMajorti7(LIVE_TI7_StatMatchPlayer,LIVE_TI7_Player); %#ok<ASGLU>
                [LIVE_TI7_StatHeros]=StatHero(LIVE_TI7_Hero,LIVE_TI7_StatMatchPlayer,LIVE_TI7_ContextMatch);
                [LIVE_TI7_StatMatchTeam,LIVE_TI7_StatTeam]=StatTeam(LIVE_TI7_StatMatch,LIVE_TI7_ContextMatch,LIVE_TI7_Team,LIVE_TI7_StatMatchPlayer);
                [LIVE_TI7_Table_presence,LIVE_TI7_Table_phase1,LIVE_TI7_Table_phase2,LIVE_TI7_Table_phase3]=Table_Draft(LIVE_TI7_ContextMatch,LIVE_TI7_Hero); %#ok<ASGLU>
                save('livesqlti7.mat','LIVE_TI7_StatPlayer','LIVE_TI7_StatHeroPlayer','LIVE_TI7_StatHeros','LIVE_TI7_StatMatchTeam','LIVE_TI7_StatTeam','LIVE_TI7_Table_presence','LIVE_TI7_Table_phase1',...
                    'LIVE_TI7_Table_phase2','LIVE_TI7_Table_phase3','-append')
            catch ME
                disp(ME.message)
                disp(struct2table(ME.stack))
            end
            if isempty(LIVE_TI7_CompPlayer) || isempty(LIVE_TI7_CompHeros) || isempty(LIVE_TI7_CompTeam)
                [LIVE_TI7_CompPlayer,LIVE_TI7_CompPlayerStat,LIVE_TI7_CompTeamStat,LIVE_TI7_CompHeroStat,LIVE_TI7_CompTeam,LIVE_TI7_CompHeros,LIVE_TI7_CompTN]=compendiumti7(LIVE_TI7_StatMatchPlayer,LIVE_TI7_StatMatchTeam,LIVE_TI7_Player,LIVE_TI7_Team,LIVE_TI7_StatTeam,LIVE_TI7_StatPlayer,LIVE_TI7_StatHeros,LIVE_TI7_Hero); %#ok<ASGLU>
                save('livesqlti7.mat','LIVE_TI7_CompPlayer','LIVE_TI7_CompPlayerStat','LIVE_TI7_CompTeamStat','LIVE_TI7_CompHeroStat','LIVE_TI7_CompTeam','LIVE_TI7_CompHeros','LIVE_TI7_CompTN','-append')
            else
                try
                    [LIVE_TI7_CompPlayerTemp,LIVE_TI7_CompPlayerStat,LIVE_TI7_CompTeamStat,LIVE_TI7_CompHeroStat,LIVE_TI7_CompTeamTemp,LIVE_TI7_CompHerosTemp,LIVE_TI7_CompTNTemp]=compendiumti7(LIVE_TI7_StatMatchPlayer,LIVE_TI7_StatMatchTeam,LIVE_TI7_Player,LIVE_TI7_Team,LIVE_TI7_StatTeam,LIVE_TI7_StatPlayer,LIVE_TI7_StatHeros,LIVE_TI7_Hero); %#ok<ASGLU>
                    TweetCompPlayer(LIVE_TI7_CompPlayer,LIVE_TI7_CompPlayerTemp,LIVE_TI7_Player,twfr,twen);
                    TweetCompTeam(LIVE_TI7_CompTeam,LIVE_TI7_CompTeamTemp,LIVE_TI7_Team,twfr,twen);
                    TweetCompHeros(LIVE_TI7_CompHeros,LIVE_TI7_CompHerosTemp,twfr,twen);
                    [LIVE_TI7_CompPlayer,LIVE_TI7_CompPlayerStat,LIVE_TI7_CompTeamStat,LIVE_TI7_CompHeroStat,LIVE_TI7_CompTeam,LIVE_TI7_CompHeros,LIVE_TI7_CompTN]=compendiumti7(LIVE_TI7_StatMatchPlayer,LIVE_TI7_StatMatchTeam,LIVE_TI7_Player,LIVE_TI7_Team,LIVE_TI7_StatTeam,LIVE_TI7_StatPlayer,LIVE_TI7_StatHeros,LIVE_TI7_Hero); %#ok<ASGLU>
                    save('livesqlti7.mat','LIVE_TI7_CompPlayer','LIVE_TI7_CompPlayerStat','LIVE_TI7_CompTeamStat','LIVE_TI7_CompHeroStat','LIVE_TI7_CompTeam','LIVE_TI7_CompHeros','LIVE_TI7_CompTN','-append')
                catch ME
                    disp(ME.message)
                    disp(struct2table(ME.stack))
                end
            end
        else
            try
                [LIVE_TI7_StatPlayer,LIVE_TI7_StatHeroPlayer]=StatMajorti7(LIVE_TI7_StatMatchPlayer,LIVE_TI7_Player); %#ok<ASGLU>
                [LIVE_TI7_StatHeros]=StatHero(LIVE_TI7_Hero,LIVE_TI7_StatMatchPlayer,LIVE_TI7_ContextMatch);
                [LIVE_TI7_StatMatchTeam,LIVE_TI7_StatTeam]=StatTeam(LIVE_TI7_StatMatch,LIVE_TI7_ContextMatch,LIVE_TI7_Team,LIVE_TI7_StatMatchPlayer);
                [LIVE_TI7_Table_presence,LIVE_TI7_Table_phase1,LIVE_TI7_Table_phase2,LIVE_TI7_Table_phase3]=Table_Draft(LIVE_TI7_ContextMatch,LIVE_TI7_Hero); %#ok<ASGLU>
                save('livesqlti7.mat','LIVE_TI7_StatPlayer','LIVE_TI7_StatHeroPlayer','LIVE_TI7_StatHeros','LIVE_TI7_StatMatchTeam','LIVE_TI7_StatTeam','LIVE_TI7_Table_presence','LIVE_TI7_Table_phase1',...
                    'LIVE_TI7_Table_phase2','LIVE_TI7_Table_phase3','-append')
                [LIVE_TI7_CompPlayer,LIVE_TI7_CompPlayerStat,LIVE_TI7_CompTeamStat,LIVE_TI7_CompHeroStat,LIVE_TI7_CompTeam,LIVE_TI7_CompHeros,LIVE_TI7_CompTN]=compendiumti7(LIVE_TI7_StatMatchPlayer,LIVE_TI7_StatMatchTeam,LIVE_TI7_Player,LIVE_TI7_Team,LIVE_TI7_StatTeam,LIVE_TI7_StatPlayer,LIVE_TI7_StatHeros,LIVE_TI7_Hero); %#ok<ASGLU>
                save('livesqlti7.mat','LIVE_TI7_CompPlayer','LIVE_TI7_CompPlayerStat','LIVE_TI7_CompTeamStat','LIVE_TI7_CompHeroStat','LIVE_TI7_CompTeam','LIVE_TI7_CompHeros','LIVE_TI7_CompTN','-append')
            catch ME
                disp(ME.message)
                disp(struct2table(ME.stack))
            end
        end
    end
    %% Insertion SQL des info Stat Globale
    % attention les stats peuve necessité un appel en SQL au info des
    % tournois antérieur au tournois traité
    
    %% Insertion SQL des information MVP
    % Partie Clément
    
    %% Update du Hall of fame
    % cross all tournois
    % recup info SQL
    % comparaison au info récupéré au fils des parse
    % tweet si record Hall of fame batu
    
    %% update SQL du Hall of Fame
    % update BD pour detax
    
    %% Inportation des flag et des datas des précédent tournois par SQL
    % partie matrice
    
    %% calcul des nouveaux flag
    % Traitement au fil des parse
    
    %% remonté les flag temps réel au admin tournois
    % solution a dev
    
    %% enregistrement des info flag en SQL
    % partie matrice
    
    %% Fréquence de rotation de la boucle
    % définit a 60 seconde dans un premier temps à contrôler pour évité de
    % dépassé le nombre de requète API possible
    
    pause(1)
    
end



%% sorti du programme a faire !!!
% update des dernière info en SQL
% cloturer le programe ou le mettre en standby serveur ?

end
