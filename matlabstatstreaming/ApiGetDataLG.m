function data=ApiGetDataLG(api_url,api_endpoint,TN_api_key,TN_api_token)

RQString=['https://',api_url,'/v1/',api_endpoint];

options = weboptions;
options.Timeout=60;

header{1,1} = 'X-Api-Key';
header{1,2} = TN_api_key;
header{2,1} = 'Authorization';
header{2,2} = ['Bearer ', TN_api_token];

options.HeaderFields=string(header);

data=webread(RQString,options);
pause(1);

end