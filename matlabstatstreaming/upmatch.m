function MatchBO=upmatch(MatchBO,Matchdata,Matchgame,format,steamid)

for i=1:format
       
        
if strcmp(Matchgame(i).status,'completed')==1 && strcmp(MatchBO.Status{i,1},'completed')==0
    MatchBO.SteamID(i,1)=str2double(steamid{i});
    MatchBO.Status{i,1}='completed';
    MatchBO.isdefine(i,1)=1;
    MatchBO.isnews(i,1)=1;
end


if MatchBO.isdefine(i,1)==0 && strcmp(MatchBO.Status{i,1},'completed')==0
    if isfield(Matchgame(i).opponents(1).participant,'id')==1 && isfield(Matchgame(i).opponents(2).participant,'id')==1
        MatchBO.TeamID1{i,1}=Matchgame(i).opponents(1).participant.id;
        MatchBO.TeamName1{i,1}=Matchgame(i).opponents(1).participant.name;
        MatchBO.TeamID2{i,1}=Matchgame(i).opponents(2).participant.id;
        MatchBO.TeamName2{i,1}=Matchgame(i).opponents(2).participant.name;
        if isempty(Matchgame(i).opponents(1).result)==0
            if Matchgame(i).opponents(1).result==1
                MatchBO.Gagnant(i,1)=1;
                MatchBO.isend(i,1)=1;
            elseif Matchgame(i).opponents(1).result==3
                MatchBO.Gagnant(i,1)=2;
                MatchBO.isend(i,1)=1;
            else
                MatchBO.Gagnant(i,1)=NaN;
            end
        else
            MatchBO.Gagnant(i,1)=NaN;
        end
        MatchBO.SteamID(i,1)=str2double(steamid{i});
        MatchBO.isdefine(i,1)=1;
    end
    
elseif MatchBO.isdefine(i,1)==1 && MatchBO.isnews(i,1)==0 && strcmp(MatchBO.Status{i,1},'completed')==0
    if isfield(Matchgame(i).opponents(1).participant,'id')==1
        if isempty(Matchgame(i).opponents(1).result)==0
            if Matchgame(i).opponents(1).result==1
                MatchBO.Gagnant(i,1)=1;
                MatchBO.isend(i,1)=1;
            elseif Matchgame(i).opponents(1).result==3
                MatchBO.Gagnant(i,1)=2;
                MatchBO.isend(i,1)=1;
            else
                MatchBO.Gagnant(i,1)=NaN;
            end
        else
            MatchBO.Gagnant(i,1)=NaN;
        end
        MatchBO.SteamID(i,1)=str2double(steamid{i});
    end
    
elseif MatchBO.isdefine(i,1)==1 && MatchBO.isnews(i,1)==1 && strcmp(MatchBO.Status{i,1},'completed')==0
    
    if isfield(Matchgame(i).opponents(1).participant,'id')==1
        if isempty(Matchgame(i).opponents(1).result)==0
            if Matchgame(i).opponents(1).result==1
                MatchBO.Gagnant(i,1)=1;
                MatchBO.isend(i,1)=1;
            elseif Matchgame(i).opponents(1).result==3
                MatchBO.Gagnant(i,1)=2;
                MatchBO.isend(i,1)=1;
            else
                MatchBO.Gagnant(i,1)=NaN;
            end
        else
            MatchBO.Gagnant(i,1)=NaN;
        end
        MatchBO.SteamID(i,1)=str2double(steamid{i});
    end
    elseif MatchBO.isdefine(i,1)==1 && MatchBO.isnews(i,1)==1 && strcmp(MatchBO.Status{i,1},'completed')==1
    
    if isfield(Matchgame(i).opponents(1).participant,'id')==1
        if isempty(Matchgame(i).opponents(1).result)==0
            if Matchgame(i).opponents(1).result==1
                MatchBO.Gagnant(i,1)=1;
                MatchBO.isend(i,1)=1;
            elseif Matchgame(i).opponents(1).result==3
                MatchBO.Gagnant(i,1)=2;
                MatchBO.isend(i,1)=1;
            else
                MatchBO.Gagnant(i,1)=NaN;
            end
        else
            MatchBO.Gagnant(i,1)=NaN;
        end
        MatchBO.SteamID(i,1)=str2double(steamid{i});
    end
end
end