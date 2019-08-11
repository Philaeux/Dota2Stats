function [StatPlayer]=genadvstat(CalcStatPlayer,variable,StatPlayer)

StatPlayerAdd2=table;
%% création des nom de variable
%mean=['mean_',variable];
%max=['max_',variable];
%min=['min_',variable];
median=['median_',variable];
std=['std_',variable];
%tot=['tot_',variable];
var=['var_',variable];
cov=['cov_',variable];

if height(CalcStatPlayer)>0
    
    StatPlayerAdd2.(median)=nanmedian(CalcStatPlayer.(variable));
    StatPlayerAdd2.(std)=nanstd(CalcStatPlayer.(variable));
    StatPlayerAdd2.(var)=nanvar(CalcStatPlayer.(variable));
    StatPlayerAdd2.(cov)=nancov(CalcStatPlayer.(variable));
    StatPlayer=[StatPlayer StatPlayerAdd2];
else
    StatPlayerAdd2.(median)=nanmedian(CalcStatPlayer.(variable));
    StatPlayerAdd2.(std)=nanstd(CalcStatPlayer.(variable));
    StatPlayerAdd2.(var)=nanvar(CalcStatPlayer.(variable));
    StatPlayerAdd2.(cov)=nancov(CalcStatPlayer.(variable));
    StatPlayer=[StatPlayer StatPlayerAdd2];
end
end