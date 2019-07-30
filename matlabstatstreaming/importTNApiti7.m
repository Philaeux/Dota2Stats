function [Tournoi,Team,Player]=importTNApiti7(TN_Name,TN_api_url,TN_api_key,TN_api_token,ti7_id)

%% initialisation variable
Tournoi=table();
Team=table();
Player=table();

idp=1;

%% recupération des données tournoi
dataLG=struct2table(ApiGetDataLG(TN_api_url,'me/tournaments',TN_api_key,TN_api_token));
idx=find(strcmp(TN_Name,dataLG.id)==1);

Tournoi.id_tn=5401;
Tournoi.TOO_ID='559134859607343104';
Tournoi.Nom=dataLG.name(idx,1);
Tournoi.Start=datetime(dataLG.date_start(idx,1));
Tournoi.End=datetime(dataLG.date_end(idx,1));
Tournoi.NB_Team=dataLG.size(idx,1);

%% recupération des données équipes
dataTN=struct2table(ApiGetDataTNTeam(TN_api_url,Tournoi.TOO_ID,TN_api_key,TN_api_token));
Team.TOO_ID=dataTN.id;
Team.name=dataTN.name;
Team.country=dataTN.country;


%% recupération des données joueur
for i=1:height(Team)
    AddPlayer=table();
    Team.icon_small=dataTN.logo(i,1).icon_small;
    Team.icon_medium=dataTN.logo(i,1).icon_medium;
    Team.icon_large_square=dataTN.logo(i,1).icon_large_square;
    Team.extra_small_square=dataTN.logo(i,1).extra_small_square;
    Team.medium_small_square=dataTN.logo(i,1).medium_small_square;
    Team.original=dataTN.logo(i,1).original;
    datateam=ApiGetDataTNPDetail(TN_api_url,Tournoi.TOO_ID,Team.TOO_ID{i,1},TN_api_key,TN_api_token);
    dataTeam=struct2table(datateam.lineup);
    Team.team_id(i,1)=str2double(datateam.custom_fields_private(1).value);
    Team.tag(i,1)=datateam.custom_fields_private(2).value;
    Team.invite(i,1)=datateam.custom_fields_private(3).value;
    nbplayer=length(datateam.lineup);
    AddPlayer.Pseudo=dataTeam.name;
    AddPlayer.country=dataTeam.name;
    for j=1:nbplayer
        AddPlayer.account_id(j,1)=str2double(datateam.lineup(j).custom_fields_private(1).value);
        AddPlayer.position(j,1)=str2double(datateam.lineup(j).custom_fields_private(2).value);
        AddPlayer.birth{j,1}=datateam.lineup(j).custom_fields_private(3).value;
        AddPlayer.position(j,1)=str2double(datateam.lineup(j).custom_fields_private(4).value);
        AddPlayer.nb_ti(j,1)=str2double(datateam.lineup(j).custom_fields_private(5).value);
        AddPlayer.cash(j,1)=str2double(datateam.lineup(j).custom_fields_private(6).value);
        AddPlayer.TeamID(j,1)=Team.team_id(i,1);
    end
    Player=[Player;AddPlayer];
end


end


