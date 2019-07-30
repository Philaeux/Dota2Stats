function data=pgsqldata(conn,RQSting)

%% Execute query and fetch results
curs = exec(conn,RQSting);
curs = fetch(curs);
data = curs.Data;
close(curs)

%% Clear variables
clear curs