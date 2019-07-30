function [MetaRecord]=metarecord(BD_TI7_PlayerRecords)

MetaRecord=table();

%% maxkill

for i=5:width(BD_TI7_PlayerRecords)
    
    
    maxvalue=max(table2array(BD_TI7_PlayerRecords(:,i)));
    idx=find(table2array(BD_TI7_PlayerRecords(:,i))==maxvalue);
    for j=1:length(BD_TI7_PlayerRecords{idx,i})
        Metarecordadd=table();
        Metarecordadd.type=BD_TI7_PlayerRecords.Properties.VariableNames(i);
        Metarecordadd.value=BD_TI7_PlayerRecords{idx(j),i};
        Metarecordadd.Player=BD_TI7_PlayerRecords{idx(j),3};
        Metarecordadd.Team=BD_TI7_PlayerRecords{idx(j),4};
        MetaRecord=[MetaRecord;Metarecordadd];
    end
end

end
