function pgsqlexec(conn,RQSting)


%% Execute query and fetch results
curs = exec(conn,RQSting);
close(curs)

%% Clear variables
clear curs