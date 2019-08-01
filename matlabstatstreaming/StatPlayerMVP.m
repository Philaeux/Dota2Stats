function [LIVE_TI7_StatPlayerMVP]=StatPlayerMVP(LIVE_TI7_StatMatchMVP,LIVE_TI7_Player)

LIVE_TI7_StatPlayerMVP=table;
for i=1:height(LIVE_TI7_Player)
    CalcStatPlayer=LIVE_TI7_StatMatchMVP(LIVE_TI7_StatMatchMVP.player_id==LIVE_TI7_Player.account_id(i,1),:);
    if ~isempty(CalcStatPlayer)
    LIVE_TI7_StatPlayerMVPadd=table;
    LIVE_TI7_StatPlayerMVPadd.account_id=LIVE_TI7_Player.account_id(i,1);
    LIVE_TI7_StatPlayerMVPadd.team_id=LIVE_TI7_Player.team_id(LIVE_TI7_Player.account_id==LIVE_TI7_StatPlayerMVPadd.account_id);
    LIVE_TI7_StatPlayerMVPadd.Pseudo=LIVE_TI7_Player.Pseudo(LIVE_TI7_Player.account_id==LIVE_TI7_StatPlayerMVPadd.account_id);
    LIVE_TI7_StatPlayerMVPadd.team_name=LIVE_TI7_Player.team_name(LIVE_TI7_Player.account_id==LIVE_TI7_StatPlayerMVPadd.account_id);
    LIVE_TI7_StatPlayerMVPadd.position=LIVE_TI7_Player.position(LIVE_TI7_Player.account_id==LIVE_TI7_StatPlayerMVPadd.account_id);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'KD',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'GPM',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'LH',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'Stuns',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'LHTowers',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'Rosh',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'Observers',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'Stacks',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'Runes',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'FB',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'TF',LIVE_TI7_StatPlayerMVPadd);
    [LIVE_TI7_StatPlayerMVPadd]=genstat(CalcStatPlayer,'pt_fantasy',LIVE_TI7_StatPlayerMVPadd);
    LIVE_TI7_StatPlayerMVP=[LIVE_TI7_StatPlayerMVP;LIVE_TI7_StatPlayerMVPadd];
    end
end








end