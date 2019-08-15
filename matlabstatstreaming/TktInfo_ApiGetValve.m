function matchs=TktInfo_ApiGetValve(id_tn)

testvalve=0;
while testvalve==0
    try
        id_tn_rq=num2str(round(id_tn));
        RQString=['http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=FB3E80CED3B660BF4A064B030E3F424F&league_id=',id_tn_rq];
        options = weboptions('Timeout',60);
        data=webread(RQString,options);
        matchsvalve=table([data.result.matches.series_id].', [data.result.matches.match_id].', [data.result.matches.start_time].', [data.result.matches.radiant_team_id].',...
            [data.result.matches.dire_team_id].', 'VariableNames', {'series_id', 'match_id', 'start_time', 'radiant_team_id', 'dire_team_id'});
        testvalve=1;
    catch
        disp('api valve indisponible nouvel essai dnas 1 min...')
        pause(60)
    end
end



% teststratz=0;
% while teststratz==0
%     try
%         id_tn_rq=num2str(round(id_tn));
%         datastratz={};
%         cpt=0;
%         matchsstratz=table();
%         while isa(datastratz,'cell')
%             matchsstratzadd=table();
%             datastratz=webread(['https://api.stratz.com/api/v1/league/',id_tn_rq,'/matches'],'take','250','skip',num2str(0+250*cpt));
%             if isa(datastratz,'cell')
%                 for i=1:length(datastratz)
%                     matchsstratzadd.series_id(i,1)=datastratz{i, 1}.seriesId;
%                     matchsstratzadd.match_id(i,1)=datastratz{i, 1}.id;
%                     matchsstratzadd.start_time(i,1)=datastratz{i, 1}.startDateTime;
%                     matchsstratzadd.radiant_team_id(i,1)=datastratz{i, 1}.radiantTeamId;
%                     matchsstratzadd.dire_team_id(i,1)=datastratz{i, 1}.direTeamId;
%                 end
%                 matchsstratz=[matchsstratz;matchsstratzadd];
%             else
%                 matchsstratzadd.series_id(:,1)=[datastratz.seriesId].';
%                 matchsstratzadd.match_id=[datastratz.id].';
%                 matchsstratzadd.start_time=[datastratz.startDateTime].';
%                 matchsstratzadd.radiant_team_id=[datastratz.radiantTeamId].';
%                 matchsstratzadd.dire_team_id=[datastratz.direTeamId].';
%                 matchsstratz=[matchsstratz;matchsstratzadd];
%             end
%             cpt=cpt+1;
%         end
%         teststratz=1;
%     catch
%         disp('api stratz indisponible nouvel essai dnas 1 min...')
%         pause(60)
%     end
% end
% 
% matchsstratz=matchsstratz(matchsstratz.dire_team_id>0 & matchsstratz.radiant_team_id>0,:);
% 
% if height(matchsvalve)>=height(matchsstratz)
     matchs=matchsvalve;
% else
%     matchs=matchsstratz;
% end

end
