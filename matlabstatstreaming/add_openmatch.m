function add_openmatch(conn,datamatch)
match_id=datamatch.match_id;
selectQ=sprintf('select * from openmatch wher openmatch.match_id=%f' ,match_id);
match_data=select(conn,selectQ);
if ~isempty(match_data)
    fprintf('the match of if %f is already in database',match_id)
    return
end


match_data=[match_data;{match_id,datamatch.radiant_score,datamatch.dire_score,...
    datamatch.duration,datamatch.players{1,1}.hero_id,datamatch.players{2,1}.hero_id,...
    datamatch.players{3,1}.hero_id,datamatch.players{4,1}.hero_id,datamatch.players{5,1}.hero_id,...
    datamatch.players{6,1}.hero_id,datamatch.players{7,1}.hero_id,datamatch.players{8,1}.hero_id,...
    datamatch.players{9,1}.hero_id,datamatch.players{10,1}.hero_id,datamatch.radiant_win}];
sqlwrite(conn,'openmatch',match_data)