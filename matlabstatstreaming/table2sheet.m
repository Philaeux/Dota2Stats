function table2sheet(idspreadsheet,idsheet,data)

var=data.Properties.VariableNames;
data=table2cell(data(:,:));
dim=size(data);


mat2sheets(idspreadsheet,idsheet,[1 1],var);
mat2sheets(idspreadsheet,idsheet,[2 1],data(:,:));

end