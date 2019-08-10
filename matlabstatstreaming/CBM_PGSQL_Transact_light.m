function CBM_PGSQL_Transact_light(connect,tableName,fieldNames,data,PK,basename,varargin)
%% Programe d'insertion générique pour tous les programmes CBM
% Chargement de type transact d'un format table uniquement !
% ce chargement contient x ligne de la table et peut être composé d'insert et d'update
%
% liste des arguments :
% connect => curseur de la connection ODBC
% tableName => nom de la table SQL cible
% fieldNames => liste des champs de la table a insert/update
% data => table de donnée a charger (table dont les nom des colonne dnas
% matlab sont l'exact copie des nom de colonne a charger dans SQL
% PK => nom de la clef primaire de la table a charger
% basename => Nom de la base de donnée contenant la table a charger souvent
% public en pgsql


%% vérifie que tous les arguments sont présent
if nargin==0
%     %debug
%     [configSQL,~,~,~]=import_config('cbm_config.xml');
%     
%     %% ouverture sql
%     %Set preferences with setdbprefs.
%     setdbprefs('DataReturnFormat', 'table');
%     setdbprefs('NullNumberRead', 'NaN');
%     setdbprefs('NullStringRead', 'null');
%     
%     %Using ODBC driver.
%     connect = database(configSQL.BDD, configSQL.login, configSQL.pass);
%     configSQL=configSQL.ind;
else
    narginchk(6,6);
end

%% calcule la dimention de la donnée a injecter
numberOfCols=length(fieldNames);
numberOfrows=height(data);
data=table2cell(data);
%% début de la création de la RQ transact


%% identifier la colonne de la PK
nbcolPK=find(strcmp(fieldNames,PK)==1);
%% créer la requete de data
RQString='BEGIN; ';
for j=1:numberOfrows
    insertField ='';
    insertData ='';
    if isnan(data{j,nbcolPK}) %cas d'injection
        for i=1:numberOfCols
            if i~=nbcolPK
                if i==numberOfCols
                    insertField = [insertField,'"',fieldNames{i},'"']; %#ok<AGROW>
                    if isa(data{j,i},'char') || isa(data{j,i},'string')
                        if strcmp(data{j,i},'null')==1
                            insertData = [insertData,'null']; %#ok<AGROW>
                        else
                            insertData = [insertData,'''',data{j,i},'''']; %#ok<AGROW>
                            
                        end
                    elseif isa(data{j,i},'double') || isa(data{j,i},'logical')
                        if isnan(data{j,i})==1
                            insertData = [insertData,'null']; %#ok<AGROW>
                        else
                           insertData = [insertData,'',num2str(data{j,i}),'']; %#ok<AGROW>
%                             insertData = [insertData,'',num2str(data{j,i}),'']; %#ok<AGROW>
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
                    if isa(data{j,i},'char') || isa(data{j,i},'string')
                        if strcmp(data{j,i},'null')==1
                            insertData = [insertData,'null',',']; %#ok<AGROW>
                        else
                            insertData = [insertData,'''',data{j,i},''',']; %#ok<AGROW>
                        end
                    elseif isa(data{j,i},'double')|| isa(data{j,i},'logical')
                        if isnan(data{j,i})==1
                            insertData = [insertData,'null',',' ]; %#ok<AGROW>
                        else
                            insertData = [insertData,'',num2str(data{j,i}),',']; %#ok<AGROW>
                        end
                    elseif isa(data{j,i},'datetime')
                        if isnat(data{j,i})==1
                            insertData = [insertData,'null',',']; %#ok<AGROW>
                        else
                            formatOut='yyyy-mm-dd hh:MM:ss';
                            insertData = [insertData,'''',datestr(data{j,i},formatOut),''',']; %#ok<AGROW>
                        end
                    else
                        error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{j,i}))
                    end
                end
            end
        end
        RQStringadd = ['INSERT INTO ',basename,'.',tableName ,' (',insertField ,')  VALUES  (',insertData ,')'];
        RQString=[RQString,' ',RQStringadd,'; ']; %#ok<AGROW>
    else %cas d'update
        insertData ='';
        for i=1:numberOfCols
            if i~=nbcolPK
                if i==numberOfCols
                    if isa(data{j,i},'char') || isa(data{j,i},'string')
                        if strcmp(data{j,i},'null')==1
                            insertData = [insertData,'"',fieldNames{i},'"','=null']; %#ok<AGROW>
                        else
                            insertData = [insertData,'"',fieldNames{i},'"','=''',data{j,i},'''']; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'double')
                        if isnan(data{j,i})==1
                            insertData = [insertData,'"',fieldNames{i},'"','=null']; %#ok<AGROW>
                        else
                            insertData = [insertData,'"',fieldNames{i},'"','=''',num2str(data{j,i}),'''']; %#ok<AGROW>
%                              insertData = [insertData,'"',fieldNames{i},'"','=',num2str(data{j,i}),'']; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'datetime')
                        if isnat(data{j,i})==1
                            insertData = [insertData,'"',fieldNames{i},'"','=null']; %#ok<AGROW>
                        else
                            formatOut='yyyy-mm-dd hh:MM:ss';
                            insertData = [insertData,'"',fieldNames{i},'"','=''',datestr(data{j,i},formatOut),'''']; %#ok<AGROW>
                        end
                    else
                        error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{j,i}))
                    end
                else
                    if isa(data{j,i},'char') || isa(data{j,i},'string')
                        if strcmp(data{j,i},'null')==1
                            insertData = [insertData,'"',fieldNames{i},'"','=null',',']; %#ok<AGROW>
                        else
                            insertData = [insertData,'"',fieldNames{i},'"','=''',data{j,i},'''',',']; %#ok<AGROW>
                        end
                        
                    elseif isa(data{j,i},'double')
                        if isnan(data{j,i})==1
                            insertData = [insertData,'"',fieldNames{i},'"','=null',',' ]; %#ok<AGROW>
                        else
                            insertData = [insertData,'"',fieldNames{i},'"','=''',num2str(data{j,i}),'''',',']; %#ok<AGROW>W>
                        end
                        
                    elseif isa(data{j,i},'datetime')
                        if isnat(data{j,i})==1
                            insertData = [insertData,'"',fieldNames{i},'"','=null',',' ]; %#ok<AGROW>
                        else
                            formatOut='yyyy-mm-dd hh:MM:ss';
                            insertData = [insertData,'"',fieldNames{i},'"','=''',datestr(data{j,i},formatOut),'''',',' ]; %#ok<AGROW>
                        end
                    else
                        error('DataSQLInjectCBM:incorrectType','Error. \nInput format not supported : %s.',class(data{j,i}))
                    end
                end
            end
        end
        RQStringadd = ['UPDATE ',basename,'.',tableName,' SET ',insertData,' WHERE ',PK,'=',num2str(data{j,nbcolPK})];
        RQString=[RQString,' ',RQStringadd,'; ']; %#ok<AGROW>
    end
end
    
    %% créer la requete transact SQL
    RQStringTransact=[RQString,' COMMIT;'];
    transact=exec(connect,RQStringTransact);
    close(transact);
    
end
