function [nbid]=CBM_PGSQL_inject1l_light(connect,tableName,fieldNames,data,PK,IDPK,basename,type,varargin)

%% vérifie que tous les arguments sont présent
if nargin==0
    %debug
    [configSQL,~,~,~]=import_config('cbm_config.xml');
    
    %% ouverture sql
    %Set preferences with setdbprefs.
    setdbprefs('DataReturnFormat', 'table');
    setdbprefs('NullNumberRead', 'NaN');
    setdbprefs('NullStringRead', 'null');
    
    %Using ODBC driver.
%     connect = database(configSQL.BDD, configSQL.login, configSQL.pass);
%     configSQL=configSQL.ind;
else
    narginchk(8,8);
end

%% calcule la dimention de la donnée a injecter
numberOfCols=length(fieldNames);
numberOfrows=height(data);
data=table2cell(data);

%% update ou inject

switch type
    case 'add' %% inject sur table ou ligne
        
        %% injection d'une TABLE de donnée si
        
        insertData2='';
        for j=1:numberOfrows
            insertField ='';
            insertData ='';
            for i=1:numberOfCols
                if i==numberOfCols
                    insertField = [insertField,'"',fieldNames{i},'"']; %#ok<AGROW>
                    if isa(data{j,i},'char')
                        if strcmp(data{j,i},'null')==1
                            insertData = [insertData,'null']; %#ok<AGROW>
                        else
                            insertData = [insertData,'''',data{i},'''']; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'double')
                        if isnan(data{j,i})==1
                            insertData = [insertData,'null']; %#ok<AGROW>
                        else
                            insertData = [insertData,'''',num2str(data{j,i}),'''']; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'datetime')
                        if isnat(data{j,i})==1
                            insertData = [insertData,'null']; %#ok<AGROW>
                        else
                            formatOut='yyyy-mm-dd hh:MM:ss';
                            insertData = [insertData,'''',datestr(data{j,i},formatOut),'''']; %#ok<AGROW>
                        end
                    else
                        error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{j,i}))
                    end
                else
                    insertField = [insertField,'"',fieldNames{i},'",']; %#ok<AGROW>
                    if isa(data{j,i},'char')
                        if strcmp(data{j,i},'null')==1
                            insertData = [insertData,'null',',']; %#ok<AGROW>
                        else
                            insertData = [insertData,'''',data{j,i}, ''',' ]; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'double')
                        if isnan(data{j,i})==1
                            insertData = [insertData,'null',',' ]; %#ok<AGROW>
                        else
                            insertData = [insertData,'''',num2str(data{j,i}) ''',' ]; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'datetime')
                        if isnat(data{j,i})==1
                            insertData = [insertData,'null',',' ]; %#ok<AGROW>
                        else
                            formatOut='yyyy-mm-dd hh:MM:ss';
                            insertData = [insertData,'''',datestr(data{j,i},formatOut) ''',' ]; %#ok<AGROW>
                        end
                    else
                        error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{j,i}))
                    end
                end
            end
            if j==1
                insertData2 = insertData;
            else
                insertData2 = [insertData2,'),(',insertData]; %#ok<AGROW>
            end
        end
        
        RQString = ['INSERT INTO ',basename,'.',tableName ,' (',insertField ,')  VALUES  (',insertData ,') RETURNING ',PK,' AS id'];
        npk = exec(connect,RQString);
        npk= fetch(npk);
        NPK=npk.Data;
        nbid=NPK.id;
        close(npk)
        
    case 'update' % update sur ligne uniquement
        %% injection d'une TABLE de donnée si
        
        insertData ='';
        for i=1:numberOfCols
            if i==numberOfCols
                
                if isa(data{1,i},'char') || isa(data{1,i},'string')
                    
                    if strcmp(data{1,i},'null')==1
                        insertData = [insertData,'"',fieldNames{i},'"','=null']; %#ok<AGROW>
                    else
                        insertData = [insertData,'"',fieldNames{i},'"','=''',data{1,i},'''']; %#ok<AGROW>
                    end
                    
                elseif isa(data{1,i},'double')
                    if isnan(data{1,i})==1
                        insertData = [insertData,'"',fieldNames{i},'"','=null']; %#ok<AGROW>
                    else
                        insertData = [insertData,'"',fieldNames{i},'"','=''',num2str(data{1,i}),'''']; %#ok<AGROW>
                    end
                    
                elseif isa(data{1,i},'datetime')
                    if isnat(data{1,i})==1
                        insertData = [insertData,'"',fieldNames{i},'"','=null']; %#ok<AGROW>
                    else
                        formatOut='yyyy-mm-dd hh:MM:ss';
                        insertData = [insertData,'"',fieldNames{i},'"','=''',datestr(data{1,i},formatOut),'''']; %#ok<AGROW>
                    end
                else
                    error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{1,i}))
                end
            else
                
                if isa(data{1,i},'char') || isa(data{1,i},'string')
                    
                    if strcmp(data{1,i},'null')==1
                        insertData = [insertData,'"',fieldNames{i},'"','=null',',']; %#ok<AGROW>
                    else
                        insertData = [insertData,'"',fieldNames{i},'"','=''',data{i},'''',',']; %#ok<AGROW>
                    end
                    
                elseif isa(data{1,i},'double')
                    if isnan(data{1,i})==1
                        insertData = [insertData,'"',fieldNames{i},'"','=null',',' ]; %#ok<AGROW>
                    else
                        insertData = [insertData,'"',fieldNames{i},'"','=''',num2str(data{1,i}),'''',',']; %#ok<AGROW>W>
                    end
                    
                elseif isa(data{1,i},'datetime')
                    if isnat(data{1,i})==1
                        insertData = [insertData,'"',fieldNames{i},'"','=null',',' ]; %#ok<AGROW>
                    else
                        formatOut='yyyy-mm-dd hh:MM:ss';
                        insertData = [insertData,'"',fieldNames{i},'"','=''',datestr(data{1,i},formatOut),'''',',' ]; %#ok<AGROW>
                    end
                else
                    error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{1,i}))
                end
            end
        end
        
        RQString = ['UPDATE ',basename,'.',tableName,' SET ',insertData,' WHERE ',PK,'=',num2str(IDPK)];
        up=exec(connect,RQString);
        close(up);
        
     
end