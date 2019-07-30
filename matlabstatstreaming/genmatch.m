function [Match]=genmatch(dataTN,Matchdata,i,game,format,steamid,pro)

Match=table();

Match.SteamID=steamid;
Match.Game=game;
Match.Format=format;
Match.TOO_ID=dataTN.id(i,1);
Match.TN_TOO_ID=dataTN.tournament_id(i,1);
Match.Arbre_ID=dataTN.number(i,1);
Match.Tour_ID=dataTN.round_number(i,1);
Match.Stage_ID=dataTN.group_number(i,1);
Match.Phase_ID=dataTN.stage_number(i,1);
Match.Status=dataTN.status(i,1);
Match.match_format=dataTN.match_format(i,1);
if isfield(Matchdata.opponents(1).participant,'id')==1 && isfield(Matchdata.opponents(2).participant,'id')==1
    Match.TeamID1{1,1}=Matchdata.opponents(1).participant.id;
    Match.TeamName1{1,1}=Matchdata.opponents(1).participant.name;
    Match.TeamID2{1,1}=Matchdata.opponents(2).participant.id;
    Match.TeamName2{1,1}=Matchdata.opponents(2).participant.name;
    if isempty(Matchdata.opponents(1).result)==0
        if Matchdata.opponents(1).result==1
            Match.Gagnant=1;
        elseif Matchdata.opponents(1).result==3
            Match.Gagnant=2;
        else
            Match.Gagnant=NaN;
        end
    else
        Match.Gagnant=NaN;
    end
    Match.isdefine=1;
else
    Match.TeamID1{1,1}='null';
    Match.TeamName1{1,1}='null';
    Match.TeamID2{1,1}='null';
    Match.TeamName2{1,1}='null';
    Match.Gagnant=NaN;
    Match.SteamID=NaN;
    Match.isdefine=0;
end
if strcmp(dataTN.status(i,1),'completed')==0
    Match.isnews=0;
    Match.isend=0;
    Match.rstnews=0;
    Match.issave=0;
    Match.isparse=0;
    Match.mvpnews=0;
    Match.ispro=pro;
else
    Match.isnews=1;
    Match.isend=1;
    Match.rstnews=0;
    Match.issave=0;
    Match.isparse=0;
    Match.mvpnews=0;
    Match.ispro=pro;
end