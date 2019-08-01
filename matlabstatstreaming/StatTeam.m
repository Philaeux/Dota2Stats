function [BD_TI7_StatMatchTeam,BD_TI7_StatTeam]=StatTeam(BD_TI7_StatMatch,BD_TI7_ContextMatch,BD_TI7_Team,BD_TI7_StatMatchPlayer)

BD_TI7_StatMatchTeam=table();
BD_TI7_StatTeam=table();


for i=1:height(BD_TI7_StatMatch)
    %%radiant
    BD_TI7_StatMatchTeamadd=table();
    BD_TI7_StatMatchTeamadd.id_tn=BD_TI7_StatMatch.id_tn(i,1);
    BD_TI7_StatMatchTeamadd.match_id=BD_TI7_StatMatch.match_id(i,1);
    BD_TI7_StatMatchTeamadd.team_id=BD_TI7_ContextMatch.team_idr(i,1);
    BD_TI7_StatMatchTeamadd.name=BD_TI7_ContextMatch.namer(i,1);
    if BD_TI7_ContextMatch.isfp(i,1)==0
        BD_TI7_StatMatchTeamadd.is_fp=1;
    else
        BD_TI7_StatMatchTeamadd.is_fp=0;
    end
    BD_TI7_StatMatchTeamadd.is_radiant=1;
    if strcmp(BD_TI7_ContextMatch.win(i,1),'Radiant')==1
        BD_TI7_StatMatchTeamadd.is_win=1;
    else
        BD_TI7_StatMatchTeamadd.is_win=0;
    end
    BD_TI7_StatMatchTeamadd.pick1=BD_TI7_ContextMatch.PickR1(i,1);
    BD_TI7_StatMatchTeamadd.pick2=BD_TI7_ContextMatch.PickR2(i,1);
    BD_TI7_StatMatchTeamadd.pick3=BD_TI7_ContextMatch.PickR3(i,1);
    BD_TI7_StatMatchTeamadd.pick4=BD_TI7_ContextMatch.PickR4(i,1);
    BD_TI7_StatMatchTeamadd.pick5=BD_TI7_ContextMatch.PickR5(i,1);
    BD_TI7_StatMatchTeamadd.ban1=BD_TI7_ContextMatch.BanR1(i,1);
    BD_TI7_StatMatchTeamadd.ban2=BD_TI7_ContextMatch.BanR2(i,1);
    BD_TI7_StatMatchTeamadd.ban3=BD_TI7_ContextMatch.BanR3(i,1);
    BD_TI7_StatMatchTeamadd.ban4=BD_TI7_ContextMatch.BanR4(i,1);
    BD_TI7_StatMatchTeamadd.ban5=BD_TI7_ContextMatch.BanR5(i,1);
    BD_TI7_StatMatchTeamadd.kills=BD_TI7_StatMatch.radiant_score(i,1);
    BD_TI7_StatMatchTeamadd.assist=sum(BD_TI7_StatMatchPlayer.assists(BD_TI7_StatMatchPlayer.match_id==BD_TI7_StatMatchTeamadd.match_id & BD_TI7_StatMatchPlayer.is_radian==1));
    BD_TI7_StatMatchTeamadd.deaths=sum(BD_TI7_StatMatchPlayer.deaths(BD_TI7_StatMatchPlayer.match_id==BD_TI7_StatMatchTeamadd.match_id & BD_TI7_StatMatchPlayer.is_radian==1));
    BD_TI7_StatMatchTeamadd.temps=BD_TI7_StatMatch.temps(i,1);
    BD_TI7_StatMatchTeam=[BD_TI7_StatMatchTeam;BD_TI7_StatMatchTeamadd]; %#ok<AGROW>
    
    %%dire
    BD_TI7_StatMatchTeamadd=table();
    BD_TI7_StatMatchTeamadd.id_tn=BD_TI7_StatMatch.id_tn(i,1);
    BD_TI7_StatMatchTeamadd.match_id=BD_TI7_StatMatch.match_id(i,1);
    BD_TI7_StatMatchTeamadd.team_id=BD_TI7_ContextMatch.team_idd(i,1);
    BD_TI7_StatMatchTeamadd.name=BD_TI7_ContextMatch.named(i,1);
    if BD_TI7_ContextMatch.isfp(i,1)==1
        BD_TI7_StatMatchTeamadd.is_fp=1;
    else
        BD_TI7_StatMatchTeamadd.is_fp=0;
    end
    BD_TI7_StatMatchTeamadd.is_radiant=0;
    if strcmp(BD_TI7_ContextMatch.win(i,1),'Radiant')==0
        BD_TI7_StatMatchTeamadd.is_win=1;
    else
        BD_TI7_StatMatchTeamadd.is_win=0;
    end
    BD_TI7_StatMatchTeamadd.pick1=BD_TI7_ContextMatch.PickD1(i,1);
    BD_TI7_StatMatchTeamadd.pick2=BD_TI7_ContextMatch.PickD2(i,1);
    BD_TI7_StatMatchTeamadd.pick3=BD_TI7_ContextMatch.PickD3(i,1);
    BD_TI7_StatMatchTeamadd.pick4=BD_TI7_ContextMatch.PickD4(i,1);
    BD_TI7_StatMatchTeamadd.pick5=BD_TI7_ContextMatch.PickD5(i,1);
    BD_TI7_StatMatchTeamadd.ban1=BD_TI7_ContextMatch.BanD1(i,1);
    BD_TI7_StatMatchTeamadd.ban2=BD_TI7_ContextMatch.BanD2(i,1);
    BD_TI7_StatMatchTeamadd.ban3=BD_TI7_ContextMatch.BanD3(i,1);
    BD_TI7_StatMatchTeamadd.ban4=BD_TI7_ContextMatch.BanD4(i,1);
    BD_TI7_StatMatchTeamadd.ban5=BD_TI7_ContextMatch.BanD5(i,1);
    BD_TI7_StatMatchTeamadd.kills=BD_TI7_StatMatch.dire_score(i,1);
    BD_TI7_StatMatchTeamadd.assist=sum(BD_TI7_StatMatchPlayer.assists(BD_TI7_StatMatchPlayer.match_id==BD_TI7_StatMatchTeamadd.match_id & BD_TI7_StatMatchPlayer.is_radian==0));
    BD_TI7_StatMatchTeamadd.deaths=sum(BD_TI7_StatMatchPlayer.deaths(BD_TI7_StatMatchPlayer.match_id==BD_TI7_StatMatchTeamadd.match_id & BD_TI7_StatMatchPlayer.is_radian==0));
    BD_TI7_StatMatchTeamadd.temps=BD_TI7_StatMatch.temps(i,1);
    BD_TI7_StatMatchTeam=[BD_TI7_StatMatchTeam;BD_TI7_StatMatchTeamadd]; %#ok<AGROW>
end


for i=1:height(BD_TI7_Team)
    CalcStatTeam=BD_TI7_StatMatchTeam(BD_TI7_StatMatchTeam.team_id==BD_TI7_Team.team_id(i,1),:);
    CalcStatTeam2=BD_TI7_StatMatchTeam(BD_TI7_StatMatchTeam.team_id==BD_TI7_Team.team_id(i,1) & BD_TI7_StatMatchTeam.is_win==1,:);
    if ~isempty(CalcStatTeam)
    BD_TI7_StatTeamadd=table();
    BD_TI7_StatTeamadd.team_id=BD_TI7_Team.team_id(i,1);
    BD_TI7_StatTeamadd.name=BD_TI7_Team.name(i,1);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam,'is_fp',BD_TI7_StatTeamadd);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam,'is_radiant',BD_TI7_StatTeamadd);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam,'is_win',BD_TI7_StatTeamadd);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam,'kills',BD_TI7_StatTeamadd);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam,'assist',BD_TI7_StatTeamadd);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam,'deaths',BD_TI7_StatTeamadd);
    [BD_TI7_StatTeamadd]=genstat(CalcStatTeam2,'temps',BD_TI7_StatTeamadd);
    BD_TI7_StatTeam=[BD_TI7_StatTeam;BD_TI7_StatTeamadd]; %#ok<AGROW>
    end
end





end